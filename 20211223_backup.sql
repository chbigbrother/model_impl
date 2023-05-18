-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        8.0.26 - MySQL Community Server - GPL
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
CREATE DATABASE IF NOT EXISTS `jobshop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `jobshop`;

-- 테이블 jobshop.auth_group 구조 내보내기
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.auth_group:~13 rows (대략적) 내보내기
DELETE FROM `auth_group`;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` (`id`, `name`) VALUES
	(1, '(주)나다'),
	(2, '(주)동광'),
	(3, '(주)베가'),
	(10, '(주)청옥산업'),
	(7, '(주)효성'),
	(12, 'admin'),
	(13, 'company'),
	(11, 'customer'),
	(6, '경주산업사'),
	(4, '대명섬유'),
	(9, '부민직물(주)'),
	(8, '삼화기업'),
	(5, '태화방직(주)');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;

-- 테이블 jobshop.auth_group_permissions 구조 내보내기
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.auth_group_permissions:~220 rows (대략적) 내보내기
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
	(68, 1, 68),
	(69, 2, 1),
	(70, 2, 2),
	(71, 2, 3),
	(72, 2, 4),
	(73, 2, 5),
	(74, 2, 6),
	(75, 2, 7),
	(76, 2, 8),
	(77, 2, 9),
	(78, 2, 10),
	(79, 2, 11),
	(80, 2, 12),
	(81, 2, 13),
	(82, 2, 14),
	(83, 2, 15),
	(84, 2, 16),
	(85, 2, 17),
	(86, 2, 18),
	(87, 2, 19),
	(88, 2, 20),
	(89, 2, 21),
	(90, 2, 22),
	(91, 2, 23),
	(92, 2, 24),
	(93, 2, 25),
	(94, 2, 26),
	(95, 2, 27),
	(96, 2, 28),
	(97, 2, 29),
	(98, 2, 30),
	(99, 2, 31),
	(100, 2, 32),
	(101, 2, 33),
	(102, 2, 34),
	(103, 2, 35),
	(104, 2, 36),
	(105, 2, 37),
	(106, 2, 38),
	(107, 2, 39),
	(108, 2, 40),
	(109, 2, 41),
	(110, 2, 42),
	(111, 2, 43),
	(112, 2, 44),
	(113, 2, 45),
	(114, 2, 46),
	(115, 2, 47),
	(116, 2, 48),
	(117, 2, 49),
	(118, 2, 50),
	(119, 2, 51),
	(120, 2, 52),
	(121, 2, 53),
	(122, 2, 54),
	(123, 2, 55),
	(124, 2, 56),
	(125, 2, 57),
	(126, 2, 58),
	(127, 2, 59),
	(128, 2, 60),
	(129, 2, 61),
	(130, 2, 62),
	(131, 2, 63),
	(132, 2, 64),
	(133, 2, 65),
	(134, 2, 66),
	(135, 2, 67),
	(136, 2, 68),
	(137, 2, 69),
	(138, 2, 70),
	(139, 2, 71),
	(140, 2, 72),
	(141, 2, 73),
	(142, 2, 74),
	(143, 2, 75),
	(144, 2, 76),
	(145, 12, 1),
	(146, 12, 2),
	(147, 12, 3),
	(148, 12, 4),
	(149, 12, 5),
	(150, 12, 6),
	(151, 12, 7),
	(152, 12, 8),
	(153, 12, 9),
	(154, 12, 10),
	(155, 12, 11),
	(156, 12, 12),
	(157, 12, 13),
	(158, 12, 14),
	(159, 12, 15),
	(160, 12, 16),
	(161, 12, 17),
	(162, 12, 18),
	(163, 12, 19),
	(164, 12, 20),
	(165, 12, 21),
	(166, 12, 22),
	(167, 12, 23),
	(168, 12, 24),
	(169, 12, 25),
	(170, 12, 26),
	(171, 12, 27),
	(172, 12, 28),
	(173, 12, 29),
	(174, 12, 30),
	(175, 12, 31),
	(176, 12, 32),
	(177, 12, 33),
	(178, 12, 34),
	(179, 12, 35),
	(180, 12, 36),
	(181, 12, 37),
	(182, 12, 38),
	(183, 12, 39),
	(184, 12, 40),
	(185, 12, 41),
	(186, 12, 42),
	(187, 12, 43),
	(188, 12, 44),
	(189, 12, 45),
	(190, 12, 46),
	(191, 12, 47),
	(192, 12, 48),
	(193, 12, 49),
	(194, 12, 50),
	(195, 12, 51),
	(196, 12, 52),
	(197, 12, 53),
	(198, 12, 54),
	(199, 12, 55),
	(200, 12, 56),
	(201, 12, 57),
	(202, 12, 58),
	(203, 12, 59),
	(204, 12, 60),
	(205, 12, 61),
	(206, 12, 62),
	(207, 12, 63),
	(208, 12, 64),
	(209, 12, 65),
	(210, 12, 66),
	(211, 12, 67),
	(212, 12, 68),
	(213, 12, 69),
	(214, 12, 70),
	(215, 12, 71),
	(216, 12, 72),
	(217, 12, 73),
	(218, 12, 74),
	(219, 12, 75),
	(220, 12, 76);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;

-- 테이블 jobshop.auth_permission 구조 내보내기
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.auth_permission:~100 rows (대략적) 내보내기
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
	(76, 'Can view order list', 19, 'view_orderlist'),
	(77, 'Can add daily facility', 20, 'add_dailyfacility'),
	(78, 'Can change daily facility', 20, 'change_dailyfacility'),
	(79, 'Can delete daily facility', 20, 'delete_dailyfacility'),
	(80, 'Can view daily facility', 20, 'view_dailyfacility'),
	(81, 'Can add auth company', 21, 'add_authcompany'),
	(82, 'Can change auth company', 21, 'change_authcompany'),
	(83, 'Can delete auth company', 21, 'delete_authcompany'),
	(84, 'Can view auth company', 21, 'view_authcompany'),
	(85, 'Can add information', 22, 'add_information'),
	(86, 'Can change information', 22, 'change_information'),
	(87, 'Can delete information', 22, 'delete_information'),
	(88, 'Can view information', 22, 'view_information'),
	(89, 'Can add schedule', 23, 'add_schedule'),
	(90, 'Can change schedule', 23, 'change_schedule'),
	(91, 'Can delete schedule', 23, 'delete_schedule'),
	(92, 'Can view schedule', 23, 'view_schedule'),
	(93, 'Can add product', 24, 'add_product'),
	(94, 'Can change product', 24, 'change_product'),
	(95, 'Can delete product', 24, 'delete_product'),
	(96, 'Can view product', 24, 'view_product'),
	(97, 'Can add facility', 25, 'add_facility'),
	(98, 'Can change facility', 25, 'change_facility'),
	(99, 'Can delete facility', 25, 'delete_facility'),
	(100, 'Can view facility', 25, 'view_facility');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;

-- 테이블 jobshop.auth_user 구조 내보내기
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.auth_user:~9 rows (대략적) 내보내기
DELETE FROM `auth_user`;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(1, 'pbkdf2_sha256$260000$DxanItG7jvbuyZ4Ly3ninW$vVOh1bPj01Xuk9pW/IPzXiwZFScqcMNkr/YR0W+dhpk=', '2021-12-22 04:58:23.834844', 1, 'pknu', '', '', 'chbigbrother@gmail.com', 1, 1, '2021-10-06 05:08:21.000000'),
	(2, 'pbkdf2_sha256$260000$SZtjG5LgsUbANrBloeJnav$CDQZWBCy3GgTSnH1ps/j2EU6WQukm8AoOvbXSjhREiw=', '2021-12-22 04:58:13.072618', 0, 'hhs', '', '', '', 1, 1, '2021-10-06 05:17:47.000000'),
	(3, 'pbkdf2_sha256$260000$m1lzzvWbaBlLYbrhcSEH7C$3GQ0qpinPaVUcsCaXWSS/rS5FDqfgi3LHQMwXsYHQJA=', '2021-10-25 01:09:54.994060', 0, 'ggt', '', '', '', 1, 1, '2021-10-06 05:19:31.000000'),
	(4, 'pbkdf2_sha256$260000$fzoR2u8VPwh1Kpxg3lW5BS$G1bcsY8932HRqIzVeymP2ZVihWIb++KcASSlcgE6rwk=', '2021-10-13 04:37:51.496321', 0, 'kcs', '', '', '', 1, 1, '2021-10-06 05:19:54.000000'),
	(5, 'pbkdf2_sha256$260000$xeqMLcyp6LSSJtebaAw0ri$ATFT01Tr1rnWhXxA9+GS74exLYoEqYRo8byNF8oeIa4=', '2021-10-12 06:37:25.967452', 0, 'shao', '', '', '', 1, 1, '2021-10-06 05:20:14.000000'),
	(6, 'pbkdf2_sha256$260000$v4gh3SvDMTcfDMrmmABqF2$3QaanJQ/aYTa4FAIQLuvFboy3BwdEeYV34QfgH1a3ig=', '2021-10-12 07:58:45.611607', 0, 'fuladi', '', '', '', 1, 1, '2021-10-06 05:21:18.000000'),
	(7, 'pbkdf2_sha256$260000$MWCiP9utwS78zXIms8wXHn$ZDRMHGhFGd36dpND4ebNE0S10kQsR+q0bl6kcBE0vX4=', '2021-11-16 05:02:02.380054', 0, 'yhpark', '박영희', '', '', 0, 1, '2021-11-15 18:42:07.000000'),
	(8, 'pbkdf2_sha256$260000$YHmGtyH5wUJJamTadEC8xq$Rh9zGcvzXzNtahDmtR53I3+StWapynDgFevxRKPCHXs=', '2021-11-22 06:35:41.284220', 0, 'super', '', '', '', 0, 1, '2021-11-16 02:35:52.000000'),
	(9, 'pbkdf2_sha256$260000$GGLLCavin5mDX3zHdOykSV$QFm+tyGAvV+5/++1cYbkJQWCiP51WhoN9TO4fKfXxFo=', '2021-11-16 09:09:12.097556', 0, 'richlee', '이부자', '', '', 0, 1, '2021-11-16 09:08:02.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;

-- 테이블 jobshop.auth_user_groups 구조 내보내기
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.auth_user_groups:~5 rows (대략적) 내보내기
DELETE FROM `auth_user_groups`;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES
	(1, 1, 1),
	(2, 2, 10),
	(3, 7, 11),
	(4, 8, 12),
	(5, 9, 11);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;

-- 테이블 jobshop.auth_user_user_permissions 구조 내보내기
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.auth_user_user_permissions:~240 rows (대략적) 내보내기
DELETE FROM `auth_user_user_permissions`;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
INSERT INTO `auth_user_user_permissions` (`id`, `user_id`, `permission_id`) VALUES
	(89, 1, 1),
	(90, 1, 2),
	(91, 1, 3),
	(92, 1, 4),
	(93, 1, 5),
	(94, 1, 6),
	(95, 1, 7),
	(96, 1, 8),
	(97, 1, 9),
	(98, 1, 10),
	(99, 1, 11),
	(100, 1, 12),
	(101, 1, 13),
	(102, 1, 14),
	(103, 1, 15),
	(104, 1, 16),
	(105, 1, 17),
	(106, 1, 18),
	(107, 1, 19),
	(108, 1, 20),
	(109, 1, 21),
	(110, 1, 22),
	(111, 1, 23),
	(112, 1, 24),
	(113, 1, 25),
	(114, 1, 26),
	(115, 1, 27),
	(116, 1, 28),
	(117, 1, 29),
	(118, 1, 30),
	(119, 1, 31),
	(120, 1, 32),
	(121, 1, 33),
	(122, 1, 34),
	(123, 1, 35),
	(124, 1, 36),
	(125, 1, 37),
	(126, 1, 38),
	(127, 1, 39),
	(128, 1, 40),
	(129, 1, 41),
	(130, 1, 42),
	(131, 1, 43),
	(132, 1, 44),
	(133, 1, 45),
	(134, 1, 46),
	(135, 1, 47),
	(136, 1, 48),
	(137, 1, 49),
	(138, 1, 50),
	(139, 1, 51),
	(140, 1, 52),
	(141, 1, 53),
	(142, 1, 54),
	(143, 1, 55),
	(144, 1, 56),
	(145, 1, 57),
	(146, 1, 58),
	(147, 1, 59),
	(148, 1, 60),
	(149, 1, 61),
	(150, 1, 62),
	(151, 1, 63),
	(152, 1, 64),
	(153, 1, 65),
	(154, 1, 66),
	(155, 1, 67),
	(156, 1, 68),
	(157, 1, 69),
	(158, 1, 70),
	(159, 1, 71),
	(160, 1, 72),
	(161, 1, 73),
	(162, 1, 74),
	(163, 1, 75),
	(164, 1, 76),
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
	(69, 6, 36),
	(165, 8, 1),
	(166, 8, 2),
	(167, 8, 3),
	(168, 8, 4),
	(169, 8, 5),
	(170, 8, 6),
	(171, 8, 7),
	(172, 8, 8),
	(173, 8, 9),
	(174, 8, 10),
	(175, 8, 11),
	(176, 8, 12),
	(177, 8, 13),
	(178, 8, 14),
	(179, 8, 15),
	(180, 8, 16),
	(181, 8, 17),
	(182, 8, 18),
	(183, 8, 19),
	(184, 8, 20),
	(185, 8, 21),
	(186, 8, 22),
	(187, 8, 23),
	(188, 8, 24),
	(189, 8, 25),
	(190, 8, 26),
	(191, 8, 27),
	(192, 8, 28),
	(193, 8, 29),
	(194, 8, 30),
	(195, 8, 31),
	(196, 8, 32),
	(197, 8, 33),
	(198, 8, 34),
	(199, 8, 35),
	(200, 8, 36),
	(201, 8, 37),
	(202, 8, 38),
	(203, 8, 39),
	(204, 8, 40),
	(205, 8, 41),
	(206, 8, 42),
	(207, 8, 43),
	(208, 8, 44),
	(209, 8, 45),
	(210, 8, 46),
	(211, 8, 47),
	(212, 8, 48),
	(213, 8, 49),
	(214, 8, 50),
	(215, 8, 51),
	(216, 8, 52),
	(217, 8, 53),
	(218, 8, 54),
	(219, 8, 55),
	(220, 8, 56),
	(221, 8, 57),
	(222, 8, 58),
	(223, 8, 59),
	(224, 8, 60),
	(225, 8, 61),
	(226, 8, 62),
	(227, 8, 63),
	(228, 8, 64),
	(229, 8, 65),
	(230, 8, 66),
	(231, 8, 67),
	(232, 8, 68),
	(233, 8, 69),
	(234, 8, 70),
	(235, 8, 71),
	(236, 8, 72),
	(237, 8, 73),
	(238, 8, 74),
	(239, 8, 75),
	(240, 8, 76);
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;

-- 테이블 jobshop.board_article 구조 내보내기
CREATE TABLE IF NOT EXISTS `board_article` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `modified_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.board_article:~3 rows (대략적) 내보내기
DELETE FROM `board_article`;
/*!40000 ALTER TABLE `board_article` DISABLE KEYS */;
INSERT INTO `board_article` (`id`, `title`, `author`, `content`, `created_at`, `modified_at`) VALUES
	(1, 'How to install system environment', '최연지', 'The code is on github : \r\nhttps://github.com/chbigbrother/jobshopscheduling\r\n\r\nAfter installing the PyCharm, please clone it to your PyCharm project.\r\nFollow the steps shown in the README.md.', '2021-10-06 06:02:05.098953', '2021-10-06 06:02:05.098953'),
	(2, '샘플 데이터 추가', '황현숙', '연지씨\r\n\r\n세미나때 작성한 수주, 업체에 관한 샘플 데이터 엑셀로 작성하여 업로드 부탁해요.', '2021-10-12 00:23:05.201336', '2021-10-12 00:23:05.201336'),
	(3, '서버 외부 접속 가능하게 설정', '황현숙', '연지씨, \r\n\r\n서버가 외부에서는 접속이 안되는데, 확인해봐줘요', '2021-10-12 00:24:07.705542', '2021-10-12 00:24:07.705542');
/*!40000 ALTER TABLE `board_article` ENABLE KEYS */;

-- 테이블 jobshop.company_facility 구조 내보내기
CREATE TABLE IF NOT EXISTS `company_facility` (
  `facility_id` char(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '설비 아이디',
  `facility_name` int DEFAULT NULL COMMENT '설비명',
  `comp_id` int DEFAULT NULL COMMENT '회사 아이디',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`facility_id`),
  KEY `FK_company_facility_company_information` (`comp_id`),
  CONSTRAINT `FK_company_facility_company_information` FOREIGN KEY (`comp_id`) REFERENCES `company_information` (`comp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='설비정보';

-- 테이블 데이터 jobshop.company_facility:~10 rows (대략적) 내보내기
DELETE FROM `company_facility`;
/*!40000 ALTER TABLE `company_facility` DISABLE KEYS */;
INSERT INTO `company_facility` (`facility_id`, `facility_name`, `comp_id`, `created_at`, `modified_at`) VALUES
	('FAC1#101', 101, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#102', 102, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#103', 103, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#104', 104, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#105', 105, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#106', 106, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#107', 107, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#108', 108, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#109', 109, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#110', 110, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#111', 111, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#112', 112, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#117', 117, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#118', 118, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#119', 119, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#120', 120, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#121', 121, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#122', 122, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#123', 123, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#124', 124, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#125', 125, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#126', 126, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#127', 127, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#128', 128, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#129', 129, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#130', 130, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#131', 131, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#132', 132, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#133', 133, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#134', 134, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#135', 135, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#136', 136, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#165', 165, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#166', 166, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#167', 167, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#168', 168, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#169', 169, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#170', 170, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#171', 171, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#172', 172, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#173', 173, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#174', 174, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#213', 213, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#214', 214, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#215', 215, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#216', 216, 1, '2021-12-23 04:25:34', '2021-12-23 04:25:34'),
	('FAC1#237', 237, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#238', 238, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#239', 239, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#240', 240, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#241', 241, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#242', 242, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#243', 243, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#244', 244, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#245', 245, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#246', 246, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#247', 247, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#248', 248, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#249', 249, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#250', 250, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#251', 251, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#252', 252, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#253', 253, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#254', 254, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#255', 255, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#256', 256, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#257', 257, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#258', 258, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#259', 259, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#260', 260, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#261', 261, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#262', 262, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#263', 263, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35'),
	('FAC1#264', 264, 1, '2021-12-23 04:25:35', '2021-12-23 04:25:35');
/*!40000 ALTER TABLE `company_facility` ENABLE KEYS */;

-- 테이블 jobshop.company_information 구조 내보내기
CREATE TABLE IF NOT EXISTS `company_information` (
  `comp_id` int NOT NULL AUTO_INCREMENT COMMENT '회사아이디',
  `comp_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '회사명',
  PRIMARY KEY (`comp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.company_information:~10 rows (대략적) 내보내기
DELETE FROM `company_information`;
/*!40000 ALTER TABLE `company_information` DISABLE KEYS */;
INSERT INTO `company_information` (`comp_id`, `comp_name`) VALUES
	(1, '(주)나다'),
	(2, '(주)동광'),
	(3, '(주)베가'),
	(4, '대명섬유'),
	(5, '태화방직(주)'),
	(6, '경주산업사'),
	(7, '(주)효성'),
	(8, '삼화기업'),
	(9, '부민직물(주)'),
	(10, '(주)청옥산업');
/*!40000 ALTER TABLE `company_information` ENABLE KEYS */;

-- 테이블 jobshop.company_product 구조 내보내기
CREATE TABLE IF NOT EXISTS `company_product` (
  `prod_id` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '제품 아이디',
  `comp_id` int DEFAULT NULL,
  `prod_name` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제품 명',
  `density` double DEFAULT NULL COMMENT '밀도',
  `rpm` double DEFAULT NULL COMMENT '기계 rpm',
  `daily_prod_rate` int DEFAULT NULL COMMENT '일일생산량',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`prod_id`),
  KEY `FK_company_product_company_information` (`comp_id`),
  CONSTRAINT `FK_company_product_company_information` FOREIGN KEY (`comp_id`) REFERENCES `company_information` (`comp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='제품정보';

-- 테이블 데이터 jobshop.company_product:~11 rows (대략적) 내보내기
DELETE FROM `company_product`;
/*!40000 ALTER TABLE `company_product` DISABLE KEYS */;
INSERT INTO `company_product` (`prod_id`, `comp_id`, `prod_name`, `density`, `rpm`, `daily_prod_rate`, `created_at`, `modified_at`) VALUES
	('PRD001', 1, '6FD-904', 74, 510, 262, '2021-12-22 04:49:45', '2021-12-22 04:49:45'),
	('PRD002', 1, '6KOS-FD2', 74, 499, 256, '2021-12-22 04:49:45', '2021-12-22 04:49:45'),
	('PRD003', 1, 'P 210T', 70, 562, 305, '2021-12-22 04:49:45', '2021-12-22 04:49:45'),
	('PRD004', 1, '6KOS-FDCJ', 70, 525, 285, '2021-12-22 04:49:45', '2021-12-22 04:49:45'),
	('PRD005', 1, 'N/T 210T', 90, 571, 241, '2021-12-22 04:49:45', '2021-12-22 04:49:45'),
	('PRD006', 1, 'N MGB', 70, 568, 308, '2021-12-22 04:49:45', '2021-12-22 04:49:45');
/*!40000 ALTER TABLE `company_product` ENABLE KEYS */;

-- 테이블 jobshop.company_schedule 구조 내보내기
CREATE TABLE IF NOT EXISTS `company_schedule` (
  `sch_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '오더일자',
  `comp_id` int DEFAULT NULL COMMENT '회사 아이디',
  `facility_id` char(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '설비 아이디',
  `count` int DEFAULT NULL COMMENT '스케줄생성카운트',
  `order_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '오더넘버',
  `sch_color` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '색깔',
  `x_axis_1` double NOT NULL COMMENT 'x축 1',
  `x_axis_2` double NOT NULL COMMENT 'x축 2',
  `y_axis_1` double NOT NULL COMMENT 'y축 1',
  `y_axis_2` double NOT NULL COMMENT 'y축 2',
  `work_str_date` char(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '작업시작일자',
  `work_end_date` char(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '작업종료일자',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`sch_id`),
  KEY `comp_id` (`comp_id`),
  KEY `FK_company_schedule_company_facility` (`facility_id`),
  CONSTRAINT `FK_company_schedule_comp_admin_authcompany` FOREIGN KEY (`comp_id`) REFERENCES `company_information` (`comp_id`),
  CONSTRAINT `FK_company_schedule_company_facility` FOREIGN KEY (`facility_id`) REFERENCES `company_facility` (`facility_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.company_schedule:~2 rows (대략적) 내보내기
DELETE FROM `company_schedule`;
/*!40000 ALTER TABLE `company_schedule` DISABLE KEYS */;
INSERT INTO `company_schedule` (`sch_id`, `comp_id`, `facility_id`, `count`, `order_id`, `sch_color`, `x_axis_1`, `x_axis_2`, `y_axis_1`, `y_axis_2`, `work_str_date`, `work_end_date`, `created_at`, `modified_at`) VALUES
	('SCH2021122000l0', 1, 'FAC1#104', 1, 'ORD001.1', 'yellow', 0, 29, 0.7, 1.5, '20211220', '20220201', '2021-12-20 09:40:48', '2021-12-20 09:40:49'),
	('SCH2021122010i0', 1, 'FAC1#107', 1, 'ORD002.1', 'whitesmoke', 29, 72, 0.7, 1.5, '20211220', '20220201', '2021-12-20 09:40:49', '2021-12-20 09:40:49'),
	('SCH2021122020i0', 1, 'FAC1#110', 2, 'ORD002.1', 'whitesmoke', 29, 72, 0.7, 1.5, '20211220', '20211221', '2021-12-20 09:40:49', '2021-12-20 09:40:49');
/*!40000 ALTER TABLE `company_schedule` ENABLE KEYS */;

-- 테이블 jobshop.django_admin_log 구조 내보내기
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.django_admin_log:~58 rows (대략적) 내보내기
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
	(44, '2021-11-09 03:21:57.359667', '1', 'pknu', 2, '[{"changed": {"fields": ["Groups"]}}]', 4, 1),
	(45, '2021-11-15 10:00:48.664225', '2', '(주)청옥산업', 1, '[{"added": {}}]', 3, 1),
	(46, '2021-11-15 15:21:12.351400', '2', 'hhs', 2, '[{"changed": {"fields": ["Groups"]}}]', 4, 1),
	(47, '2021-11-15 18:42:07.700876', '7', 'test', 1, '[{"added": {}}]', 4, 1),
	(48, '2021-11-16 02:28:33.802642', '7', 'yhpark', 2, '[{"changed": {"fields": ["Username", "First name"]}}]', 4, 1),
	(49, '2021-11-16 02:35:52.392396', '8', 'super', 1, '[{"added": {}}]', 4, 1),
	(50, '2021-11-16 02:49:43.163571', '1', 'pknu', 2, '[{"changed": {"fields": ["User permissions"]}}]', 4, 1),
	(51, '2021-11-16 02:50:05.826154', '11', 'customer', 1, '[{"added": {}}]', 3, 1),
	(52, '2021-11-16 02:50:17.957946', '7', 'yhpark', 2, '[{"changed": {"fields": ["Groups"]}}]', 4, 1),
	(53, '2021-11-16 02:57:06.820179', '12', 'admin', 1, '[{"added": {}}]', 3, 1),
	(54, '2021-11-16 03:01:13.286699', '8', 'super', 2, '[{"changed": {"fields": ["User permissions"]}}]', 4, 1),
	(55, '2021-11-16 03:02:26.000741', '8', 'super', 2, '[{"changed": {"fields": ["Groups"]}}]', 4, 1),
	(56, '2021-11-16 09:08:02.656243', '9', 'richlee', 1, '[{"added": {}}]', 4, 1),
	(57, '2021-11-16 09:08:16.474494', '9', 'richlee', 2, '[{"changed": {"fields": ["Groups"]}}]', 4, 1),
	(58, '2021-11-16 09:09:06.952106', '9', 'richlee', 2, '[{"changed": {"fields": ["First name"]}}]', 4, 1),
	(59, '2021-11-18 03:43:15.579705', '1', '1 / (주)나다 / 4', 1, '[{"added": {}}]', 21, 1),
	(60, '2021-11-18 06:36:26.182426', '13', 'company', 1, '[{"added": {}}]', 3, 1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;

-- 테이블 jobshop.django_content_type 구조 내보내기
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.django_content_type:~22 rows (대략적) 내보내기
DELETE FROM `django_content_type`;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(3, 'auth', 'group'),
	(2, 'auth', 'permission'),
	(4, 'auth', 'user'),
	(9, 'board', 'article'),
	(21, 'comp_admin', 'authcompany'),
	(10, 'company', 'article'),
	(11, 'company', 'company'),
	(15, 'company', 'daily'),
	(20, 'company', 'dailyfacility'),
	(25, 'company', 'facility'),
	(17, 'company', 'fixedschedule'),
	(22, 'company', 'information'),
	(24, 'company', 'product'),
	(16, 'company', 'schedule'),
	(5, 'contenttypes', 'contenttype'),
	(13, 'dashboard', 'schedule'),
	(8, 'fileutils', 'fileupload'),
	(12, 'fileutils', 'fileuploadcsv'),
	(14, 'fileutils', 'photo'),
	(7, 'jobshop', 'document'),
	(19, 'order', 'orderlist'),
	(18, 'order', 'orderschedule'),
	(23, 'schedule', 'schedule'),
	(6, 'sessions', 'session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;

-- 테이블 jobshop.django_migrations 구조 내보내기
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.django_migrations:~31 rows (대략적) 내보내기
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
	(29, 'order', '0001_initial', '2021-11-09 03:49:54.330048'),
	(30, 'order', '0002_alter_orderschedule_sch_id', '2021-11-11 06:24:58.610422'),
	(31, 'comp_admin', '0001_initial', '2021-11-18 03:29:02.302693'),
	(32, 'order', '0002_auto_20211216_1208', '2021-12-16 03:08:25.506333'),
	(33, 'schedule', '0001_initial', '2021-12-20 02:37:58.205626'),
	(34, 'fileutils', '0005_alter_fileuploadcsv_file', '2021-12-22 02:36:50.619088'),
	(35, 'fileutils', '0006_alter_fileuploadcsv_file', '2021-12-23 02:39:34.639295');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;

-- 테이블 jobshop.django_session 구조 내보내기
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.django_session:~24 rows (대략적) 내보내기
DELETE FROM `django_session`;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('0wtqbfagfi6ljgjiwkyudjc32fz1unjb', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1mzUwb:0DG_a9dgIz4dAVN4YwxL3_wBCkkyWS6RK-LG556g5xQ', '2022-01-04 02:32:01.803483'),
	('70ormi719s2auzxducjy1ztp1ac1mcp6', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1mcMGY:PtLpNB_Eldh7Z6aDNvdz60OOyOZ2vkNzgPubgviH27M', '2021-11-01 06:36:58.219744'),
	('81mob9rf1asg8zg35g816fb99honif58', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1mkzJN:8LXT519o309hvUTdSRqCLrxP1CCRB9Sf4TUD5ieE-kg', '2021-11-25 01:55:33.870503'),
	('9o9vx6g5peyrpf4znbukx7k4qw8gy7b9', '.eJxVjMsOwiAQRf-FtSEDyMul-34DGRiQqoGktCvjv2uTLnR7zzn3xQJuaw3byEuYiV2YYaffLWJ65LYDumO7dZ56W5c58l3hBx186pSf18P9O6g46rfWClx0ZDSqmMEWKXUCmbJE64zzBtBoIJV8sabYQoJEAhA-2jNGKzN7fwDUpjei:1metgF:CzbJNvRyjAgrt_C5T8UFz2P76GE-4w1FUkYF8fti8SQ', '2021-11-08 06:41:59.986392'),
	('e8fdaion6htke2rfwblr9mzm4adr2m1q', '.eJxVjEEOwiAQRe_C2hDawlBcuvcMzTAzSNVAUtqV8e7apAvd_vfef6kJtzVPW5NlmlmdVVCn3y0iPaTsgO9YblVTLesyR70r-qBNXyvL83K4fwcZW_7WMaEkb8wIEsGnwQLYmJwnAsEOxxDRMgBDb5xYduQRek9ghs44y0G9PwUFOA8:1mmuSm:Bj1w8witTblh19tBfmPHGsGZ4bIFln_CSMwZKOcanYU', '2021-11-30 09:09:12.102043'),
	('efoipo68omk6rdmegaq5jn3spf3f47au', '.eJxVjMsOwiAQRf-FtSG8hMGl-34DYRiQqoGktCvjv2uTLnR7zzn3xULc1hq2kZcwE7swYKffDWN65LYDusd26zz1ti4z8l3hBx186pSf18P9O6hx1G-tURqNEK11wpMDROlAFqOdoGKTMNmhUAQueeXPCKhzAdBRKtKS0LD3B8_xN30:1mmsW7:hjuBircIVIe6Uui-CfUyEFuRUGHiwzy0bDA_-E-5-KE', '2021-11-30 07:04:31.238002'),
	('iskza4e7j1m6r284h3ei7asrdmdoul7j', '.eJxVjEEOwiAQAP_C2RBsaVk8eu8byLK7SNXQpLQn49-VpAe9zkzmpQLuWw57lTXMrC6qV6dfFpEeUprgO5bbomkp2zpH3RJ92KqnheV5Pdq_Qcaa2xaQx3Rma5JBMoBiwAnxMAohOLLJ9n6grpMkkQHc-G0peYBoO_Co3h8G8zir:1meoUs:9TLSnCSTuweIrxIhnt-2KbQKzTDj4T5XKRy80vbltMc', '2021-11-08 01:09:54.998059'),
	('jw6w8j1a4ccf7yr6sf43qyosyrk57rfi', '.eJxVjMsOgjAURP-la9OUwi2tS_d8A7mPYlHTJhRWxn8XEhY6yzln5q1G3NY0bjUu4yzqqqy6_HaE_Iz5APLAfC-aS16XmfSh6JNWPRSJr9vp_h0krGlft3tcYyD4hmyYXM_Otyw8CYkjjxTJ9g22bIgjAHgIfYfWsBiBjkR9vtp_OCg:1mfDZ5:_dT72l55TRqgm3z_jSm7Whxm9ieZD6TPM1d1mA8r3Nc', '2021-11-09 03:55:55.769977'),
	('k1d7lk0zp4ljaksg60em61hti98rmaw6', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1mkFdF:dg0EpMo8Xyfsuc8ps3PlmdRq6tcQ4LeFcpjI8WB9DTA', '2021-11-23 01:09:01.680874'),
	('kuwjad0rxvl41pvblhyz1rp6f8ty612k', '.eJxVjMsOwiAQRf-FtSG8hMGl-34DYRiQqoGktCvjv2uTLnR7zzn3xULc1hq2kZcwE7swYKffDWN65LYDusd26zz1ti4z8l3hBx186pSf18P9O6hx1G-tURqNEK11wpMDROlAFqOdoGKTMNmhUAQueeXPCKhzAdBRKtKS0LD3B8_xN30:1mp2vV:DzQuazCA5epcJjqtIBnPGRCCNHPtzUmnn8RCpMHw01A', '2021-12-06 06:35:41.288210'),
	('meui39vg866noga9q083a67f1h1860rd', '.eJxVjDsOwjAQBe_iGlnr9TeU9JzBWttrHECxlE-FuDtESgHtm5n3EpG2tcVt4TmORZyFE6ffLVF-8LSDcqfp1mXu0zqPSe6KPOgir73w83K4fweNlvatg1LFhmAsq-qNRrBUKpqkLXAIQ1WO6gBGm4TMRAUYKkCqmB16RC_eH8okN2Y:1mY279:gYJfJSekh9jZChwAcOoUi-nvCCJStyAyZJc_ZM4gv2M', '2021-10-20 08:17:23.502700'),
	('oe04a3zc66j5vmcp4kd5mjxb8ng1t94x', '.eJxVjMsOwiAUBf-FtSFAL6m4dO83EO4DqRqalHbV-O9K0oVuz8ycXcW0rSVuTZY4sboor06_GyZ6Su2AH6neZ01zXZcJdVf0QZu-zSyv6-H-HZTUSq_DAEIwWGCGDDaMYJCAz5iRk3hi8xXYBW8R_JiTdYE9GfHi0Amr9wf7ZDi5:1maBPh:etUb2Iweu7k6uY11e2e-bvyWjKkixZM7gh-OURG5tqs', '2021-10-26 06:37:25.972451'),
	('pf936qa3zuvm2xxnxh7wlokxqowd560h', '.eJxVjEEOwiAQRe_C2hDawlBcuvcMzTAzSNVAUtqV8e7apAvd_vfef6kJtzVPW5NlmlmdVVCn3y0iPaTsgO9YblVTLesyR70r-qBNXyvL83K4fwcZW_7WMaEkb8wIEsGnwQLYmJwnAsEOxxDRMgBDb5xYduQRek9ghs44y0G9PwUFOA8:1mmuS5:94ixPsEuXpD_OsxJP1bmRN4xQNk9-6jUeTsTMVcLtxo', '2021-11-30 09:08:29.727185'),
	('ph9l8kecewxi44wlx7pmgl74yx6fvz1m', '.eJxVjMsOwiAUBf-FtSFAL6m4dO83EO4DqRqalHbV-O9K0oVuz8ycXcW0rSVuTZY4sboor06_GyZ6Su2AH6neZ01zXZcJdVf0QZu-zSyv6-H-HZTUSq_DAEIwWGCGDDaMYJCAz5iRk3hi8xXYBW8R_JiTdYE9GfHi0Amr9wf7ZDi5:1maBO2:9irarAQzFj0AZ9maJyFxYGXUyrF8A0st8W4DHdD4Ej0', '2021-10-26 06:35:42.401452'),
	('prbx8u6fmml2aa50wwqyykkn5k51hhqe', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1mzYmS:NuhZVuVI2x7URCN7aqtvE9lBgRxp2Ya2xadW9W4hNcs', '2022-01-04 06:37:48.118765'),
	('pwfxkjz37f5rwqehjhp25htp2phj68u7', '.eJxVjMsOgjAURP-la9OUwi2tS_d8A7mPYlHTJhRWxn8XEhY6yzln5q1G3NY0bjUu4yzqqqy6_HaE_Iz5APLAfC-aS16XmfSh6JNWPRSJr9vp_h0krGlft3tcYyD4hmyYXM_Otyw8CYkjjxTJ9g22bIgjAHgIfYfWsBiBjkR9vtp_OCg:1mmm02:VsETb25Cs4zQ1D6k-xJd4oaulLBHcAtjprHHVnt8irw', '2021-11-30 00:06:58.646698'),
	('reeklhqzof8la3e6bgdd155wehxr18ol', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1maB9s:kJvwiTi5ee1uM3VPj6Fwf3Dq2qQQhKEvdH9Y4wFHBHw', '2021-10-26 06:21:04.913450'),
	('rnjj5l3hi08tas1pf09vk6tzbyoq4hkg', '.eJxVjMsOgjAURP-la9OUwi2tS_d8A7mPYlHTJhRWxn8XEhY6yzln5q1G3NY0bjUu4yzqqqy6_HaE_Iz5APLAfC-aS16XmfSh6JNWPRSJr9vp_h0krGlft3tcYyD4hmyYXM_Otyw8CYkjjxTJ9g22bIgjAHgIfYfWsBiBjkR9vtp_OCg:1mZsdY:_3dscVeQ6EYBX5QvShnKWbyuwleD_LqszlVeE2eBpY8', '2021-10-25 10:34:28.841935'),
	('s37bihpfk5swxgsb9wyj8619uohg8atz', '.eJxVjEEOwiAQAP_C2RBsaVk8eu8byLK7SNXQpLQn49-VpAe9zkzmpQLuWw57lTXMrC6qV6dfFpEeUprgO5bbomkp2zpH3RJ92KqnheV5Pdq_Qcaa2xaQx3Rma5JBMoBiwAnxMAohOLLJ9n6grpMkkQHc-G0peYBoO_Co3h8G8zir:1mXzax:-k_JHR-XEFK_oAQ6lbO8WqmYCFInMDvFsFsT2YTbus8', '2021-10-20 05:35:59.991710'),
	('sun1fi05w1gru825jmhnvysevd44dkvr', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1mnDm9:YDnVgPdZNxxeoB_rWYzedPFNvYbEVKIa-TVdlh_IXUk', '2021-12-01 05:46:29.869128'),
	('wv20h3q60iuip38psg0h2gydtf98k7gl', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1mmmOT:FrRwCmSvt2Dn73ONPKVqG0vK0zFF78cCF0iTNrnK_OE', '2021-11-30 00:32:13.256141'),
	('wx7ipscbbqozjlcw37uu6oeohurs9mm6', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1mXzAy:zK88BlNciAyKErYrCPu0P-Znw8fMc2G70QUPkFTmUh8', '2021-10-20 05:09:08.613191'),
	('xg3ivkxwjlxokndumiv82cm3z4yxrvqi', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1maWsU:DRUMfGzbkbcT-Z1iODg0veGku95mnac1QGrRAVzWb10', '2021-10-27 05:32:34.277016'),
	('xiu27uuea5g5qzzz6d75s4rslu1a0ty6', '.eJxVjDsOwyAQBe9CHSHAhoWU6X0GtHw2OIlAMnYV5e6xJRdJ-2bmvZnHbS1-63nxc2JXJtnldwsYn7keID2w3huPra7LHPih8JN2PrWUX7fT_Tso2MteO4yG9GAB5QhkwYyJhHagBIBMMjqd1UCZBFkXB6UhEpiERoJVYbfY5wvOQjcz:1mzthn:qmxLM7FAgcqToNk721ZjQa7docPKJ8iKrv3HX50vwfA', '2022-01-05 04:58:23.839722');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;

-- 테이블 jobshop.fileutils_fileupload 구조 내보내기
CREATE TABLE IF NOT EXISTS `fileutils_fileupload` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.fileutils_fileupload:~6 rows (대략적) 내보내기
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
CREATE TABLE IF NOT EXISTS `fileutils_fileuploadcsv` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `file` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.fileutils_fileuploadcsv:~194 rows (대략적) 내보내기
DELETE FROM `fileutils_fileuploadcsv`;
/*!40000 ALTER TABLE `fileutils_fileuploadcsv` DISABLE KEYS */;
INSERT INTO `fileutils_fileuploadcsv` (`id`, `title`, `file`) VALUES
	(3, '', '주나다_설비정보.csv'),
	(4, '', '주나다_설비정보.csv'),
	(5, '', '주나다_설비정보.csv'),
	(6, '', 'order.csv'),
	(7, '', 'production.csv'),
	(8, '', 'order.csv'),
	(9, '', 'production.csv'),
	(10, '', 'order.csv'),
	(11, '', 'order.csv'),
	(12, '', 'order.csv'),
	(13, '', 'order.csv');
/*!40000 ALTER TABLE `fileutils_fileuploadcsv` ENABLE KEYS */;

-- 테이블 jobshop.fileutils_photo 구조 내보내기
CREATE TABLE IF NOT EXISTS `fileutils_photo` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_id` int DEFAULT NULL,
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
CREATE TABLE IF NOT EXISTS `order_orderlist` (
  `order_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '오더아이디',
  `cust_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고객 이름',
  `sch_date` char(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문일자',
  `exp_date` char(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기한',
  `prod_id` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '섬유유형',
  `amount` int DEFAULT NULL COMMENT '수량',
  `contact` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '연락처',
  `email` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이메일',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `FK_order_orderlist_company_product` (`prod_id`),
  CONSTRAINT `FK_order_orderlist_company_product` FOREIGN KEY (`prod_id`) REFERENCES `company_product` (`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.order_orderlist:~0 rows (대략적) 내보내기
DELETE FROM `order_orderlist`;
/*!40000 ALTER TABLE `order_orderlist` DISABLE KEYS */;
INSERT INTO `order_orderlist` (`order_id`, `cust_name`, `sch_date`, `exp_date`, `prod_id`, `amount`, `contact`, `email`, `created_at`, `modified_at`) VALUES
	('ORD001', '강부자', '20211220', '20220130', 'PRD001', 10000, '010-5555-6666', 'rich@rich.com', '2021-12-23 06:11:14', '2021-12-23 06:11:14'),
	('ORD002', '유민상', '20211220', '20220130', 'PRD002', 2000, '010-4444-1111', 'yoo@min.com', '2021-12-23 06:11:14', '2021-12-23 06:11:14'),
	('ORD003', '김준현', '20211220', '20220125', 'PRD003', 50000, '010-8888-4444', 'kim@food.com', '2021-12-23 06:11:14', '2021-12-23 06:11:14'),
	('ORD004', '박영희', '20211221', '20220125', 'PRD004', 250000, '010-9999-4444', 'yhpark@fabric.com', '2021-12-23 06:11:14', '2021-12-23 06:11:14'),
	('ORD005', '이부자', '20211221', '20220125', 'PRD002', 1200, '010-3333-2222', 'richlee@lee.com', '2021-12-23 06:11:14', '2021-12-23 06:11:14'),
	('ORD006', '박영희', '20211221', '20220125', 'PRD001', 60000, '010-9999-4444', 'yhpark@fabric.com', '2021-12-23 06:11:14', '2021-12-23 06:11:14'),
	('ORD007', '이부자', '20211221', '20220125', 'PRD005', 1200, '010-3333-2222', 'richlee@lee.com', '2021-12-23 06:11:14', '2021-12-23 06:11:14'),
	('ORD008', '최술관', '20211221', '20220125', 'PRD006', 52030, '010-1111-1111', 'choi@museum.com', '2021-12-23 06:11:14', '2021-12-23 06:11:14'),
	('ORD009', '김러닝', '20211221', '20220125', 'PRD005', 60000, '010-8855-1111', 'choi@museum.com', '2021-12-23 06:11:14', '2021-12-23 06:11:14'),
	('ORD010', '장장국', '20211221', '20220125', 'PRD001', 78000, '010-1111-9999', 'soup@soup.com', '2021-12-23 06:11:14', '2021-12-23 06:11:14');
/*!40000 ALTER TABLE `order_orderlist` ENABLE KEYS */;

-- 테이블 jobshop.order_orderschedule 구조 내보내기
CREATE TABLE IF NOT EXISTS `order_orderschedule` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `order_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sch_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `use_yn` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idx`),
  KEY `order_id` (`order_id`),
  KEY `sch_id` (`sch_id`),
  CONSTRAINT `FK_order_orderschedule_company_schedule` FOREIGN KEY (`sch_id`) REFERENCES `company_schedule` (`sch_id`),
  CONSTRAINT `FK_order_orderschedule_order_orderlist` FOREIGN KEY (`order_id`) REFERENCES `order_orderlist` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 테이블 데이터 jobshop.order_orderschedule:~0 rows (대략적) 내보내기
DELETE FROM `order_orderschedule`;
/*!40000 ALTER TABLE `order_orderschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_orderschedule` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
