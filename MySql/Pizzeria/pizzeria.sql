-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Pizzeria` ;

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
  `Tipo` VARCHAR(20) NOT NULL,
  `descripcio` VARCHAR(45) NULL,
  `imatge_url` VARCHAR(45) NULL,
  `preu` DECIMAL(6,2) NOT NULL,
  `categoria_id` INT NULL,
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


INSERT INTO categoria(nom) VALUES ('Vegetarianas');
INSERT INTO categoria(nom) VALUES ('Veganas');
INSERT INTO categoria(nom) VALUES ('Tradicionales');

INSERT INTO producte(nom, tipo, descripcio, imatge_url, preu, categoria_id) VALUES('Coca-Cola', 'Bebida',null, null, 3.50, null);
INSERT INTO producte(nom, tipo, descripcio, imatge_url, preu, categoria_id) VALUES('4 quesos', 'Pizza',null, null, 8.00, null);
INSERT INTO producte(nom, tipo, descripcio, imatge_url, preu, categoria_id) VALUES('Margherita', 'Pizza',null, null, 2.50, null);
INSERT INTO producte(nom, tipo, descripcio, imatge_url, preu, categoria_id) VALUES('Con panceta', 'Hamburgueses',null, null, 3.50, null);
INSERT INTO producte(nom, tipo, descripcio, imatge_url, preu, categoria_id) VALUES('Peperoni', 'Pizza',null, null, 8.50, null);
INSERT INTO producte(nom, tipo, descripcio, imatge_url, preu, categoria_id) VALUES('Vegana', 'Pizza',null, null, 13.50, null);

INSERT INTO provincia(nom) VALUES ('Barcelona');
INSERT INTO provincia(nom) VALUES ('Madrid');
INSERT INTO provincia(nom) VALUES ('Málaga');
INSERT INTO localitat(nom, provincia_id) VALUES ('Barcelona', 1);
INSERT INTO localitat(nom, provincia_id) VALUES ('Madrid', 1);
INSERT INTO localitat(nom, provincia_id) VALUES ('Girona', 1);
INSERT INTO adreca(adreca, codi_postal, localitat_id) VALUES ('Marina 254', '08041', 1);
INSERT INTO adreca(adreca, codi_postal, localitat_id) VALUES ('Fastenrath 66', '08041', 2);
INSERT INTO adreca(adreca, codi_postal, localitat_id) VALUES ('Góngora', '08041', 3);
INSERT INTO adreca(adreca, codi_postal, localitat_id) VALUES ('Otro 2224', '08041', 2);
INSERT INTO adreca(adreca, codi_postal, localitat_id) VALUES ('Inexistente 5554', '08041', 1);
INSERT INTO botiga(adreca_id) VALUES (1);
INSERT INTO botiga(adreca_id) VALUES (2);
INSERT INTO botiga(adreca_id) VALUES (3);
INSERT INTO empleat(nom, cognom, nif, telefon, tasca, botiga_id) VALUES ('Pedro', 'Andrade', 'y6464637e', '555555555', 'repartidor',1);
INSERT INTO empleat(nom, cognom, nif, telefon, tasca, botiga_id) VALUES ('Maic', 'foooo', 'y6488837e', '555555555', 'repartidor',1);
INSERT INTO empleat(nom, cognom, nif, telefon, tasca, botiga_id) VALUES ('Pau', 'Andrade', 'y622227e', '555555555', 'cocinero',1);
INSERT INTO cliente(nom, cognom, telefon, adreca_id) VALUES ('Mauri', 'Pari', '666666666', 1);
INSERT INTO cliente(nom, cognom, telefon, adreca_id) VALUES ('Pedro', 'Sanchez', '666666666', 4);
INSERT INTO cliente(nom, cognom, telefon, adreca_id) VALUES ('Hendrix', 'Paloosa', '666666666', 5);
INSERT INTO cliente(nom, cognom, telefon, adreca_id) VALUES ('Joaquina', 'Carlota', '666666666', 2);
INSERT INTO comande(data_compra, repartir, preu_total, botiga_id, cliente_id, empleat_id) VALUES ('2021-01-20 00:00:01', 1, 99.78, 1,1,3);
INSERT INTO comande(data_compra, repartir, preu_total, botiga_id, cliente_id, empleat_id) VALUES ('2021-01-20 00:00:01', 0, 99.78, 3,2,1);
INSERT INTO comande(data_compra, repartir, preu_total, botiga_id, cliente_id, empleat_id) VALUES ('2021-01-20 00:00:01', 1, 99.78, 3,1,2);
INSERT INTO comande(data_compra, repartir, preu_total, botiga_id, cliente_id, empleat_id) VALUES ('2021-01-20 00:00:01', 0, 99.78, 1,2,1);
INSERT INTO comande(data_compra, repartir, preu_total, botiga_id, cliente_id, empleat_id) VALUES ('2021-01-20 00:00:01', 1, 99.78, 3,1,3);
INSERT INTO comande(data_compra, repartir, preu_total, botiga_id, cliente_id, empleat_id) VALUES ('2021-01-20 00:00:01', 0, 99.78, 1,2,1);
INSERT INTO comande(data_compra, repartir, preu_total, botiga_id, cliente_id, empleat_id) VALUES ('2021-01-20 00:00:01', 1, 99.78, 2,1,3);
INSERT INTO comande(data_compra, repartir, preu_total, botiga_id, cliente_id, empleat_id) VALUES ('2021-01-20 00:00:01', 1, 99.78, 1,3,1);
INSERT INTO comande(data_compra, repartir, preu_total, botiga_id, cliente_id, empleat_id) VALUES ('2021-01-20 00:00:01', 1, 99.78, 3,4,2);
INSERT INTO comande(data_compra, repartir, preu_total, botiga_id, cliente_id, empleat_id) VALUES ('2021-01-20 00:00:01', 0, 99.78, 1,1,2);
INSERT INTO comande(data_compra, repartir, preu_total, botiga_id, cliente_id, empleat_id) VALUES ('2021-01-20 00:00:01', 0, 99.78, 2,4,1);
INSERT INTO comande_detall(quantitat, preu_cadascun, producte_id, comande_id) VALUES(1, 8.99, 4, 1);
INSERT INTO comande_detall(quantitat, preu_cadascun, producte_id, comande_id) VALUES(2, 8.99, 1, 2);
INSERT INTO comande_detall(quantitat, preu_cadascun, producte_id, comande_id) VALUES(3, 8.99, 2, 5);
INSERT INTO comande_detall(quantitat, preu_cadascun, producte_id, comande_id) VALUES(2, 8.99, 1, 9);
INSERT INTO comande_detall(quantitat, preu_cadascun, producte_id, comande_id) VALUES(3, 8.99, 4, 8);
INSERT INTO comande_detall(quantitat, preu_cadascun, producte_id, comande_id) VALUES(5, 8.99, 1, 7);
INSERT INTO comande_detall(quantitat, preu_cadascun, producte_id, comande_id) VALUES(6, 8.99, 2, 6);
INSERT INTO comande_detall(quantitat, preu_cadascun, producte_id, comande_id) VALUES(1, 8.99, 1, 5);
INSERT INTO comande_detall(quantitat, preu_cadascun, producte_id, comande_id) VALUES(1, 8.99, 2, 4);
INSERT INTO comande_detall(quantitat, preu_cadascun, producte_id, comande_id) VALUES(4, 8.99, 1, 3);
INSERT INTO comande_detall(quantitat, preu_cadascun, producte_id, comande_id) VALUES(2, 8.99, 3, 2);
INSERT INTO comande_detall(quantitat, preu_cadascun, producte_id, comande_id) VALUES(1, 8.99, 1, 1);
INSERT INTO comande_detall(quantitat, preu_cadascun, producte_id, comande_id) VALUES(3, 8.99, 2, 1);
INSERT INTO lliurament(comande_id, data_lliurament) VALUES (1, '2021-01-20 00:00:01');
INSERT INTO lliurament(comande_id, data_lliurament) VALUES (2, '2021-01-20 00:00:01');
INSERT INTO lliurament(comande_id, data_lliurament) VALUES (3, '2021-01-20 00:00:01');


SELECT l.nom, sum(cd.quantitat) as QntasBebidas
FROM comande_detall cd
JOIN comande c
ON c.comande_id = cd.comande_id
JOIN  producte p
ON cd.producte_id = p.producte_id
JOIN botiga b
ON b.botiga_id = c.botiga_id
JOIN adreca a
ON b.adreca_id = a.adreca_id
JOIN localitat l
ON l.localitat_id = a.localitat_id
WHERE p.tipo = 'bebida'
group by l.nom;

SELECT e.nom, count(c.comande_id) as QtasComandes
FROM comande c
JOIN empleat e
ON c.empleat_id = e.empleat_id
GROUP BY e.nom;
