-- MySQL Script generated by MySQL Workbench
-- Mon Mar 30 12:51:59 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema StudentExamManagementDB
-- -----------------------------------------------------
-- Databases Final Project

-- -----------------------------------------------------
-- Schema StudentExamManagementDB
--
-- Databases Final Project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `StudentExamManagementDB` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin ;
USE `StudentExamManagementDB` ;

-- -----------------------------------------------------
-- Table `StudentExamManagementDB`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `StudentExamManagementDB`.`Student` (
  `StudentID` INT NOT NULL,
  `FirstName` VARCHAR(20) NULL,
  `LastName` VARCHAR(20) NULL,
  `Class` VARCHAR(2) NULL,
  `Major` VARCHAR(45) NULL,
  `DateOfBirth` DATE NULL,
  PRIMARY KEY (`StudentID`),
  UNIQUE INDEX `StudentID_UNIQUE` (`StudentID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StudentExamManagementDB`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `StudentExamManagementDB`.`Course` (
  `CourseID` INT NOT NULL,
  `CourseName` VARCHAR(45) NULL,
  `Semester` VARCHAR(6) NULL,
  `Section` INT NOT NULL,
  `Topic` VARCHAR(4) NULL,
  `CourseType` VARCHAR(4) NULL,
  PRIMARY KEY (`CourseID`, `Section`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `StudentExamManagementDB`.`Exam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `StudentExamManagementDB`.`Exam` (
  `ExamID` INT NOT NULL,
  `CourseID` INT NOT NULL,
  `ExamType` VARCHAR(7) NULL,
  `StartDate` DATE NULL,
  PRIMARY KEY (`ExamID`, `CourseID`),
  INDEX `CourseID_idx` (`CourseID` ASC) VISIBLE,
  CONSTRAINT `CourseID`
    FOREIGN KEY (`CourseID`)
    REFERENCES `StudentExamManagementDB`.`Course` (`CourseID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `StudentExamManagementDB`.`Exam Grade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `StudentExamManagementDB`.`Exam_Grade` (
  `StudentID` INT NOT NULL,
  `ExamID` INT NOT NULL,
  `CourseID` INT NOT NULL,
  `Grade` INT NULL,
  `DateTaken` DATE NULL,
  `Retakeable` VARCHAR(1) NULL,
  `Curved` VARCHAR(1) NULL,
  PRIMARY KEY (`StudentID`, `ExamID`, `CourseID`),
  INDEX `ExamID_idx` (`ExamID` ASC) VISIBLE,
  INDEX `CourseID_idx` (`CourseID` ASC) VISIBLE,
  CONSTRAINT `StudentID`
    FOREIGN KEY (`StudentID`)
    REFERENCES `StudentExamManagementDB`.`Student` (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ExamID`
    FOREIGN KEY (`ExamID`)
    REFERENCES `StudentExamManagementDB`.`Exam` (`ExamID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`CourseID`)
    REFERENCES `StudentExamManagementDB`.`Exam` (`CourseID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `StudentExamManagementDB`.`Average Exam Grade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `StudentExamManagementDB`.`Average_Exam_Grade` (
    `StudentID` INT NOT NULL,
    `AverageExamGrade` INT NULL,
    `TotalPoints` INT NULL,
    `NumberOfExams` INT NULL,
    `Semester` VARCHAR(6) NULL,
    PRIMARY KEY (`StudentID`),
    FOREIGN KEY (`StudentID`)
        REFERENCES `StudentExamManagementDB`.`Student` (`StudentID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET SQL_SAFE_UPDATES = 0;