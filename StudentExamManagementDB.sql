-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: studentexammanagementdb
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `average_exam_grade`
--

DROP TABLE IF EXISTS `average_exam_grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `average_exam_grade` (
  `StudentID` int NOT NULL,
  `AverageExamGrade` int DEFAULT NULL,
  `TotalPoints` int DEFAULT NULL,
  `NumberOfExams` int DEFAULT '0',
  `Semester` varchar(6) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`StudentID`),
  CONSTRAINT `average_exam_grade_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`),
  CONSTRAINT `average_exam_grade_chk_1` CHECK (((`AverageExamGrade` > -(1)) and (`AverageExamGrade` < 101))),
  CONSTRAINT `average_exam_grade_chk_2` CHECK (((`Semester` = _utf8mb4'Fall') or (`Semester` = _utf8mb4'Spring') or (`Semester` = _utf8mb4'Summer')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `average_exam_grade`
--

LOCK TABLES `average_exam_grade` WRITE;
/*!40000 ALTER TABLE `average_exam_grade` DISABLE KEYS */;
INSERT INTO `average_exam_grade` VALUES (1,92,92,1,'Fall'),(38,92,276,3,'Fall');
/*!40000 ALTER TABLE `average_exam_grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `CourseID` int NOT NULL,
  `CourseName` varchar(45) COLLATE utf8mb4_bin DEFAULT NULL,
  `Topic` varchar(4) COLLATE utf8mb4_bin DEFAULT NULL,
  `CourseType` varchar(4) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`CourseID`),
  UNIQUE KEY `CourseID` (`CourseID`),
  CONSTRAINT `course_chk_2` CHECK (((`CourseType` = _utf8mb4'Onli') or (`CourseType` = _utf8mb4'Lect') or (`CourseType` = _utf8mb4'Lab')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (0,'Algebra','MATH','Lect'),(1,'English I','ENGL','Lect'),(2,'Chemistry','SCIE','Lab'),(3,'History','HIST','Lect'),(4,'Calculus I','MATH','Lect'),(5,'Computer Science I','COMP','Lab'),(6,'Intro to Psychology','PSYC','Lect'),(7,'Calculus II','MATH','Lab'),(12,'Algebra II','MATH','Lect');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `courseview`
--

DROP TABLE IF EXISTS `courseview`;
/*!50001 DROP VIEW IF EXISTS `courseview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `courseview` AS SELECT 
 1 AS `CourseID`,
 1 AS `CourseName`,
 1 AS `Topic`,
 1 AS `CourseType`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `exam`
--

DROP TABLE IF EXISTS `exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam` (
  `ExamID` int NOT NULL,
  `CourseID` int NOT NULL,
  `ExamType` varchar(7) COLLATE utf8mb4_bin DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  PRIMARY KEY (`ExamID`,`CourseID`),
  KEY `CourseID_idx` (`CourseID`),
  CONSTRAINT `CourseID` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`),
  CONSTRAINT `exam_chk_1` CHECK (((`ExamType` = _utf8mb4'Final') or (`ExamType` = _utf8mb4'Midterm') or (`ExamType` = _utf8mb4'Unit')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam`
--

LOCK TABLES `exam` WRITE;
/*!40000 ALTER TABLE `exam` DISABLE KEYS */;
INSERT INTO `exam` VALUES (1,2,'Unit','2000-02-02'),(1,12,'Unit','2019-09-20'),(2,12,'Midterm','2019-11-01'),(3,12,'Final','2019-12-09'),(5,3,'Midterm','2001-10-11');
/*!40000 ALTER TABLE `exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_grade`
--

DROP TABLE IF EXISTS `exam_grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_grade` (
  `StudentID` int NOT NULL,
  `ExamID` int NOT NULL,
  `CourseID` int NOT NULL,
  `Grade` int DEFAULT NULL,
  `DateTaken` date DEFAULT NULL,
  `Retakeable` varchar(1) COLLATE utf8mb4_bin DEFAULT 'N',
  `Curved` varchar(1) COLLATE utf8mb4_bin DEFAULT 'N',
  PRIMARY KEY (`StudentID`,`ExamID`,`CourseID`),
  KEY `ExamID_idx` (`ExamID`),
  KEY `CourseID_idx` (`CourseID`),
  CONSTRAINT `exam_grade_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `exam` (`CourseID`),
  CONSTRAINT `ExamID` FOREIGN KEY (`ExamID`) REFERENCES `exam` (`ExamID`),
  CONSTRAINT `StudentID` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`),
  CONSTRAINT `exam_grade_chk_1` CHECK (((`Grade` > -(1)) and (`Grade` < 101)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_grade`
--

LOCK TABLES `exam_grade` WRITE;
/*!40000 ALTER TABLE `exam_grade` DISABLE KEYS */;
INSERT INTO `exam_grade` VALUES (1,1,2,92,'2019-12-16','N','N'),(3,1,2,86,'2019-12-16','N','N'),(38,1,12,90,'2019-09-21','Y','N'),(38,2,12,94,'2019-11-01','N','Y'),(38,3,12,92,'2019-12-09','N','N');
/*!40000 ALTER TABLE `exam_grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `examgradeview`
--

DROP TABLE IF EXISTS `examgradeview`;
/*!50001 DROP VIEW IF EXISTS `examgradeview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `examgradeview` AS SELECT 
 1 AS `StudentID`,
 1 AS `ExamID`,
 1 AS `CourseID`,
 1 AS `Grade`,
 1 AS `DateTaken`,
 1 AS `Retakeable`,
 1 AS `Curved`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `examview`
--

DROP TABLE IF EXISTS `examview`;
/*!50001 DROP VIEW IF EXISTS `examview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `examview` AS SELECT 
 1 AS `ExamID`,
 1 AS `CourseID`,
 1 AS `ExamType`,
 1 AS `StartDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `section` (
  `CourseID` int NOT NULL,
  `SectionID` int NOT NULL,
  `Semester` varchar(6) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`CourseID`,`SectionID`),
  CONSTRAINT `section_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`),
  CONSTRAINT `section_chk_1` CHECK (((`Semester` = _utf8mb4'Fall') or (`Semester` = _utf8mb4'Spring') or (`Semester` = _utf8mb4'Summer')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES (0,1,'Fall'),(0,2,'Fall'),(1,1,'Fall'),(1,2,'Fall'),(2,1,'Spring'),(2,2,'Spring'),(3,1,'Fall'),(3,2,'Fall'),(4,1,'Summer'),(4,2,'Summer'),(4,3,'Spring'),(5,1,'Fall'),(5,2,'Fall'),(6,1,'Spring'),(12,1,'Fall');
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `sectionview`
--

DROP TABLE IF EXISTS `sectionview`;
/*!50001 DROP VIEW IF EXISTS `sectionview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sectionview` AS SELECT 
 1 AS `CourseID`,
 1 AS `SectionID`,
 1 AS `Semester`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `StudentID` int NOT NULL,
  `FirstName` varchar(20) COLLATE utf8mb4_bin DEFAULT 'John',
  `LastName` varchar(20) COLLATE utf8mb4_bin DEFAULT 'Doe',
  `Class` varchar(2) COLLATE utf8mb4_bin DEFAULT NULL,
  `Major` varchar(45) COLLATE utf8mb4_bin DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  PRIMARY KEY (`StudentID`),
  UNIQUE KEY `StudentID_UNIQUE` (`StudentID`),
  CONSTRAINT `student_chk_1` CHECK (((`Class` = _utf8mb4'Fr') or (`Class` = _utf8mb4'So') or (`Class` = _utf8mb4'Jr') or (`Class` = _utf8mb4'Sr')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (0,'Matt','Bishop','So','Computer Science','1999-12-14'),(1,'Bella','MacMahon','So','Computer Science','2000-08-16'),(2,'Owen','Williams','Sr','Biomedical Engineering','1998-04-03'),(3,'Willow','Ryan','Fr','Chemistry','2001-09-25'),(4,'Ethan','Jensen','So','Political Science','2000-06-10'),(5,'Harper','Phillips','Sr','Psychology','1997-01-17'),(6,'James','Holt','Fr','Education','2002-07-14'),(7,'Grace','Sullivan','Jr','Agriculture','1998-02-11'),(8,'Oliver','Larsen','So','Video Game Design','1999-11-07'),(9,'Mae','Harriison','Sr','Journalism','1996-05-04'),(10,'Marshall','Peralta','Fr','Mathematics','2001-10-31'),(11,'Daisy','Aldrin','Jr','Law','1998-12-04'),(12,'Parker','Johnson','Jr','Aerospace Engineering','1998-03-19'),(13,'Lily','Young','So','Marine Science','1999-08-19'),(14,'William','Smith','Fr','Hip Hop','2000-09-25'),(15,'Rose','Martin','Fr','Forensic Science','2001-07-04'),(16,'Maxwell','Lennard','Sr','Genetics','1997-12-29'),(17,'Claire','Eastwood','Jr','German','1999-05-13'),(18,'Miles','Newton','So','Astronomy','1999-10-08'),(19,'Eleanor','Knox','Jr','Biology','1998-04-17'),(20,'Charles','Thorton','Fr','English','2001-03-31'),(38,'Peyton','Tuck','Fr','Mathematics','2001-10-10');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `studentview`
--

DROP TABLE IF EXISTS `studentview`;
/*!50001 DROP VIEW IF EXISTS `studentview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `studentview` AS SELECT 
 1 AS `StudentId`,
 1 AS `FirstName`,
 1 AS `LastName`,
 1 AS `Class`,
 1 AS `Major`,
 1 AS `DateOfBirth`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'studentexammanagementdb'
--
/*!50003 DROP PROCEDURE IF EXISTS `addcourse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addcourse`( IN id INT, IN coursename VARCHAR(45), IN topic VARCHAR(4), IN coursetype VARCHAR(4) )
INSERT INTO COURSEVIEW
	SELECT id, coursename, topic, coursetype ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addexam` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addexam`(IN examid INT, IN courseid INT, IN examtype VARCHAR(7), IN startdate DATE)
INSERT INTO EXAMVIEW
	SELECT examid, courseid, examtype, startdate ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addexamgrade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addexamgrade`(IN studentid INT, IN examid INT, IN courseid INT, IN grade INT, IN datetaken DATE, IN retake VARCHAR(1), IN curve VARCHAR(1))
INSERT INTO EXAMGRADEVIEW
    SELECT studentid, examid, courseid, grade, datetaken, retake, curve ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addsection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addsection`(IN courseid INT, IN sectionid VARCHAR(45), IN semester VARCHAR(6))
INSERT INTO SECTIONVIEW
	SELECT courseid, sectionid, semester ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addstudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addstudent`( IN id INT, IN firstna VARCHAR(20), IN lastna VARCHAR(20), 
IN class VARCHAR(2), IN major VARCHAR(45), IN dob DATE )
INSERT INTO STUDENTVIEW
	SELECT id, firstna, lastna, class, major, dob ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `averageexamgradeof` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `averageexamgradeof`( IN sid INT )
SELECT AverageExamGrade FROM AVERAGE_EXAM_GRADE
	WHERE StudentID = sid ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `countstudents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `countstudents`( )
SELECT COUNT(StudentID) FROM STUDENT ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `coursesrunningin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `coursesrunningin`( IN s VARCHAR(6))
SELECT CourseName FROM COURSE
	WHERE CourseID = (SELECT CourseID FROM SECTION 
    WHERE SectionID = 1 AND Semester = s) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `examgrades` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `examgrades`( IN sid INT, IN cid INT)
SELECT Grade FROM Exam_Grade
	WHERE StudentID = sid AND CourseID = cid ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `examOver90` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `examOver90`( IN eid INT)
SELECT FirstName, LastName FROM STUDENT
    WHERE StudentID = (SELECT StudentID FROM EXAM_GRADE WHERE ExamID = eid
    AND Grade >= 90) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `examtypesgivenin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `examtypesgivenin`( IN cid INT )
SELECT ExamType FROM EXAM 
	WHERE CourseID = cid ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listaveragegrades` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listaveragegrades`( )
SELECT * FROM AVERAGE_EXAM_GRADE ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listcourses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listcourses`( )
SELECT * FROM COURSE ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listsections` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listsections`( )
SELECT * FROM SECTION ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `liststudents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `liststudents`( )
SELECT * FROM STUDENT ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `studentcourse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `studentcourse`( IN sid INT)
SELECT CourseName FROM COURSE
    WHERE CourseID = (SELECT DISTINCT CourseID FROM EXAM_GRADE WHERE StudentID = sid) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateaverage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateaverage`(IN sid INT, IN semester VARCHAR(6))
REPLACE INTO AVERAGE_EXAM_GRADE
    SELECT sid,
    (SELECT AVG(Grade) FROM EXAM_GRADE WHERE StudentID = sid), 
    (SELECT SUM(Grade) FROM EXAM_GRADE WHERE StudentID = sid), 
    (SELECT COUNT(Grade) FROM EXAM_GRADE WHERE StudentID = sid), 
    semester ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `courseview`
--

/*!50001 DROP VIEW IF EXISTS `courseview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `courseview` AS select `course`.`CourseID` AS `CourseID`,`course`.`CourseName` AS `CourseName`,`course`.`Topic` AS `Topic`,`course`.`CourseType` AS `CourseType` from `course` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `examgradeview`
--

/*!50001 DROP VIEW IF EXISTS `examgradeview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `examgradeview` AS select `exam_grade`.`StudentID` AS `StudentID`,`exam_grade`.`ExamID` AS `ExamID`,`exam_grade`.`CourseID` AS `CourseID`,`exam_grade`.`Grade` AS `Grade`,`exam_grade`.`DateTaken` AS `DateTaken`,`exam_grade`.`Retakeable` AS `Retakeable`,`exam_grade`.`Curved` AS `Curved` from `exam_grade` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `examview`
--

/*!50001 DROP VIEW IF EXISTS `examview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `examview` AS select `exam`.`ExamID` AS `ExamID`,`exam`.`CourseID` AS `CourseID`,`exam`.`ExamType` AS `ExamType`,`exam`.`StartDate` AS `StartDate` from `exam` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sectionview`
--

/*!50001 DROP VIEW IF EXISTS `sectionview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sectionview` AS select `section`.`CourseID` AS `CourseID`,`section`.`SectionID` AS `SectionID`,`section`.`Semester` AS `Semester` from `section` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `studentview`
--

/*!50001 DROP VIEW IF EXISTS `studentview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `studentview` AS select `student`.`StudentID` AS `StudentId`,`student`.`FirstName` AS `FirstName`,`student`.`LastName` AS `LastName`,`student`.`Class` AS `Class`,`student`.`Major` AS `Major`,`student`.`DateOfBirth` AS `DateOfBirth` from `student` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-11 12:26:41
