# Create the relational schema and insert a few records into the tables

CREATE SCHEMA `schema1` ;
USE schema1;

CREATE TABLE City (
CityId INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
CityName VARCHAR(45) NOT NULL,
Population INT,
MeanIncome DECIMAL(12,2)
);


INSERT INTO City (CityName, Population, MeanIncome) VALUES ('Athens', 4685789, 1340);
INSERT INTO City (CityName, Population, MeanIncome) VALUES ('Thessaloniki', 1123423, 1250);
INSERT INTO City (CityName, Population, MeanIncome) VALUES ('Iraklio', 567123, 1210);
INSERT INTO City (CityName, Population, MeanIncome) VALUES ('Larissa', 468768, 1240);
INSERT INTO City (CityName, Population, MeanIncome) VALUES ('Trikala', 323412, 1140);
Insert into City (CityName, Population, MeanIncome) Values ('Volos', 453234, 1223.34);
Insert into City (CityName, Population, MeanIncome) Values ('Karlovasi', 18354, 1523.34);
Insert into City (CityName, Population, MeanIncome) Values ('Kythira', 10323, 1333.64);
Insert into City (CityName, Population, MeanIncome) Values ('Spetses', 4027, 950);

select * from City;

CREATE TABLE Customer (
CustomerId INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
FirstName VARCHAR(45) NOT NULL,
LastName VARCHAR(45) NOT NULL,
BirthDate date,
Gender Varchar(1),
CityId INT Unsigned not null,
foreign key (CityId) references City(CityId)
);

INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Petros','Papadopoulos','1968-11-22','M',1);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Dimitris','Diamantidis','1991-04-19','M',5);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Maria','Sati','1953-11-23','F',1);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Pavlos','Pavlou','1979-01-15','M',1);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Giannis','Mpouzoukis','1989-03-14','M',3);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Pantelis','Euaggelou','1928-02-29','M',4);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Panagiota','Euaggelatou','1954-02-13','F',2);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Georgia','Spiropoulou','1978-02-17','F',3);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Sokratis','Dioudis','1988-07-05','M',2);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Kostas','Kotsaris','1996-10-16','M',2);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Kostantina','Spirou','1986-01-16','F',5);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Pantelis','Armanis','1954-05-09','M',1);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Giwrgos','Gistopoulos','1981-03-28','M',1);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Mixail','Iordanis','1963-02-17','M',6);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Magdalena','Karlov','1983-02-17','F',7);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Vaggelis','Stathis','1982-10-06','M',8);
INSERT INTO Customer (FirstName, LastName, BirthDate, Gender, CityId) VALUES ('Dimitris','Papalexiou','1973-10-08','M',9);

select * from Customer;

CREATE TABLE Plan (
PlanId INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
PlanName VARCHAR(45) NOT NULL,
Minutes INT,
SMS Int,
MB Int
);

INSERT INTO Plan (PlanName, Minutes, SMS, MB) VALUES('Student',500,60,600);
INSERT INTO Plan (PlanName, Minutes, SMS, MB) VALUES('ExtraSmall',400,40,400);
INSERT INTO Plan (PlanName, Minutes, SMS, MB) VALUES('Small',600,80,600);
INSERT INTO Plan (PlanName, Minutes, SMS, MB) VALUES('Medium',1000,100,1200);
INSERT INTO Plan (PlanName, Minutes, SMS, MB) VALUES('Large',1500,200,2000);
INSERT INTO Plan (PlanName, Minutes, SMS, MB) VALUES('Extra Large',3000,1000,5000);
INSERT INTO Plan (PlanName, Minutes, SMS, MB) VALUES('Pro',10000,10000,10000);
INSERT INTO Plan (PlanName, Minutes, SMS, MB) VALUES('Pure Freedom',20000,20000,20000);


select * from Plan;

CREATE TABLE Contracts (
ContractId INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
PhoneNumber varchar(10) unique NOT NULL,
StartingDate date NOT NULL,
EndingDate date NOT NULL,
Info text,
PlanId INT unsigned not null,
CustomerId INT unsigned not null,
foreign key (PlanId) references Plan(PlanId),
foreign key (CustomerId) references Customer(CustomerId)
);

INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6936836246','2019-01-25','2020-01-25','student contract',1,1);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6976284733','2019-05-30','2020-05-30','student contract',1,2);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6986037583','2018-03-14','2020-03-14','Monthly contract',7,3);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6976372535','2019-06-03','2021-09-28','Monthly contract',6,4);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6974428463','2019-11-01','2023-11-01','Sim only deal',2,5);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6947263944','2019-07-17','2021-09-30','VIP',5,6);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6947245767','2019-07-17','2021-09-30','VIP',7,6);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6937574633','2019-08-28','2021-03-07','VIP',6,7);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6937587987','2019-08-28','2021-03-07','VIP',7,7);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6979085744','2018-03-15','2019-12-31','Monthly contract',3,8);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6946947433','2018-11-11','2020-11-28','Monthly contract',4,9);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6933637274','2019-09-19','2021-09-19','two year contract',1,10);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6936657588','2019-08-19','2021-08-19','two year contract',4,11);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6965892134','2019-05-03','2021-05-03','two year contract',6,12);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6979045368','2019-09-30','2020-09-30','student contract',1,2);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6936580322','2019-01-28','2020-01-28','Monthly contract',5,13);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6942235678','2017-03-23','2020-03-23','Monthly contract',4,14);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6942981200','2018-08-23','2020-08-23','two year contract',4,15);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6998159567','2018-12-23','2019-12-23','one year contract',8,16);
INSERT INTO Contracts (PhoneNumber, StartingDate, EndingDate, Info, PlanId, CustomerID) VALUES('6938123568','2018-12-24','2019-12-24','one year contract',8,17);


Select * from Contracts;

CREATE TABLE Calls (
CallId INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
CallStart timestamp NOT NULL,
CalledNumber VARCHAR(10) NOT NULL,
Duration int not null,
PhoneNumber VARCHAR(10) NOT NULL,
foreign key (PhoneNumber) references Contracts(PhoneNumber)
);

Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-06-13 08:23:32','6976578430', 14, '6942981200');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-06-17 20:22:32','6976578430', 18, '6942981200');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-06-17 20:22:54','6954655822', 58, '6936836246');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-06-11 15:49:02','6987465462', 130, '6986037583');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2017-12-03 21:16:25','2106146462', 160, '6979045368');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-12-31 23:59:59','2646046523', 500, '6933637274');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2016-10-28 12:00:09','2116550656', 66, '6937574633');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2017-02-14 21:05:36','6971356452', 79, '6965892134');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2019-06-25 10:56:03','2604653535', 213, '6946947433');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2019-03-12 06:30:56','6965492345', 58, '6937574633');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2019-11-10 11:11:11','6949765434', 142, '6937587987');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-12-03 21:16:25','2106146462', 16, '6979045368');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-10-28 12:00:09','2116550656', 6, '6937574633');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-02-14 21:05:36','6971356452', 9, '6965892134');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-06-25 10:56:03','2604653535', 13, '6946947433');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-03-12 06:30:56','6965492345', 8, '6937574633');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-11-10 11:11:11','6949765434', 4, '6937587987');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-11-10 11:12:11','6949765435', 14, '6974428463');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-10-24 11:03:09','2116550656', 6, '6947263944');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-03-07 10:21:04','6954655822', 18, '6942235678');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-03-04 08:11:32','6932655672', 34, '6998159567');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-03-04 08:25:42','6932655672', 34, '6938123568');
Insert into Calls (CallStart, CalledNumber, Duration, PhoneNumber) Values('2018-06-04 09:59:48','6976578430', 23, '6979045368');


select * from Calls;