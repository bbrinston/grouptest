-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema group5
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema group5
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `group5` DEFAULT CHARACTER SET utf8 ;
USE `group5` ;

-- -----------------------------------------------------
-- Table `group5`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`professor` (
  `professorID` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Password` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`professorID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `group5`.`class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`class` (
  `ClassID` INT(11) NOT NULL AUTO_INCREMENT,
  `ProfessorID` INT(11) NULL DEFAULT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ClassID`),
  INDEX `fk_Class_Professor1_idx` (`ProfessorID` ASC),
  CONSTRAINT `fk_Class_Professor1`
    FOREIGN KEY (`ProfessorID`)
    REFERENCES `group5`.`professor` (`professorID`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `group5`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`student` (
  `studentID` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Password` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`studentID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `group5`.`ban`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`ban` (
  `BanID` INT(11) NOT NULL AUTO_INCREMENT,
  `StudentID` INT(11) NULL DEFAULT NULL,
  `ClassID` INT(11) NULL DEFAULT NULL,
  `DateBanned` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`BanID`),
  INDEX `fk_Ban_Class1_idx` (`ClassID` ASC),
  INDEX `fk_Ban_Student1_idx` (`StudentID` ASC),
  CONSTRAINT `fk_Ban_Class1`
    FOREIGN KEY (`ClassID`)
    REFERENCES `group5`.`class` (`ClassID`),
  CONSTRAINT `fk_Ban_Student1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `group5`.`student` (`studentID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `group5`.`session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`session` (
  `SessionID` INT(11) NOT NULL AUTO_INCREMENT,
  `ClassID` INT(11) NULL DEFAULT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `DateCreated` VARCHAR(45) NULL DEFAULT NULL,
  `DateArchived` VARCHAR(45) NULL DEFAULT NULL,
  `Archived` INT(11) NULL DEFAULT '0',
  PRIMARY KEY (`SessionID`),
  INDEX `fk_Session_Class1_idx` (`ClassID` ASC),
  CONSTRAINT `fk_Session_Class1`
    FOREIGN KEY (`ClassID`)
    REFERENCES `group5`.`class` (`ClassID`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `group5`.`poll`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`poll` (
  `PollID` INT(11) NOT NULL AUTO_INCREMENT,
  `SessionID` INT(11) NULL DEFAULT NULL,
  `QuestionText` VARCHAR(100) NULL DEFAULT NULL,
  `Answers` VARCHAR(100) NULL DEFAULT NULL,
  `DateCreated` VARCHAR(45) NULL DEFAULT NULL,
  `IsArchived` TINYINT(4) NULL DEFAULT '0',
  `DateArchived` VARCHAR(45) NULL DEFAULT NULL,
  `NumAnswers` INT(11) NULL DEFAULT '0',
  `Pollcol` INT(11) NULL DEFAULT '0',
  `Answer1` VARCHAR(45) NULL DEFAULT NULL,
  `Answer2` VARCHAR(45) NULL DEFAULT NULL,
  `Answer3` VARCHAR(45) NULL DEFAULT NULL,
  `Answer4` VARCHAR(45) NULL DEFAULT NULL,
  `Answer5` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`PollID`),
  INDEX `fk_Poll_Session1_idx` (`SessionID` ASC),
  CONSTRAINT `fk_Poll_Session1`
    FOREIGN KEY (`SessionID`)
    REFERENCES `group5`.`session` (`SessionID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `group5`.`question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`question` (
  `QuestionID` INT(11) NOT NULL AUTO_INCREMENT,
  `SessionID` INT(11) NULL DEFAULT NULL,
  `UserID` INT(11) NULL DEFAULT NULL,
  `Text` VARCHAR(100) NULL DEFAULT NULL,
  `User` VARCHAR(45) NULL DEFAULT NULL,
  `IsRead` VARCHAR(45) NULL DEFAULT NULL,
  `DateTime` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`QuestionID`),
  INDEX `fk_Question_Session1_idx` (`SessionID` ASC),
  INDEX `fk_Question_Student1_idx` (`UserID` ASC),
  CONSTRAINT `fk_Question_Session1`
    FOREIGN KEY (`SessionID`)
    REFERENCES `group5`.`session` (`SessionID`),
  CONSTRAINT `fk_Question_Student1`
    FOREIGN KEY (`UserID`)
    REFERENCES `group5`.`student` (`studentID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `group5`.`registration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`registration` (
  `RegID` INT(11) NOT NULL AUTO_INCREMENT,
  `StudentID` INT(11) NULL DEFAULT NULL,
  `ClassID` INT(11) NULL DEFAULT NULL,
  `DateJoined` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`RegID`),
  INDEX `fk_Registration_Class1_idx` (`ClassID` ASC),
  INDEX `fk_Registration_Student1_idx` (`StudentID` ASC),
  CONSTRAINT `fk_Registration_Class1`
    FOREIGN KEY (`ClassID`)
    REFERENCES `group5`.`class` (`ClassID`),
  CONSTRAINT `fk_Registration_Student1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `group5`.`student` (`studentID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `group5`.`vote`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`vote` (
  `VoteID` INT(11) NOT NULL AUTO_INCREMENT,
  `PollID` INT(11) NULL DEFAULT NULL,
  `StudentID` INT(11) NULL DEFAULT NULL,
  `Answer` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`VoteID`),
  INDEX `fk_Vote_Poll1_idx` (`PollID` ASC),
  INDEX `fk_Vote_Student1_idx` (`StudentID` ASC),
  CONSTRAINT `fk_Vote_Poll1`
    FOREIGN KEY (`PollID`)
    REFERENCES `group5`.`poll` (`PollID`),
  CONSTRAINT `fk_Vote_Student1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `group5`.`student` (`studentID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
