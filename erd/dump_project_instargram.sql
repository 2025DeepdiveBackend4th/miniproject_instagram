-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: project_instargram
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '코멘트 id',
  `post_id` bigint NOT NULL COMMENT '포스트id',
  `user_id` bigint NOT NULL COMMENT '사용자id',
  `text` text NOT NULL COMMENT '코멘트 내용',
  `created_at` datetime NOT NULL COMMENT '등록일',
  `updated_at` datetime DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`comment_id`),
  UNIQUE KEY `UQ_comment_id` (`comment_id`),
  KEY `FK_Posts_TO_comment` (`post_id`),
  KEY `FK_users_TO_comment` (`user_id`),
  CONSTRAINT `FK_Posts_TO_comment` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`),
  CONSTRAINT `FK_users_TO_comment` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='코멘트 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dm_deleted`
--

DROP TABLE IF EXISTS `dm_deleted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dm_deleted` (
  `message_id` bigint NOT NULL COMMENT '메시지 id',
  `user_id` bigint NOT NULL COMMENT '사용자id',
  `deleted_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '삭제일',
  KEY `FK_users_TO_DM_Deleted` (`user_id`),
  KEY `FK_DM_Messages_TO_DM_Deleted` (`message_id`),
  CONSTRAINT `FK_DM_Messages_TO_DM_Deleted` FOREIGN KEY (`message_id`) REFERENCES `dm_messages` (`message_id`),
  CONSTRAINT `FK_users_TO_DM_Deleted` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='메시지 삭제 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_deleted`
--

LOCK TABLES `dm_deleted` WRITE;
/*!40000 ALTER TABLE `dm_deleted` DISABLE KEYS */;
/*!40000 ALTER TABLE `dm_deleted` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dm_messages`
--

DROP TABLE IF EXISTS `dm_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dm_messages` (
  `message_id` bigint NOT NULL AUTO_INCREMENT COMMENT '메시지 id',
  `room_id` bigint NOT NULL COMMENT '채팅방id',
  `sender_id` bigint NOT NULL COMMENT '사용자id',
  `msg_type` varchar(16) NOT NULL COMMENT '메시지형식',
  `content` text COMMENT '내용',
  `sent_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '보낸날짜',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '삭제여부',
  PRIMARY KEY (`message_id`),
  UNIQUE KEY `UQ_message_id` (`message_id`),
  KEY `FK_users_TO_DM_Messages` (`sender_id`),
  KEY `FK_DM_Rooms_TO_DM_Messages` (`room_id`),
  CONSTRAINT `FK_DM_Rooms_TO_DM_Messages` FOREIGN KEY (`room_id`) REFERENCES `dm_rooms` (`room_id`),
  CONSTRAINT `FK_users_TO_DM_Messages` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='메시지 내용 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_messages`
--

LOCK TABLES `dm_messages` WRITE;
/*!40000 ALTER TABLE `dm_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `dm_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dm_reads`
--

DROP TABLE IF EXISTS `dm_reads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dm_reads` (
  `room_id` bigint NOT NULL COMMENT '채팅방id',
  `user_id` bigint NOT NULL COMMENT '사용자id',
  `last_read_msg_id` bigint DEFAULT NULL COMMENT '마지막읽은 id',
  KEY `FK_users_TO_DM_Reads` (`user_id`),
  KEY `FK_DM_Rooms_TO_DM_Reads` (`room_id`),
  CONSTRAINT `FK_DM_Rooms_TO_DM_Reads` FOREIGN KEY (`room_id`) REFERENCES `dm_rooms` (`room_id`),
  CONSTRAINT `FK_users_TO_DM_Reads` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='메시지 읽기확인 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_reads`
--

LOCK TABLES `dm_reads` WRITE;
/*!40000 ALTER TABLE `dm_reads` DISABLE KEYS */;
/*!40000 ALTER TABLE `dm_reads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dm_rooms`
--

DROP TABLE IF EXISTS `dm_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dm_rooms` (
  `room_id` bigint NOT NULL AUTO_INCREMENT COMMENT '채팅방id',
  `user_id1` bigint NOT NULL COMMENT '사용자id',
  `user_id2` bigint NOT NULL COMMENT '사용자id',
  `last_message_id` bigint NOT NULL COMMENT '메시지 id',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일',
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `UQ_room_id` (`room_id`),
  KEY `FK_users_TO_DM_Rooms` (`user_id1`),
  KEY `FK_users_TO_DM_Rooms1` (`user_id2`),
  KEY `FK_DM_Messages_TO_DM_Rooms` (`last_message_id`),
  CONSTRAINT `FK_DM_Messages_TO_DM_Rooms` FOREIGN KEY (`last_message_id`) REFERENCES `dm_messages` (`message_id`),
  CONSTRAINT `FK_users_TO_DM_Rooms` FOREIGN KEY (`user_id1`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK_users_TO_DM_Rooms1` FOREIGN KEY (`user_id2`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='채팅방 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_rooms`
--

LOCK TABLES `dm_rooms` WRITE;
/*!40000 ALTER TABLE `dm_rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `dm_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follows`
--

DROP TABLE IF EXISTS `follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follows` (
  `follower_user_id` bigint NOT NULL COMMENT '팔로워id',
  `followee_user_id` bigint NOT NULL COMMENT '팔로잉id',
  `followed_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  PRIMARY KEY (`follower_user_id`,`followee_user_id`),
  KEY `FK_users_TO_follows1` (`followee_user_id`),
  CONSTRAINT `FK_users_TO_follows` FOREIGN KEY (`follower_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK_users_TO_follows1` FOREIGN KEY (`followee_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='팔로워 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follows`
--

LOCK TABLES `follows` WRITE;
/*!40000 ALTER TABLE `follows` DISABLE KEYS */;
/*!40000 ALTER TABLE `follows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hashtags`
--

DROP TABLE IF EXISTS `hashtags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hashtags` (
  `hashtag_id` bigint NOT NULL AUTO_INCREMENT COMMENT '해시태그id',
  `name` varchar(100) NOT NULL COMMENT '태그명',
  `description` varchar(255) DEFAULT NULL COMMENT '해시태그 설명',
  `created_at` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`hashtag_id`),
  UNIQUE KEY `UQ_hashtag_id` (`hashtag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='해시태그 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hashtags`
--

LOCK TABLES `hashtags` WRITE;
/*!40000 ALTER TABLE `hashtags` DISABLE KEYS */;
/*!40000 ALTER TABLE `hashtags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `image_id` bigint NOT NULL AUTO_INCREMENT COMMENT '이미지id',
  `post_id` bigint NOT NULL COMMENT '포스트id',
  `image_url` varchar(100) NOT NULL COMMENT '이미지 url',
  `alt_text` varchar(100) NOT NULL COMMENT '이미지 설명',
  `order_num` int NOT NULL COMMENT '정렬순서',
  `created_at` datetime NOT NULL COMMENT '등록일자',
  PRIMARY KEY (`image_id`),
  UNIQUE KEY `UQ_image_id` (`image_id`),
  KEY `FK_Posts_TO_Images` (`post_id`),
  CONSTRAINT `FK_Posts_TO_Images` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='이미지 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `like_id` bigint NOT NULL AUTO_INCREMENT COMMENT '좋아요 id',
  `user_id` bigint NOT NULL COMMENT 'user id',
  `post_id` bigint NOT NULL COMMENT '포스트id',
  PRIMARY KEY (`like_id`),
  UNIQUE KEY `UQ_like_id` (`like_id`),
  KEY `FK_Posts_TO_likes` (`post_id`),
  CONSTRAINT `FK_Posts_TO_likes` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='좋아요 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_hashtags`
--

DROP TABLE IF EXISTS `post_hashtags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_hashtags` (
  `post_id` bigint NOT NULL COMMENT '포스트id',
  `hashtag_id` bigint NOT NULL COMMENT '해시태그id',
  `created_at` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`post_id`,`hashtag_id`),
  UNIQUE KEY `UQ_hashtag_id` (`hashtag_id`),
  CONSTRAINT `FK_Hashtags_TO_Post_Hashtags` FOREIGN KEY (`hashtag_id`) REFERENCES `hashtags` (`hashtag_id`),
  CONSTRAINT `FK_Posts_TO_Post_Hashtags` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_hashtags`
--

LOCK TABLES `post_hashtags` WRITE;
/*!40000 ALTER TABLE `post_hashtags` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_hashtags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '포스트id',
  `user_id` bigint NOT NULL COMMENT 'user id',
  `title` varchar(255) NOT NULL COMMENT '제목',
  `content` text NOT NULL COMMENT '내용',
  `created_at` datetime NOT NULL COMMENT '등록일',
  `updated_at` datetime DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`post_id`),
  UNIQUE KEY `UQ_post_id` (`post_id`),
  KEY `FK_users_TO_Posts` (`user_id`),
  CONSTRAINT `FK_users_TO_Posts` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='post 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '사용자id',
  `email` varchar(100) NOT NULL COMMENT '이메일',
  `password` varchar(50) NOT NULL COMMENT '비밀번호',
  `name` varchar(50) DEFAULT NULL COMMENT '이름',
  `phone` int DEFAULT NULL COMMENT '전화번호',
  `profile_photo` varchar(100) DEFAULT NULL COMMENT '프로필사진',
  `email_cert_code` varchar(20) DEFAULT NULL COMMENT '이메일인증코드',
  `email_cert_date` datetime DEFAULT NULL COMMENT '이메일인증일',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '가입일자',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '수정일자',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UQ_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='사용자 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_denied`
--

DROP TABLE IF EXISTS `users_denied`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_denied` (
  `denier_use_id` bigint NOT NULL COMMENT '차단요청id',
  `denied_user_id` bigint NOT NULL COMMENT '차단 id',
  `denied_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '차단일',
  PRIMARY KEY (`denier_use_id`,`denied_user_id`),
  KEY `FK_users_TO_users_denied1` (`denied_user_id`),
  CONSTRAINT `FK_users_TO_users_denied` FOREIGN KEY (`denier_use_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK_users_TO_users_denied1` FOREIGN KEY (`denied_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='접근차단테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_denied`
--

LOCK TABLES `users_denied` WRITE;
/*!40000 ALTER TABLE `users_denied` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_denied` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-24 19:46:17
