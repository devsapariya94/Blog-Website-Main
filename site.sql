-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: site
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `name` varchar(500) DEFAULT NULL,
  `phoneno` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `msg` varchar(500) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `srno` int NOT NULL AUTO_INCREMENT,
  UNIQUE KEY `srno` (`srno`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES ('first','111111111',' first@first.com',' frist msg','2020-09-05 10:40:05',1),('dev patel','1234567890','dev@mail.com','hii hello','2020-09-05 10:48:27',2),('abc','+01439765853','abc@gmail.com','hi i am abc  i visit your site and found it very intresting.','2020-09-07 17:24:16',6),('abcd','1234567890','abcd@abcdtestail.com','test','2020-09-07 17:28:14',7),('abcd','1234567890','abcd@abcdtestail.com','test','2020-09-07 17:28:39',8);
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `srno` int NOT NULL AUTO_INCREMENT,
  `titel` varchar(500) DEFAULT NULL,
  `slug` varchar(30) DEFAULT NULL,
  `subtitel` varchar(100) DEFAULT NULL,
  `content` mediumtext,
  `img_file` varchar(30) DEFAULT NULL,
  `author` varchar(500) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`srno`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'first title ','first-post','first try','this is the first post of blog','download.png','me','2020-09-07 11:41:18'),(2,'About Wikipedia','about-wikipedia-post','Largest Open Source Site','Wikipedia was launched on January 15, 2001, and was created by Jimmy Wales and Larry Sanger.Sanger coined its name as a portmanteau of the terms \"wiki\" and \"encyclopedia\". Initially an English-language encyclopedia, versions of Wikipedia in other languages were quickly developed. With 6.2 million articles, the English Wikipedia is the largest of the more than 300 Wikipedia encyclopedias. Overall, Wikipedia comprises more than 54 million articles attracting 1.5 billion unique visitors per month\"','post-wiki.jpg','Wikipedia','2020-09-08 12:25:02'),(3,'Python','python-wikipedia-post','amazing programming lang.......','Python is an interpreted, high-level and general-purpose programming language. Created by Guido van Rossum and first released in 1991, Pythons design philosophy emphasizes code readability with its notable use of significant whitespace. Its language constructs and object-oriented approach aim to help programmers write clear, logical code for small and large-scale projects. Python is dynamically typed and garbage-collected. It supports multiple programming paradigms, including structured (particularly, procedural), object-oriented, and functional programming. Python is often described as a \"batteries included\" language due to its comprehensive standard library.','post-python.jpg','Wikipedia','2020-09-08 14:55:49');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscribe`
--

DROP TABLE IF EXISTS `subscribe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscribe` (
  `srno` int NOT NULL AUTO_INCREMENT,
  `email` varchar(60) DEFAULT NULL,
  `date` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`srno`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscribe`
--

LOCK TABLES `subscribe` WRITE;
/*!40000 ALTER TABLE `subscribe` DISABLE KEYS */;
INSERT INTO `subscribe` VALUES (5,'devsapariya@rediffmail.com','2020-09-12 18:11:13.198746'),(6,'devsaparia@rediffmail.com','2020-09-12 18:27:39.575600'),(7,'devsapariya943@gmail.com','2020-09-12 18:27:57.160418'),(8,'devsapariya943@gmail.com','2020-09-12 18:27:57.198179'),(9,'devbpatel94@gmail.com','2020-09-13 15:36:56.940553');
/*!40000 ALTER TABLE `subscribe` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-14 11:08:06
