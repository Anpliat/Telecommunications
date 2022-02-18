CREATE DATABASE  IF NOT EXISTS `assignment1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `assignment1`;
-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: assignment1
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `contracts`
--

DROP TABLE IF EXISTS `contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contracts` (
  `ContractId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PhoneNumber` varchar(10) NOT NULL,
  `StartingDate` date NOT NULL,
  `EndingDate` date NOT NULL,
  `Info` text,
  `PlanId` int(10) unsigned NOT NULL,
  `CustomerId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ContractId`),
  UNIQUE KEY `PhoneNumber` (`PhoneNumber`),
  KEY `PlanId` (`PlanId`),
  KEY `CustomerId` (`CustomerId`),
  CONSTRAINT `contracts_ibfk_1` FOREIGN KEY (`PlanId`) REFERENCES `plan` (`PlanId`),
  CONSTRAINT `contracts_ibfk_2` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`CustomerId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contracts`
--

LOCK TABLES `contracts` WRITE;
/*!40000 ALTER TABLE `contracts` DISABLE KEYS */;
INSERT INTO `contracts` VALUES (1,'6936836246','2019-01-25','2020-01-25','student contract',1,1),(2,'6976284733','2019-05-30','2020-05-30','student contract',1,2),(3,'6986037583','2018-03-14','2020-03-14','Monthly contract',7,3),(4,'6976372535','2019-06-03','2021-09-28','Monthly contract',6,4),(5,'6974428463','2019-11-01','2023-11-01','Sim only deal',2,5),(6,'6947263944','2019-07-17','2021-09-30','VIP',5,6),(7,'6947245767','2019-07-17','2021-09-30','VIP',7,6),(8,'6937574633','2019-08-28','2021-03-07','VIP',6,7),(9,'6937587987','2019-08-28','2021-03-07','VIP',7,7),(10,'6979085744','2018-03-15','2019-12-31','Monthly contract',3,8),(11,'6946947433','2018-11-11','2020-11-28','Monthly contract',4,9),(12,'6933637274','2019-09-19','2021-09-19','two year contract',1,10),(13,'6936657588','2019-08-19','2021-08-19','two year contract',4,11),(14,'6965892134','2019-05-03','2021-05-03','two year contract',6,12),(15,'6979045368','2019-09-30','2020-09-30','student contract',1,2),(16,'6936580322','2019-01-28','2020-01-28','Monthly contract',5,13),(17,'6942235678','2017-03-23','2020-03-23','Monthly contract',4,14),(18,'6942981200','2018-08-23','2020-08-23','two year contract',4,15),(19,'6998159567','2018-12-23','2019-12-23','one year contract',8,16),(20,'6938123568','2018-12-24','2019-12-24','one year contract',8,17);
/*!40000 ALTER TABLE `contracts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-18 13:23:37
