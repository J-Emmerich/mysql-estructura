-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cul_d_ampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cul_d_ampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cul_d_ampolla` DEFAULT CHARACTER SET utf8 ;
USE `cul_d_ampolla` ;

-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`Adressa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`Adressa` (
  `Adressa_id` INT NOT NULL AUTO_INCREMENT,
  `Carrer` VARCHAR(45) NOT NULL,
  `Numero` VARCHAR(8) NOT NULL,
  `Piso` VARCHAR(8) NULL,
  `Porta` VARCHAR(2) NULL,
  `Ciutat` VARCHAR(45) NOT NULL,
  `Codigo Postal` VARCHAR(5) NOT NULL,
  `Pais` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`Adressa_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`Proveidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`Proveidor` (
  `Proveidor_ID` INT NOT NULL AUTO_INCREMENT,
  `NIF` VARCHAR(10) NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  `Telefon` VARCHAR(15) NULL,
  `Fax` VARCHAR(45) NULL,
  `Adressa_id` INT NOT NULL,
  PRIMARY KEY (`Proveidor_ID`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC),
  INDEX `fk_Proveidor_Adressa_idx` (`Adressa_id` ASC),
  CONSTRAINT `fk_Proveidor_Adressa`
    FOREIGN KEY (`Adressa_id`)
    REFERENCES `cul_d_ampolla`.`Adressa` (`Adressa_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`Clientes` (
  `Cliente_id` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NULL,
  `Cognoms` VARCHAR(45) NULL,
  `Telefon` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `fecha_registre` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `Adressa_id` INT NOT NULL,
  PRIMARY KEY (`Cliente_id`),
  INDEX `fk_Clientes_Adressa1_idx` (`Adressa_id` ASC),
  CONSTRAINT `fk_Clientes_Adressa1`
    FOREIGN KEY (`Adressa_id`)
    REFERENCES `cul_d_ampolla`.`Adressa` (`Adressa_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`Comandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`Comandes` (
  `Comande_ID` INT NOT NULL AUTO_INCREMENT,
  `Total` DECIMAL(6,2) NOT NULL,
  `Cliente_id` INT NOT NULL,
  `fecha_compra` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Comande_ID`),
  INDEX `fk_Comandes_Clientes1_idx` (`Cliente_id` ASC),
  CONSTRAINT `fk_Comandes_Clientes1`
    FOREIGN KEY (`Cliente_id`)
    REFERENCES `cul_d_ampolla`.`Clientes` (`Cliente_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`Empleados` (
  `Empleados_id` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NULL,
  PRIMARY KEY (`Empleados_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`Ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`Ulleres` (
  `Ulleres_id` INT NOT NULL AUTO_INCREMENT,
  `Marca` VARCHAR(45) NOT NULL,
  `graduació_dreta` VARCHAR(10) NULL,
  `graduació_esquerra` VARCHAR(10) NULL,
  `color_dreta` VARCHAR(10) NULL,
  `color_esquerra` VARCHAR(10) NULL,
  `muntura` VARCHAR(45) NULL,
  `color_muntura` VARCHAR(45) NULL,
  `precio` DECIMAL(6,2) NULL,
  `Proveidor_ID` INT NOT NULL,
  PRIMARY KEY (`Ulleres_id`),
  INDEX `fk_Ulleres_Proveidor1_idx` (`Proveidor_ID` ASC),
  CONSTRAINT `fk_Ulleres_Proveidor1`
    FOREIGN KEY (`Proveidor_ID`)
    REFERENCES `cul_d_ampolla`.`Proveidor` (`Proveidor_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`Comande_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`Comande_details` (
  `Comande_details_id` INT NOT NULL AUTO_INCREMENT,
  `Cuantidad_ulleres` VARCHAR(45) NULL,
  `Comande_ID` INT NOT NULL,
  `Empleados_id` INT NOT NULL,
  `Ulleres_id` INT NOT NULL,
  PRIMARY KEY (`Comande_details_id`),
  INDEX `fk_Comande_details_Comandes1_idx` (`Comande_ID` ASC),
  INDEX `fk_Comande_details_Empleados1_idx` (`Empleados_id` ASC),
  INDEX `fk_Comande_details_Ulleres1_idx` (`Ulleres_id` ASC),
  CONSTRAINT `fk_Comande_details_Comandes1`
    FOREIGN KEY (`Comande_ID`)
    REFERENCES `cul_d_ampolla`.`Comandes` (`Comande_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comande_details_Empleados1`
    FOREIGN KEY (`Empleados_id`)
    REFERENCES `cul_d_ampolla`.`Empleados` (`Empleados_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comande_details_Ulleres1`
    FOREIGN KEY (`Ulleres_id`)
    REFERENCES `cul_d_ampolla`.`Ulleres` (`Ulleres_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
