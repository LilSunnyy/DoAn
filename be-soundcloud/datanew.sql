CREATE DATABASE  IF NOT EXISTS `soundcloud` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `soundcloud`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: soundcloud
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_emailaddress`
--

DROP TABLE IF EXISTS `account_emailaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_emailaddress` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `account_emailaddress_user_id_2c513194_fk_soundcloud_user_id` (`user_id`),
  CONSTRAINT `account_emailaddress_user_id_2c513194_fk_soundcloud_user_id` FOREIGN KEY (`user_id`) REFERENCES `soundcloud_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailaddress`
--

LOCK TABLES `account_emailaddress` WRITE;
/*!40000 ALTER TABLE `account_emailaddress` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_emailconfirmation`
--

DROP TABLE IF EXISTS `account_emailconfirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_emailconfirmation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_address_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` (`email_address_id`),
  CONSTRAINT `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailconfirmation`
--

LOCK TABLES `account_emailconfirmation` WRITE;
/*!40000 ALTER TABLE `account_emailconfirmation` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailconfirmation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add genre',7,'add_genre'),(26,'Can change genre',7,'change_genre'),(27,'Can delete genre',7,'delete_genre'),(28,'Can view genre',7,'view_genre'),(29,'Can add playlist',8,'add_playlist'),(30,'Can change playlist',8,'change_playlist'),(31,'Can delete playlist',8,'delete_playlist'),(32,'Can view playlist',8,'view_playlist'),(33,'Can add tracks',9,'add_tracks'),(34,'Can change tracks',9,'change_tracks'),(35,'Can delete tracks',9,'delete_tracks'),(36,'Can view tracks',9,'view_tracks'),(37,'Can add playlist tracks',10,'add_playlisttracks'),(38,'Can change playlist tracks',10,'change_playlisttracks'),(39,'Can delete playlist tracks',10,'delete_playlisttracks'),(40,'Can view playlist tracks',10,'view_playlisttracks'),(41,'Can add like',11,'add_like'),(42,'Can change like',11,'change_like'),(43,'Can delete like',11,'delete_like'),(44,'Can view like',11,'view_like'),(45,'Can add follower',12,'add_follower'),(46,'Can change follower',12,'change_follower'),(47,'Can delete follower',12,'delete_follower'),(48,'Can view follower',12,'view_follower'),(49,'Can add comment',13,'add_comment'),(50,'Can change comment',13,'change_comment'),(51,'Can delete comment',13,'delete_comment'),(52,'Can view comment',13,'view_comment'),(53,'Can add application',14,'add_application'),(54,'Can change application',14,'change_application'),(55,'Can delete application',14,'delete_application'),(56,'Can view application',14,'view_application'),(57,'Can add access token',15,'add_accesstoken'),(58,'Can change access token',15,'change_accesstoken'),(59,'Can delete access token',15,'delete_accesstoken'),(60,'Can view access token',15,'view_accesstoken'),(61,'Can add grant',16,'add_grant'),(62,'Can change grant',16,'change_grant'),(63,'Can delete grant',16,'delete_grant'),(64,'Can view grant',16,'view_grant'),(65,'Can add refresh token',17,'add_refreshtoken'),(66,'Can change refresh token',17,'change_refreshtoken'),(67,'Can delete refresh token',17,'delete_refreshtoken'),(68,'Can view refresh token',17,'view_refreshtoken'),(69,'Can add id token',18,'add_idtoken'),(70,'Can change id token',18,'change_idtoken'),(71,'Can delete id token',18,'delete_idtoken'),(72,'Can view id token',18,'view_idtoken'),(73,'Can add Token',19,'add_token'),(74,'Can change Token',19,'change_token'),(75,'Can delete Token',19,'delete_token'),(76,'Can view Token',19,'view_token'),(77,'Can add token',20,'add_tokenproxy'),(78,'Can change token',20,'change_tokenproxy'),(79,'Can delete token',20,'delete_tokenproxy'),(80,'Can view token',20,'view_tokenproxy'),(81,'Can add social account',21,'add_socialaccount'),(82,'Can change social account',21,'change_socialaccount'),(83,'Can delete social account',21,'delete_socialaccount'),(84,'Can view social account',21,'view_socialaccount'),(85,'Can add social application',22,'add_socialapp'),(86,'Can change social application',22,'change_socialapp'),(87,'Can delete social application',22,'delete_socialapp'),(88,'Can view social application',22,'view_socialapp'),(89,'Can add social application token',23,'add_socialtoken'),(90,'Can change social application token',23,'change_socialtoken'),(91,'Can delete social application token',23,'delete_socialtoken'),(92,'Can view social application token',23,'view_socialtoken'),(93,'Can add email address',24,'add_emailaddress'),(94,'Can change email address',24,'change_emailaddress'),(95,'Can delete email address',24,'delete_emailaddress'),(96,'Can view email address',24,'view_emailaddress'),(97,'Can add email confirmation',25,'add_emailconfirmation'),(98,'Can change email confirmation',25,'change_emailconfirmation'),(99,'Can delete email confirmation',25,'delete_emailconfirmation'),(100,'Can view email confirmation',25,'view_emailconfirmation');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_soundcloud_user_id` FOREIGN KEY (`user_id`) REFERENCES `soundcloud_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `comment_text` longtext COLLATE utf8mb4_unicode_ci,
  `fk_tracks_id` bigint DEFAULT NULL,
  `fk_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_fk_tracks_id_84224971_fk_tracks_id` (`fk_tracks_id`),
  KEY `comment_fk_user_id_4e6ded59_fk_soundcloud_user_id` (`fk_user_id`),
  CONSTRAINT `comment_fk_tracks_id_84224971_fk_tracks_id` FOREIGN KEY (`fk_tracks_id`) REFERENCES `tracks` (`id`),
  CONSTRAINT `comment_fk_user_id_4e6ded59_fk_soundcloud_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `soundcloud_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'2024-03-18 09:37:17.144320','2024-03-18 09:37:17.144320',1,'This track is the best',1,1),(2,'2024-03-18 09:37:45.842249','2024-03-18 09:37:45.842249',1,'good',2,1),(3,'2024-03-18 09:37:57.066640','2024-03-18 09:37:57.066640',1,'very good',3,1);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_soundcloud_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_soundcloud_user_id` FOREIGN KEY (`user_id`) REFERENCES `soundcloud_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-03-18 08:53:30.876748','1','love',1,'[{\"added\": {}}]',7,1),(2,'2024-03-18 08:53:38.104681','2','chill',1,'[{\"added\": {}}]',7,1),(3,'2024-03-18 08:53:46.761828','3','party',1,'[{\"added\": {}}]',7,1),(4,'2024-03-18 08:56:00.141853','1','Sau Cơn Mưa - CoolKid ft Rhyder',1,'[{\"added\": {}}]',9,1),(5,'2024-03-18 08:57:10.905843','2','Think twice',1,'[{\"added\": {}}]',9,1),(6,'2024-03-18 08:58:25.669832','3','니가_ (You_)',1,'[{\"added\": {}}]',9,1),(7,'2024-03-18 09:15:39.406362','1','My Playlist',1,'[{\"added\": {}}]',8,1),(8,'2024-03-18 09:29:08.873709','2','PlaylistTracks object (2)',1,'[{\"added\": {}}]',10,1),(9,'2024-03-18 09:29:52.140293','3','PlaylistTracks object (3)',1,'[{\"added\": {}}]',10,1),(10,'2024-03-18 09:29:59.817147','4','PlaylistTracks object (4)',1,'[{\"added\": {}}]',10,1),(11,'2024-03-18 09:37:17.145322','1','Comment object (1)',1,'[{\"added\": {}}]',13,1),(12,'2024-03-18 09:37:45.843247','2','Comment object (2)',1,'[{\"added\": {}}]',13,1),(13,'2024-03-18 09:37:57.066640','3','Comment object (3)',1,'[{\"added\": {}}]',13,1),(14,'2024-03-18 09:47:03.471167','1','Like object (1)',1,'[{\"added\": {}}]',11,1),(15,'2024-03-18 09:47:14.498745','2','Like object (2)',1,'[{\"added\": {}}]',11,1),(16,'2024-03-18 09:47:25.758345','3','Like object (3)',1,'[{\"added\": {}}]',11,1),(17,'2024-03-18 09:55:23.642716','2','user1',1,'[{\"added\": {}}]',6,1),(18,'2024-03-18 09:55:37.713314','1','Follower object (1)',1,'[{\"added\": {}}]',12,1),(19,'2024-04-23 08:37:07.584187','1','Sau Cơn Mưa - CoolKid ft Rhyder',2,'[{\"changed\": {\"fields\": [\"View\"]}}]',9,1),(20,'2024-04-23 08:37:14.867566','2','Think twice',2,'[{\"changed\": {\"fields\": [\"View\"]}}]',9,1),(21,'2024-04-23 08:37:26.898915','3','니가_ (You_)',2,'[{\"changed\": {\"fields\": [\"View\"]}}]',9,1),(22,'2024-04-23 12:19:38.422600','4','Genre object (4)',1,'[{\"added\": {}}]',7,1),(23,'2024-04-23 12:26:02.510650','4','B.O.R. (Birth of Rap)',1,'[{\"added\": {}}]',9,1),(24,'2024-04-23 12:30:22.372053','5','Đen Đá Không Đường (Rap Version) -AMee',1,'[{\"added\": {}}]',9,1),(25,'2024-04-23 12:43:36.015895','1','Genre object (1)',2,'[{\"changed\": {\"fields\": [\"Name\", \"Description\"]}}]',7,1),(26,'2024-04-23 12:43:52.002590','5','Đen Đá Không Đường (Rap Version) -AMee',2,'[{\"changed\": {\"fields\": [\"Fk genre\"]}}]',9,1),(27,'2024-04-23 12:46:05.284037','6','LOVE IS GONE FT. DYLAN MATTHEW (ACOUSTIC)',1,'[{\"added\": {}}]',9,1),(28,'2024-04-23 12:56:55.762681','7','Justin Bieber - Love Yourself (COVER)',1,'[{\"added\": {}}]',9,1),(29,'2024-04-23 13:00:01.267387','8','we can\'t be friends (wait for your love) - ariana grande',1,'[{\"added\": {}}]',9,1),(30,'2024-04-23 13:03:11.226068','9','Each Time You Fall In Love',1,'[{\"added\": {}}]',9,1),(31,'2024-04-23 14:08:07.492519','10','Over - KHOI VU (ft. khoivy) x minhnhat.',1,'[{\"added\": {}}]',9,1),(32,'2024-04-23 14:08:25.573734','10','Over - KHOI VU (ft. khoivy) x minhnhat.',2,'[{\"changed\": {\"fields\": [\"Fk genre\"]}}]',9,1),(33,'2024-04-23 14:11:03.724633','11','Không Quan Trọng - Vụ Nổ Lớn',1,'[{\"added\": {}}]',9,1),(34,'2024-04-23 14:13:24.509386','12','Xe Đạp - Charles - Acoustic cover',1,'[{\"added\": {}}]',9,1),(35,'2024-04-23 14:15:05.020344','13','Chạm Khẽ Tim Anh Một Chút Thôi - Noo Phước Thịnh',1,'[{\"added\": {}}]',9,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (24,'account','emailaddress'),(25,'account','emailconfirmation'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(19,'authtoken','token'),(20,'authtoken','tokenproxy'),(4,'contenttypes','contenttype'),(15,'oauth2_provider','accesstoken'),(14,'oauth2_provider','application'),(16,'oauth2_provider','grant'),(18,'oauth2_provider','idtoken'),(17,'oauth2_provider','refreshtoken'),(5,'sessions','session'),(21,'socialaccount','socialaccount'),(22,'socialaccount','socialapp'),(23,'socialaccount','socialtoken'),(13,'soundcloud','comment'),(12,'soundcloud','follower'),(7,'soundcloud','genre'),(11,'soundcloud','like'),(8,'soundcloud','playlist'),(10,'soundcloud','playlisttracks'),(9,'soundcloud','tracks'),(6,'soundcloud','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-03-18 06:57:06.650889'),(2,'contenttypes','0002_remove_content_type_name','2024-03-18 06:57:06.699582'),(3,'auth','0001_initial','2024-03-18 06:57:06.837146'),(4,'auth','0002_alter_permission_name_max_length','2024-03-18 06:57:06.872975'),(5,'auth','0003_alter_user_email_max_length','2024-03-18 06:57:06.879332'),(6,'auth','0004_alter_user_username_opts','2024-03-18 06:57:06.883662'),(7,'auth','0005_alter_user_last_login_null','2024-03-18 06:57:06.887662'),(8,'auth','0006_require_contenttypes_0002','2024-03-18 06:57:06.890665'),(9,'auth','0007_alter_validators_add_error_messages','2024-03-18 06:57:06.895664'),(10,'auth','0008_alter_user_username_max_length','2024-03-18 06:57:06.899663'),(11,'auth','0009_alter_user_last_name_max_length','2024-03-18 06:57:06.904375'),(12,'auth','0010_alter_group_name_max_length','2024-03-18 06:57:06.915489'),(13,'auth','0011_update_proxy_permissions','2024-03-18 06:57:06.921488'),(14,'auth','0012_alter_user_first_name_max_length','2024-03-18 06:57:06.925487'),(15,'soundcloud','0001_initial','2024-03-18 06:57:07.550453'),(16,'admin','0001_initial','2024-03-18 06:57:07.632629'),(17,'admin','0002_logentry_remove_auto_add','2024-03-18 06:57:07.641629'),(18,'admin','0003_logentry_add_action_flag_choices','2024-03-18 06:57:07.650483'),(19,'oauth2_provider','0001_initial','2024-03-18 06:57:08.111828'),(20,'oauth2_provider','0002_auto_20190406_1805','2024-03-18 06:57:08.158067'),(21,'oauth2_provider','0003_auto_20201211_1314','2024-03-18 06:57:08.205071'),(22,'oauth2_provider','0004_auto_20200902_2022','2024-03-18 06:57:08.476165'),(23,'oauth2_provider','0005_auto_20211222_2352','2024-03-18 06:57:08.529501'),(24,'oauth2_provider','0006_alter_application_client_secret','2024-03-18 06:57:08.554503'),(25,'oauth2_provider','0007_application_post_logout_redirect_uris','2024-03-18 06:57:08.609501'),(26,'sessions','0001_initial','2024-03-18 06:57:08.661482'),(27,'soundcloud','0002_tracks_like','2024-03-18 06:57:08.700035'),(28,'account','0001_initial','2024-03-18 07:10:58.784405'),(29,'account','0002_email_max_length','2024-03-18 07:10:58.805697'),(30,'authtoken','0001_initial','2024-03-18 07:10:58.872016'),(31,'authtoken','0002_auto_20160226_1747','2024-03-18 07:10:58.934017'),(32,'authtoken','0003_tokenproxy','2024-03-18 07:10:58.939017'),(33,'socialaccount','0001_initial','2024-03-18 07:10:59.147019'),(34,'socialaccount','0002_token_max_lengths','2024-03-18 07:10:59.189019'),(35,'socialaccount','0003_extra_data_default_dict','2024-03-18 07:10:59.204017'),(36,'soundcloud','0003_playlisttracks_created_date_playlisttracks_is_active_and_more','2024-03-18 09:26:44.168382'),(37,'soundcloud','0004_like_like','2024-03-18 09:42:41.996916'),(38,'soundcloud','0005_tracks_view','2024-04-23 08:35:16.958203');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('8c8qhmvpmoozbqov0qufrlocqcs8igyk','.eJxVjEEOwiAQRe_C2pBSGUCX7nuGZoYZpGogKe3KeHfbpAvd_vfef6sR1yWPa5N5nFhdlVGn340wPqXsgB9Y7lXHWpZ5Ir0r-qBND5XldTvcv4OMLW919AHQxuS7mCBZYfKEfTIMFxI0wMQIoaeOkC2eXfCbi-hdEuYETn2-Jb054g:1rzBdq:ccvQG489jGoMzap-sNr2z-UK_81LyoAzAfiCSxPzIpw','2024-05-07 08:36:42.950441'),('d2gb408l21mbd9yelscuogln2qfrwoa1','.eJxVjEEOwiAQRe_C2pBSGUCX7nuGZoYZpGogKe3KeHfbpAvd_vfef6sR1yWPa5N5nFhdlVGn340wPqXsgB9Y7lXHWpZ5Ir0r-qBND5XldTvcv4OMLW919AHQxuS7mCBZYfKEfTIMFxI0wMQIoaeOkC2eXfCbi-hdEuYETn2-Jb054g:1rm6yV:CbxKFwFWDTywpt5rE_tsaiX1iUIO6WZ9F0QQ3XczoEY','2024-04-01 06:59:59.175775'),('urya1swma8nf9jckvwu8qwainblquxzo','.eJxVjEEOwiAQRe_C2pBSGUCX7nuGZoYZpGogKe3KeHfbpAvd_vfef6sR1yWPa5N5nFhdlVGn340wPqXsgB9Y7lXHWpZ5Ir0r-qBND5XldTvcv4OMLW919AHQxuS7mCBZYfKEfTIMFxI0wMQIoaeOkC2eXfCbi-hdEuYETn2-Jb054g:1rm8jV:Of7THCjb_5Vhj1Dw564FrH4Qs-mbFNwkZBs6gbmBJ3Q','2024-04-01 08:52:37.331298');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follower`
--

DROP TABLE IF EXISTS `follower`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follower` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `fk_follower_id` bigint DEFAULT NULL,
  `fk_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `follower_fk_follower_id_c50521c9_fk_soundcloud_user_id` (`fk_follower_id`),
  KEY `follower_fk_user_id_55c5f3fc_fk_soundcloud_user_id` (`fk_user_id`),
  CONSTRAINT `follower_fk_follower_id_c50521c9_fk_soundcloud_user_id` FOREIGN KEY (`fk_follower_id`) REFERENCES `soundcloud_user` (`id`),
  CONSTRAINT `follower_fk_user_id_55c5f3fc_fk_soundcloud_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `soundcloud_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follower`
--

LOCK TABLES `follower` WRITE;
/*!40000 ALTER TABLE `follower` DISABLE KEYS */;
INSERT INTO `follower` VALUES (1,'2024-03-18 09:55:37.712308','2024-03-18 09:55:37.712308',1,2,1);
/*!40000 ALTER TABLE `follower` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (1,'2024-03-18 08:53:30.875745','2024-04-23 12:43:36.014897',1,'pop','pop'),(2,'2024-03-18 08:53:38.103681','2024-03-18 08:53:38.103681',1,'chill','chill'),(3,'2024-03-18 08:53:46.761828','2024-03-18 08:53:46.761828',1,'party','party'),(4,'2024-04-23 12:19:38.421715','2024-04-23 12:19:38.421715',1,'rap','rap');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like`
--

DROP TABLE IF EXISTS `like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `like` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `fk_tracks_id` bigint DEFAULT NULL,
  `fk_user_id` bigint DEFAULT NULL,
  `like` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `like_fk_tracks_id_e0f7bc40_fk_tracks_id` (`fk_tracks_id`),
  KEY `like_fk_user_id_3fc0f2fb_fk_soundcloud_user_id` (`fk_user_id`),
  CONSTRAINT `like_fk_tracks_id_e0f7bc40_fk_tracks_id` FOREIGN KEY (`fk_tracks_id`) REFERENCES `tracks` (`id`),
  CONSTRAINT `like_fk_user_id_3fc0f2fb_fk_soundcloud_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `soundcloud_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like`
--

LOCK TABLES `like` WRITE;
/*!40000 ALTER TABLE `like` DISABLE KEYS */;
INSERT INTO `like` VALUES (1,'2024-03-18 09:47:03.470166','2024-03-18 09:47:03.470166',1,1,1,1),(2,'2024-03-18 09:47:14.497746','2024-03-18 09:47:14.497746',1,2,1,1),(3,'2024-03-18 09:47:25.758345','2024-03-18 09:47:25.758345',1,3,1,1);
/*!40000 ALTER TABLE `like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_accesstoken`
--

DROP TABLE IF EXISTS `oauth2_provider_accesstoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_accesstoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `source_refresh_token_id` bigint DEFAULT NULL,
  `id_token_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `source_refresh_token_id` (`source_refresh_token_id`),
  UNIQUE KEY `id_token_id` (`id_token_id`),
  KEY `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_acce_user_id_6e4c9a65_fk_soundclou` (`user_id`),
  CONSTRAINT `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_acce_id_token_id_85db651b_fk_oauth2_pr` FOREIGN KEY (`id_token_id`) REFERENCES `oauth2_provider_idtoken` (`id`),
  CONSTRAINT `oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr` FOREIGN KEY (`source_refresh_token_id`) REFERENCES `oauth2_provider_refreshtoken` (`id`),
  CONSTRAINT `oauth2_provider_acce_user_id_6e4c9a65_fk_soundclou` FOREIGN KEY (`user_id`) REFERENCES `soundcloud_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_accesstoken`
--

LOCK TABLES `oauth2_provider_accesstoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_accesstoken` VALUES (1,'M01xFl6OE7VdJSpKmJwdGl8bMPayF5','2024-03-20 00:46:09.265881','read write',1,1,'2024-03-19 14:46:09.266883','2024-03-19 14:46:09.266883',NULL,NULL),(2,'v7ZtHz5YYhbiucdSojfGOsH0IcRACZ','2024-04-22 19:39:57.076404','read write',1,1,'2024-04-22 09:39:57.076404','2024-04-22 09:39:57.076404',NULL,NULL),(3,'tL9okArEGASza2Zmj9nTCWwV6pZiOv','2024-04-22 19:42:49.337685','read write',1,1,'2024-04-22 09:42:49.337685','2024-04-22 09:42:49.337685',NULL,NULL),(4,'x260ju8hR6PBVVaXy7aJTvDcXkfZY8','2024-04-23 22:40:57.900344','read write',1,1,'2024-04-23 12:40:57.900344','2024-04-23 12:40:57.901344',NULL,NULL),(5,'XloHjPA4OjvaQw5hCfbFmcy7BWF2mh','2024-04-23 23:30:40.389031','read write',1,1,'2024-04-23 13:30:40.389031','2024-04-23 13:30:40.389031',NULL,NULL);
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_application`
--

DROP TABLE IF EXISTS `oauth2_provider_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_application` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `client_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect_uris` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `authorization_grant_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_secret` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `skip_authorization` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `algorithm` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_logout_redirect_uris` longtext COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT (_utf8mb3''),
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `oauth2_provider_appl_user_id_79829054_fk_soundclou` (`user_id`),
  KEY `oauth2_provider_application_client_secret_53133678` (`client_secret`),
  CONSTRAINT `oauth2_provider_appl_user_id_79829054_fk_soundclou` FOREIGN KEY (`user_id`) REFERENCES `soundcloud_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_application`
--

LOCK TABLES `oauth2_provider_application` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_application` DISABLE KEYS */;
INSERT INTO `oauth2_provider_application` VALUES (1,'h6rqnFxmhiJMBO5VEV2fBHJTACDEcw80xheZQZBk','','confidential','password','pbkdf2_sha256$600000$tJKKNmRVAvLyh5qzJd4mu8$oo7rkppVjpXdyxw0yC2mlc+nRHEOqDGPb1MHA9uThxY=','SoundCloudApp',1,0,'2024-03-18 07:01:05.158026','2024-03-18 07:01:05.158026','','');
/*!40000 ALTER TABLE `oauth2_provider_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_grant`
--

DROP TABLE IF EXISTS `oauth2_provider_grant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_grant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `redirect_uri` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `scope` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `code_challenge` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code_challenge_method` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nonce` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `claims` longtext COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT (_utf8mb3''),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_grant_user_id_e8f62af8_fk_soundcloud_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_grant_user_id_e8f62af8_fk_soundcloud_user_id` FOREIGN KEY (`user_id`) REFERENCES `soundcloud_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_grant`
--

LOCK TABLES `oauth2_provider_grant` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_grant` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_grant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_idtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_idtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_idtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `jti` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jti` (`jti`),
  KEY `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_idtoken_user_id_dd512b59_fk_soundcloud_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_idtoken_user_id_dd512b59_fk_soundcloud_user_id` FOREIGN KEY (`user_id`) REFERENCES `soundcloud_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_idtoken`
--

LOCK TABLES `oauth2_provider_idtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_refreshtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_refreshtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_refreshtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` bigint DEFAULT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `revoked` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_token_id` (`access_token_id`),
  UNIQUE KEY `oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq` (`token`,`revoked`),
  KEY `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_refr_user_id_da837fce_fk_soundclou` (`user_id`),
  CONSTRAINT `oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr` FOREIGN KEY (`access_token_id`) REFERENCES `oauth2_provider_accesstoken` (`id`),
  CONSTRAINT `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_refr_user_id_da837fce_fk_soundclou` FOREIGN KEY (`user_id`) REFERENCES `soundcloud_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_refreshtoken`
--

LOCK TABLES `oauth2_provider_refreshtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_refreshtoken` VALUES (1,'fxEk5mlKrvXvpoq2qlVLVeCdEmUWnl',1,1,1,'2024-03-19 14:46:09.273881','2024-03-19 14:46:09.273881',NULL),(2,'MSihgh7dS4VX0gjPdbmLCTULcmLwwL',2,1,1,'2024-04-22 09:39:57.092404','2024-04-22 09:39:57.092404',NULL),(3,'WZ1e6K4ZntL2jU42Z0Vjdt0A2GP7zN',3,1,1,'2024-04-22 09:42:49.339683','2024-04-22 09:42:49.339683',NULL),(4,'BiDM2HKTaNTvv4R2dOc8Qh6DZsr06A',4,1,1,'2024-04-23 12:40:57.907344','2024-04-23 12:40:57.907344',NULL),(5,'i56HaAI6KyY1PieNqJ5JpVZ052muhS',5,1,1,'2024-04-23 13:30:40.390031','2024-04-23 13:30:40.390031',NULL);
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlist` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `fk_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `playlist_fk_user_id_8b8f6e54_fk_soundcloud_user_id` (`fk_user_id`),
  CONSTRAINT `playlist_fk_user_id_8b8f6e54_fk_soundcloud_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `soundcloud_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist`
--

LOCK TABLES `playlist` WRITE;
/*!40000 ALTER TABLE `playlist` DISABLE KEYS */;
INSERT INTO `playlist` VALUES (1,'2024-03-18 09:15:39.405360','2024-03-18 09:15:39.405360',1,'My Playlist','My Playlist',1);
/*!40000 ALTER TABLE `playlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlisttracks`
--

DROP TABLE IF EXISTS `playlisttracks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlisttracks` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fk_playlist_id` bigint DEFAULT NULL,
  `fk_tracks_id` bigint DEFAULT NULL,
  `created_date` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `playlisttracks_fk_playlist_id_e7eb671f_fk_playlist_id` (`fk_playlist_id`),
  KEY `playlisttracks_fk_tracks_id_d2abe227_fk_tracks_id` (`fk_tracks_id`),
  CONSTRAINT `playlisttracks_fk_playlist_id_e7eb671f_fk_playlist_id` FOREIGN KEY (`fk_playlist_id`) REFERENCES `playlist` (`id`),
  CONSTRAINT `playlisttracks_fk_tracks_id_d2abe227_fk_tracks_id` FOREIGN KEY (`fk_tracks_id`) REFERENCES `tracks` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlisttracks`
--

LOCK TABLES `playlisttracks` WRITE;
/*!40000 ALTER TABLE `playlisttracks` DISABLE KEYS */;
INSERT INTO `playlisttracks` VALUES (2,1,2,'2024-03-18 09:29:08.872710',1,'2024-03-18 09:29:08.872710'),(3,1,3,'2024-03-18 09:29:52.139294',1,'2024-03-18 09:29:52.139294'),(4,1,1,'2024-03-18 09:29:59.817147',1,'2024-03-18 09:29:59.817147');
/*!40000 ALTER TABLE `playlisttracks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialaccount`
--

DROP TABLE IF EXISTS `socialaccount_socialaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialaccount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `extra_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  KEY `socialaccount_social_user_id_8146e70c_fk_soundclou` (`user_id`),
  CONSTRAINT `socialaccount_social_user_id_8146e70c_fk_soundclou` FOREIGN KEY (`user_id`) REFERENCES `soundcloud_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialaccount`
--

LOCK TABLES `socialaccount_socialaccount` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp`
--

DROP TABLE IF EXISTS `socialaccount_socialapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialapp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp`
--

LOCK TABLES `socialaccount_socialapp` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialtoken`
--

DROP TABLE IF EXISTS `socialaccount_socialtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialtoken` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `token_secret` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `account_id` int NOT NULL,
  `app_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`),
  CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialtoken`
--

LOCK TABLES `socialaccount_socialtoken` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `soundcloud_user`
--

DROP TABLE IF EXISTS `soundcloud_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `soundcloud_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `avatar` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tel` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `tel` (`tel`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `soundcloud_user`
--

LOCK TABLES `soundcloud_user` WRITE;
/*!40000 ALTER TABLE `soundcloud_user` DISABLE KEYS */;
INSERT INTO `soundcloud_user` VALUES (1,'pbkdf2_sha256$600000$ItiMJhLtSpsVeHTXdjQiUe$ARgFOx+bNC5V/6LID742uzSfGwSfFwT5dTu+xXiyMcc=','2024-04-23 08:36:42.947425',1,'admin','','',1,1,'2024-03-18 06:58:54.261078','','hgooshvhd123@gmail.com',NULL),(2,'12345678',NULL,0,'user1','tran','dat',0,1,'2024-03-18 09:54:32.000000','uploads/2024/03/artworks-RmIIrpDm8l6iF2zc-PWl5VA-t500x500.jpg','user1@gmail.com','0916300500');
/*!40000 ALTER TABLE `soundcloud_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `soundcloud_user_groups`
--

DROP TABLE IF EXISTS `soundcloud_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `soundcloud_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `soundcloud_user_groups_user_id_group_id_6e9b2b8a_uniq` (`user_id`,`group_id`),
  KEY `soundcloud_user_groups_group_id_56a77d8f_fk_auth_group_id` (`group_id`),
  CONSTRAINT `soundcloud_user_groups_group_id_56a77d8f_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `soundcloud_user_groups_user_id_c77febc3_fk_soundcloud_user_id` FOREIGN KEY (`user_id`) REFERENCES `soundcloud_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `soundcloud_user_groups`
--

LOCK TABLES `soundcloud_user_groups` WRITE;
/*!40000 ALTER TABLE `soundcloud_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `soundcloud_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `soundcloud_user_user_permissions`
--

DROP TABLE IF EXISTS `soundcloud_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `soundcloud_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `soundcloud_user_user_per_user_id_permission_id_4100827a_uniq` (`user_id`,`permission_id`),
  KEY `soundcloud_user_user_permission_id_7e097c10_fk_auth_perm` (`permission_id`),
  CONSTRAINT `soundcloud_user_user_permission_id_7e097c10_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `soundcloud_user_user_user_id_2bdcf76f_fk_soundclou` FOREIGN KEY (`user_id`) REFERENCES `soundcloud_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `soundcloud_user_user_permissions`
--

LOCK TABLES `soundcloud_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `soundcloud_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `soundcloud_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tracks`
--

DROP TABLE IF EXISTS `tracks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tracks` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `duration` int NOT NULL,
  `photo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fk_genre_id` bigint DEFAULT NULL,
  `fk_user_id` bigint DEFAULT NULL,
  `like` int NOT NULL,
  `view` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tracks_fk_genre_id_722c84ab_fk_genre_id` (`fk_genre_id`),
  KEY `tracks_fk_user_id_4b8e9459_fk_soundcloud_user_id` (`fk_user_id`),
  CONSTRAINT `tracks_fk_genre_id_722c84ab_fk_genre_id` FOREIGN KEY (`fk_genre_id`) REFERENCES `genre` (`id`),
  CONSTRAINT `tracks_fk_user_id_4b8e9459_fk_soundcloud_user_id` FOREIGN KEY (`fk_user_id`) REFERENCES `soundcloud_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracks`
--

LOCK TABLES `tracks` WRITE;
/*!40000 ALTER TABLE `tracks` DISABLE KEYS */;
INSERT INTO `tracks` VALUES (1,'2024-03-18 08:56:00.136853','2024-04-23 08:37:07.583187',1,'Sau Cơn Mưa - CoolKid ft Rhyder','Sau Cơn Mưa - CoolKid ft Rhyder',133,'photos/2024/03/artworks-RmIIrpDm8l6iF2zc-PWl5VA-t500x500.jpg','song/2024/03/Sau_Cơn_Mưa_-_CoolKid_ft_Rhyder.mp3',1,1,133,10000),(2,'2024-03-18 08:57:10.894842','2024-04-23 08:37:14.865555',1,'Think twice','Think twice',183,'photos/2024/03/artworks-bpRynxDm2DKvmrdC-zFZ60g-t500x500.jpg','song/2024/03/Think_twice.mp3',2,1,183,9999),(3,'2024-03-18 08:58:25.665832','2024-04-23 08:37:26.896915',1,'니가_ (You_)','니가_ (You_)',169,'photos/2024/03/artworks-YyAZXHylHhI1MGHs-GuWikg-t500x500.jpg','song/2024/03/artworks-YyAZXHylHhI1MGHs-GuWikg-t500x500.jpg',3,1,169,11400),(4,'2024-04-23 12:26:02.498521','2024-04-23 12:26:02.498521',1,'B.O.R. (Birth of Rap)','B.O.R. (Birth of Rap)',630,'photos/2024/04/artworks-tpbaG3n6Av2H-0-t500x500.jpg','song/2024/04/BOR_Birth_of_Rap.mp3',4,2,1100,3333),(5,'2024-04-23 12:30:22.360357','2024-04-23 12:43:51.999589',1,'Đen Đá Không Đường (Rap Version) -AMee','Đen Đá Không Đường (Rap Version) -AMee',196,'photos/2024/04/artworks-000557512089-zq7sp2-t500x500.jpg','song/2024/04/Đen_Đá_Không_Đường_Rap_Version_-AMee.mp3',1,2,10000,10000000),(6,'2024-04-23 12:46:05.271036','2024-04-23 12:46:05.272037',1,'LOVE IS GONE FT. DYLAN MATTHEW (ACOUSTIC)','LOVE IS GONE FT. DYLAN MATTHEW (ACOUSTIC)',177,'photos/2024/04/loveisgone.png','song/2024/04/LOVE_IS_GONE_FT_DYLAN_MATTHEW_ACOUSTIC.mp3',1,2,9999,999999),(7,'2024-04-23 12:56:55.750682','2024-04-23 12:56:55.750682',1,'Justin Bieber - Love Yourself (COVER)','Justin Bieber - Love Yourself (COVER)',211,'photos/2024/04/Screenshot_Capture_-_2024-04-23_-_19-55-21.png','song/2024/04/Justin_Bieber_-_Love_Yourself_COVER.mp3',1,2,99999,9999999),(8,'2024-04-23 13:00:01.256742','2024-04-23 13:00:01.256742',1,'we can\'t be friends (wait for your love) - ariana grande','we can\'t be friends (wait for your love) - ariana grande',210,'photos/2024/04/Screenshot_Capture_-_2024-04-23_-_19-59-00.png','song/2024/04/we_cant_be_friends_wait_for_your_love_-_ariana_grandesped_up.mp3',1,2,5555,60000),(9,'2024-04-23 13:03:11.215070','2024-04-23 13:03:11.215070',1,'Each Time You Fall In Love','Each Time You Fall In Love',290,'photos/2024/04/Screenshot_Capture_-_2024-04-23_-_20-02-13.png','song/2024/04/Each_Time_You_Fall_In_Love.mp3',1,2,3333,6666),(10,'2024-04-23 14:08:07.476801','2024-04-23 14:08:25.569734',1,'Over - KHOI VU (ft. khoivy) x minhnhat.','Over - KHOI VU (ft. khoivy) x minhnhat.',162,'photos/2024/04/Screenshot_Capture_-_2024-04-23_-_20-59-40.png','song/2024/04/Over_-_KHOI_VU_ft_khoivy_x_minhnhat.mp3',2,2,223,4000),(11,'2024-04-23 14:11:03.711608','2024-04-23 14:11:03.711608',1,'Không Quan Trọng - Vụ Nổ Lớn','Không Quan Trọng - Vụ Nổ Lớn',264,'photos/2024/04/Screenshot_Capture_-_2024-04-23_-_21-09-57.png','song/2024/04/Không_Quan_Trọng_-_Vụ_Nổ_Lớn.mp3',2,2,12345,123456),(12,'2024-04-23 14:13:24.496387','2024-04-23 14:13:24.496387',1,'Xe Đạp - Charles - Acoustic cover','Xe Đạp - Charles - Acoustic cover',244,'photos/2024/04/Screenshot_Capture_-_2024-04-23_-_21-11-36.png','song/2024/04/Xe_đạp-_Charles.mp3',2,2,5555,67844),(13,'2024-04-23 14:15:05.008344','2024-04-23 14:15:05.008344',1,'Chạm Khẽ Tim Anh Một Chút Thôi - Noo Phước Thịnh','Chạm Khẽ Tim Anh Một Chút Thôi - Noo Phước Thịnh',346,'photos/2024/04/Screenshot_Capture_-_2024-04-23_-_21-14-07.png','song/2024/04/Chạm_Khẽ_Tim_Anh_Một_Chút_Thôi_-_Noo_Phước_Thịnh.mp3',2,2,999999,999999);
/*!40000 ALTER TABLE `tracks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-23 21:59:30
