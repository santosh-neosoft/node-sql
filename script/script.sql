-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: node_sql
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Feature`
--

DROP TABLE IF EXISTS `Feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Feature` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `feature_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Feature`
--

LOCK TABLES `Feature` WRITE;
/*!40000 ALTER TABLE `Feature` DISABLE KEYS */;
INSERT INTO `Feature` VALUES (1,'Feature A'),(2,'Feature B'),(3,'Feature C'),(4,'Feature D'),(5,'Feature E');
/*!40000 ALTER TABLE `Feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Language`
--

DROP TABLE IF EXISTS `Language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Language` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `lang_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Language`
--

LOCK TABLES `Language` WRITE;
/*!40000 ALTER TABLE `Language` DISABLE KEYS */;
INSERT INTO `Language` VALUES (1,'java'),(2,'C#'),(3,'Android'),(4,'ios'),(5,'Php');
/*!40000 ALTER TABLE `Language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Program_Details`
--

DROP TABLE IF EXISTS `Program_Details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Program_Details` (
  `id` int(11) NOT NULL,
  `lang_id` int(11) DEFAULT NULL,
  `prog_id` int(11) DEFAULT NULL,
  `code` mediumtext,
  `codewithoutcomments` varchar(45) DEFAULT NULL,
  `codewithoutlogic` varchar(45) DEFAULT NULL,
  `exampleoutput` varchar(45) DEFAULT NULL,
  `difficultylevel` int(11) DEFAULT NULL,
  `exampleoutputtype` varchar(100) DEFAULT NULL,
  `isrunnable` char(1) DEFAULT NULL,
  `canbeuseforchallenges` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lang_id_idx` (`lang_id`),
  KEY `prog_id_idx` (`prog_id`),
  CONSTRAINT `lang_id` FOREIGN KEY (`lang_id`) REFERENCES `Language` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prog_id` FOREIGN KEY (`prog_id`) REFERENCES `program` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Program_Details`
--

LOCK TABLES `Program_Details` WRITE;
/*!40000 ALTER TABLE `Program_Details` DISABLE KEYS */;
INSERT INTO `Program_Details` VALUES (1001,1,101,'<script>alert( \'Hello, world!\' );</script>','codewithoutcomments','without logic','Hello, world',1,'JS','Y','N'),(1002,4,103,'#include <stdio.h> int main() { // printf() displays the string inside quotation printf(\'Hello, World!\'); return 0; }','codewithoutcomments','without logic','Hello, world',1,'IOS','Y','N'),(1003,4,103,'#include <stdio.h> int main() { // printf() displays the string inside quotation printf(\'Hello, World!\'); return 0; }','codewithoutcomments','without logic','Hello, world',2,'ios','N','Y');
/*!40000 ALTER TABLE `Program_Details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `cat_name` varchar(100) DEFAULT NULL,
  `category_sequence` int(11) DEFAULT NULL,
  `featureid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `featureid_idx` (`featureid`),
  CONSTRAINT `featureid` FOREIGN KEY (`featureid`) REFERENCES `Feature` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (101,'Web Development',1,1),(102,'Android Development',2,4),(103,'IOS Development',3,5),(104,'Front End Developer',4,3),(464,'Android Development',4,2),(774,'Android Development',4,2);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program` (
  `id` int(11) NOT NULL,
  `program_name` varchar(100) DEFAULT NULL,
  `program_description` varchar(500) DEFAULT NULL,
  `program_category` int(11) DEFAULT NULL,
  `description_image_base64` varchar(1000) DEFAULT NULL,
  `description_image_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `program_category_idx` (`program_category`),
  CONSTRAINT `program_category` FOREIGN KEY (`program_category`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
INSERT INTO `program` VALUES (101,'CRUD','WAP to create Employee CRM',101,'data:image/gif;base64,R0lGODlhPQBEAPeoAJosM//AwO/','https://jsfiddle.net/casiano/xadvz/'),(102,'Wather App','create Android App to show whether info',102,'data:image/gif;base64,R0lGODlhPQBEAPeoAJosM//AwO/','https://jsfiddle.net/casiano/xadvz/'),(103,'Wather App','create IOS App to show whether info',103,'data:image/gif;base64,R0lGODlhPQBEAPeoAJosM//AwO/','https://jsfiddle.net/casiano/xadvz/'),(104,'CRUD','WAP to create Employee CRM',103,'data:image/gif;base64,R0lGODlhPQBEAPeoAJosM//AwO/','https://jsfiddle.net/casiano/xadvz/'),(317,'CRUD Android App','WAP to create Employee CRM',464,'data:image/gif;base64,R0lGODlhPQBEAPeoAJosM//AwO/','https://jsfiddle.net/casiano/xadvz/');
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_io`
--

DROP TABLE IF EXISTS `program_io`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_io` (
  `id` int(11) NOT NULL,
  `prog_id` int(11) DEFAULT NULL,
  `input` varchar(500) DEFAULT NULL,
  `output` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prog_io_idx` (`prog_id`),
  CONSTRAINT `prog_io` FOREIGN KEY (`prog_id`) REFERENCES `Program_Details` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_io`
--

LOCK TABLES `program_io` WRITE;
/*!40000 ALTER TABLE `program_io` DISABLE KEYS */;
INSERT INTO `program_io` VALUES (158,1003,'abc','pqr'),(627,NULL,'abc','pqr'),(658,1003,'abc','pqr');
/*!40000 ALTER TABLE `program_io` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requestlog`
--

DROP TABLE IF EXISTS `requestlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requestlog` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `versionno` int(11) DEFAULT NULL,
  `client` varchar(50) DEFAULT NULL,
  `appname` varchar(100) DEFAULT NULL,
  `language` varchar(100) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requestlog`
--

LOCK TABLES `requestlog` WRITE;
/*!40000 ALTER TABLE `requestlog` DISABLE KEYS */;
INSERT INTO `requestlog` VALUES (1,123,'android|ios','learn ios','ios','2017-09-27 19:11:10'),(2,123,'android|ios','learn ios','ios','2017-09-27 19:22:05'),(3,123,'android|ios','learn ios','ios','2017-09-27 19:23:39'),(4,123,'android|ios','learn ios','java','2017-09-27 19:24:02'),(5,123,'android|ios','learn ios','java','2017-09-27 19:31:20'),(6,123,'android|ios','learn ios','ios','2017-09-27 19:32:18'),(7,123,'android|ios','learn ios','java','2017-09-27 19:34:12'),(8,123,'android|ios','learn ios','ios','2017-09-27 19:35:45'),(9,123,'android|ios','learn ios','ios','2017-09-27 19:37:31'),(10,100,'android|ios','learn me','Php','2017-09-27 19:38:49'),(11,100,'android|ios','learn me','me','2017-09-27 19:39:06'),(12,100,'android|ios','learn me','me','2017-09-27 19:40:48'),(13,100,'android|ios','learn me','me','2017-09-27 19:44:28'),(14,100,'android|ios','learn me','ios','2017-09-27 19:44:52'),(15,100,'android|ios','learn me','ios','2017-09-27 19:45:53'),(16,100,'android|ios','learn me','me','2017-09-27 19:46:03'),(17,100,'android|ios','learn me','me','2017-09-27 19:46:59'),(18,100,'android|ios','learn me','me','2017-09-27 19:47:27'),(19,100,'android|ios','learn me','ios','2017-09-27 20:14:15'),(20,100,'android|ios','learn me','ios','2017-09-28 15:35:38'),(21,100,'android|ios','learn me','ios','2017-09-28 15:43:08'),(22,100,'android|ios','learn me','ios','2017-09-28 15:48:37'),(23,100,'android|ios','learn me','ios','2017-09-28 15:51:41'),(24,100,'android|ios','learn me','ios','2017-09-28 15:53:20'),(25,100,'android|ios','learn me','ios','2017-09-28 15:55:06'),(26,100,'android|ios','learn me','ios','2017-09-28 15:58:03'),(27,100,'android|ios','learn me','is','2017-09-28 15:58:30'),(28,100,'android|ios','learn me','is','2017-09-28 16:00:50'),(29,100,'android|ios','learn me','is','2017-09-28 16:08:27'),(30,100,'android|ios','learn me','is','2017-09-28 16:12:22'),(31,100,'android|ios','learn me','is','2017-09-28 16:16:49'),(32,100,'android|ios','learn me','is','2017-09-28 16:21:32'),(33,100,'android|ios','learn me','ios','2017-09-28 16:22:03'),(34,100,'android|ios','learn me','ios','2017-09-28 16:25:51'),(35,100,'android|ios','learn me','is','2017-09-28 16:25:56'),(36,100,'android|ios','learn me','ios','2017-09-28 16:26:06');
/*!40000 ALTER TABLE `requestlog` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-28 16:42:01
