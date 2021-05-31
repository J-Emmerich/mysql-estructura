-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;
USE `youtube` ;

-- -----------------------------------------------------
-- Table `youtube`.`Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Videos` (
  `idVideos` INT NOT NULL AUTO_INCREMENT,
  `Títol` VARCHAR(45) NULL,
  `Descripcion` VARCHAR(45) NULL,
  `Tamaño` VARCHAR(45) NULL,
  `Nom_Arxiu` VARCHAR(45) NULL,
  `Durada` VARCHAR(45) NULL,
  `Thumbnail` VARCHAR(45) NULL,
  `Num_repetitions` VARCHAR(45) NULL,
  `Likes` VARCHAR(45) NULL,
  `Dislikes` VARCHAR(45) NULL,
  `Estado` VARCHAR(45) NULL,
  PRIMARY KEY (`idVideos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Etiquetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Etiquetas` (
  `idEtiquetas` INT NOT NULL,
  `Nom` VARCHAR(45) NULL,
  PRIMARY KEY (`idEtiquetas`))
ENGINE = InnoDB
COMMENT = '		';


-- -----------------------------------------------------
-- Table `youtube`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`User` (
  `User_Id` INT NOT NULL AUTO_INCREMENT,
  `Nom_d_usuari` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `data_naixement` VARCHAR(45) NULL,
  `sexe` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `codi_postal` VARCHAR(45) NULL,
  PRIMARY KEY (`User_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`User_has_Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`User_has_Videos` (
  `User_User_Id` INT NOT NULL,
  `Videos_idVideos` INT NOT NULL,
  PRIMARY KEY (`User_User_Id`, `Videos_idVideos`),
  INDEX `fk_User_has_Videos_Videos1_idx` (`Videos_idVideos` ASC),
  INDEX `fk_User_has_Videos_User1_idx` (`User_User_Id` ASC),
  CONSTRAINT `fk_User_has_Videos_User1`
    FOREIGN KEY (`User_User_Id`)
    REFERENCES `youtube`.`User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Videos_Videos1`
    FOREIGN KEY (`Videos_idVideos`)
    REFERENCES `youtube`.`Videos` (`idVideos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Likes` (
  `Like_Id` INT NOT NULL,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`Like_Id`))
ENGINE = InnoDB
COMMENT = '						';


-- -----------------------------------------------------
-- Table `youtube`.`Videos_has_Likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Videos_has_Likes` (
  `Videos_idVideos` INT NOT NULL,
  `Likes_Like_Id` INT NOT NULL,
  PRIMARY KEY (`Videos_idVideos`, `Likes_Like_Id`),
  INDEX `fk_Videos_has_Likes_Likes1_idx` (`Likes_Like_Id` ASC),
  INDEX `fk_Videos_has_Likes_Videos1_idx` (`Videos_idVideos` ASC),
  CONSTRAINT `fk_Videos_has_Likes_Videos1`
    FOREIGN KEY (`Videos_idVideos`)
    REFERENCES `youtube`.`Videos` (`idVideos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Videos_has_Likes_Likes1`
    FOREIGN KEY (`Likes_Like_Id`)
    REFERENCES `youtube`.`Likes` (`Like_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Dislikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Dislikes` (
  `Dislike_id` INT NOT NULL AUTO_INCREMENT,
  `last_update` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Dislike_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Videos_has_Dislikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Videos_has_Dislikes` (
  `Videos_idVideos` INT NOT NULL,
  `Dislikes_Dislike_id` INT NOT NULL,
  PRIMARY KEY (`Videos_idVideos`, `Dislikes_Dislike_id`),
  INDEX `fk_Videos_has_Dislikes_Dislikes1_idx` (`Dislikes_Dislike_id` ASC),
  INDEX `fk_Videos_has_Dislikes_Videos1_idx` (`Videos_idVideos` ASC),
  CONSTRAINT `fk_Videos_has_Dislikes_Videos1`
    FOREIGN KEY (`Videos_idVideos`)
    REFERENCES `youtube`.`Videos` (`idVideos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Videos_has_Dislikes_Dislikes1`
    FOREIGN KEY (`Dislikes_Dislike_id`)
    REFERENCES `youtube`.`Dislikes` (`Dislike_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Canals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Canals` (
  `Canal_Id` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Descripcion` TEXT NULL,
  `Data_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Canal_Id`),
  UNIQUE INDEX `Nom_UNIQUE` (`Nom` ASC))
ENGINE = InnoDB
COMMENT = '\n';


-- -----------------------------------------------------
-- Table `youtube`.`Canals_has_User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Canals_has_User` (
  `Canals_Canal_Id` INT NOT NULL,
  `User_User_Id` INT NOT NULL,
  PRIMARY KEY (`Canals_Canal_Id`, `User_User_Id`),
  INDEX `fk_Canals_has_User_User1_idx` (`User_User_Id` ASC),
  INDEX `fk_Canals_has_User_Canals1_idx` (`Canals_Canal_Id` ASC),
  CONSTRAINT `fk_Canals_has_User_Canals1`
    FOREIGN KEY (`Canals_Canal_Id`)
    REFERENCES `youtube`.`Canals` (`Canal_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Canals_has_User_User1`
    FOREIGN KEY (`User_User_Id`)
    REFERENCES `youtube`.`User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Canals_has_Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Canals_has_Videos` (
  `Canals_Canal_Id` INT NOT NULL,
  `Videos_idVideos` INT NOT NULL,
  PRIMARY KEY (`Canals_Canal_Id`, `Videos_idVideos`),
  INDEX `fk_Canals_has_Videos_Videos1_idx` (`Videos_idVideos` ASC),
  INDEX `fk_Canals_has_Videos_Canals1_idx` (`Canals_Canal_Id` ASC),
  CONSTRAINT `fk_Canals_has_Videos_Canals1`
    FOREIGN KEY (`Canals_Canal_Id`)
    REFERENCES `youtube`.`Canals` (`Canal_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Canals_has_Videos_Videos1`
    FOREIGN KEY (`Videos_idVideos`)
    REFERENCES `youtube`.`Videos` (`idVideos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Subscriptions` (
  `Canals_Canal_Id` INT NOT NULL,
  `User_User_Id` INT NOT NULL,
  PRIMARY KEY (`Canals_Canal_Id`, `User_User_Id`),
  INDEX `fk_Canals_has_User1_User1_idx` (`User_User_Id` ASC),
  INDEX `fk_Canals_has_User1_Canals1_idx` (`Canals_Canal_Id` ASC),
  CONSTRAINT `fk_Canals_has_User1_Canals1`
    FOREIGN KEY (`Canals_Canal_Id`)
    REFERENCES `youtube`.`Canals` (`Canal_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Canals_has_User1_User1`
    FOREIGN KEY (`User_User_Id`)
    REFERENCES `youtube`.`User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Videos_has_Etiquetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Videos_has_Etiquetas` (
  `Videos_idVideos` INT NOT NULL,
  `Etiquetas_idEtiquetas` INT NOT NULL,
  PRIMARY KEY (`Videos_idVideos`, `Etiquetas_idEtiquetas`),
  INDEX `fk_Videos_has_Etiquetas_Etiquetas1_idx` (`Etiquetas_idEtiquetas` ASC),
  INDEX `fk_Videos_has_Etiquetas_Videos1_idx` (`Videos_idVideos` ASC),
  CONSTRAINT `fk_Videos_has_Etiquetas_Videos1`
    FOREIGN KEY (`Videos_idVideos`)
    REFERENCES `youtube`.`Videos` (`idVideos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Videos_has_Etiquetas_Etiquetas1`
    FOREIGN KEY (`Etiquetas_idEtiquetas`)
    REFERENCES `youtube`.`Etiquetas` (`idEtiquetas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`User_has_Dislikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`User_has_Dislikes` (
  `User_User_Id` INT NOT NULL,
  `Dislikes_Dislike_id` INT NOT NULL,
  PRIMARY KEY (`User_User_Id`, `Dislikes_Dislike_id`),
  INDEX `fk_User_has_Dislikes_Dislikes1_idx` (`Dislikes_Dislike_id` ASC),
  INDEX `fk_User_has_Dislikes_User1_idx` (`User_User_Id` ASC),
  CONSTRAINT `fk_User_has_Dislikes_User1`
    FOREIGN KEY (`User_User_Id`)
    REFERENCES `youtube`.`User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Dislikes_Dislikes1`
    FOREIGN KEY (`Dislikes_Dislike_id`)
    REFERENCES `youtube`.`Dislikes` (`Dislike_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`User_has_Likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`User_has_Likes` (
  `User_User_Id` INT NOT NULL,
  `Likes_Like_Id` INT NOT NULL,
  PRIMARY KEY (`User_User_Id`, `Likes_Like_Id`),
  INDEX `fk_User_has_Likes_Likes1_idx` (`Likes_Like_Id` ASC),
  INDEX `fk_User_has_Likes_User1_idx` (`User_User_Id` ASC),
  CONSTRAINT `fk_User_has_Likes_User1`
    FOREIGN KEY (`User_User_Id`)
    REFERENCES `youtube`.`User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Likes_Likes1`
    FOREIGN KEY (`Likes_Like_Id`)
    REFERENCES `youtube`.`Likes` (`Like_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Playlists` (
  `Playlist_Id` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NULL,
  `fecha_creacion` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` VARCHAR(45) NULL,
  PRIMARY KEY (`Playlist_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`User_has_Playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`User_has_Playlists` (
  `User_User_Id` INT NOT NULL,
  `Playlists_Playlist_Id` INT NOT NULL,
  PRIMARY KEY (`User_User_Id`, `Playlists_Playlist_Id`),
  INDEX `fk_User_has_Playlists_Playlists1_idx` (`Playlists_Playlist_Id` ASC),
  INDEX `fk_User_has_Playlists_User1_idx` (`User_User_Id` ASC),
  CONSTRAINT `fk_User_has_Playlists_User1`
    FOREIGN KEY (`User_User_Id`)
    REFERENCES `youtube`.`User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Playlists_Playlists1`
    FOREIGN KEY (`Playlists_Playlist_Id`)
    REFERENCES `youtube`.`Playlists` (`Playlist_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Videos_has_Playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Videos_has_Playlists` (
  `Videos_idVideos` INT NOT NULL,
  `Playlists_Playlist_Id` INT NOT NULL,
  PRIMARY KEY (`Videos_idVideos`, `Playlists_Playlist_Id`),
  INDEX `fk_Videos_has_Playlists_Playlists1_idx` (`Playlists_Playlist_Id` ASC),
  INDEX `fk_Videos_has_Playlists_Videos1_idx` (`Videos_idVideos` ASC),
  CONSTRAINT `fk_Videos_has_Playlists_Videos1`
    FOREIGN KEY (`Videos_idVideos`)
    REFERENCES `youtube`.`Videos` (`idVideos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Videos_has_Playlists_Playlists1`
    FOREIGN KEY (`Playlists_Playlist_Id`)
    REFERENCES `youtube`.`Playlists` (`Playlist_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Comments` (
  `Comment_Id` INT NOT NULL AUTO_INCREMENT,
  `Comment_Text` TEXT NULL,
  `fecha_creacion` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Comment_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Videos_has_Comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Videos_has_Comments` (
  `Videos_idVideos` INT NOT NULL,
  `Comments_Comment_Id` INT NOT NULL,
  PRIMARY KEY (`Videos_idVideos`, `Comments_Comment_Id`),
  INDEX `fk_Videos_has_Comments_Comments1_idx` (`Comments_Comment_Id` ASC),
  INDEX `fk_Videos_has_Comments_Videos1_idx` (`Videos_idVideos` ASC),
  CONSTRAINT `fk_Videos_has_Comments_Videos1`
    FOREIGN KEY (`Videos_idVideos`)
    REFERENCES `youtube`.`Videos` (`idVideos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Videos_has_Comments_Comments1`
    FOREIGN KEY (`Comments_Comment_Id`)
    REFERENCES `youtube`.`Comments` (`Comment_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`User_has_Comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`User_has_Comments` (
  `User_User_Id` INT NOT NULL,
  `Comments_Comment_Id` INT NOT NULL,
  PRIMARY KEY (`User_User_Id`, `Comments_Comment_Id`),
  INDEX `fk_User_has_Comments_Comments1_idx` (`Comments_Comment_Id` ASC),
  INDEX `fk_User_has_Comments_User1_idx` (`User_User_Id` ASC),
  CONSTRAINT `fk_User_has_Comments_User1`
    FOREIGN KEY (`User_User_Id`)
    REFERENCES `youtube`.`User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Comments_Comments1`
    FOREIGN KEY (`Comments_Comment_Id`)
    REFERENCES `youtube`.`Comments` (`Comment_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Comments_has_Likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Comments_has_Likes` (
  `Comments_Comment_Id` INT NOT NULL,
  `Likes_Like_Id` INT NOT NULL,
  PRIMARY KEY (`Comments_Comment_Id`, `Likes_Like_Id`),
  INDEX `fk_Comments_has_Likes_Likes1_idx` (`Likes_Like_Id` ASC),
  INDEX `fk_Comments_has_Likes_Comments1_idx` (`Comments_Comment_Id` ASC),
  CONSTRAINT `fk_Comments_has_Likes_Comments1`
    FOREIGN KEY (`Comments_Comment_Id`)
    REFERENCES `youtube`.`Comments` (`Comment_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comments_has_Likes_Likes1`
    FOREIGN KEY (`Likes_Like_Id`)
    REFERENCES `youtube`.`Likes` (`Like_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Comments_has_Dislikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Comments_has_Dislikes` (
  `Comments_Comment_Id` INT NOT NULL,
  `Dislikes_Dislike_id` INT NOT NULL,
  PRIMARY KEY (`Comments_Comment_Id`, `Dislikes_Dislike_id`),
  INDEX `fk_Comments_has_Dislikes_Dislikes1_idx` (`Dislikes_Dislike_id` ASC),
  INDEX `fk_Comments_has_Dislikes_Comments1_idx` (`Comments_Comment_Id` ASC),
  CONSTRAINT `fk_Comments_has_Dislikes_Comments1`
    FOREIGN KEY (`Comments_Comment_Id`)
    REFERENCES `youtube`.`Comments` (`Comment_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comments_has_Dislikes_Dislikes1`
    FOREIGN KEY (`Dislikes_Dislike_id`)
    REFERENCES `youtube`.`Dislikes` (`Dislike_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
