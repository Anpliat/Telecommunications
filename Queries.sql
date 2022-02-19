# a. Show the call id of all calls that were made between 8am and 10am on June 2018 having duration < 30
SELECT CallId FROM Calls
WHERE DATE_FORMAT(CallStart,'%H:%i') between '08:00' and '10:00'
and EXTRACT(MONTH from CallStart) = '06' 
and EXTRACT(YEAR from CallStart) = '2018' 
and duration < 30;


# b. Show the first and last name of customers that live in a city with population greater than 20000
SELECT FirstName,LastName FROM Customer as Cust
JOIN City
ON Cust.CityID = City.CityID
WHERE Population>20000;


# c. Show the customer id that have a contract in the plan with name like ‘Freedom’
select CustomerId, FirstName from Customer
where CustomerId in
(select CustomerId from Contracts where PlanId in
(select PlanId from Plan where PlanName like "%Freedom%")); 


# d. For each contract that ends in less than sixty days from today, show the contract id, the phone number, the customer’s id, his/her first name and his/her last name
SELECT Contracts.ContractId, PhoneNumber, Contracts.CustomerId, FirstName, LastName
FROM Contracts
JOIN Customer as Cust
ON Cust.CustomerId = Contracts.CustomerId  
where DATEDIFF(EndingDate, CURDATE())<60;


# e. For each contract id and each month of 2018, show the average duration of calls
SELECT ContractId, EXTRACT(MONTH from CallStart) as Month_,ROUND(AVG(Duration),2) as Average_Duration
FROM Calls
JOIN Contracts
ON Calls.PhoneNumber = contracts.PhoneNumber
WHERE EXTRACT(YEAR from CallStart)='2018'
GROUP BY ContractId, Month_
order by ContractId;  


# f. Show the total duration of calls in 2018 per plan id
SELECT Plan.PlanId,SUM(Duration) as Total_Duration
FROM Calls
JOIN Contracts ON Calls.PhoneNumber = Contracts.PhoneNumber
JOIN Plan ON Plan.PlanId = Contracts.PlanId
WHERE EXTRACT(YEAR from CallStart)='2018'
GROUP BY PlanId
ORDER BY Total_Duration DESC;


# g. Show the top called number among TP’s customers in 2018
SELECT  CalledNumber  as top_called_number #, count(*) as Received_Calls
from Calls
WHERE EXTRACT(YEAR from CallStart) = '2018'
group by CalledNumber
ORDER BY count(*) DESC
limit 1; 


# h. Show the contract ids and the months where the total duration of the calls was greater than the free minutes offered by the plan of the contract
SELECT ContractId, EXTRACT(MONTH from CallStart) as Month_, Plan.Minutes, SUM(Duration) as Total_Duration
FROM Calls
JOIN Contracts ON Calls.PhoneNumber = Contracts.PhoneNumber
JOIN Plan ON Contracts.PlanId = Plan.PlanId
GROUP BY Month_, Plan.Minutes
HAVING Total_Duration > Plan.Minutes;


# i. For each month of 2018, show the percentage change of the total duration of calls compared to the same month of 2017
CREATE VIEW duration_2017(Months,Total_Duration2017) AS
SELECT EXTRACT(MONTH from CallStart),SUM(Duration) FROM Calls
WHERE EXTRACT(YEAR from CallStart)=2017
GROUP BY EXTRACT(MONTH from CallStart)
ORDER BY EXTRACT(MONTH from CallStart);
CREATE VIEW duration_2018(Months,Total_Duration2018) AS
SELECT EXTRACT(MONTH from CallStart),SUM(Duration) FROM Calls
WHERE EXTRACT(YEAR from CallStart)=2018
GROUP BY EXTRACT(MONTH from CallStart)
ORDER BY EXTRACT(MONTH from CallStart);

#### Comment: We created two “view” Tables, one for the Duration of calls made in 2017 and second one for the Duration of calls made in 2018.
SELECT duration_2017.Months,ROUND(100*(Total_Duration2018-Total_Duration2017)/Total_Duration2017,2) as 'percentage change','%'
FROM duration_2017
JOIN duration_2018 
ON duration_2017.Months=duration_2018.Months;


# j. For each city id and calls made in 2018, show the average call duration by females and the average call duration by males
select IF(Customer.Gender='M','Male','Female') AS 'Gender', c.CityId, ROUND(AVG(Duration),2) as 'avg_duration'
from Calls
Join Contracts on Calls.PhoneNumber = Contracts.PhoneNumber
Join Customer on Customer.CustomerId = Contracts.CustomerId
join City as c on c.CityId = Customer.CityId
WHERE EXTRACT(YEAR from CallStart)=2018
GROUP BY Gender, c.CityId
ORDER BY CityId;

# k. For each city id, show the city id, the ratio of the total duration of the calls made from customers staying in that city in 2018 over the total duration of all calls made in 2018, and the ratio of the city’s population over the total population of all cities
select a.City_Id as Id, (a.sum_per_city / b.total_sum) as Dur_ratio, (Population/d.Pop_sum) as Pop_ratio
from City, (select c.CityId as City_Id, sum(Duration) as sum_per_city from Calls
				Join Contracts on Calls.PhoneNumber = Contracts.PhoneNumber
				Join Customer on Customer.CustomerId = Contracts.CustomerId
				join City as c on c.CityId = Customer.CityId
                			WHERE EXTRACT(YEAR from CallStart)=2018
				group by c.CityId) as a, 
       (select sum(Duration) as total_sum from Calls WHERE EXTRACT(YEAR from CallStart)=2018) as b,
       (select sum(Population) as Pop_sum from City ) as d
where a.City_Id = City.CityId
group by a.City_Id;