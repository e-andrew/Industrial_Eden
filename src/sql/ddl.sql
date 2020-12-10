-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Industrial_Eden_DB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Industrial_Eden_DB` ;

-- -----------------------------------------------------
-- Schema Industrial_Eden_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Industrial_Eden_DB` DEFAULT CHARACTER SET utf8 ;
USE `Industrial_Eden_DB` ;

-- -----------------------------------------------------
-- Table `Industrial_Eden_DB`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Industrial_Eden_DB`.`User` ;

CREATE TABLE IF NOT EXISTS `Industrial_Eden_DB`.`User` (
  `UserID` INT NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `nickname` VARCHAR(20) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `confirmation` TINYINT(1) NOT NULL,
  `activationKey` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `nickname_UNIQUE` (`nickname` ASC) VISIBLE,
  UNIQUE INDEX `activationKey_UNIQUE` (`activationKey` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Industrial_Eden_DB`.`Review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Industrial_Eden_DB`.`Review` ;

CREATE TABLE IF NOT EXISTS `Industrial_Eden_DB`.`Review` (
  `ReviewID` INT NOT NULL,
  `topic` VARCHAR(45) NOT NULL,
  `text` VARCHAR(1000) NOT NULL,
  `creationdate` DATE NOT NULL,
  `AuthorID` INT NOT NULL,
  PRIMARY KEY (`ReviewID`),
  INDEX `fk_Review_User_idx` (`AuthorID` ASC) VISIBLE,
  CONSTRAINT `fk_Review_User`
    FOREIGN KEY (`AuthorID`)
    REFERENCES `Industrial_Eden_DB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Industrial_Eden_DB`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Industrial_Eden_DB`.`Role` ;

CREATE TABLE IF NOT EXISTS `Industrial_Eden_DB`.`Role` (
  `RoleID` INT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `permissions` ENUM("Guest", "Moderator", "Admin") NOT NULL,
  PRIMARY KEY (`RoleID`),
  INDEX `fk_Role_User1_idx` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_Role_User1`
    FOREIGN KEY (`name`)
    REFERENCES `Industrial_Eden_DB`.`User` (`nickname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Industrial_Eden_DB`.`Datasets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Industrial_Eden_DB`.`Datasets` ;

CREATE TABLE IF NOT EXISTS `Industrial_Eden_DB`.`Datasets` (
  `DatasetID` INT NOT NULL,
  `datasetTableName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DatasetID`),
  UNIQUE INDEX `datasetname_UNIQUE` (`datasetTableName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Industrial_Eden_DB`.`Metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Industrial_Eden_DB`.`Metadata` ;

CREATE TABLE IF NOT EXISTS `Industrial_Eden_DB`.`Metadata` (
  `MetadataID` INT NOT NULL,
  `key` VARCHAR(45) NOT NULL,
  `value` VARCHAR(45) NOT NULL,
  `Datasets_DatasetID` INT NOT NULL,
  PRIMARY KEY (`MetadataID`),
  UNIQUE INDEX `conceptioname_UNIQUE` (`key` ASC) VISIBLE,
  INDEX `fk_Metadata_Datasets1_idx` (`Datasets_DatasetID` ASC) VISIBLE,
  CONSTRAINT `fk_Metadata_Datasets1`
    FOREIGN KEY (`Datasets_DatasetID`)
    REFERENCES `Industrial_Eden_DB`.`Datasets` (`DatasetID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Industrial_Eden_DB`.`Entities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Industrial_Eden_DB`.`Entities` ;

CREATE TABLE IF NOT EXISTS `Industrial_Eden_DB`.`Entities` (
  `EntityID` INT NOT NULL,
  `entityTableName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`EntityID`),
  UNIQUE INDEX `entityname_UNIQUE` (`entityTableName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Industrial_Eden_DB`.`Conceptions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Industrial_Eden_DB`.`Conceptions` ;

CREATE TABLE IF NOT EXISTS `Industrial_Eden_DB`.`Conceptions` (
  `ConceptionID` INT NOT NULL,
  `conceptioTableName` VARCHAR(45) NOT NULL,
  `DatasetID` INT NOT NULL,
  PRIMARY KEY (`ConceptionID`),
  UNIQUE INDEX `conceptioname_UNIQUE` (`conceptioTableName` ASC) VISIBLE,
  INDEX `fk_Conceptions_Datasets1_idx` (`DatasetID` ASC) VISIBLE,
  CONSTRAINT `fk_Conceptions_Datasets1`
    FOREIGN KEY (`DatasetID`)
    REFERENCES `Industrial_Eden_DB`.`Datasets` (`DatasetID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Industrial_Eden_DB`.`Datapoints`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Industrial_Eden_DB`.`Datapoints` ;

CREATE TABLE IF NOT EXISTS `Industrial_Eden_DB`.`Datapoints` (
  `DatapointID` INT NOT NULL,
  `datapointTableName` VARCHAR(45) NOT NULL,
  `ElementID` INT NOT NULL,
  PRIMARY KEY (`DatapointID`),
  UNIQUE INDEX `conceptioname_UNIQUE` (`datapointTableName` ASC) VISIBLE,
  INDEX `fk_Datapoints_Datasets1_idx` (`ElementID` ASC) VISIBLE,
  CONSTRAINT `fk_Datapoints_Datasets1`
    FOREIGN KEY (`ElementID`)
    REFERENCES `Industrial_Eden_DB`.`Datasets` (`DatasetID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Datapoints_Entities1`
    FOREIGN KEY (`ElementID`)
    REFERENCES `Industrial_Eden_DB`.`Entities` (`EntityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Industrial_Eden_DB`.`Action`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Industrial_Eden_DB`.`Action` ;

CREATE TABLE IF NOT EXISTS `Industrial_Eden_DB`.`Action` (
  `ActionID` INT NOT NULL,
  `type` VARCHAR(30) NOT NULL,
  `actedAt` DATETIME NOT NULL,
  `UserID` INT NOT NULL,
  `ElementID` INT NOT NULL,
  PRIMARY KEY (`ActionID`),
  INDEX `fk_Action_User1_idx` (`UserID` ASC) VISIBLE,
  INDEX `fk_Action_Datasets1_idx` (`ElementID` ASC) VISIBLE,
  CONSTRAINT `fk_Action_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `Industrial_Eden_DB`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Action_Datasets1`
    FOREIGN KEY (`ElementID`)
    REFERENCES `Industrial_Eden_DB`.`Datasets` (`DatasetID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Action_Metadata1`
    FOREIGN KEY (`ElementID`)
    REFERENCES `Industrial_Eden_DB`.`Metadata` (`MetadataID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Action_Entities1`
    FOREIGN KEY (`ElementID`)
    REFERENCES `Industrial_Eden_DB`.`Entities` (`EntityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Action_Conceptions1`
    FOREIGN KEY (`ElementID`)
    REFERENCES `Industrial_Eden_DB`.`Conceptions` (`ConceptionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Action_Datapoints1`
    FOREIGN KEY (`ElementID`)
    REFERENCES `Industrial_Eden_DB`.`Datapoints` (`DatapointID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Industrial_Eden_DB`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `Industrial_Eden_DB`;
INSERT INTO `Industrial_Eden_DB`.`User` (`UserID`, `email`, `nickname`, `password`, `confirmation`, `activationKey`) VALUES (1, 'example1@gmail.com', 'example1', '11111111', 1, 'activate1');
INSERT INTO `Industrial_Eden_DB`.`User` (`UserID`, `email`, `nickname`, `password`, `confirmation`, `activationKey`) VALUES (2, 'example2@gmail.com', 'example2', '22222222', 1, 'activate2');
INSERT INTO `Industrial_Eden_DB`.`User` (`UserID`, `email`, `nickname`, `password`, `confirmation`, `activationKey`) VALUES (3, 'example3@gmail.com', 'example3', '33333333', 1, 'activate3');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Industrial_Eden_DB`.`Review`
-- -----------------------------------------------------
START TRANSACTION;
USE `Industrial_Eden_DB`;
INSERT INTO `Industrial_Eden_DB`.`Review` (`ReviewID`, `topic`, `text`, `creationdate`, `AuthorID`) VALUES (1, 'topic1', 'text1', '2020-06-25', 1);
INSERT INTO `Industrial_Eden_DB`.`Review` (`ReviewID`, `topic`, `text`, `creationdate`, `AuthorID`) VALUES (2, 'topic2', 'text2', '2020-06-25', 2);
INSERT INTO `Industrial_Eden_DB`.`Review` (`ReviewID`, `topic`, `text`, `creationdate`, `AuthorID`) VALUES (3, 'topic3', 'text3', '2020-06-25', 3);

COMMIT;

