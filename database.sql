-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema group5
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema group5
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `group5` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema group5
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema group5
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `group5` DEFAULT CHARACTER SET utf8 ;
USE `group5` ;

-- -----------------------------------------------------
-- Table `group5`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`Professor` (
  `professorID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Password` VARCHAR(45) NULL,
  PRIMARY KEY (`professorID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group5`.`Class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`Class` (
  `ClassID` INT NOT NULL AUTO_INCREMENT,
  `Professor` INT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`ClassID`),
  INDEX `fk_Class_Professor1_idx` (`Professor` ASC),
  CONSTRAINT `fk_Class_Professor1`
    FOREIGN KEY (`Professor`)
    REFERENCES `group5`.`Professor` (`professorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group5`.`Session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`Session` (
  `SessionID` INT NOT NULL AUTO_INCREMENT,
  `ClassID` INT NULL,
  `Name` VARCHAR(45) NULL,
  `DateCreated` DATE NULL,
  `DateArchived` DATE NULL,
  PRIMARY KEY (`SessionID`),
  INDEX `fk_Session_Class1_idx` (`ClassID` ASC),
  CONSTRAINT `fk_Session_Class1`
    FOREIGN KEY (`ClassID`)
    REFERENCES `group5`.`Class` (`ClassID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group5`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`Student` (
  `studentID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Password` VARCHAR(45) NULL,
  PRIMARY KEY (`studentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group5`.`Registration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`Registration` (
  `RegID` INT NOT NULL AUTO_INCREMENT,
  `StudentID` INT NULL,
  `ClassID` INT NULL,
  `DateJoined` DATE NULL,
  PRIMARY KEY (`RegID`),
  INDEX `fk_Registration_Class1_idx` (`ClassID` ASC),
  INDEX `fk_Registration_Student1_idx` (`StudentID` ASC),
  CONSTRAINT `fk_Registration_Class1`
    FOREIGN KEY (`ClassID`)
    REFERENCES `group5`.`Class` (`ClassID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registration_Student1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `group5`.`Student` (`studentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group5`.`Ban`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`Ban` (
  `BanID` INT NOT NULL AUTO_INCREMENT,
  `StudentID` INT NULL,
  `ClassID` INT NULL,
  `DateBanned` DATE NULL,
  PRIMARY KEY (`BanID`),
  INDEX `fk_Ban_Class1_idx` (`ClassID` ASC),
  INDEX `fk_Ban_Student1_idx` (`StudentID` ASC),
  CONSTRAINT `fk_Ban_Class1`
    FOREIGN KEY (`ClassID`)
    REFERENCES `group5`.`Class` (`ClassID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ban_Student1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `group5`.`Student` (`studentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group5`.`Poll`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`Poll` (
  `PollID` INT NOT NULL AUTO_INCREMENT,
  `SessionID` INT NULL,
  `QuestionText` VARCHAR(100) NULL,
  `Answers` VARCHAR(100) NULL,
  `DateCreated` DATE NULL,
  `Archived` DATE NULL,
  `DateArchived` DATE NULL,
  PRIMARY KEY (`PollID`),
  INDEX `fk_Poll_Session1_idx` (`SessionID` ASC),
  CONSTRAINT `fk_Poll_Session1`
    FOREIGN KEY (`SessionID`)
    REFERENCES `group5`.`Session` (`SessionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group5`.`Question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`Question` (
  `questionID` INT NOT NULL AUTO_INCREMENT,
  `SessionID` INT NULL,
  `StudentID` INT NULL,
  `Text` VARCHAR(100) NULL,
  `User` VARCHAR(45) NULL,
  `isRead` VARCHAR(45) NULL,
  `DateTime` DATE NULL,
  PRIMARY KEY (`questionID`),
  INDEX `fk_Question_Session1_idx` (`SessionID` ASC),
  INDEX `fk_Question_Student1_idx` (`StudentID` ASC),
  CONSTRAINT `fk_Question_Session1`
    FOREIGN KEY (`SessionID`)
    REFERENCES `group5`.`Session` (`SessionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Question_Student1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `group5`.`Student` (`studentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group5`.`Vote`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group5`.`Vote` (
  `VoteID` INT NOT NULL AUTO_INCREMENT,
  `PollID` INT NULL,
  `StudentID` INT NULL,
  `Answer` VARCHAR(100) NULL,
  PRIMARY KEY (`VoteID`),
  INDEX `fk_Vote_Poll1_idx` (`PollID` ASC),
  INDEX `fk_Vote_Student1_idx` (`StudentID` ASC),
  CONSTRAINT `fk_Vote_Poll1`
    FOREIGN KEY (`PollID`)
    REFERENCES `group5`.`Poll` (`PollID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vote_Student1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `group5`.`Student` (`studentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `group5` ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;