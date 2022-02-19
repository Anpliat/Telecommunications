
# Implementation of query (k) in R programming language - without using GROUP BY SQL statements
# k. For each city id, show the city id, the ratio of the total duration of the calls made from customers staying in that city in 2018 over the total duration of all calls made in 2018, and the ratio of the city’s population over the total population of all cities

##################################
#########  1st solution  #########
##################################
library(RMySQL);
mydb = dbConnect(MySQL(), user = 'root', password = 'your_password', dbname = 'assignment1', host = 'localhost')
rs = dbSendQuery(mydb,"select * from City")
city = fetch(rs,n=-1)
City_Id = city$CityId
Population_Ratio = city$Population/sum(city$Population)
rs = dbSendQuery(mydb,"select c.CityId as City_Id, Duration from Calls 
                 Join Contracts on Calls.PhoneNumber = Contracts.PhoneNumber 
                 Join Customer on Customer.CustomerId = Contracts.CustomerId 
                 Join City as c on c.CityId = Customer.CityId 
                 WHERE EXTRACT(YEAR from CallStart)=2018") 
CallsDurWithCity = fetch(rs, n=-1)
CallsPerCity = by(CallsDurWithCity$Duration, CallsDurWithCity$City_Id, sum);CallsPerCity
CallsPerCity = as.numeric(CallsPerCity)
y = sum(CallsPerCity)
fun1 = function(x){
  return(x/y)
}
Duration_Ratio = tapply(CallsPerCity, 1:length(CallsPerCity), fun1)
finalData = cbind(City_Id, Duration_Ratio, Population_Ratio)
finalData

##################################
#########  2nd solution  #########
##################################

#### 1st step: Connect to the database and create all the different tables/relations
install.packages("RMySQL")
library(RMySQL)
mydb = dbConnect(MySQL(), user = 'root', password = 'your_password', dbname = 'assignment1', host = 'localhost')
# City table
rs<-dbSendQuery(mydb,"select * from City")
city<-fetch(rs,n=-1)
city ; str(city)
# Customer table
rs<-dbSendQuery(mydb,"select * from Customer")
customer<-fetch(rs,n=-1)
# Plan table
rs<-dbSendQuery(mydb,"select * from Plan")
plan<-fetch(rs,n=-1)
# Contracts table
rs<-dbSendQuery(mydb,"select * from Contracts")
contracts<-fetch(rs,n=-1)
# Calls table
rs<-dbSendQuery(mydb,"select * from Calls")
calls<-fetch(rs,n=-1)



#### 2nd step: Create type of Joins similar to SQL in R
join<-function(x,y,z){
  df<-data.frame()
  for (i in 1:dim(x)[1]){   
    cond<-x[,z][i]==y[,z] & substr(calls$CallStart[i], start=1, stop=4)=='2018'
    if (any(cond)){
      temp<-cbind(y[cond,],x$Duration[i])
      df<-rbind(df,temp) }
  }
  colnames(df)[length(names(df))]<-"Duration"
  df }
join1<-function(x,y,z){
  df<-data.frame()
  for (i in 1:dim(x)[1]){   
    cond<-x[,z][i]==y[,z]
    if (any(cond)){
      temp<-cbind(y[cond,],x$Duration[i])
      df<-rbind(df,temp) }
  }
  colnames(df)[length(names(df))]<-"Duration"
  df }

df1<-join(calls,contracts,"PhoneNumber")
df2<-join1(df1,customer,"CustomerId")
df3<-join1(df2,city,"CityId")
# order them by CityId
df3<-df3[order(df3$CityId),] 
df3


#### 3rd step: Replicate the effect of  ‘group by’ command from SQL in R
# For each city id, show the ratio of the total duration of the calls made from customers #staying in that city in 2018
results<-rep(0,length(unique(df3$CityId)))
for (i in 1:length(unique(df3$CityId))){ 
  if (sum(unique(df3$CityId)[i]==df3$CityId)>1){      #if it has more than 1 values (it’s duplicated)
    results[i]<-sum(df3$Duration[df3$CityId==i])
  }else{                   
    results[i]<-df3$Duration[unique(df3$CityId)[i]==df3$CityId]  }
}
results


#### 4th step: Computations
# Over the total duration of all calls made in 2018

##### 1st way
total_sum<-sum(calls$Duration[substr(calls$CallStart, start=1, stop=4)=='2018'])
dur_ratio<-round(results/total_sum,4)
pin1<-cbind(unique(df3$CityId),dur_ratio) 
##### 2nd way
query1<-"select sum(Duration) from Calls WHERE EXTRACT(YEAR from CallStart)=2018"
rs<-dbSendQuery(mydb,query1)
sum15<-fetch(rs,n=-1)

# The ratio of the city’s population over the total population of all cities
##### 1st way
pop_ratio<-round(city$Population/sum(city$Population),4)
pop_ratio<-pop_ratio[city$CityId%in%pin1[,1]] 
##### 2nd way
rs<-dbSendQuery(mydb,"select sum(Population) as Pop_sum from City")
sumpop15<-fetch(rs,n=-1)

## Implemantation of query (i.e. For each city id, show the city id,and the 2 ratios)
pin13<-cbind(pin1,pop_ratio)
colnames(pin13)<-c('Cityid','Duration_ratio','Population_ratio')
pin13