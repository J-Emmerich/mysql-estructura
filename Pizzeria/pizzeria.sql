-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`provincia` (
  `provincia_id` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`provincia_id`),
  UNIQUE INDEX `Nom_UNIQUE` (`Nom` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`localitat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`localitat` (
  `localitat_id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `provincia_id` INT NOT NULL,
  PRIMARY KEY (`localitat_id`),
  INDEX `fk_localitat_provincia_idx` (`provincia_id` ASC),
  CONSTRAINT `fk_localitat_provincia`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `Pizzeria`.`provincia` (`provincia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`adreca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`adreca` (
  `adreca_id` INT NOT NULL AUTO_INCREMENT,
  `adreca` VARCHAR(45) NOT NULL,
  `codi_postal` VARCHAR(5) NOT NULL,
  `localitat_id` INT NOT NULL,
  PRIMARY KEY (`adreca_id`),
  INDEX `fk_adreca_localitat1_idx` (`localitat_id` ASC),
  CONSTRAINT `fk_adreca_localitat1`
    FOREIGN KEY (`localitat_id`)
    REFERENCES `Pizzeria`.`localitat` (`localitat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`cliente` (
  `cliente_id` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `cognom` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  `adreca_id` INT NOT NULL,
  PRIMARY KEY (`cliente_id`),
  INDEX `fk_cliente_adreca1_idx` (`adreca_id` ASC),
  CONSTRAINT `fk_cliente_adreca1`
    FOREIGN KEY (`adreca_id`)
    REFERENCES `Pizzeria`.`adreca` (`adreca_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Botiga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Botiga` (
  `Botiga_id` INT NOT NULL AUTO_INCREMENT,
  `adreca_id` INT NOT NULL,
  PRIMARY KEY (`Botiga_id`),
  INDEX `fk_Botiga_adreca1_idx` (`adreca_id` ASC),
  CONSTRAINT `fk_Botiga_adreca1`
    FOREIGN KEY (`adreca_id`)
    REFERENCES `Pizzeria`.`adreca` (`adreca_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`empleat` (
  `empleat_id` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Cognom` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(10) NOT NULL,
  `telefon` VARCHAR(15) NOT NULL,
  `tasca` VARCHAR(45) NOT NULL,
  `Botiga_id` INT NOT NULL,
  PRIMARY KEY (`empleat_id`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC),
  INDEX `fk_empleat_Botiga1_idx` (`Botiga_id` ASC),
  CONSTRAINT `fk_empleat_Botiga1`
    FOREIGN KEY (`Botiga_id`)
    REFERENCES `Pizzeria`.`Botiga` (`Botiga_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`comande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`comande` (
  `comande_id` INT NOT NULL AUTO_INCREMENT,
  `data_compra` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `repartir` TINYINT NOT NULL COMMENT '1 repartiment a domicili, 0 per a recollir en botiga',
  `preu_total` DECIMAL(6,2) NOT NULL,
  `Botiga_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  `empleat_id` INT NOT NULL,
  PRIMARY KEY (`comande_id`),
  INDEX `fk_comande_Botiga1_idx` (`Botiga_id` ASC),
  INDEX `fk_comande_cliente1_idx` (`cliente_id` ASC),
  INDEX `fk_comande_empleat1_idx` (`empleat_id` ASC),
  CONSTRAINT `fk_comande_Botiga1`
    FOREIGN KEY (`Botiga_id`)
    REFERENCES `Pizzeria`.`Botiga` (`Botiga_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comande_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `Pizzeria`.`cliente` (`cliente_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comande_empleat1`
    FOREIGN KEY (`empleat_id`)
    REFERENCES `Pizzeria`.`empleat` (`empleat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`lliurament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`lliurament` (
  `lliurament_id` INT NOT NULL AUTO_INCREMENT,
  `comande_id` INT NOT NULL,
  `data_lliurament` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`lliurament_id`),
  INDEX `fk_empleat_comande_comande1_idx` (`comande_id` ASC),
  CONSTRAINT `fk_empleat_comande_comande1`
    FOREIGN KEY (`comande_id`)
    REFERENCES `Pizzeria`.`comande` (`comande_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`categoria` (
  `categoria_id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`categoria_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`producte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`producte` (
  `producte_id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(45) NULL,
  `imatge_url` VARCHAR(45) NULL,
  `preu` DECIMAL(6,2) NOT NULL,
  `categoria_id` INT NOT NULL,
  PRIMARY KEY (`producte_id`),
  INDEX `fk_producte_categoria1_idx` (`categoria_id` ASC),
  CONSTRAINT `fk_producte_categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `Pizzeria`.`categoria` (`categoria_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`comande_detall`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`comande_detall` (
  `comande_detall_id` INT NOT NULL AUTO_INCREMENT,
  `quantitat` TINYINT NOT NULL,
  `preu_cadascun` DECIMAL(6,2) NOT NULL,
  `producte_id` INT NOT NULL,
  `comande_id` INT NOT NULL,
  PRIMARY KEY (`comande_detall_id`),
  INDEX `fk_comande_detall_producte1_idx` (`producte_id` ASC),
  INDEX `fk_comande_detall_comande1_idx` (`comande_id` ASC),
  CONSTRAINT `fk_comande_detall_producte1`
    FOREIGN KEY (`producte_id`)
    REFERENCES `Pizzeria`.`producte` (`producte_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comande_detall_comande1`
    FOREIGN KEY (`comande_id`)
    REFERENCES `Pizzeria`.`comande` (`comande_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
