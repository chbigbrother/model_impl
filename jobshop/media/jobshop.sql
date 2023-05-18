-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        8.0.15 - MySQL Community Server - GPL
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- jobshop 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `jobshop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `jobshop`;

-- 테이블 jobshop.auth_group 구조 내보내기
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.auth_group:~0 rows (대략적) 내보내기
DELETE FROM `auth_group`;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` (`id`, `name`) VALUES
	(1, 'A');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;

-- 테이블 jobshop.auth_group_permissions 구조 내보내기
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.auth_group_permissions:~68 rows (대략적) 내보내기
DELETE FROM `auth_group_permissions`;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES
	(1, 1, 1),
	(2, 1, 2),
	(3, 1, 3),
	(4, 1, 4),
	(5, 1, 5),
	(6, 1, 6),
	(7, 1, 7),
	(8, 1, 8),
	(9, 1, 9),
	(10, 1, 10),
	(11, 1, 11),
	(12, 1, 12),
	(13, 1, 13),
	(14, 1, 14),
	(15, 1, 15),
	(16, 1, 16),
	(17, 1, 17),
	(18, 1, 18),
	(19, 1, 19),
	(20, 1, 20),
	(21, 1, 21),
	(22, 1, 22),
	(23, 1, 23),
	(24, 1, 24),
	(25, 1, 25),
	(26, 1, 26),
	(27, 1, 27),
	(28, 1, 28),
	(29, 1, 29),
	(30, 1, 30),
	(31, 1, 31),
	(32, 1, 32),
	(33, 1, 33),
	(34, 1, 34),
	(35, 1, 35),
	(36, 1, 36),
	(37, 1, 37),
	(38, 1, 38),
	(39, 1, 39),
	(40, 1, 40),
	(41, 1, 41),
	(42, 1, 42),
	(43, 1, 43),
	(44, 1, 44),
	(45, 1, 45),
	(46, 1, 46),
	(47, 1, 47),
	(48, 1, 48),
	(49, 1, 49),
	(50, 1, 50),
	(51, 1, 51),
	(52, 1, 52),
	(53, 1, 53),
	(54, 1, 54),
	(55, 1, 55),
	(56, 1, 56),
	(57, 1, 57),
	(58, 1, 58),
	(59, 1, 59),
	(60, 1, 60),
	(61, 1, 61),
	(62, 1, 62),
	(63, 1, 63),
	(64, 1, 64),
	(65, 1, 65),
	(66, 1, 66),
	(67, 1, 67),
	(68, 1, 68);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;

-- 테이블 jobshop.auth_permission 구조 내보내기
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.auth_permission:~75 rows (대략적) 내보내기
DELETE FROM `auth_permission`;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(1, 'Can add log entry', 1, 'add_logentry'),
	(2, 'Can change log entry', 1, 'change_logentry'),
	(3, 'Can delete log entry', 1, 'delete_logentry'),
	(4, 'Can view log entry', 1, 'view_logentry'),
	(5, 'Can add permission', 2, 'add_permission'),
	(6, 'Can change permission', 2, 'change_permission'),
	(7, 'Can delete permission', 2, 'delete_permission'),
	(8, 'Can view permission', 2, 'view_permission'),
	(9, 'Can add group', 3, 'add_group'),
	(10, 'Can change group', 3, 'change_group'),
	(11, 'Can delete group', 3, 'delete_group'),
	(12, 'Can view group', 3, 'view_group'),
	(13, 'Can add user', 4, 'add_user'),
	(14, 'Can change user', 4, 'change_user'),
	(15, 'Can delete user', 4, 'delete_user'),
	(16, 'Can view user', 4, 'view_user'),
	(17, 'Can add content type', 5, 'add_contenttype'),
	(18, 'Can change content type', 5, 'change_contenttype'),
	(19, 'Can delete content type', 5, 'delete_contenttype'),
	(20, 'Can view content type', 5, 'view_contenttype'),
	(21, 'Can add session', 6, 'add_session'),
	(22, 'Can change session', 6, 'change_session'),
	(23, 'Can delete session', 6, 'delete_session'),
	(24, 'Can view session', 6, 'view_session'),
	(25, 'Can add document', 7, 'add_document'),
	(26, 'Can change document', 7, 'change_document'),
	(27, 'Can delete document', 7, 'delete_document'),
	(28, 'Can view document', 7, 'view_document'),
	(29, 'Can add file upload', 8, 'add_fileupload'),
	(30, 'Can change file upload', 8, 'change_fileupload'),
	(31, 'Can delete file upload', 8, 'delete_fileupload'),
	(32, 'Can view file upload', 8, 'view_fileupload'),
	(33, 'Can add article', 9, 'add_article'),
	(34, 'Can change article', 9, 'change_article'),
	(35, 'Can delete article', 9, 'delete_article'),
	(36, 'Can view article', 9, 'view_article'),
	(37, 'Can add article', 10, 'add_article'),
	(38, 'Can change article', 10, 'change_article'),
	(39, 'Can delete article', 10, 'delete_article'),
	(40, 'Can view article', 10, 'view_article'),
	(41, 'Can add company', 11, 'add_company'),
	(42, 'Can change company', 11, 'change_company'),
	(43, 'Can delete company', 11, 'delete_company'),
	(44, 'Can view company', 11, 'view_company'),
	(45, 'Can add file upload csv', 12, 'add_fileuploadcsv'),
	(46, 'Can change file upload csv', 12, 'change_fileuploadcsv'),
	(47, 'Can delete file upload csv', 12, 'delete_fileuploadcsv'),
	(48, 'Can view file upload csv', 12, 'view_fileuploadcsv'),
	(49, 'Can add schedule', 13, 'add_schedule'),
	(50, 'Can change schedule', 13, 'change_schedule'),
	(51, 'Can delete schedule', 13, 'delete_schedule'),
	(52, 'Can view schedule', 13, 'view_schedule'),
	(53, 'Can add photo', 14, 'add_photo'),
	(54, 'Can change photo', 14, 'change_photo'),
	(55, 'Can delete photo', 14, 'delete_photo'),
	(56, 'Can view photo', 14, 'view_photo'),
	(57, 'Can add daily', 15, 'add_daily'),
	(58, 'Can change daily', 15, 'change_daily'),
	(59, 'Can delete daily', 15, 'delete_daily'),
	(60, 'Can view daily', 15, 'view_daily'),
	(61, 'Can add schedule', 16, 'add_schedule'),
	(62, 'Can change schedule', 16, 'change_schedule'),
	(63, 'Can delete schedule', 16, 'delete_schedule'),
	(64, 'Can view schedule', 16, 'view_schedule'),
	(65, 'Can add fixed schedule', 17, 'add_fixedschedule'),
	(66, 'Can change fixed schedule', 17, 'change_fixedschedule'),
	(67, 'Can delete fixed schedule', 17, 'delete_fixedschedule'),
	(68, 'Can view fixed schedule', 17, 'view_fixedschedule'),
	(69, 'Can add order schedule', 18, 'add_orderschedule'),
	(70, 'Can change order schedule', 18, 'change_orderschedule'),
	(71, 'Can delete order schedule', 18, 'delete_orderschedule'),
	(72, 'Can view order schedule', 18, 'view_orderschedule'),
	(73, 'Can add order list', 19, 'add_orderlist'),
	(74, 'Can change order list', 19, 'change_orderlist'),
	(75, 'Can delete order list', 19, 'delete_orderlist'),
	(76, 'Can view order list', 19, 'view_orderlist');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;

-- 테이블 jobshop.auth_user 구조 내보내기
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.auth_user:~6 rows (대략적) 내보내기
DELETE FROM `auth_user`;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(1, 'pbkdf2_sha256$260000$DxanItG7jvbuyZ4Ly3ninW$vVOh1bPj01Xuk9pW/IPzXiwZFScqcMNkr/YR0W+dhpk=', '2021-11-11 01:55:33.847475', 1, 'pknu', '', '', 'chbigbrother@gmail.com', 1, 1, '2021-10-06 05:08:21.000000'),
	(2, 'pbkdf2_sha256$260000$SZtjG5LgsUbANrBloeJnav$CDQZWBCy3GgTSnH1ps/j2EU6WQukm8AoOvbXSjhREiw=', '2021-10-28 07:31:11.151783', 0, 'hhs', '', '', '', 1, 1, '2021-10-06 05:17:47.000000'),
	(3, 'pbkdf2_sha256$260000$m1lzzvWbaBlLYbrhcSEH7C$3GQ0qpinPaVUcsCaXWSS/rS5FDqfgi3LHQMwXsYHQJA=', '2021-10-25 01:09:54.994060', 0, 'ggt', '', '', '', 1, 1, '2021-10-06 05:19:31.000000'),
	(4, 'pbkdf2_sha256$260000$fzoR2u8VPwh1Kpxg3lW5BS$G1bcsY8932HRqIzVeymP2ZVihWIb++KcASSlcgE6rwk=', '2021-10-13 04:37:51.496321', 0, 'kcs', '', '', '', 1, 1, '2021-10-06 05:19:54.000000'),
	(5, 'pbkdf2_sha256$260000$xeqMLcyp6LSSJtebaAw0ri$ATFT01Tr1rnWhXxA9+GS74exLYoEqYRo8byNF8oeIa4=', '2021-10-12 06:37:25.967452', 0, 'shao', '', '', '', 1, 1, '2021-10-06 05:20:14.000000'),
	(6, 'pbkdf2_sha256$260000$v4gh3SvDMTcfDMrmmABqF2$3QaanJQ/aYTa4FAIQLuvFboy3BwdEeYV34QfgH1a3ig=', '2021-10-12 07:58:45.611607', 0, 'fuladi', '', '', '', 1, 1, '2021-10-06 05:21:18.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;

-- 테이블 jobshop.auth_user_groups 구조 내보내기
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.auth_user_groups:~0 rows (대략적) 내보내기
DELETE FROM `auth_user_groups`;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES
	(1, 1, 1);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;

-- 테이블 jobshop.auth_user_user_permissions 구조 내보내기
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.auth_user_user_permissions:~80 rows (대략적) 내보내기
DELETE FROM `auth_user_user_permissions`;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
INSERT INTO `auth_user_user_permissions` (`id`, `user_id`, `permission_id`) VALUES
	(6, 2, 17),
	(7, 2, 18),
	(8, 2, 19),
	(9, 2, 20),
	(10, 2, 25),
	(11, 2, 26),
	(12, 2, 27),
	(13, 2, 28),
	(14, 2, 29),
	(15, 2, 30),
	(16, 2, 31),
	(1, 2, 32),
	(2, 2, 33),
	(3, 2, 34),
	(4, 2, 35),
	(5, 2, 36),
	(81, 2, 45),
	(82, 2, 46),
	(83, 2, 47),
	(84, 2, 48),
	(85, 2, 53),
	(86, 2, 54),
	(87, 2, 55),
	(88, 2, 56),
	(38, 3, 17),
	(39, 3, 18),
	(40, 3, 19),
	(41, 3, 20),
	(42, 3, 25),
	(43, 3, 26),
	(44, 3, 27),
	(45, 3, 28),
	(46, 3, 29),
	(47, 3, 30),
	(48, 3, 31),
	(33, 3, 32),
	(34, 3, 33),
	(35, 3, 34),
	(36, 3, 35),
	(37, 3, 36),
	(22, 4, 17),
	(23, 4, 18),
	(24, 4, 19),
	(25, 4, 20),
	(26, 4, 25),
	(27, 4, 26),
	(28, 4, 27),
	(29, 4, 28),
	(30, 4, 29),
	(31, 4, 30),
	(32, 4, 31),
	(17, 4, 32),
	(18, 4, 33),
	(19, 4, 34),
	(20, 4, 35),
	(21, 4, 36),
	(54, 5, 17),
	(55, 5, 18),
	(56, 5, 19),
	(57, 5, 20),
	(58, 5, 25),
	(59, 5, 26),
	(60, 5, 27),
	(61, 5, 28),
	(62, 5, 29),
	(63, 5, 30),
	(64, 5, 31),
	(49, 5, 32),
	(50, 5, 33),
	(51, 5, 34),
	(52, 5, 35),
	(53, 5, 36),
	(70, 6, 17),
	(71, 6, 18),
	(72, 6, 19),
	(73, 6, 20),
	(74, 6, 25),
	(75, 6, 26),
	(76, 6, 27),
	(77, 6, 28),
	(78, 6, 29),
	(79, 6, 30),
	(80, 6, 31),
	(65, 6, 32),
	(66, 6, 33),
	(67, 6, 34),
	(68, 6, 35),
	(69, 6, 36);
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;

-- 테이블 jobshop.board_article 구조 내보내기
DROP TABLE IF EXISTS `board_article`;
CREATE TABLE IF NOT EXISTS `board_article` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `modified_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.board_article:~2 rows (대략적) 내보내기
DELETE FROM `board_article`;
/*!40000 ALTER TABLE `board_article` DISABLE KEYS */;
INSERT INTO `board_article` (`id`, `title`, `author`, `content`, `created_at`, `modified_at`) VALUES
	(1, 'How to install system environment', '최연지', 'The code is on github : \r\nhttps://github.com/chbigbrother/jobshopscheduling\r\n\r\nAfter installing the PyCharm, please clone it to your PyCharm project.\r\nFollow the steps shown in the README.md.', '2021-10-06 06:02:05.098953', '2021-10-06 06:02:05.098953'),
	(2, '샘플 데이터 추가', '황현숙', '연지씨\r\n\r\n세미나때 작성한 수주, 업체에 관한 샘플 데이터 엑셀로 작성하여 업로드 부탁해요.', '2021-10-12 00:23:05.201336', '2021-10-12 00:23:05.201336'),
	(3, '서버 외부 접속 가능하게 설정', '황현숙', '연지씨, \r\n\r\n서버가 외부에서는 접속이 안되는데, 확인해봐줘요', '2021-10-12 00:24:07.705542', '2021-10-12 00:24:07.705542');
/*!40000 ALTER TABLE `board_article` ENABLE KEYS */;

-- 테이블 jobshop.company_company 구조 내보내기
DROP TABLE IF EXISTS `company_company`;
CREATE TABLE IF NOT EXISTS `company_company` (
  `comp_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '아이디',
  `comp_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `textile_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL COMMENT '생성일자',
  `modified_at` datetime DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`comp_id`) USING BTREE,
  UNIQUE KEY `comp_name` (`comp_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.company_company:~8 rows (대략적) 내보내기
DELETE FROM `company_company`;
/*!40000 ALTER TABLE `company_company` DISABLE KEYS */;
INSERT INTO `company_company` (`comp_id`, `comp_name`, `textile_type`, `created_at`, `modified_at`) VALUES
	(1, '(주)나다', 'weave', '2021-10-28 17:04:48', '2021-10-28 17:04:49'),
	(2, '(주)동광', 'weave', '2021-10-28 17:04:59', '2021-10-28 17:04:59'),
	(3, '(주)베가', 'weave, knit', '2021-10-28 17:07:24', '2021-10-28 17:07:24'),
	(4, '대명섬유', 'knit', '2021-10-28 17:07:31', '2021-10-28 17:07:31'),
	(5, '태화방직(주)', 'weave', '2021-10-28 17:07:42', '2021-10-28 17:07:42'),
	(6, '경주산업사', 'knit', '2021-10-28 17:07:52', '2021-10-28 17:07:53'),
	(7, '(주)효성', 'weave, knit', '2021-10-28 17:08:05', '2021-10-28 17:08:06'),
	(8, '삼화기업', 'knit', '2021-10-28 17:08:12', '2021-10-28 17:08:12'),
	(9, '부민직물(주)', 'knit', '2021-10-28 17:08:20', '2021-10-28 17:08:20'),
	(10, '(주)청옥산업', 'weave', '2021-10-28 17:08:30', '2021-10-28 17:08:30');
/*!40000 ALTER TABLE `company_company` ENABLE KEYS */;

-- 테이블 jobshop.company_daily 구조 내보내기
DROP TABLE IF EXISTS `company_daily`;
CREATE TABLE IF NOT EXISTS `company_daily` (
  `idx` int(11) NOT NULL AUTO_INCREMENT COMMENT '번호',
  `comp_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '회사명',
  `work_date` char(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '작업일자',
  `work_end_date` char(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '작업종료일자',
  `fac_code` int(11) DEFAULT NULL COMMENT '작업호기',
  `prod_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제품명',
  `rpm` char(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'rpm',
  `uptime` char(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '가동시간',
  `running_time` int(11) DEFAULT NULL COMMENT '운행시간',
  `prod_output` int(11) DEFAULT NULL COMMENT '생산량(yd)',
  `prod_rate` char(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '가동율',
  `created_at` datetime DEFAULT NULL COMMENT '생성일자',
  `modified_at` datetime DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`idx`),
  KEY `comp_name` (`comp_name`),
  CONSTRAINT `FK_company_daily_company_company` FOREIGN KEY (`comp_name`) REFERENCES `company_company` (`comp_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.company_daily:~0 rows (대략적) 내보내기
DELETE FROM `company_daily`;
/*!40000 ALTER TABLE `company_daily` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_daily` ENABLE KEYS */;

-- 테이블 jobshop.company_schedule 구조 내보내기
DROP TABLE IF EXISTS `company_schedule`;
CREATE TABLE IF NOT EXISTS `company_schedule` (
  `sch_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '오더일자',
  `comp_id` int(11) DEFAULT NULL COMMENT '회사아이디',
  `count` int(11) DEFAULT NULL COMMENT '스케줄생성카운트',
  `order_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '오더넘버',
  `sch_date` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '스케줄작동일자',
  `sch_color` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '색깔',
  `x_axis_1` double NOT NULL,
  `x_axis_2` double NOT NULL,
  `y_axis_1` double NOT NULL,
  `y_axis_2` double NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`sch_id`),
  KEY `comp_id` (`comp_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `FK_company_schedule_company_company` FOREIGN KEY (`comp_id`) REFERENCES `company_company` (`comp_id`),
  CONSTRAINT `FK_company_schedule_order_orderlist` FOREIGN KEY (`order_id`) REFERENCES `order_orderlist` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.company_schedule:~779 rows (대략적) 내보내기
DELETE FROM `company_schedule`;
/*!40000 ALTER TABLE `company_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_schedule` ENABLE KEYS */;

-- 테이블 jobshop.django_admin_log 구조 내보내기
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.django_admin_log:~44 rows (대략적) 내보내기
DELETE FROM `django_admin_log`;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
	(1, '2021-10-06 05:10:04.411227', '1', 'FileUpload object (1)', 1, '[{"added": {}}]', 8, 1),
	(2, '2021-10-06 05:10:25.213271', '2', 'FileUpload object (2)', 1, '[{"added": {}}]', 8, 1),
	(3, '2021-10-06 05:17:47.982931', '2', 'hhs', 1, '[{"added": {}}]', 4, 1),
	(4, '2021-10-06 05:18:46.918956', '2', 'hhs', 2, '[{"changed": {"fields": ["Staff status"]}}]', 4, 1),
	(5, '2021-10-06 05:19:18.303953', '2', 'hhs', 2, '[{"changed": {"fields": ["Superuser status"]}}]', 4, 1),
	(6, '2021-10-06 05:19:31.635933', '3', 'ggt', 1, '[{"added": {}}]', 4, 1),
	(7, '2021-10-06 05:19:36.676954', '3', 'ggt', 2, '[{"changed": {"fields": ["Staff status", "Superuser status"]}}]', 4, 1),
	(8, '2021-10-06 05:19:54.276961', '4', 'kcs', 1, '[{"added": {}}]', 4, 1),
	(9, '2021-10-06 05:19:58.918931', '4', 'kcs', 2, '[{"changed": {"fields": ["Staff status", "Superuser status"]}}]', 4, 1),
	(10, '2021-10-06 05:20:14.951932', '5', 'shao', 1, '[{"added": {}}]', 4, 1),
	(11, '2021-10-06 05:20:19.621181', '5', 'shao', 2, '[{"changed": {"fields": ["Staff status", "Superuser status"]}}]', 4, 1),
	(12, '2021-10-06 05:21:18.615180', '6', 'fuladi', 1, '[{"added": {}}]', 4, 1),
	(13, '2021-10-06 05:21:23.665179', '6', 'fuladi', 2, '[{"changed": {"fields": ["Staff status", "Superuser status"]}}]', 4, 1),
	(14, '2021-10-06 05:22:07.980179', '2', 'hhs', 2, '[{"changed": {"fields": ["Superuser status", "User permissions"]}}]', 4, 1),
	(15, '2021-10-06 05:22:21.987713', '4', 'kcs', 2, '[{"changed": {"fields": ["Superuser status", "User permissions"]}}]', 4, 1),
	(16, '2021-10-06 05:22:34.986713', '3', 'ggt', 2, '[{"changed": {"fields": ["Superuser status", "User permissions"]}}]', 4, 1),
	(17, '2021-10-06 05:22:46.212713', '5', 'shao', 2, '[{"changed": {"fields": ["Superuser status", "User permissions"]}}]', 4, 1),
	(18, '2021-10-06 05:22:56.356741', '6', 'fuladi', 2, '[{"changed": {"fields": ["Superuser status", "User permissions"]}}]', 4, 1),
	(19, '2021-10-06 05:23:33.334436', '1', 'FileUpload object (1)', 3, '', 8, 2),
	(20, '2021-10-06 05:46:45.976853', '3', 'FileUpload object (3)', 1, '[{"added": {}}]', 8, 3),
	(21, '2021-10-06 05:57:32.504952', '3', 'FileUpload object (3)', 2, '[{"changed": {"fields": ["File"]}}]', 8, 1),
	(22, '2021-10-06 05:57:51.604952', '3', 'FileUpload object (3)', 2, '[{"changed": {"fields": ["Content"]}}]', 8, 1),
	(23, '2021-10-06 05:58:02.596950', '3', 'FileUpload object (3)', 2, '[{"changed": {"fields": ["Content"]}}]', 8, 1),
	(24, '2021-10-06 05:58:12.215951', '2', 'FileUpload object (2)', 3, '', 8, 1),
	(25, '2021-10-06 06:02:05.099952', '1', '1 / How to install system environment / 최연지', 1, '[{"added": {}}]', 9, 1),
	(26, '2021-10-12 00:19:44.483945', '3', 'FileUpload object (3)', 2, '[]', 8, 2),
	(27, '2021-10-12 00:23:05.202338', '2', '2 / 샘플 데이터 추가 / 황현숙', 1, '[{"added": {}}]', 9, 2),
	(28, '2021-10-12 00:24:07.706542', '3', '3 / 서버 외부 접속 가능하게 설정 / 황현숙', 1, '[{"added": {}}]', 9, 2),
	(29, '2021-10-12 05:49:14.670863', '4', 'FileUpload object (4)', 1, '[{"added": {}}]', 8, 2),
	(30, '2021-10-12 06:24:44.243451', '4', 'FileUpload object (4)', 3, '', 8, 1),
	(31, '2021-10-12 06:33:30.186451', '5', 'FileUpload object (5)', 1, '[{"added": {}}]', 8, 1),
	(32, '2021-10-12 06:46:25.492451', '5', 'FileUpload object (5)', 2, '[{"changed": {"fields": ["Content"]}}]', 8, 5),
	(33, '2021-10-13 01:48:51.124835', '6', 'FileUpload object (6)', 1, '[{"added": {}}]', 8, 1),
	(34, '2021-10-13 05:34:25.684017', '7', 'FileUpload object (7)', 1, '[{"added": {}}]', 8, 1),
	(35, '2021-10-21 04:46:50.008197', '8', 'FileUpload object (8)', 1, '[{"added": {}}]', 8, 1),
	(36, '2021-10-21 05:00:15.660667', '8', 'FileUpload object (8)', 2, '[{"changed": {"fields": ["File"]}}]', 8, 1),
	(37, '2021-10-21 05:00:28.659663', '8', 'FileUpload object (8)', 2, '[{"changed": {"fields": ["File"]}}]', 8, 1),
	(38, '2021-10-21 06:32:37.607966', '8', 'FileUpload object (8)', 2, '[{"added": {"name": "photo", "object": "Photo object (1)"}}, {"added": {"name": "photo", "object": "Photo object (2)"}}, {"added": {"name": "photo", "object": "Photo object (3)"}}]', 8, 1),
	(39, '2021-10-26 06:24:23.773828', '9', 'FileUpload object (9)', 1, '[{"added": {}}]', 8, 1),
	(40, '2021-10-28 07:30:40.452504', '2', 'hhs', 2, '[{"changed": {"fields": ["User permissions"]}}]', 4, 1),
	(41, '2021-10-28 07:32:23.560782', '9', 'FileUpload object (9)', 2, '[{"added": {"name": "photo", "object": "Photo object (4)"}}, {"added": {"name": "photo", "object": "Photo object (5)"}}]', 8, 2),
	(42, '2021-10-28 07:32:44.216976', '9', 'FileUpload object (9)', 2, '[{"changed": {"fields": ["Title"]}}]', 8, 2),
	(43, '2021-11-09 03:21:47.663659', '1', 'A', 1, '[{"added": {}}]', 3, 1),
	(44, '2021-11-09 03:21:57.359667', '1', 'pknu', 2, '[{"changed": {"fields": ["Groups"]}}]', 4, 1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;

-- 테이블 jobshop.django_content_type 구조 내보내기
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.django_content_type:~17 rows (대략적) 내보내기
DELETE FROM `django_content_type`;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(3, 'auth', 'group'),
	(2, 'auth', 'permission'),
	(4, 'auth', 'user'),
	(9, 'board', 'article'),
	(10, 'company', 'article'),
	(11, 'company', 'company'),
	(15, 'company', 'daily'),
	(17, 'company', 'fixedschedule'),
	(16, 'company', 'schedule'),
	(5, 'contenttypes', 'contenttype'),
	(13, 'dashboard', 'schedule'),
	(8, 'fileutils', 'fileupload'),
	(12, 'fileutils', 'fileuploadcsv'),
	(14, 'fileutils', 'photo'),
	(7, 'jobshop', 'document'),
	(19, 'order', 'orderlist'),
	(18, 'order', 'orderschedule'),
	(6, 'sessions', 'session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;

-- 테이블 jobshop.django_migrations 구조 내보내기
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.django_migrations:~26 rows (대략적) 내보내기
DELETE FROM `django_migrations`;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2021-10-06 05:06:55.914613'),
	(2, 'auth', '0001_initial', '2021-10-06 05:06:56.774612'),
	(3, 'admin', '0001_initial', '2021-10-06 05:06:57.057613'),
	(4, 'admin', '0002_logentry_remove_auto_add', '2021-10-06 05:06:57.069613'),
	(5, 'admin', '0003_logentry_add_action_flag_choices', '2021-10-06 05:06:57.084612'),
	(6, 'contenttypes', '0002_remove_content_type_name', '2021-10-06 05:06:57.221613'),
	(7, 'auth', '0002_alter_permission_name_max_length', '2021-10-06 05:06:57.311614'),
	(8, 'auth', '0003_alter_user_email_max_length', '2021-10-06 05:06:57.341612'),
	(9, 'auth', '0004_alter_user_username_opts', '2021-10-06 05:06:57.351613'),
	(10, 'auth', '0005_alter_user_last_login_null', '2021-10-06 05:06:57.421613'),
	(11, 'auth', '0006_require_contenttypes_0002', '2021-10-06 05:06:57.427615'),
	(12, 'auth', '0007_alter_validators_add_error_messages', '2021-10-06 05:06:57.437612'),
	(13, 'auth', '0008_alter_user_username_max_length', '2021-10-06 05:06:57.528612'),
	(14, 'auth', '0009_alter_user_last_name_max_length', '2021-10-06 05:06:57.629612'),
	(15, 'auth', '0010_alter_group_name_max_length', '2021-10-06 05:06:57.655614'),
	(16, 'auth', '0011_update_proxy_permissions', '2021-10-06 05:06:57.667615'),
	(17, 'auth', '0012_alter_user_first_name_max_length', '2021-10-06 05:06:57.753613'),
	(18, 'sessions', '0001_initial', '2021-10-06 05:06:57.808614'),
	(19, 'fileutils', '0001_initial', '2021-10-06 05:09:40.505223'),
	(20, 'board', '0001_initial', '2021-10-06 05:24:15.780421'),
	(21, 'company', '0001_initial', '2021-10-12 00:49:48.602341'),
	(22, 'company', '0002_auto_20211012_1430', '2021-10-12 05:31:01.185234'),
	(23, 'board', '0002_alter_article_options', '2021-10-13 01:09:08.772929'),
	(24, 'fileutils', '0002_alter_fileupload_options', '2021-10-13 01:09:08.782930'),
	(25, 'company', '0002_alter_company_prod_rate', '2021-10-13 01:36:50.917134'),
	(26, 'fileutils', '0003_fileuploadcsv', '2021-10-15 05:44:30.568395'),
	(27, 'dashboard', '0001_initial', '2021-10-20 06:46:36.441003'),
	(28, 'fileutils', '0004_photo', '2021-10-21 06:32:06.083876'),
	(29, 'order', '0001_initial', '2021-11-09 03:49:54.330048');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;

-- 테이블 jobshop.django_session 구조 내보내기
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.django_session:~14 rows (대략적) 내보내기
DELETE FROM `django_session`;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('70ormi719s2auzxducjy1ztp1ac1mcp6', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1mcMGY:PtLpNB_Eldh7Z6aDNvdz60OOyOZ2vkNzgPubgviH27M', '2021-11-01 06:36:58.219744'),
	('81mob9rf1asg8zg35g816fb99honif58', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1mkzJN:8LXT519o309hvUTdSRqCLrxP1CCRB9Sf4TUD5ieE-kg', '2021-11-25 01:55:33.870503'),
	('9o9vx6g5peyrpf4znbukx7k4qw8gy7b9', '.eJxVjMsOwiAQRf-FtSEDyMul-34DGRiQqoGktCvjv2uTLnR7zzn3xQJuaw3byEuYiV2YYaffLWJ65LYDumO7dZ56W5c58l3hBx186pSf18P9O6g46rfWClx0ZDSqmMEWKXUCmbJE64zzBtBoIJV8sabYQoJEAhA-2jNGKzN7fwDUpjei:1metgF:CzbJNvRyjAgrt_C5T8UFz2P76GE-4w1FUkYF8fti8SQ', '2021-11-08 06:41:59.986392'),
	('iskza4e7j1m6r284h3ei7asrdmdoul7j', '.eJxVjEEOwiAQAP_C2RBsaVk8eu8byLK7SNXQpLQn49-VpAe9zkzmpQLuWw57lTXMrC6qV6dfFpEeUprgO5bbomkp2zpH3RJ92KqnheV5Pdq_Qcaa2xaQx3Rma5JBMoBiwAnxMAohOLLJ9n6grpMkkQHc-G0peYBoO_Co3h8G8zir:1meoUs:9TLSnCSTuweIrxIhnt-2KbQKzTDj4T5XKRy80vbltMc', '2021-11-08 01:09:54.998059'),
	('jw6w8j1a4ccf7yr6sf43qyosyrk57rfi', '.eJxVjMsOgjAURP-la9OUwi2tS_d8A7mPYlHTJhRWxn8XEhY6yzln5q1G3NY0bjUu4yzqqqy6_HaE_Iz5APLAfC-aS16XmfSh6JNWPRSJr9vp_h0krGlft3tcYyD4hmyYXM_Otyw8CYkjjxTJ9g22bIgjAHgIfYfWsBiBjkR9vtp_OCg:1mfDZ5:_dT72l55TRqgm3z_jSm7Whxm9ieZD6TPM1d1mA8r3Nc', '2021-11-09 03:55:55.769977'),
	('k1d7lk0zp4ljaksg60em61hti98rmaw6', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1mkFdF:dg0EpMo8Xyfsuc8ps3PlmdRq6tcQ4LeFcpjI8WB9DTA', '2021-11-23 01:09:01.680874'),
	('meui39vg866noga9q083a67f1h1860rd', '.eJxVjDsOwjAQBe_iGlnr9TeU9JzBWttrHECxlE-FuDtESgHtm5n3EpG2tcVt4TmORZyFE6ffLVF-8LSDcqfp1mXu0zqPSe6KPOgir73w83K4fweNlvatg1LFhmAsq-qNRrBUKpqkLXAIQ1WO6gBGm4TMRAUYKkCqmB16RC_eH8okN2Y:1mY279:gYJfJSekh9jZChwAcOoUi-nvCCJStyAyZJc_ZM4gv2M', '2021-10-20 08:17:23.502700'),
	('oe04a3zc66j5vmcp4kd5mjxb8ng1t94x', '.eJxVjMsOwiAUBf-FtSFAL6m4dO83EO4DqRqalHbV-O9K0oVuz8ycXcW0rSVuTZY4sboor06_GyZ6Su2AH6neZ01zXZcJdVf0QZu-zSyv6-H-HZTUSq_DAEIwWGCGDDaMYJCAz5iRk3hi8xXYBW8R_JiTdYE9GfHi0Amr9wf7ZDi5:1maBPh:etUb2Iweu7k6uY11e2e-bvyWjKkixZM7gh-OURG5tqs', '2021-10-26 06:37:25.972451'),
	('ph9l8kecewxi44wlx7pmgl74yx6fvz1m', '.eJxVjMsOwiAUBf-FtSFAL6m4dO83EO4DqRqalHbV-O9K0oVuz8ycXcW0rSVuTZY4sboor06_GyZ6Su2AH6neZ01zXZcJdVf0QZu-zSyv6-H-HZTUSq_DAEIwWGCGDDaMYJCAz5iRk3hi8xXYBW8R_JiTdYE9GfHi0Amr9wf7ZDi5:1maBO2:9irarAQzFj0AZ9maJyFxYGXUyrF8A0st8W4DHdD4Ej0', '2021-10-26 06:35:42.401452'),
	('reeklhqzof8la3e6bgdd155wehxr18ol', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1maB9s:kJvwiTi5ee1uM3VPj6Fwf3Dq2qQQhKEvdH9Y4wFHBHw', '2021-10-26 06:21:04.913450'),
	('rnjj5l3hi08tas1pf09vk6tzbyoq4hkg', '.eJxVjMsOgjAURP-la9OUwi2tS_d8A7mPYlHTJhRWxn8XEhY6yzln5q1G3NY0bjUu4yzqqqy6_HaE_Iz5APLAfC-aS16XmfSh6JNWPRSJr9vp_h0krGlft3tcYyD4hmyYXM_Otyw8CYkjjxTJ9g22bIgjAHgIfYfWsBiBjkR9vtp_OCg:1mZsdY:_3dscVeQ6EYBX5QvShnKWbyuwleD_LqszlVeE2eBpY8', '2021-10-25 10:34:28.841935'),
	('s37bihpfk5swxgsb9wyj8619uohg8atz', '.eJxVjEEOwiAQAP_C2RBsaVk8eu8byLK7SNXQpLQn49-VpAe9zkzmpQLuWw57lTXMrC6qV6dfFpEeUprgO5bbomkp2zpH3RJ92KqnheV5Pdq_Qcaa2xaQx3Rma5JBMoBiwAnxMAohOLLJ9n6grpMkkQHc-G0peYBoO_Co3h8G8zir:1mXzax:-k_JHR-XEFK_oAQ6lbO8WqmYCFInMDvFsFsT2YTbus8', '2021-10-20 05:35:59.991710'),
	('wx7ipscbbqozjlcw37uu6oeohurs9mm6', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1mXzAy:zK88BlNciAyKErYrCPu0P-Znw8fMc2G70QUPkFTmUh8', '2021-10-20 05:09:08.613191'),
	('xg3ivkxwjlxokndumiv82cm3z4yxrvqi', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1maWsU:DRUMfGzbkbcT-Z1iODg0veGku95mnac1QGrRAVzWb10', '2021-10-27 05:32:34.277016');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;

-- 테이블 jobshop.fileutils_fileupload 구조 내보내기
DROP TABLE IF EXISTS `fileutils_fileupload`;
CREATE TABLE IF NOT EXISTS `fileutils_fileupload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.fileutils_fileupload:~4 rows (대략적) 내보내기
DELETE FROM `fileutils_fileupload`;
/*!40000 ALTER TABLE `fileutils_fileupload` DISABLE KEYS */;
INSERT INTO `fileutils_fileupload` (`id`, `title`, `author`, `file`, `content`, `created_at`) VALUES
	(3, '2021.10.05. 세미나 회의록', '공길탁', '2021.10.05._섬유산업__JSSP_모델_회의록_GJftwS3.docx', '내용 추가 후 첨부하였습니다. - 최연지', '2021-10-06 05:46:45.975852'),
	(5, 'shao\'s python code', '최연지', 'SS-LSTM-python_.py', 'python code for JSSP \r\ntrain model once\r\nexecute the dataset\r\n\r\nfor training the model : 3hr / dataset #1000', '2021-10-12 06:33:30.184449'),
	(6, 'Shao\'s JSSP paper', '최연지', '10-1_Journal_TIIS__LSTM_Job_Shop_Scheduling_15권_8호_21년.pdf', 'This is Shao\'s JSSP paper.\r\nThank you.', '2021-10-13 01:48:51.123836'),
	(7, '2021.10.12. 세미나 회의록', '최연지', '2021.10.12._섬유산업__JSSP_모델_회의록.docx', '', '2021-10-13 05:34:25.682017'),
	(8, '2021.10.20. 세미나 회의록', '최연지', '2021.10.20._섬유산업__JSSP_모델_회의록_YtcOMIS.docx', '', '2021-10-21 04:46:50.005196'),
	(9, '2021.10.27. 세미나 데이터', '최연지', 'daily1_kmKoCg0.csv', '', '2021-10-26 06:24:23.772832');
/*!40000 ALTER TABLE `fileutils_fileupload` ENABLE KEYS */;

-- 테이블 jobshop.fileutils_fileuploadcsv 구조 내보내기
DROP TABLE IF EXISTS `fileutils_fileuploadcsv`;
CREATE TABLE IF NOT EXISTS `fileutils_fileuploadcsv` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` longtext COLLATE utf8mb4_unicode_ci,
  `file` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.fileutils_fileuploadcsv:~48 rows (대략적) 내보내기
DELETE FROM `fileutils_fileuploadcsv`;
/*!40000 ALTER TABLE `fileutils_fileuploadcsv` DISABLE KEYS */;
INSERT INTO `fileutils_fileuploadcsv` (`id`, `title`, `file`) VALUES
	(1, '', 'compinfo_-_복사본.csv'),
	(2, '', 'compinfo_-_복사본_Uu3dSJw.csv'),
	(3, '', 'compinfo_-_복사본_-_복사본.csv'),
	(4, '', 'compinfo_-_복사본_-_복사본_0Nj2ucX.csv'),
	(5, '', 'compinfo_-_복사본_9NyiI6p.csv'),
	(6, '', 'compinfo_-_복사본_-_복사본_7BjnZp3.csv'),
	(7, '', 'compinfo_-_복사본_-_복사본_1GWRXxQ.csv'),
	(8, '', 'compinfo_-_복사본_-_복사본_wz81DCm.csv'),
	(9, '', 'compinfo_-_복사본_3AykZQN.csv'),
	(10, '', 'compinfo_-_복사본_Yd4BQDn.csv'),
	(11, '', 'compinfo_-_복사본_-_복사본_f75Wy6U.csv'),
	(12, '', 'compinfo_X7fqyEm.csv'),
	(13, '', 'compinfo_-_복사본_-_복사본_LToRlFb.csv'),
	(14, '', 'compinfo_-_복사본_-_복사본_V2K68yG.csv'),
	(15, '', 'compinfo_-_복사본_-_복사본_hAbM9tL.csv'),
	(16, '', 'compinfo_-_복사본_-_복사본_AwpVVr7.csv'),
	(17, '', 'compinfo.csv'),
	(18, '', 'compinfo_-_복사본.csv'),
	(19, '', 'compinfo_VB2EwKD.csv'),
	(20, '', 'compinfo.csv'),
	(21, '', '회사정보.csv'),
	(22, '', '회사정보_3KvNiau.csv'),
	(23, '', '1._21년_8월_주3_답안.xlsx'),
	(24, '', '회사정보_xxpQxKp.csv'),
	(25, '', '경상북도_영천시_면직물_직물_생산_공장_현황_20200824.csv'),
	(26, '', '경상북도_영천시_면직물_직물_생산_공장_현황_20200824_9lfcNrp.csv'),
	(27, '', '경상북도_20200824.csv'),
	(28, '', '경상북도_20200824_a7YEomr.csv'),
	(29, '', '경상북도_20200824_trsRZTj.csv'),
	(30, '', '경상북도_20200824_JrypL8I.csv'),
	(31, '', '경상북도_20200824_pmRsHIo.csv'),
	(32, '', '경상북도_20200824.csv'),
	(33, '', '경상북도_20200824_qomoeea.csv'),
	(34, '', '1._21년_8월_주3_답안_ZnZBsRI.xlsx'),
	(35, '', '경상북도_20200824_ExebBzu.csv'),
	(36, '', '경상북도_20200824_HSpZg2o.csv'),
	(37, '', '경상북도_20200824_tsbqfvd.csv'),
	(38, '', '통합_문서1.csv'),
	(39, '', 'daily1.csv'),
	(40, '', 'daily1_GMQybUj.csv'),
	(41, '', 'daily1_lnJOYsC.csv'),
	(42, '', 'daily1_zLlVjmp.csv'),
	(43, '', 'daily1_o2WhtsR.csv'),
	(44, '', 'daily1_hWA5tI8.csv'),
	(45, '', 'daily1_FqzdUIH.csv'),
	(46, '', 'daily1_GB8MC2j.csv'),
	(47, '', 'daily1_t6R6wlV.csv'),
	(48, '', 'daily1_03Y2hHb.csv'),
	(49, '', 'daily1_fspZUYk.csv'),
	(50, '', 'daily1.csv');
/*!40000 ALTER TABLE `fileutils_fileuploadcsv` ENABLE KEYS */;

-- 테이블 jobshop.fileutils_photo 구조 내보내기
DROP TABLE IF EXISTS `fileutils_photo`;
CREATE TABLE IF NOT EXISTS `fileutils_photo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fileutils_photo_post_id_b198500f_fk_fileutils_fileupload_id` (`post_id`),
  CONSTRAINT `fileutils_photo_post_id_b198500f_fk_fileutils_fileupload_id` FOREIGN KEY (`post_id`) REFERENCES `fileutils_fileupload` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.fileutils_photo:~5 rows (대략적) 내보내기
DELETE FROM `fileutils_photo`;
/*!40000 ALTER TABLE `fileutils_photo` DISABLE KEYS */;
INSERT INTO `fileutils_photo` (`id`, `image`, `post_id`) VALUES
	(1, 'images/KakaoTalk_20211021_135930862.jpg', 8),
	(2, 'images/KakaoTalk_20211021_135930862_01.jpg', 8),
	(3, 'images/KakaoTalk_20211021_135930862_02.jpg', 8),
	(4, 'images/20211028_163139968.jpg', 9),
	(5, 'images/20211028_163143451.jpg', 9);
/*!40000 ALTER TABLE `fileutils_photo` ENABLE KEYS */;

-- 테이블 jobshop.order_orderlist 구조 내보내기
DROP TABLE IF EXISTS `order_orderlist`;
CREATE TABLE IF NOT EXISTS `order_orderlist` (
  `order_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '오더아이디',
  `cust_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고객 이름',
  `sch_date` char(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문일자',
  `exp_date` char(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기한',
  `textile_type` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '섬유유형',
  `textile_name` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '섬유이름',
  `amount` int(11) DEFAULT NULL COMMENT '수량',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.order_orderlist:~2 rows (대략적) 내보내기
DELETE FROM `order_orderlist`;
/*!40000 ALTER TABLE `order_orderlist` DISABLE KEYS */;
INSERT INTO `order_orderlist` (`order_id`, `cust_name`, `sch_date`, `exp_date`, `textile_type`, `textile_name`, `amount`, `created_at`, `modified_at`) VALUES
	('ORD001', '홍길동', '20211111', '20211130', 'weave', '옷', 3000, '2021-11-09 13:29:54', '2021-11-09 13:29:54'),
	('ORD002', '홍길동', '20211111', '20211130', 'knit', '신발', 2000, '2021-11-09 13:30:40', '2021-11-09 13:30:40');
/*!40000 ALTER TABLE `order_orderlist` ENABLE KEYS */;

-- 테이블 jobshop.order_orderschedule 구조 내보내기
DROP TABLE IF EXISTS `order_orderschedule`;
CREATE TABLE IF NOT EXISTS `order_orderschedule` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sch_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idx`),
  KEY `order_id` (`order_id`),
  KEY `sch_id` (`sch_id`),
  CONSTRAINT `FK_order_orderschedule_company_schedule` FOREIGN KEY (`sch_id`) REFERENCES `company_schedule` (`sch_id`),
  CONSTRAINT `FK_order_orderschedule_order_orderlist` FOREIGN KEY (`order_id`) REFERENCES `order_orderlist` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.order_orderschedule:~2 rows (대략적) 내보내기
DELETE FROM `order_orderschedule`;
/*!40000 ALTER TABLE `order_orderschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_orderschedule` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
