-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Spotify
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Spotify` ;

-- -----------------------------------------------------
-- Schema Spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Spotify` DEFAULT CHARACTER SET utf8 ;
USE `Spotify` ;

-- -----------------------------------------------------
-- Table `Spotify`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`User` (
  `User_ID` INT NOT NULL AUTO_INCREMENT,
  `User_email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `Nom_usuari` VARCHAR(45) NULL,
  `data_naixement` DATETIME NULL,
  `sexe` VARCHAR(10) NULL,
  `pais` VARCHAR(2) NULL,
  `codi_postal` VARCHAR(5) NULL,
  PRIMARY KEY (`User_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Suscripcions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Suscripcions` (
  `suscripcions_id` INT NOT NULL AUTO_INCREMENT,
  `id_user` INT NOT NULL,
  `data_inici` DATETIME NULL,
  `data_renovacio` DATETIME NULL,
  `tipo_pagamento` VARCHAR(15) NULL,
  PRIMARY KEY (`suscripcions_id`),
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC),
  CONSTRAINT `User_user_id`
    FOREIGN KEY (`id_user`)
    REFERENCES `Spotify`.`User` (`User_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Tarjetas_credito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Tarjetas_credito` (
  `tarjetas_credito_id` INT NOT NULL AUTO_INCREMENT,
  `Numero_tarjeta` VARCHAR(16) NOT NULL,
  `caducitat` DATETIME NOT NULL,
  `Codigo_seguretat` TINYINT NULL,
  `suscripcions_id` INT NOT NULL,
  PRIMARY KEY (`tarjetas_credito_id`),
  INDEX `fk_Tarjetas_credito_Suscripcions1_idx` (`suscripcions_id` ASC),
  CONSTRAINT `fk_Tarjetas_credito_Suscripcions1`
    FOREIGN KEY (`suscripcions_id`)
    REFERENCES `Spotify`.`Suscripcions` (`suscripcions_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Paypal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Paypal` (
  `paypal_id` INT NOT NULL AUTO_INCREMENT,
  `nom_usuari` VARCHAR(45) NOT NULL,
  `suscripcions_id` INT NOT NULL,
  PRIMARY KEY (`paypal_id`),
  UNIQUE INDEX `nom_usuari_UNIQUE` (`nom_usuari` ASC),
  INDEX `fk_Paypal_Suscripcions1_idx` (`suscripcions_id` ASC),
  CONSTRAINT `fk_Paypal_Suscripcions1`
    FOREIGN KEY (`suscripcions_id`)
    REFERENCES `Spotify`.`Suscripcions` (`suscripcions_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Pagaments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Pagaments` (
  `ordre_id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NULL,
  `total` DOUBLE NULL,
  `Suscripcions_suscripcions_id` INT NOT NULL,
  PRIMARY KEY (`ordre_id`),
  INDEX `fk_Pagaments_Suscripcions1_idx` (`Suscripcions_suscripcions_id` ASC),
  CONSTRAINT `fk_Pagaments_Suscripcions1`
    FOREIGN KEY (`Suscripcions_suscripcions_id`)
    REFERENCES `Spotify`.`Suscripcions` (`suscripcions_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '			';


-- -----------------------------------------------------
-- Table `Spotify`.`Playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Playlists` (
  `playlist_id` INT NOT NULL AUTO_INCREMENT,
  `Titol` VARCHAR(45) NOT NULL,
  `Nombre_cancions` SMALLINT NULL,
  `Fecha_creacio` DATETIME NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `fecha_eliminada` DATETIME NULL,
  PRIMARY KEY (`playlist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Artista` (
  `artista_id` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `img_artist_url` VARCHAR(50) NULL,
  PRIMARY KEY (`artista_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Album` (
  `album_id` INT NOT NULL AUTO_INCREMENT,
  `Artista_artista_id` INT NOT NULL,
  `Titol` VARCHAR(45) NOT NULL,
  `Ano_publicacio` DATETIME NULL,
  `img_portada_url` VARCHAR(50) NULL,
  PRIMARY KEY (`album_id`, `Artista_artista_id`),
  INDEX `fk_Album_Artista1_idx` (`Artista_artista_id` ASC),
  CONSTRAINT `fk_Album_Artista1`
    FOREIGN KEY (`Artista_artista_id`)
    REFERENCES `Spotify`.`Artista` (`artista_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Cancions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Cancions` (
  `Cancion_id` INT NOT NULL AUTO_INCREMENT,
  `Album_id` INT NOT NULL,
  `nombre_reproduccions` INT NULL,
  `Titol` VARCHAR(45) NOT NULL,
  `durada_segonds` INT NOT NULL,
  PRIMARY KEY (`Cancion_id`, `Album_id`),
  INDEX `fk_Cançons_Album1_idx` (`Album_id` ASC),
  CONSTRAINT `fk_Cançons_Album1`
    FOREIGN KEY (`Album_id`)
    REFERENCES `Spotify`.`Album` (`album_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Favorite_cancions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Favorite_cancions` (
  `Cancions_Cancion_id` INT NOT NULL,
  `Cancions_Album_album_id` INT NOT NULL,
  `User_User_ID` INT NOT NULL,
  PRIMARY KEY (`Cancions_Cancion_id`, `Cancions_Album_album_id`, `User_User_ID`),
  INDEX `fk_Cançons_has_User_User1_idx` (`User_User_ID` ASC),
  INDEX `fk_Cançons_has_User_Cançons1_idx` (`Cancions_Cancion_id` ASC, `Cancions_Album_album_id` ASC),
  CONSTRAINT `fk_Cançons_has_User_Cançons1`
    FOREIGN KEY (`Cancions_Cancion_id` , `Cancions_Album_album_id`)
    REFERENCES `Spotify`.`Cancions` (`Cancion_id` , `Album_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cançons_has_User_User1`
    FOREIGN KEY (`User_User_ID`)
    REFERENCES `Spotify`.`User` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Album_favorites`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Album_favorites` (
  `Album_album_id` INT NOT NULL,
  `Album_Artista_artista_id` INT NOT NULL,
  `User_User_ID` INT NOT NULL,
  PRIMARY KEY (`Album_album_id`, `Album_Artista_artista_id`, `User_User_ID`),
  INDEX `fk_Album_has_User_User1_idx` (`User_User_ID` ASC),
  INDEX `fk_Album_has_User_Album1_idx` (`Album_album_id` ASC, `Album_Artista_artista_id` ASC),
  CONSTRAINT `fk_Album_has_User_Album1`
    FOREIGN KEY (`Album_album_id` , `Album_Artista_artista_id`)
    REFERENCES `Spotify`.`Album` (`album_id` , `Artista_artista_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Album_has_User_User1`
    FOREIGN KEY (`User_User_ID`)
    REFERENCES `Spotify`.`User` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Artista_relacionados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Artista_relacionados` (
  `Artista_artista_id` INT NOT NULL,
  `Artista_artista_id1` INT NOT NULL,
  PRIMARY KEY (`Artista_artista_id`, `Artista_artista_id1`),
  INDEX `fk_Artista_has_Artista_Artista2_idx` (`Artista_artista_id1` ASC),
  INDEX `fk_Artista_has_Artista_Artista1_idx` (`Artista_artista_id` ASC),
  CONSTRAINT `fk_Artista_has_Artista_Artista1`
    FOREIGN KEY (`Artista_artista_id`)
    REFERENCES `Spotify`.`Artista` (`artista_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Artista_has_Artista_Artista2`
    FOREIGN KEY (`Artista_artista_id1`)
    REFERENCES `Spotify`.`Artista` (`artista_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Cancion_en_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Cancion_en_playlist` (
  `Cancion_en_playlist` INT NOT NULL AUTO_INCREMENT,
  `Playlists_playlist_id` INT NOT NULL,
  `Cancions_Cancion_id` INT NOT NULL,
  `Cancions_Album_album_id` INT NOT NULL,
  `Fecha_anadida` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `User_anadio` INT NOT NULL,
  INDEX `fk_Playlists_has_Cançons_Cançons1_idx` (`Cancions_Cancion_id` ASC, `Cancions_Album_album_id` ASC),
  INDEX `fk_Playlists_has_Cançons_Playlists1_idx` (`Playlists_playlist_id` ASC),
  UNIQUE INDEX `User_anadio_UNIQUE` (`User_anadio` ASC),
  PRIMARY KEY (`Cancion_en_playlist`),
  CONSTRAINT `fk_Playlists_has_Cançons_Playlists1`
    FOREIGN KEY (`Playlists_playlist_id`)
    REFERENCES `Spotify`.`Playlists` (`playlist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Playlists_has_Cançons_Cançons1`
    FOREIGN KEY (`Cancions_Cancion_id` , `Cancions_Album_album_id`)
    REFERENCES `Spotify`.`Cancions` (`Cancion_id` , `Album_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `User_anadio_canço`
    FOREIGN KEY (`User_anadio`)
    REFERENCES `Spotify`.`User` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify`.`Playlist_Active`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify`.`Playlist_Active` (
  `User_User_ID` INT NOT NULL,
  `Playlists_playlist_id` INT NOT NULL,
  `Cancion_en_playlist_ID` INT NOT NULL,
  PRIMARY KEY (`User_User_ID`, `Playlists_playlist_id`, `Cancion_en_playlist_ID`),
  INDEX `fk_User_has_Playlists1_Playlists2_idx` (`Playlists_playlist_id` ASC),
  INDEX `fk_User_has_Playlists1_User2_idx` (`User_User_ID` ASC),
  INDEX `fk_User_has_Playlists1_Canço_en_playlist1_idx` (`Cancion_en_playlist_ID` ASC),
  CONSTRAINT `fk_User_has_Playlists1_User2`
    FOREIGN KEY (`User_User_ID`)
    REFERENCES `Spotify`.`User` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Playlists1_Playlists2`
    FOREIGN KEY (`Playlists_playlist_id`)
    REFERENCES `Spotify`.`Playlists` (`playlist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Playlists1_Canço_en_playlist1`
    FOREIGN KEY (`Cancion_en_playlist_ID`)
    REFERENCES `Spotify`.`Cancion_en_playlist` (`Cancion_en_playlist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
