-- MySQL Script generated by MySQL Workbench
-- Wed Jul  5 10:32:10 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema YouTubeSchema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema YouTubeSchema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `YouTubeSchema` DEFAULT CHARACTER SET utf8 ;
USE `YouTubeSchema` ;

-- -----------------------------------------------------
-- Table `YouTubeSchema`.`channels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeSchema`.`channels` (
  `id_channel` INT NOT NULL AUTO_INCREMENT,
  `name_channel` VARCHAR(45) NOT NULL,
  `description_channel` VARCHAR(255) NULL,
  `date_reation_channel` DATE NOT NULL,
  PRIMARY KEY (`id_channel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeSchema`.`videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeSchema`.`videos` (
  `id_video` INT NOT NULL AUTO_INCREMENT,
  `title_video` VARCHAR(45) NOT NULL,
  `date_creation_video` DATETIME NOT NULL,
  `description_video` VARCHAR(255) NULL,
  `size_video` FLOAT NOT NULL,
  `lenght_video` FLOAT NOT NULL,
  `thumbnail_video` BLOB NOT NULL,
  `reproductions_video` INT NOT NULL,
  `likes_video` INT NOT NULL,
  `dislike_video` INT NOT NULL,
  `users_id_user` INT NOT NULL,
  PRIMARY KEY (`id_video`),
  INDEX `fk_videos_users_idx` (`users_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_videos_users`
    FOREIGN KEY (`users_id_user`)
    REFERENCES `YouTubeSchema`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeSchema`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeSchema`.`comments` (
  `id_comment` INT NOT NULL AUTO_INCREMENT,
  `date_time_comment` DATETIME NOT NULL,
  `text_comment` VARCHAR(255) NOT NULL,
  `users_id_user` INT NOT NULL,
  `videos_id_video` INT NOT NULL,
  PRIMARY KEY (`id_comment`),
  INDEX `fk_comments_users1_idx` (`users_id_user` ASC) VISIBLE,
  INDEX `fk_comments_videos1_idx` (`videos_id_video` ASC) VISIBLE,
  CONSTRAINT `fk_comments_users1`
    FOREIGN KEY (`users_id_user`)
    REFERENCES `YouTubeSchema`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_videos1`
    FOREIGN KEY (`videos_id_video`)
    REFERENCES `YouTubeSchema`.`videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeSchema`.`feedbacks_comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeSchema`.`feedbacks_comments` (
  `id_feedbacks_comments` INT NOT NULL AUTO_INCREMENT,
  `date_time_feedback` DATETIME NOT NULL,
  `like_dislike_comment` ENUM('like', 'dislike') NULL,
  `comments_id_comment` INT NOT NULL,
  PRIMARY KEY (`id_feedbacks_comments`),
  INDEX `fk_feedbacks_comments_comments1_idx` (`comments_id_comment` ASC) VISIBLE,
  CONSTRAINT `fk_feedbacks_comments_comments1`
    FOREIGN KEY (`comments_id_comment`)
    REFERENCES `YouTubeSchema`.`comments` (`id_comment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeSchema`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeSchema`.`users` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `email_user` VARCHAR(45) NOT NULL,
  `password_user` VARCHAR(45) NOT NULL,
  `name_user` VARCHAR(45) NOT NULL,
  `birthdate_user` DATETIME NOT NULL,
  `sex_user` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `zipcode_user` INT NULL,
  `creator_channels_id_channel` INT NOT NULL,
  `subscriber_channels_id_channel` INT NOT NULL,
  `like_dislike_videos_id_video` ENUM('like', 'dislike') NULL,
  `feedbacks_comments_id_feedbacks_comments` INT NOT NULL,
  PRIMARY KEY (`id_user`),
  INDEX `fk_users_channels1_idx` (`creator_channels_id_channel` ASC) VISIBLE,
  INDEX `fk_users_channels2_idx` (`subscriber_channels_id_channel` ASC) VISIBLE,
  INDEX `fk_users_videos1_idx` (`like_dislike_videos_id_video` ASC) VISIBLE,
  INDEX `fk_users_feedbacks_comments1_idx` (`feedbacks_comments_id_feedbacks_comments` ASC) VISIBLE,
  CONSTRAINT `fk_users_channels1`
    FOREIGN KEY (`creator_channels_id_channel`)
    REFERENCES `YouTubeSchema`.`channels` (`id_channel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_channels2`
    FOREIGN KEY (`subscriber_channels_id_channel`)
    REFERENCES `YouTubeSchema`.`channels` (`id_channel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_videos1`
    FOREIGN KEY (`like_dislike_videos_id_video`)
    REFERENCES `YouTubeSchema`.`videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_feedbacks_comments1`
    FOREIGN KEY (`feedbacks_comments_id_feedbacks_comments`)
    REFERENCES `YouTubeSchema`.`feedbacks_comments` (`id_feedbacks_comments`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeSchema`.`states_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeSchema`.`states_video` (
  `id_states_video` INT NOT NULL AUTO_INCREMENT,
  `states_videocol` ENUM('public', 'hidden', 'private') NOT NULL,
  `videos_id_video` INT NOT NULL,
  PRIMARY KEY (`id_states_video`),
  INDEX `fk_states_video_videos1_idx` (`videos_id_video` ASC) VISIBLE,
  CONSTRAINT `fk_states_video_videos1`
    FOREIGN KEY (`videos_id_video`)
    REFERENCES `YouTubeSchema`.`videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeSchema`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeSchema`.`tags` (
  `id_tag` INT NOT NULL AUTO_INCREMENT,
  `text_tag` VARCHAR(45) NOT NULL,
  `videos_id_video` INT NOT NULL,
  PRIMARY KEY (`id_tag`),
  INDEX `fk_tags_videos1_idx` (`videos_id_video` ASC) VISIBLE,
  CONSTRAINT `fk_tags_videos1`
    FOREIGN KEY (`videos_id_video`)
    REFERENCES `YouTubeSchema`.`videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeSchema`.`playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeSchema`.`playlists` (
  `id_playlist` INT NOT NULL AUTO_INCREMENT,
  `name_playlist` VARCHAR(45) NOT NULL,
  `date_creation_playlist` DATE NOT NULL,
  `state_playlist` ENUM('public', 'private') NULL,
  `users_id_user` INT NOT NULL,
  PRIMARY KEY (`id_playlist`),
  INDEX `fk_playlists_users1_idx` (`users_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_users1`
    FOREIGN KEY (`users_id_user`)
    REFERENCES `YouTubeSchema`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
