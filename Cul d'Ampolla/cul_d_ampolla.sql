-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cul_d_ampolla
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cul_d_ampolla` ;

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
  `Codigo_Postal` VARCHAR(5) NOT NULL,
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
-- Table `cul_d_ampolla`.`Comandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`Comandes` (
  `Comande_ID` INT NOT NULL AUTO_INCREMENT,
  `Total` DECIMAL(6,2) NOT NULL,
  `Cliente_id` INT NOT NULL,
  `fecha_compra` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `Empleados_id` INT NOT NULL,
  `Ulleres_id` INT NOT NULL,
  PRIMARY KEY (`Comande_ID`),
  INDEX `fk_Comandes_Clientes1_idx` (`Cliente_id` ASC),
  INDEX `fk_Comandes_Empleados1_idx` (`Empleados_id` ASC),
  INDEX `fk_Comandes_Ulleres1_idx` (`Ulleres_id` ASC),
  CONSTRAINT `fk_Comandes_Clientes1`
    FOREIGN KEY (`Cliente_id`)
    REFERENCES `cul_d_ampolla`.`Clientes` (`Cliente_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comandes_Empleados1`
    FOREIGN KEY (`Empleados_id`)
    REFERENCES `cul_d_ampolla`.`Empleados` (`Empleados_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comandes_Ulleres1`
    FOREIGN KEY (`Ulleres_id`)
    REFERENCES `cul_d_ampolla`.`Ulleres` (`Ulleres_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO adressa(carrer, numero, piso, porta, ciutat, codigo_postal, pais) VALUES ('Marina', '67', '1', '1', 'Barcelona', '08034', 'ES');
INSERT INTO adressa(carrer, numero, piso, porta, ciutat, codigo_postal, pais) VALUES ('Fastenrath', '67', '1', '1', 'Barcelona', '08044', 'ES');
INSERT INTO adressa(carrer, numero, piso, porta, ciutat, codigo_postal, pais) VALUES ('Góngora', '67', '1', '1', 'Barcelona', '08035', 'ES');
INSERT INTO adressa(carrer, numero, piso, porta, ciutat, codigo_postal, pais) VALUES ('Medeiros', '67', '1', '1', 'Barcelona', '08065', 'ES');
INSERT INTO adressa(carrer, numero, piso, porta, ciutat, codigo_postal, pais) VALUES ('Juliao', '67', '1', '1', 'Barcelona', '08024', 'ES');

INSERT INTO clientes(nom, cognoms, telefon, email,adressa_adressa_id) VALUES('Linguado', 'Macalé', '3232323434', 'rafaelito@email.com',3);
INSERT INTO clientes(nom, cognoms, telefon, email,adressa_adressa_id) VALUES('Rafael', 'Mistura', '33250987', 'rafaelito@email.com',2);
INSERT INTO clientes(nom, cognoms, telefon, email,adressa_adressa_id) VALUES('Pizzara', 'Parangolé', '9995554432', 'macanuda@email.com',2);
INSERT INTO proveidor(nif,nom, telefon, fax, adressa_adressa_id) VALUES('y44434567e', 'Joao', '88876578',null,1);
INSERT INTO proveidor(nif,nom, telefon, fax, adressa_adressa_id) VALUES('X8882332f', 'Pamplona', '2376578',null,2);

INSERT INTO ulleres(marca, graduació_dreta, graduació_esquerra, color_dreta, color_esquerra, muntura, color_muntura, precio, proveidor_proveidor_id)
values ('Bamba', '-0.25', '0.6', 'azul', 'azul', 'standard', 'blanca', 76.89, 1);
INSERT INTO ulleres(marca, graduació_dreta, graduació_esquerra, color_dreta, color_esquerra, muntura, color_muntura, precio, proveidor_proveidor_id)
values ('Bamba', '2.25', '-0.6', 'azul', 'azul', 'standard', 'blanca', 143.89, 1);
INSERT INTO ulleres(marca, graduació_dreta, graduació_esquerra, color_dreta, color_esquerra, muntura, color_muntura, precio, proveidor_proveidor_id)
values ('Bacon', '-0.25', '2.6', 'azul', 'azul', 'especial', 'blanca', 444.89, 1);
INSERT INTO ulleres(marca, graduació_dreta, graduació_esquerra, color_dreta, color_esquerra, muntura, color_muntura, precio, proveidor_proveidor_id)
values ('Merchan', '-0.25', '0.6', 'azul', 'azul', 'standard', 'blanca', 176.66, 2);
INSERT INTO ulleres(marca, graduació_dreta, graduació_esquerra, color_dreta, color_esquerra, muntura, color_muntura, precio, proveidor_proveidor_id)
values ('Merchan', '-0.25', '0.6', 'azul', 'azul', 'standard', 'blanca', 176.66, 1);
INSERT INTO ulleres(marca, graduació_dreta, graduació_esquerra, color_dreta, color_esquerra, muntura, color_muntura, precio, proveidor_proveidor_id)
values ('Miriade', '-0.25', '0.6', 'azul', 'azul', 'standard', 'blanca', 323.66, 2);

INSERT INTO Empleados(nom) VALUES ('Cannonball Adderley');
INSERT INTO Empleados(nom) VALUES ('Charles Mingus');
INSERT INTO Empleados(nom) VALUES ('Coltrane');
INSERT INTO Empleados(nom) VALUES ('Miles');
INSERT INTO Empleados(nom) VALUES ('Chet');

INSERT INTO comandes(total, clientes_id, fecha_compra, empleados_id, ulleres_id) VALUES (2322.34, 4, '2020-05-05 00:00:01', 1,3);
INSERT INTO comandes(total, clientes_id, fecha_compra, empleados_id, ulleres_id) VALUES (2322.34, 3, '2020-08-00 00:00:01', 3,2);
INSERT INTO comandes(total, clientes_id, fecha_compra, empleados_id, ulleres_id) VALUES (2322.34, 5, '2020-04-10 00:00:01', 3,1);
INSERT INTO comandes(total, clientes_id, fecha_compra, empleados_id, ulleres_id) VALUES (2322.34, 2, '2020-10-10 00:00:01', 3,1);
INSERT INTO comandes(total, clientes_id, fecha_compra, empleados_id, ulleres_id) VALUES (2322.34, 4, '2021-01-12 00:00:01', 2,5);
INSERT INTO comandes(total, clientes_id, fecha_compra, empleados_id, ulleres_id) VALUES (2322.34, 2, '2020-04-21 00:00:01', 2,4);
INSERT INTO comandes(total, clientes_id, fecha_compra, empleados_id, ulleres_id) VALUES (2322.34, 1, '2020-03-24 00:00:01', 2,4);
INSERT INTO comandes(total, clientes_id, fecha_compra, empleados_id, ulleres_id) VALUES (2322.34, 1, '2021-06-05 00:00:01', 2,4);