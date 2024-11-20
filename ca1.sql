-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: ca1
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `service_id` int NOT NULL,
  `booking_date` datetime NOT NULL,
  `remarks` varchar(255) NOT NULL DEFAULT 'NULL',
  `status` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `booking_fk5` (`status`),
  CONSTRAINT `booking_fk5` FOREIGN KEY (`status`) REFERENCES `status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,3,1,'2024-11-16 10:00:00','Regular monthly cleaning',1),(2,3,5,'2024-11-17 15:30:00','Urgent carpet cleaning',2),(3,3,7,'2024-11-18 09:00:00','First-time upholstery service',3),(4,4,2,'2024-11-16 12:00:00','Sanitization after party',1),(5,4,6,'2024-11-17 08:00:00','Spot cleaning request',3),(6,4,9,'2024-11-18 14:00:00','Leather couch cleaning',2),(7,5,3,'2024-11-16 11:00:00','Exhaust cleaning maintenance',3),(8,5,4,'2024-11-17 13:00:00','General room cleaning',2),(9,5,8,'2024-11-18 10:30:00','Wood polishing service',1);
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `service_id` int NOT NULL,
  `booking_time` datetime NOT NULL,
  `price` int NOT NULL,
  `remarks` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `cart_fk1` (`user_id`),
  KEY `cart_fk2` (`service_id`),
  CONSTRAINT `cart_fk1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cart_fk2` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `service_id` int NOT NULL,
  `booking_id` int NOT NULL,
  `rating` int NOT NULL,
  `description` text,
  `suggestion` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `Feedback_fk3` (`booking_id`),
  CONSTRAINT `Feedback_fk3` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `service_name` varchar(45) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT 'NULL',
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `service_fk1` (`category_id`),
  CONSTRAINT `service_fk1` FOREIGN KEY (`category_id`) REFERENCES `service_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,1,'Deep Toilet Scrubbing','Thorough cleaning to remove stains and limescale',25.00),(2,1,'Sanitization Service','Disinfection of all surfaces and fixtures',30.00),(3,1,'Exhaust Vent Cleaning','Cleaning and maintenance of toilet exhaust fans',20.00),(4,2,'General Dusting and Mopping','Dusting and mopping of room surfaces',15.00),(5,2,'Carpet Vacuuming','Vacuuming and stain removal from carpets',40.00),(6,2,'Ceiling Spot Cleaning','Cleaning of visible spots and cobwebs',20.00),(7,3,'Upholstery Cleaning','Cleaning and shampooing of sofas and chairs',50.00),(8,3,'Wood Polishing','Polishing of wooden furniture to restore shine',35.00),(9,3,'Leather Care','Conditioning and cleaning of leather furniture',45.00);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_category`
--

DROP TABLE IF EXISTS `service_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT 'NULL',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_category`
--

LOCK TABLES `service_category` WRITE;
/*!40000 ALTER TABLE `service_category` DISABLE KEYS */;
INSERT INTO `service_category` VALUES (1,'Toilet Cleaning','Cleaning and sanitization of toilets'),(2,'Room Cleaning','General and deep cleaning of rooms'),(3,'Furniture Cleaning','Upholstery and furniture maintenance');
/*!40000 ALTER TABLE `service_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'Incomplete'),(2,'Completed'),(3,'Cancelled');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'K@gmail.com','K','$2a$10$j5Ei75J13da18coWP1PENeA1AZkTvPD2boeH0rnmLt7xU7qmA3e3q','admin'),(2,'CCLZ@gmail.com','CCLZ','$2a$10$4rNeRhqW/5YTYX0SEMNnVejNXZpOQFf/FJrZqYNqBzSHOqRkq8ZBC','admin'),(3,'u111@gmail.com','u111','$2a$10$GL2xL2VtFUeej/trYmgY0e.tOvXVTmYLMuplqVren/ZIUPdSpcW1m','member'),(4,'u112@gmail.com','u112','$2a$10$/WuhWNdCH7VH3dlqvR9eI.QbiKk1ZPC/bqzgHwzHdX.SbsxthgxHa','member'),(5,'u113@gmail.com','u113','$2a$10$jH/Qa/eO2fVqadWaROSq4uXpo3M9PXEw5uB0oNGx44KHoWDnATgUu','member'),(6,'liltay@gmail.com','liltay','$2a$10$9Wd1oUPjW/m/1PnkgJBP0e87pP3v1lGSBYhDN8iSgoQAe7GZX6X9q','member');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ca1'
--

--
-- Dumping routines for database 'ca1'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-20 20:01:41
