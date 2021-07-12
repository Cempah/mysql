#
# TABLE STRUCTURE FOR: communities
#

DROP TABLE IF EXISTS `communities`;

CREATE TABLE `communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(145) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(245) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `communities_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `communities` (`id`, `name`, `description`) VALUES ('1', 'atque', 'Dignissimos itaque ab aut eos rerum aut.');
INSERT INTO `communities` (`id`, `name`, `description`) VALUES ('2', 'incidunt', 'Et aliquid dolores dolores qui rerum.');
INSERT INTO `communities` (`id`, `name`, `description`) VALUES ('3', 'distinctio', 'Consequuntur impedit dolores ea et natus eveniet itaque optio.');
INSERT INTO `communities` (`id`, `name`, `description`) VALUES ('4', 'et', 'Et consequatur sed laudantium excepturi.');
INSERT INTO `communities` (`id`, `name`, `description`) VALUES ('5', 'unde', 'Debitis dignissimos repudiandae cum voluptates.');
INSERT INTO `communities` (`id`, `name`, `description`) VALUES ('6', 'quod', 'Necessitatibus consequatur dolorem delectus perferendis et.');
INSERT INTO `communities` (`id`, `name`, `description`) VALUES ('7', 'quos', 'Saepe omnis recusandae dolor in minima id.');
INSERT INTO `communities` (`id`, `name`, `description`) VALUES ('8', 'eius', 'Impedit beatae repudiandae recusandae nisi.');
INSERT INTO `communities` (`id`, `name`, `description`) VALUES ('9', 'ut', 'Non fuga ullam sed.');
INSERT INTO `communities` (`id`, `name`, `description`) VALUES ('10', 'non', 'Magnam molestiae laborum officia dolores doloremque.');
INSERT INTO `communities` (`id`, `name`, `description`) VALUES ('11', 'tempora', 'Et eum qui consequatur enim.');
INSERT INTO `communities` (`id`, `name`, `description`) VALUES ('12', 'eum', 'Ut veritatis velit aut ipsum quidem soluta esse amet.');
INSERT INTO `communities` (`id`, `name`, `description`) VALUES ('13', 'tempora', 'Totam non aut atque ea itaque repudiandae dolore.');
INSERT INTO `communities` (`id`, `name`, `description`) VALUES ('14', 'itaque', 'Est natus ea esse a ullam itaque reprehenderit.');
INSERT INTO `communities` (`id`, `name`, `description`) VALUES ('15', 'a', 'Rerum iure assumenda quae quia quisquam.');


#
# TABLE STRUCTURE FOR: communities_users
#

DROP TABLE IF EXISTS `communities_users`;

CREATE TABLE `communities_users` (
  `community_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`community_id`,`user_id`),
  KEY `communities_users_comm_idx` (`community_id`),
  KEY `communities_users_users_idx` (`user_id`),
  CONSTRAINT `communities_users_ibfk_1` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`),
  CONSTRAINT `communities_users_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('1', '5', '2013-03-16 11:01:47');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('1', '35', '1999-05-08 05:31:51');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('1', '74', '1979-05-28 19:57:45');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('1', '89', '1976-08-15 20:05:30');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('1', '90', '1979-01-24 05:56:42');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('1', '99', '1973-11-08 17:25:28');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('2', '11', '1970-04-08 18:40:44');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('2', '19', '1993-12-10 08:46:59');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('2', '27', '2016-02-20 15:32:02');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('2', '99', '2001-06-21 12:36:24');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('3', '18', '2000-09-14 02:05:16');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('4', '14', '1971-10-26 23:45:00');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('4', '20', '1976-04-18 03:27:16');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('4', '22', '1992-03-05 17:15:52');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('4', '23', '2016-11-06 17:29:59');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('4', '33', '2012-02-23 23:24:15');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('4', '42', '1995-05-26 06:32:14');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('4', '76', '1984-07-17 14:00:30');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('5', '3', '1984-12-22 22:39:11');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('5', '13', '1971-11-14 13:01:42');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('5', '30', '2018-08-02 05:41:24');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('5', '33', '2008-02-03 09:40:57');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('5', '76', '1997-05-09 20:19:19');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('5', '83', '1980-02-23 17:10:23');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('5', '88', '2019-04-02 09:39:21');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('6', '24', '1981-09-02 01:17:12');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('6', '26', '1982-10-15 08:50:36');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('6', '57', '1988-06-02 14:19:44');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('6', '64', '1989-10-30 00:16:21');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('6', '81', '1996-06-04 20:58:57');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('6', '85', '1974-01-19 20:46:49');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('6', '90', '2000-11-20 20:20:30');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('7', '4', '1988-05-16 01:28:05');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('7', '7', '1977-02-08 10:57:12');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('7', '28', '1976-11-06 22:50:55');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('7', '51', '2003-09-12 02:03:11');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('7', '60', '2005-01-30 09:46:45');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('8', '1', '1979-10-29 00:33:54');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('8', '8', '2016-05-14 08:18:04');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('8', '41', '1988-11-26 05:35:00');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('8', '52', '1994-04-22 23:49:58');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('8', '74', '2002-03-30 20:11:13');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('8', '84', '2005-04-02 08:02:54');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('8', '97', '1981-07-13 00:32:57');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('9', '26', '2020-12-02 20:40:57');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('9', '30', '1978-01-09 18:30:53');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('9', '40', '1982-03-26 12:27:46');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('9', '66', '1982-11-08 07:59:02');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('9', '72', '1994-10-06 02:47:57');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('9', '76', '2008-12-04 04:14:33');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('9', '82', '2003-01-28 14:59:08');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('10', '13', '2001-12-01 08:46:34');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('10', '29', '1976-06-16 07:38:38');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('10', '70', '1993-07-28 11:44:52');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('10', '87', '1987-05-26 23:02:08');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('11', '8', '1974-02-05 16:46:45');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('11', '59', '1979-01-30 13:56:14');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('11', '60', '2013-08-16 15:56:06');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('12', '1', '2011-11-13 03:11:15');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('12', '11', '1997-09-24 02:37:55');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('12', '16', '2005-02-06 14:15:02');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('12', '18', '1988-05-29 13:49:22');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('12', '27', '2018-09-08 03:04:17');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('12', '53', '1978-12-16 15:33:58');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('12', '85', '1993-05-01 16:26:22');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('13', '32', '2006-04-23 17:30:07');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('13', '40', '1976-07-14 20:13:08');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('13', '49', '2005-11-23 22:24:38');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('13', '54', '2009-06-03 23:44:18');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('13', '88', '1999-12-28 05:52:13');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('14', '37', '1988-01-16 11:25:47');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('14', '45', '1994-02-18 19:28:59');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('14', '46', '2015-12-26 12:31:32');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('14', '70', '1995-11-26 05:54:51');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('15', '12', '1974-05-25 19:25:17');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('15', '14', '1990-11-13 06:15:20');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('15', '26', '1972-09-01 20:11:23');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES ('15', '70', '1997-07-08 01:15:42');


#
# TABLE STRUCTURE FOR: friend_requests
#

DROP TABLE IF EXISTS `friend_requests`;

CREATE TABLE `friend_requests` (
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `accepted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`from_user_id`,`to_user_id`),
  KEY `fk_friend_requests_from_user_idx` (`from_user_id`),
  KEY `fk_friend_requests_to_user_idx` (`to_user_id`),
  CONSTRAINT `fk_friend_requests_users_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_friend_requests_users_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('1', '31', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('2', '50', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('3', '43', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('4', '87', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('6', '16', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('7', '11', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('7', '78', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('8', '38', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('8', '74', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('8', '87', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('9', '71', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('10', '41', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('10', '85', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('11', '44', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('11', '66', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('12', '99', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('13', '2', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('13', '23', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('14', '17', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('14', '52', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('16', '10', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('17', '16', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('17', '63', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('18', '51', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('18', '94', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('20', '6', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('20', '50', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('22', '13', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('24', '15', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('25', '66', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('25', '71', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('27', '4', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('27', '37', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('28', '27', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('28', '78', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('30', '40', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('31', '54', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('32', '19', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('32', '56', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('32', '94', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('33', '56', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('34', '92', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('35', '21', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('35', '66', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('35', '98', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('36', '34', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('36', '76', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('36', '92', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('37', '88', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('38', '43', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('38', '58', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('38', '73', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('39', '86', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('41', '31', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('41', '69', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('42', '56', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('42', '94', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('43', '89', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('46', '11', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('46', '60', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('46', '98', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('47', '19', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('47', '36', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('48', '33', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('50', '37', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('51', '32', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('51', '34', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('52', '73', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('52', '93', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('53', '35', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('53', '52', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('53', '64', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('53', '99', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('54', '40', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('54', '54', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('54', '56', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('54', '61', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('56', '52', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('56', '71', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('59', '12', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('59', '35', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('59', '56', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('59', '75', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('61', '7', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('61', '9', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('63', '3', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('64', '72', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('65', '47', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('67', '8', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('67', '26', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('69', '84', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('70', '86', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('71', '17', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('71', '48', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('72', '79', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('73', '14', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('77', '91', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('79', '60', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('81', '6', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('82', '92', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('83', '20', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('83', '63', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('86', '82', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('88', '42', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('89', '18', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('89', '52', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('90', '69', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('91', '67', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('94', '32', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('94', '38', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('94', '87', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('95', '5', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('97', '39', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('97', '65', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('97', '99', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('98', '80', 0);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('99', '8', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('99', '29', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('99', '76', 1);
INSERT INTO `friend_requests` (`from_user_id`, `to_user_id`, `accepted`) VALUES ('100', '90', 0);


#
# TABLE STRUCTURE FOR: media
#

DROP TABLE IF EXISTS `media`;

CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_types_id` int(10) unsigned NOT NULL,
  `file_name` varchar(245) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '/files/folder/img.png',
  `file_size` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `media_users_idx` (`user_id`),
  KEY `media_media_types_idx` (`media_types_id`),
  CONSTRAINT `fk_media_media_types` FOREIGN KEY (`media_types_id`) REFERENCES `media_types` (`id`),
  CONSTRAINT `fk_media_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('1', '78', 4, 'folder', '3170', '1970-08-04 07:21:20');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('2', '58', 2, 'folder', '433', '1991-08-19 12:18:15');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('3', '55', 1, 'png', '3998', '1988-02-24 23:05:29');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('4', '77', 3, 'files', '4804', '1989-05-13 02:42:25');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('5', '76', 3, 'folder', '311', '1982-12-24 08:38:04');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('6', '94', 2, 'files', '4095', '1999-06-17 15:35:52');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('7', '65', 3, 'folder', '3708', '1988-09-13 23:06:59');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('8', '1', 4, 'folder', '2545', '1973-04-16 15:39:35');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('9', '3', 1, 'png', '2617', '2009-01-22 11:40:37');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('10', '21', 2, 'png', '827', '1987-06-29 06:24:06');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('11', '81', 2, 'png', '1567', '2018-12-07 07:56:43');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('12', '51', 4, 'files', '5496', '2019-05-23 20:42:53');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('13', '97', 1, 'files', '3638', '1972-05-04 08:31:08');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('14', '59', 3, 'files', '3866', '1972-12-20 08:50:09');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('15', '21', 3, 'img', '4482', '2018-05-19 15:35:09');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('16', '95', 4, 'img', '1669', '1982-10-25 18:41:21');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('17', '52', 3, 'files', '2061', '1975-12-10 09:03:51');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('18', '37', 1, 'png', '4885', '2003-06-12 04:13:11');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('19', '54', 1, 'img', '3874', '2020-02-12 22:12:52');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('20', '64', 2, 'folder', '3329', '1980-10-05 11:28:58');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('21', '77', 3, 'folder', '2313', '2002-09-05 12:55:23');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('22', '75', 2, 'files', '1957', '1974-07-12 10:49:36');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('23', '18', 3, 'img', '2280', '2004-08-21 11:34:23');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('24', '21', 1, 'png', '2484', '1976-10-22 18:16:21');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('25', '95', 2, 'files', '1756', '2015-02-21 06:24:14');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('26', '50', 3, 'img', '3805', '1972-05-15 22:57:35');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('27', '80', 4, 'img', '5570', '2012-05-16 00:22:22');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('28', '60', 4, 'png', '4766', '1989-09-30 16:22:35');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('29', '12', 1, 'files', '1816', '2003-01-17 23:56:55');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('30', '32', 2, 'folder', '2970', '1990-09-25 05:50:37');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('31', '82', 2, 'files', '1225', '1984-04-23 10:11:14');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('32', '30', 2, 'png', '2898', '2000-04-23 17:00:10');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('33', '77', 3, 'files', '287', '1990-08-17 00:25:42');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('34', '40', 2, 'png', '1894', '1979-07-11 17:18:41');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('35', '81', 1, 'png', '3664', '2020-06-14 09:12:33');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('36', '59', 3, 'folder', '4199', '1994-10-14 14:25:41');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('37', '60', 2, 'folder', '4815', '1973-04-05 04:04:13');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('38', '97', 4, 'img', '5438', '1994-03-04 20:59:39');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('39', '7', 1, 'files', '2592', '2008-03-27 09:10:03');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('40', '97', 1, 'png', '1414', '1979-08-29 01:33:12');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('41', '58', 2, 'png', '3198', '1983-04-03 03:57:42');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('42', '76', 2, 'folder', '3125', '2005-03-10 22:00:21');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('43', '46', 2, 'img', '3743', '1987-05-16 06:27:31');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('44', '13', 3, 'folder', '684', '1999-09-08 19:17:23');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('45', '53', 2, 'files', '2645', '1980-06-10 16:50:22');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('46', '88', 2, 'folder', '1076', '2004-03-05 04:21:08');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('47', '70', 1, 'files', '5571', '1978-10-12 08:46:53');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('48', '68', 2, 'folder', '779', '1973-12-26 13:04:31');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('49', '84', 1, 'png', '1586', '1998-06-24 10:48:25');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('50', '77', 3, 'folder', '2081', '2002-04-15 20:10:18');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('51', '9', 2, 'img', '1833', '1991-09-10 22:09:00');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('52', '21', 3, 'png', '816', '2005-09-03 11:28:29');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('53', '68', 1, 'files', '1493', '1973-04-26 00:57:13');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('54', '45', 3, 'folder', '1323', '1994-02-19 06:05:44');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('55', '35', 2, 'folder', '4136', '2002-01-07 20:45:06');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('56', '75', 4, 'png', '4864', '1983-01-23 04:18:07');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('57', '86', 2, 'files', '3802', '1996-04-28 23:01:44');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('58', '29', 2, 'folder', '2370', '1993-06-09 18:40:39');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('59', '86', 2, 'folder', '546', '2021-05-24 08:37:43');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('60', '88', 2, 'files', '3551', '1987-05-24 08:39:38');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('61', '86', 3, 'png', '5581', '1975-06-28 19:46:41');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('62', '73', 3, 'img', '4037', '2008-04-22 08:35:14');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('63', '93', 2, 'folder', '2473', '1974-04-06 09:36:30');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('64', '2', 4, 'folder', '3149', '1988-10-22 01:24:46');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('65', '47', 4, 'folder', '596', '1996-09-04 16:18:55');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('66', '41', 3, 'folder', '3102', '1971-04-22 23:14:28');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('67', '13', 3, 'files', '4276', '2017-12-19 14:36:07');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('68', '23', 4, 'img', '4184', '2018-09-13 01:26:53');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('69', '79', 3, 'folder', '2537', '2003-01-17 12:55:18');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('70', '53', 1, 'img', '199', '2021-06-21 00:54:00');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('71', '8', 2, 'folder', '1392', '1998-09-02 15:20:08');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('72', '5', 4, 'png', '4950', '2016-01-27 21:20:36');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('73', '78', 2, 'folder', '1341', '1970-02-09 01:37:17');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('74', '24', 3, 'folder', '5540', '1980-06-04 12:51:36');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('75', '76', 1, 'folder', '5250', '1983-02-01 19:28:39');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('76', '1', 3, 'png', '175', '2006-12-10 08:23:30');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('77', '86', 3, 'folder', '3424', '2010-12-05 22:54:51');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('78', '17', 4, 'png', '4403', '1997-11-18 20:10:00');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('79', '13', 1, 'files', '2701', '1987-12-09 01:13:56');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('80', '54', 3, 'files', '3705', '1979-05-28 21:38:28');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('81', '96', 4, 'img', '203', '2008-11-03 21:57:05');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('82', '14', 1, 'png', '2178', '1977-08-28 15:13:18');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('83', '56', 2, 'img', '2827', '2006-05-06 14:22:56');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('84', '88', 2, 'folder', '5214', '1970-02-19 23:47:23');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('85', '4', 2, 'folder', '1310', '1988-05-12 04:50:45');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('86', '47', 1, 'files', '3234', '1992-01-21 09:23:23');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('87', '68', 3, 'img', '5265', '2020-08-01 18:35:47');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('88', '4', 2, 'png', '2666', '1976-10-05 22:04:30');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('89', '85', 2, 'folder', '180', '2021-05-07 09:02:18');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('90', '8', 3, 'img', '417', '1990-11-23 06:28:54');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('91', '38', 1, 'folder', '1431', '2016-07-01 23:30:35');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('92', '21', 1, 'img', '3193', '2004-08-19 23:34:59');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('93', '82', 2, 'files', '296', '1980-05-07 10:36:59');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('94', '1', 4, 'files', '3836', '2016-03-22 21:53:56');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('95', '56', 3, 'img', '538', '2000-01-01 23:21:18');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('96', '54', 3, 'files', '5578', '1982-09-04 11:38:10');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('97', '49', 3, 'files', '5478', '1976-02-02 05:16:58');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('98', '59', 1, 'img', '4333', '1974-10-09 21:37:42');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('99', '4', 2, 'img', '375', '1974-04-06 06:17:01');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('100', '38', 1, 'files', '3309', '2019-11-06 15:57:24');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('101', '87', 4, 'png', '4179', '1980-01-27 09:42:18');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('102', '18', 3, 'img', '2962', '2001-11-04 03:45:50');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('103', '35', 1, 'img', '3270', '1975-11-29 05:56:12');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('104', '99', 1, 'files', '624', '1989-07-07 05:07:09');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('105', '48', 1, 'img', '3960', '1998-05-01 13:42:55');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('106', '79', 4, 'img', '2666', '1977-01-16 20:01:13');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('107', '15', 4, 'png', '4391', '1974-10-05 07:08:42');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('108', '9', 4, 'img', '3457', '1990-06-09 03:43:32');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('109', '37', 1, 'folder', '5401', '1981-12-03 07:53:34');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('110', '91', 4, 'png', '4302', '1995-08-30 15:04:39');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('111', '64', 2, 'files', '246', '1994-05-22 00:10:46');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('112', '43', 1, 'folder', '3495', '1990-10-29 09:46:58');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('113', '11', 1, 'folder', '453', '2003-06-13 13:17:30');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('114', '17', 1, 'files', '4181', '1983-05-04 19:58:49');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('115', '48', 3, 'png', '3400', '1976-01-13 01:25:00');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('116', '22', 2, 'files', '2118', '1996-09-27 02:57:17');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('117', '37', 2, 'png', '3656', '2009-12-09 03:51:04');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('118', '88', 3, 'folder', '2836', '1993-01-14 12:19:36');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('119', '60', 4, 'files', '5187', '2013-12-09 08:17:37');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('120', '91', 1, 'folder', '2605', '1987-06-02 20:55:28');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('121', '93', 3, 'files', '1162', '2014-06-26 07:56:55');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('122', '92', 1, 'png', '721', '1980-11-03 18:53:45');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('123', '70', 1, 'img', '2649', '2016-08-30 19:13:27');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('124', '3', 1, 'img', '4918', '2008-12-12 13:34:22');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('125', '10', 4, 'png', '3974', '1978-04-11 21:43:12');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('126', '98', 3, 'folder', '5299', '1971-02-22 14:11:51');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('127', '37', 2, 'files', '4035', '2014-10-29 03:41:01');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('128', '86', 2, 'files', '5591', '2017-05-26 16:53:45');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('129', '42', 1, 'folder', '2623', '2005-06-27 05:00:46');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('130', '62', 4, 'folder', '1214', '1988-11-19 03:52:29');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('131', '55', 4, 'files', '3495', '1976-10-28 05:08:35');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('132', '23', 4, 'img', '2266', '2002-10-19 02:06:24');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('133', '23', 1, 'files', '5380', '2020-07-09 01:59:41');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('134', '64', 4, 'files', '2700', '1978-05-20 03:35:46');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('135', '96', 3, 'folder', '676', '1973-01-21 09:59:26');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('136', '89', 4, 'folder', '5466', '1985-12-07 14:13:06');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('137', '24', 4, 'img', '714', '1984-06-16 19:51:09');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('138', '95', 4, 'folder', '5402', '1974-06-13 18:05:22');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('139', '81', 4, 'img', '801', '2012-01-24 18:21:09');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('140', '99', 4, 'files', '3852', '1986-09-16 13:34:31');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('141', '91', 4, 'img', '1212', '2003-04-21 08:35:55');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('142', '63', 2, 'files', '3429', '2017-08-01 11:49:44');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('143', '37', 2, 'img', '2190', '1985-06-28 16:32:55');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('144', '75', 4, 'folder', '3410', '2018-07-25 08:04:05');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('145', '50', 2, 'png', '2710', '2004-11-03 07:53:27');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('146', '67', 1, 'files', '2823', '2008-03-29 18:49:38');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('147', '21', 4, 'files', '4522', '1988-08-24 02:11:22');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('148', '96', 2, 'files', '652', '2013-01-31 14:37:34');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('149', '99', 3, 'folder', '864', '1992-12-17 06:16:38');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('150', '24', 4, 'folder', '2394', '2015-01-15 06:18:53');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('151', '13', 1, 'folder', '762', '2004-07-30 23:12:19');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('152', '82', 2, 'files', '4490', '2017-07-19 06:45:45');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('153', '93', 4, 'folder', '2137', '2010-08-29 02:17:14');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('154', '29', 3, 'png', '4677', '2010-10-12 05:12:01');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('155', '75', 2, 'folder', '4810', '1976-02-17 22:08:27');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('156', '64', 3, 'folder', '1811', '2007-02-06 03:22:08');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('157', '23', 2, 'png', '1342', '2020-06-13 23:32:25');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('158', '93', 3, 'files', '5118', '2020-11-06 07:38:30');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('159', '75', 3, 'png', '3368', '1986-10-16 09:27:11');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('160', '37', 1, 'png', '4752', '2008-06-02 14:30:31');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('161', '4', 1, 'files', '1788', '2004-06-21 00:11:20');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('162', '29', 1, 'png', '5552', '1977-03-22 09:16:23');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('163', '92', 1, 'files', '3441', '1985-06-03 08:57:11');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('164', '67', 4, 'folder', '4043', '1979-01-12 05:45:27');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('165', '84', 4, 'files', '728', '2011-03-31 03:22:14');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('166', '85', 4, 'files', '521', '2010-02-24 19:36:55');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('167', '3', 3, 'files', '3938', '1975-09-21 05:59:14');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('168', '32', 4, 'folder', '2368', '2007-06-30 15:55:07');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('169', '43', 3, 'files', '525', '1985-01-25 20:41:30');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('170', '70', 1, 'img', '5024', '2013-02-01 03:14:00');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('171', '87', 2, 'png', '4723', '1980-01-19 15:34:26');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('172', '83', 1, 'img', '4361', '2001-09-10 21:09:08');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('173', '60', 3, 'folder', '4142', '2018-10-30 23:50:20');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('174', '67', 2, 'files', '1884', '1998-12-27 20:32:17');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('175', '42', 1, 'img', '1993', '2007-06-27 17:45:27');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('176', '58', 2, 'png', '1380', '2020-04-12 09:02:26');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('177', '6', 4, 'png', '2277', '1980-03-18 07:44:33');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('178', '70', 4, 'png', '955', '2017-02-18 14:22:12');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('179', '11', 2, 'png', '854', '1977-06-25 04:47:15');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('180', '88', 4, 'files', '2550', '2007-08-16 08:19:34');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('181', '27', 3, 'img', '3120', '2005-07-01 11:11:06');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('182', '90', 2, 'png', '5089', '1983-01-19 15:13:26');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('183', '38', 1, 'img', '3434', '1982-09-28 08:11:12');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('184', '26', 4, 'img', '3363', '2017-09-15 17:30:15');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('185', '82', 4, 'png', '1266', '1989-10-28 04:17:46');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('186', '98', 3, 'files', '4082', '1994-03-13 23:02:54');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('187', '28', 4, 'folder', '460', '2012-07-02 07:07:20');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('188', '76', 4, 'files', '4303', '1996-02-18 19:44:46');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('189', '54', 2, 'files', '3364', '2020-07-17 08:13:16');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('190', '21', 4, 'folder', '3336', '1995-12-13 00:58:16');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('191', '45', 4, 'png', '1912', '1994-09-16 21:09:41');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('192', '41', 2, 'folder', '4187', '2016-01-28 05:55:35');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('193', '66', 1, 'folder', '3880', '2001-09-11 17:19:57');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('194', '48', 4, 'folder', '2724', '2001-09-21 05:57:10');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('195', '47', 2, 'folder', '988', '1981-04-22 20:06:03');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('196', '69', 3, 'files', '2464', '1986-09-07 19:11:46');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('197', '7', 3, 'files', '2795', '2008-03-09 09:27:09');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('198', '3', 2, 'png', '2973', '1970-09-27 20:14:24');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('199', '80', 2, 'img', '3266', '1983-05-06 04:50:29');
INSERT INTO `media` (`id`, `user_id`, `media_types_id`, `file_name`, `file_size`, `created_at`) VALUES ('200', '25', 3, 'png', '2230', '2005-03-23 19:57:57');


#
# TABLE STRUCTURE FOR: media_types
#

DROP TABLE IF EXISTS `media_types`;

CREATE TABLE `media_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `media_types` (`id`, `name`) VALUES (3, 'asperiores');
INSERT INTO `media_types` (`id`, `name`) VALUES (2, 'aut');
INSERT INTO `media_types` (`id`, `name`) VALUES (4, 'nobis');
INSERT INTO `media_types` (`id`, `name`) VALUES (1, 'quaerat');


#
# TABLE STRUCTURE FOR: messages
#

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `txt` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_delivered` tinyint(1) DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_messages_from_user_idx` (`from_user_id`),
  KEY `fk_messages_to_user_idx` (`to_user_id`),
  CONSTRAINT `fk_messages_users_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_messages_users_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('1', '96', '99', 'Est ad nemo odit numquam voluptatibus dolor.', 1, '1994-10-24 23:19:09', '1970-04-26 03:14:01');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('2', '61', '79', 'Ut doloremque qui recusandae.', 0, '1988-05-01 01:47:34', '1987-04-04 22:40:29');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('3', '23', '99', 'Similique necessitatibus perspiciatis quasi et.', 1, '1994-10-28 23:19:56', '1992-04-08 17:17:28');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('4', '6', '10', 'Inventore repellendus excepturi accusantium rerum dolores qui excepturi.', 1, '2009-06-30 14:07:13', '1974-08-20 17:45:47');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('5', '49', '90', 'Qui dolorem maxime eaque qui voluptatem.', 1, '2019-08-21 16:55:53', '1984-12-14 14:16:18');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('6', '28', '92', 'Quas qui libero magnam dolorum.', 1, '2002-03-14 03:38:36', '2015-04-03 01:04:14');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('7', '18', '54', 'Suscipit quam ipsam dolore nulla accusamus.', 1, '1975-02-01 23:38:06', '2012-01-12 16:29:08');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('8', '67', '26', 'Rerum ut laudantium quod quibusdam quia eaque.', 1, '2017-05-16 05:04:35', '2011-05-01 16:47:50');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('9', '21', '82', 'Quo dignissimos facere dolor.', 1, '2012-04-24 03:43:05', '1975-10-09 03:40:55');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('10', '30', '5', 'Architecto sint soluta eos veritatis.', 1, '1993-11-23 11:49:49', '1991-05-24 20:16:47');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('11', '22', '52', 'Et aliquam quas harum quia mollitia tenetur voluptate necessitatibus.', 0, '2011-09-08 08:50:49', '2011-11-21 15:51:02');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('12', '58', '35', 'Ea quia dolore voluptates consequatur fugit doloremque.', 1, '1998-08-31 13:20:58', '2010-01-24 23:18:11');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('13', '49', '66', 'Optio quis minima delectus cupiditate blanditiis.', 1, '2013-03-27 12:10:49', '1978-09-12 20:29:00');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('14', '11', '49', 'Quos non sit quod odio velit facere.', 0, '1982-05-22 23:15:22', '1982-01-26 14:01:46');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('15', '12', '37', 'Accusamus dolore repellendus voluptas nam quia.', 1, '2016-11-10 22:15:12', '1993-12-11 19:35:16');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('16', '55', '7', 'Ut deserunt et tempora similique autem natus placeat.', 1, '1984-06-13 09:27:43', '1978-05-28 12:39:35');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('17', '36', '15', 'Ut accusamus a consectetur qui est.', 1, '1988-07-28 11:56:38', '1972-02-01 08:55:11');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('18', '86', '59', 'Nemo voluptatem dolorem sit veniam soluta incidunt qui consectetur.', 1, '1973-02-01 16:08:33', '1977-05-18 01:47:57');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('19', '14', '91', 'Quasi nobis quibusdam qui quo quaerat.', 1, '1982-10-19 07:51:05', '2016-08-19 06:04:58');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('20', '68', '62', 'Eum pariatur esse molestiae qui iusto eos.', 0, '2019-08-15 08:41:46', '1983-07-18 07:03:30');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('21', '81', '95', 'Enim autem error quasi nemo qui neque vero non.', 1, '2010-02-07 10:45:38', '2001-10-18 08:57:35');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('22', '54', '98', 'Magnam provident fugit laboriosam nostrum consequatur consequatur.', 1, '1973-06-15 05:47:33', '1993-04-25 16:44:04');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('23', '48', '21', 'Dolores nam dolorum consequatur quas placeat.', 1, '1971-06-27 19:56:48', '2010-10-30 09:51:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('24', '24', '68', 'Occaecati ducimus iure fugiat voluptas autem omnis animi saepe.', 1, '1988-06-24 00:24:17', '1979-05-10 14:19:12');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('25', '2', '53', 'Ducimus qui tenetur enim quas quibusdam.', 1, '2006-08-31 01:44:16', '1971-04-10 22:10:38');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('26', '73', '23', 'Eveniet et eligendi repudiandae quia.', 0, '1988-11-11 03:01:31', '1979-03-15 21:12:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('27', '5', '30', 'Debitis et quasi suscipit magnam explicabo.', 0, '1973-08-25 10:37:21', '1978-09-03 00:06:48');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('28', '58', '53', 'Facilis repellat quas accusantium et voluptas sed sint voluptatem.', 0, '2012-07-06 00:08:58', '2004-12-01 12:39:45');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('29', '95', '68', 'Qui eveniet beatae voluptatem eveniet.', 0, '1995-03-07 14:53:11', '2018-02-16 03:21:47');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('30', '2', '7', 'Vel consequatur repellendus optio velit fugiat sed voluptate.', 1, '1975-12-26 08:08:20', '2021-01-28 23:11:01');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('31', '4', '57', 'Id suscipit vitae occaecati.', 0, '2010-05-07 02:56:44', '1995-12-13 11:17:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('32', '14', '40', 'Molestias et facilis molestiae odit labore doloremque culpa.', 0, '1987-02-23 20:47:48', '1995-10-22 04:56:16');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('33', '71', '99', 'Et qui quidem iure eius explicabo.', 0, '1976-07-18 23:31:00', '2016-05-28 05:30:32');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('34', '98', '84', 'Harum voluptate id assumenda ipsam unde quasi quasi.', 1, '2014-11-11 13:41:38', '2000-10-09 23:15:53');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('35', '89', '65', 'Voluptas alias facere ex voluptas eum dolores rem.', 1, '2008-07-17 22:38:25', '1984-08-30 22:36:16');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('36', '46', '69', 'Sunt ut accusamus sapiente voluptatem voluptas.', 0, '1994-11-29 16:34:34', '1997-11-16 19:40:07');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('37', '59', '100', 'Quis vel minima quae repudiandae consequatur animi.', 1, '1980-07-14 18:10:26', '1983-02-10 06:29:25');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('38', '67', '7', 'Unde consectetur quos id blanditiis.', 1, '1981-05-15 19:44:17', '1985-06-17 13:20:14');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('39', '20', '90', 'Id dolores incidunt qui aspernatur illum vitae illum.', 0, '2001-01-26 12:34:12', '1981-08-28 00:18:56');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('40', '75', '21', 'Nobis et deserunt aut temporibus.', 1, '2005-08-03 01:04:36', '2019-09-11 12:11:02');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('41', '42', '47', 'Ratione voluptates non est omnis iste.', 1, '1990-05-05 05:23:11', '2014-06-05 09:06:12');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('42', '44', '47', 'Autem aut quia corporis nesciunt inventore dolorem.', 0, '1978-08-25 15:21:36', '1991-06-19 22:55:08');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('43', '76', '1', 'Repudiandae et alias quae sed architecto.', 0, '2001-04-08 03:13:14', '1984-09-13 21:12:22');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('44', '100', '71', 'Ut qui doloribus reiciendis incidunt explicabo.', 0, '2008-02-15 08:56:39', '2010-04-18 08:39:17');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('45', '69', '2', 'Provident dolorem voluptatem qui dolorem eligendi provident reprehenderit.', 1, '1983-10-11 07:23:11', '2001-09-13 20:56:35');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('46', '77', '73', 'Aut quia aut sunt laborum voluptatem.', 0, '1973-08-16 07:11:52', '2004-03-13 22:01:24');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('47', '58', '91', 'Officia iste et illo sequi.', 0, '2017-07-25 20:56:35', '1975-06-14 12:45:33');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('48', '12', '28', 'Repudiandae commodi odit vitae amet quia sed.', 1, '1995-06-02 02:23:24', '1971-03-04 08:45:25');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('49', '89', '9', 'Sed ex voluptates in autem.', 1, '2015-10-29 05:29:11', '2013-11-26 04:08:22');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('50', '12', '78', 'Consequatur velit alias et est eum doloribus praesentium.', 0, '2007-11-24 18:35:50', '1986-10-11 22:02:32');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('51', '73', '58', 'Est rerum eius autem aut cumque.', 0, '2017-05-20 11:09:46', '1987-06-06 22:32:38');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('52', '46', '32', 'Velit qui magni omnis repudiandae.', 0, '1998-08-02 08:03:59', '2013-04-13 12:12:57');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('53', '57', '12', 'A explicabo id voluptatibus sit quo praesentium laudantium.', 0, '2015-10-11 18:58:15', '1981-10-15 09:38:44');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('54', '38', '77', 'Voluptas est delectus accusamus nobis.', 0, '2004-04-18 05:43:26', '2011-07-27 23:31:55');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('55', '2', '12', 'Corporis minus soluta temporibus dolore.', 0, '1989-03-28 20:47:15', '2006-08-23 03:37:03');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('56', '97', '43', 'Cum ut rerum vel inventore beatae ducimus.', 0, '1984-03-25 16:18:55', '2016-06-27 08:00:55');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('57', '59', '41', 'Suscipit adipisci quo minus.', 1, '2013-09-12 01:35:52', '1992-06-05 01:54:38');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('58', '90', '34', 'Ratione quisquam doloribus explicabo est esse eos.', 0, '1994-09-17 09:04:04', '1984-11-04 01:13:47');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('59', '42', '89', 'Autem sint velit vel aliquid a et.', 0, '2015-01-27 18:14:24', '2009-10-11 11:43:59');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('60', '5', '10', 'Dolores maiores quaerat saepe omnis.', 0, '1986-03-28 04:03:39', '2007-01-29 00:43:29');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('61', '90', '82', 'Placeat aut eius consectetur voluptas autem sint perspiciatis.', 1, '2015-09-24 18:26:19', '1982-12-22 23:50:40');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('62', '83', '47', 'Odit quod ut placeat aliquam doloribus mollitia ut.', 0, '1986-10-03 23:33:49', '2005-02-10 13:52:18');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('63', '72', '94', 'Blanditiis repudiandae optio aspernatur omnis non voluptas ea animi.', 0, '1983-08-09 20:47:40', '1977-05-19 17:32:29');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('64', '74', '60', 'Est ad quo in dolor.', 0, '1998-08-30 23:20:56', '1988-07-19 22:27:27');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('65', '3', '86', 'Labore praesentium sint voluptatem doloribus qui omnis ut.', 1, '1976-05-30 00:54:53', '1981-12-24 21:21:05');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('66', '37', '76', 'Et et perspiciatis sed officia reiciendis.', 0, '2016-05-10 22:54:02', '1993-11-17 17:23:09');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('67', '43', '83', 'Aut perferendis beatae occaecati quo inventore delectus.', 1, '1990-01-18 02:45:19', '2001-05-18 13:23:11');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('68', '7', '100', 'Magnam autem eveniet ipsa nulla et nemo.', 0, '1983-12-24 01:36:16', '1979-11-05 19:16:55');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('69', '95', '45', 'Occaecati totam enim iusto explicabo soluta veniam cum.', 0, '1974-08-20 06:06:57', '2002-10-13 10:47:09');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('70', '76', '96', 'Veniam non error perspiciatis unde.', 0, '1995-06-09 13:30:10', '2013-10-01 06:55:24');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('71', '57', '73', 'Rem magni quod beatae voluptatem amet.', 1, '2009-02-03 04:33:00', '2018-09-04 05:58:03');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('72', '39', '15', 'Voluptas natus totam et sit.', 1, '1995-04-12 07:56:00', '2016-07-01 17:45:45');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('73', '13', '28', 'Quis autem quibusdam iste odio.', 1, '2006-11-28 13:31:37', '2016-10-10 16:20:25');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('74', '49', '55', 'Consectetur tempora vero numquam fugit.', 1, '1977-03-24 22:33:00', '2014-01-06 10:25:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('75', '16', '53', 'Vitae voluptatem id aut consequatur minus et voluptatem consectetur.', 0, '1993-09-12 03:04:49', '2011-02-26 10:36:43');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('76', '65', '5', 'Omnis nostrum delectus ea assumenda vel in eos.', 0, '1992-08-21 10:45:52', '1979-01-10 21:18:46');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('77', '34', '47', 'Et sed enim eos omnis optio at omnis.', 1, '2009-07-03 21:06:59', '1987-01-06 06:14:28');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('78', '51', '5', 'Consequatur rerum officiis aut autem repellendus.', 1, '1978-04-23 00:34:46', '1993-04-17 20:14:00');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('79', '41', '25', 'Ut laborum officia reprehenderit facilis nam laboriosam ipsam voluptas.', 0, '1976-03-06 11:36:54', '1992-02-23 19:09:47');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('80', '65', '43', 'Nihil iste sit facere aperiam quae.', 0, '2016-03-08 16:06:27', '1983-11-03 22:08:01');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('81', '11', '1', 'Sed quas vel alias consequatur deserunt facilis consequatur.', 1, '1997-01-26 10:39:05', '2005-12-20 03:37:11');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('82', '18', '54', 'Perspiciatis quisquam ipsam reiciendis nulla.', 0, '1970-12-06 12:27:19', '1980-06-28 02:43:10');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('83', '84', '24', 'Voluptatem commodi libero dolorem et.', 1, '1978-02-15 08:19:15', '1975-03-17 18:14:07');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('84', '53', '78', 'Et quasi deserunt ex vero asperiores.', 1, '1986-12-30 17:04:59', '2008-07-19 20:56:05');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('85', '69', '28', 'Minus cum sed sed tempora.', 1, '2000-12-12 07:38:32', '1996-03-17 18:37:58');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('86', '73', '25', 'Rerum nostrum natus consequatur aspernatur et.', 0, '2007-09-01 05:40:27', '1997-08-17 18:55:22');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('87', '100', '11', 'Qui nesciunt impedit fugit ducimus a amet.', 1, '1992-03-19 22:11:21', '2016-12-17 03:01:40');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('88', '40', '13', 'Esse corrupti laborum nam enim et.', 1, '1985-09-16 16:45:07', '1993-03-02 18:14:43');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('89', '38', '88', 'Voluptates ut quia nam suscipit expedita.', 0, '1985-05-13 01:26:07', '2003-06-27 21:02:53');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('90', '67', '53', 'Quia quia praesentium error aut.', 0, '2017-12-03 04:25:59', '1996-07-23 09:21:46');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('91', '40', '31', 'Placeat non ut libero.', 0, '1993-06-29 21:50:43', '2002-03-10 10:38:42');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('92', '58', '74', 'Quibusdam dolores dolorem minus sit inventore corrupti quibusdam.', 0, '2007-07-26 08:27:53', '2021-02-18 02:30:59');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('93', '78', '9', 'Distinctio doloremque eum sunt vel aliquam velit quam ut.', 1, '1998-05-04 15:18:26', '2004-03-20 14:49:31');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('94', '79', '18', 'Nesciunt iure voluptate sed repellendus sed delectus suscipit.', 1, '2013-11-05 03:29:49', '1998-09-01 23:21:16');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('95', '34', '43', 'Autem quo voluptas rerum.', 0, '1994-01-15 01:55:50', '1986-02-21 10:46:19');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('96', '60', '44', 'Ratione vitae magni cum eveniet vitae culpa at.', 0, '1990-04-05 19:12:17', '1989-12-31 06:57:54');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('97', '44', '77', 'Excepturi molestiae est saepe quam velit.', 1, '2005-06-09 14:47:14', '2008-08-23 16:53:15');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('98', '97', '27', 'Optio commodi voluptatem autem et accusantium dolore.', 1, '1979-08-13 07:59:11', '1974-09-30 02:09:29');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('99', '1', '50', 'Aut error facilis ut ducimus nihil.', 1, '1970-02-24 08:01:22', '1976-05-14 02:50:20');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('100', '4', '70', 'Est possimus debitis sed.', 0, '2020-08-06 05:29:20', '1977-09-10 09:49:17');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('101', '77', '76', 'Iusto voluptatem incidunt illum eos vel autem deserunt ipsa.', 1, '1987-04-19 04:57:39', '1994-09-17 01:00:34');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('102', '94', '77', 'Sit qui libero ut sit quis.', 1, '2007-07-23 04:16:06', '1973-11-20 23:39:28');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('103', '86', '33', 'Explicabo sint molestiae laborum velit quae doloremque aut.', 1, '1989-12-08 05:33:48', '2000-04-19 21:46:33');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('104', '89', '24', 'Sint consequuntur exercitationem repudiandae.', 0, '1999-01-22 03:52:36', '2006-12-07 14:04:01');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('105', '21', '56', 'Nostrum laboriosam ut vero quo rerum quod nesciunt.', 0, '2007-08-24 10:54:29', '2006-05-14 10:22:50');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('106', '76', '61', 'Eos repellat omnis itaque eligendi quibusdam.', 0, '1996-06-15 23:21:12', '1978-07-09 10:06:57');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('107', '87', '34', 'Omnis nesciunt delectus est provident repellendus.', 1, '1974-08-22 08:53:22', '1973-09-21 06:56:55');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('108', '34', '64', 'Iusto voluptate sint qui voluptatibus et aperiam non.', 1, '1970-01-18 19:44:30', '2009-11-26 19:31:15');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('109', '42', '12', 'Totam asperiores perspiciatis corrupti mollitia ullam dignissimos ut.', 0, '2017-12-19 04:39:20', '2011-09-06 17:18:45');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('110', '81', '76', 'Sed voluptatum pariatur ut a minima quo nihil veritatis.', 1, '1995-06-17 07:47:09', '1985-11-18 09:01:06');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('111', '55', '40', 'Et laboriosam tenetur ipsam velit voluptatem delectus.', 1, '1989-01-07 12:53:23', '1983-01-06 23:31:31');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('112', '19', '98', 'Architecto possimus occaecati assumenda.', 0, '1981-05-31 08:06:31', '2006-10-31 22:22:10');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('113', '17', '16', 'Officiis magnam nesciunt eveniet sequi aut.', 0, '1996-07-25 01:02:35', '2004-01-03 17:46:08');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('114', '24', '18', 'Recusandae dolores harum dolores.', 1, '2015-11-11 01:18:41', '1999-08-27 22:20:45');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('115', '65', '27', 'Qui velit ipsum quas eum aut qui accusamus.', 1, '1999-08-18 16:39:26', '1976-06-01 13:47:19');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('116', '87', '42', 'Necessitatibus dolores quis et dolores quas in.', 1, '1981-08-14 18:29:32', '1978-09-28 03:17:34');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('117', '3', '80', 'Qui nostrum libero minima alias.', 0, '1994-03-03 22:06:14', '2014-08-27 05:56:47');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('118', '18', '88', 'Suscipit iure rerum quo ad.', 0, '1994-06-15 16:43:00', '1985-08-09 08:26:11');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('119', '13', '7', 'Ut facilis ut voluptates a ipsam officia quam.', 1, '2017-12-28 00:58:28', '1983-11-01 23:30:43');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('120', '12', '33', 'Qui deserunt minima deserunt praesentium a quis autem.', 0, '1994-02-07 01:28:35', '2003-06-23 09:12:31');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('121', '62', '87', 'Facilis ut labore consequatur veniam.', 0, '1996-02-01 06:12:34', '2006-11-05 07:36:39');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('122', '93', '48', 'Laboriosam tenetur et natus est dolorem omnis.', 0, '2006-02-26 17:37:29', '2001-10-09 16:01:20');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('123', '21', '27', 'Labore fugit ut dolor ut odit aut.', 0, '2005-09-17 23:13:51', '1994-12-11 21:22:13');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('124', '11', '63', 'Modi architecto maxime quia voluptate.', 1, '1996-03-18 09:40:32', '2004-12-09 02:24:40');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('125', '39', '92', 'Ad eveniet voluptatem expedita tempora eius vitae qui.', 1, '1997-01-14 01:20:02', '1978-08-29 20:52:47');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('126', '38', '93', 'Aperiam quia omnis in aliquid eveniet similique reprehenderit.', 1, '2020-05-11 23:23:41', '2010-04-29 16:14:16');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('127', '31', '57', 'Libero quasi cum saepe error nobis.', 0, '2016-06-11 01:06:17', '1980-07-26 04:15:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('128', '90', '48', 'Nulla rerum distinctio facilis commodi aut.', 0, '1973-08-12 03:50:37', '2007-04-12 22:35:05');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('129', '72', '14', 'Molestias inventore est blanditiis distinctio molestias in aut qui.', 0, '2016-05-30 08:51:28', '2003-01-09 18:22:14');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('130', '65', '37', 'Aut qui veritatis laboriosam aliquid officiis in animi voluptate.', 0, '2012-10-12 07:57:26', '2007-05-25 09:48:26');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('131', '41', '51', 'Id sit ea qui est eum reprehenderit omnis minima.', 1, '1988-11-19 13:03:54', '2019-01-07 16:31:58');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('132', '78', '43', 'A mollitia vel cupiditate.', 0, '1984-11-29 05:11:39', '1982-04-14 09:02:12');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('133', '31', '96', 'Necessitatibus eum iste nesciunt non veritatis enim velit.', 0, '2008-05-29 09:34:55', '2004-10-10 12:37:14');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('134', '31', '44', 'Quas iusto et labore optio.', 1, '1991-02-18 17:48:09', '1993-08-25 15:26:40');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('135', '2', '42', 'Culpa molestiae expedita modi ut.', 1, '1982-12-13 10:25:57', '2007-10-23 07:35:00');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('136', '77', '64', 'Aliquid repellendus aut aut consequatur dolores.', 1, '2019-08-24 22:53:22', '1988-03-10 05:50:35');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('137', '29', '70', 'Sit recusandae fuga sunt quibusdam rerum repellat.', 0, '1977-12-18 03:07:28', '2018-05-14 06:46:42');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('138', '12', '49', 'Quod ut id excepturi magni.', 0, '1999-05-28 19:36:35', '1974-05-29 20:39:16');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('139', '96', '23', 'Amet alias inventore natus nostrum voluptas excepturi.', 1, '1979-07-14 04:29:06', '2017-11-19 22:54:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('140', '11', '35', 'Qui consequatur hic consequatur est quo et.', 1, '1983-12-30 15:06:45', '2001-02-15 10:06:37');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('141', '14', '48', 'Optio dolorum ut neque sequi ea aspernatur.', 1, '1992-04-21 22:56:08', '2001-08-05 05:02:54');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('142', '27', '45', 'Molestiae est ut ducimus dignissimos sunt nisi est id.', 0, '1987-11-28 15:20:32', '2010-06-21 03:49:00');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('143', '5', '17', 'Soluta culpa qui quisquam omnis sequi ipsam eum.', 1, '1984-08-16 23:27:45', '1971-09-06 08:52:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('144', '92', '76', 'Illo mollitia ipsum quas quis.', 1, '1983-04-28 07:29:02', '1976-10-23 13:46:34');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('145', '31', '57', 'Fuga non quo voluptas.', 0, '1994-04-18 08:55:59', '1980-12-09 20:46:04');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('146', '13', '71', 'Ut optio et quia nobis molestias ipsam.', 1, '2006-05-20 14:47:48', '1979-05-20 21:45:17');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('147', '8', '90', 'Labore voluptatem consequatur quaerat consequuntur quisquam.', 1, '1997-05-22 07:15:48', '1971-11-04 22:10:53');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('148', '13', '39', 'Eos rem vitae nemo.', 0, '2014-05-22 09:13:35', '1973-07-23 20:30:21');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('149', '86', '43', 'Quam quasi quisquam rerum quaerat.', 0, '2001-07-20 11:11:47', '1986-01-10 03:13:00');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('150', '82', '87', 'Et neque atque ullam vel quasi nostrum et.', 0, '1990-05-05 11:11:21', '2018-08-12 23:03:58');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('151', '84', '59', 'Ut corrupti neque rerum velit consectetur voluptate dignissimos.', 0, '1997-04-11 05:41:02', '2018-03-12 13:10:57');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('152', '51', '12', 'Totam laudantium recusandae laudantium cum tenetur.', 1, '2003-02-16 04:16:07', '2017-11-01 05:50:26');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('153', '28', '62', 'Animi velit ducimus esse.', 0, '2020-11-19 22:15:04', '2002-07-27 03:39:48');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('154', '61', '23', 'Eligendi voluptatem voluptatem facere ipsum sint repudiandae.', 1, '1998-01-18 19:20:27', '1970-07-17 04:14:33');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('155', '84', '72', 'Inventore dolor ducimus autem id consequuntur.', 1, '1984-02-21 14:56:15', '2004-03-22 13:42:15');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('156', '57', '98', 'Sit sunt omnis est accusantium.', 1, '1974-02-11 13:17:27', '2005-02-25 04:51:42');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('157', '20', '84', 'Sunt quia molestiae suscipit qui explicabo ex.', 0, '1998-07-22 02:33:32', '1990-10-17 17:39:39');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('158', '42', '24', 'Qui omnis quo dignissimos modi.', 1, '1985-07-10 21:24:33', '2001-08-18 00:08:06');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('159', '100', '34', 'Odit voluptatem numquam illo debitis quia qui qui.', 1, '1971-12-26 19:58:08', '2020-03-12 22:49:05');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('160', '100', '30', 'Voluptatibus id consequatur delectus quaerat vitae ea est.', 1, '1993-11-21 03:54:11', '1979-04-19 15:12:36');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('161', '90', '12', 'Perferendis aspernatur soluta labore.', 1, '1979-09-18 04:34:38', '1981-08-19 21:32:10');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('162', '1', '97', 'Eum quidem et quidem officiis quibusdam optio.', 0, '2010-05-27 19:14:03', '1984-10-26 10:14:53');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('163', '2', '13', 'Ipsum dolorum aliquid aliquam ea omnis.', 1, '1974-01-26 12:54:15', '2020-08-01 13:04:27');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('164', '35', '87', 'Dolorem ipsum perferendis neque sed commodi aut beatae velit.', 1, '1992-11-04 08:00:33', '1997-12-22 08:33:44');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('165', '56', '17', 'Aut est aut veniam doloribus dolores.', 1, '2015-03-18 15:57:06', '1990-12-19 15:27:17');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('166', '73', '39', 'Recusandae qui recusandae nihil molestias aut enim.', 0, '2004-03-30 00:34:35', '1997-08-23 17:13:05');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('167', '75', '24', 'Et vel suscipit ipsum.', 1, '1988-01-11 04:15:24', '2000-05-06 13:41:27');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('168', '51', '2', 'Dignissimos illum ipsa quis veniam.', 0, '1972-04-02 11:22:26', '1989-07-18 07:38:32');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('169', '85', '12', 'Doloremque in natus ut ut ut libero.', 1, '1993-04-08 14:07:34', '1991-03-10 18:28:02');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('170', '25', '69', 'Voluptas nemo repudiandae quaerat in consectetur neque.', 1, '1990-08-26 12:06:10', '2007-07-24 14:41:09');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('171', '83', '82', 'Explicabo architecto eum quisquam in ut occaecati quo.', 1, '1983-12-26 11:27:56', '2007-10-12 09:19:40');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('172', '66', '3', 'Vel facilis et ut fuga dolorem et corporis eos.', 1, '2015-01-19 20:09:55', '2001-11-28 14:40:26');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('173', '65', '7', 'Tempora velit alias vel in numquam voluptatibus quo.', 1, '2005-12-17 20:34:53', '2001-05-07 13:47:14');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('174', '26', '65', 'Similique nulla aspernatur non quidem.', 0, '1977-12-19 13:15:35', '2004-01-16 15:10:39');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('175', '40', '25', 'Voluptatum ipsa aliquam et dignissimos atque voluptatem.', 1, '1971-10-08 21:23:51', '2016-08-14 20:34:10');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('176', '95', '30', 'Est deleniti quos qui exercitationem sed doloribus earum.', 1, '2013-04-17 00:20:57', '1978-12-30 03:14:03');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('177', '37', '95', 'Tempore neque cum aliquam eius.', 1, '1981-11-13 20:24:57', '1996-04-13 11:34:12');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('178', '26', '38', 'Corrupti perferendis corrupti ab ut sapiente optio.', 0, '1978-01-27 20:13:42', '2020-04-14 09:15:10');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('179', '8', '61', 'Sed qui quae libero aut ut.', 0, '1982-04-14 11:55:37', '2011-10-30 08:09:01');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('180', '24', '63', 'Fuga labore nemo fugiat quibusdam sit.', 0, '1984-03-04 08:12:18', '1975-07-19 11:34:34');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('181', '78', '97', 'Quis accusamus laboriosam sed facilis.', 1, '2015-06-22 11:01:27', '1994-11-10 20:43:04');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('182', '2', '52', 'Fugit tempora maxime et sed.', 1, '1997-07-13 09:58:13', '1983-06-05 12:52:24');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('183', '20', '53', 'Sunt fugit porro accusamus possimus quae asperiores id.', 1, '2006-05-18 16:00:51', '1989-03-04 14:42:37');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('184', '54', '5', 'Laudantium tempore doloribus corporis ut.', 0, '2002-04-04 09:05:33', '2001-12-13 18:22:16');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('185', '65', '79', 'Corporis quia quas tenetur adipisci.', 1, '2001-07-05 08:59:54', '2000-08-08 06:20:32');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('186', '73', '47', 'Assumenda temporibus qui asperiores omnis blanditiis et.', 0, '2001-11-07 16:12:16', '2002-02-22 10:15:12');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('187', '60', '38', 'Error quis ratione natus.', 1, '1995-10-23 11:25:36', '1981-01-17 10:45:21');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('188', '49', '25', 'Placeat sit repudiandae incidunt quis accusantium perspiciatis.', 1, '1972-12-11 08:35:53', '1982-03-20 18:45:47');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('189', '45', '75', 'Similique perspiciatis odit voluptatem non voluptatem autem odio.', 0, '2001-12-07 21:00:48', '1974-01-12 18:53:22');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('190', '89', '85', 'Qui harum porro deleniti nihil accusantium illum consectetur.', 0, '2015-08-14 05:01:50', '1987-08-07 12:22:26');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('191', '99', '84', 'Esse minima recusandae sint ratione cumque.', 0, '2014-04-21 07:35:57', '1989-09-11 23:57:45');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('192', '14', '36', 'Voluptas non quos perferendis esse.', 0, '2009-01-16 04:00:48', '1983-08-18 18:20:33');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('193', '79', '40', 'Voluptatem qui ratione ducimus accusamus voluptatibus ipsa.', 1, '2016-12-25 05:26:35', '2006-01-15 17:55:32');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('194', '73', '86', 'At non vitae non veniam veritatis enim dolor eveniet.', 0, '2009-02-07 19:19:02', '1974-11-06 22:11:53');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('195', '1', '97', 'Est est molestiae est dolor.', 0, '2008-09-06 04:41:03', '2007-03-22 01:41:24');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('196', '49', '78', 'Sit quasi optio perferendis autem ut illum iusto non.', 1, '1993-07-11 08:54:30', '1974-06-12 03:06:23');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('197', '93', '51', 'Quisquam commodi vel nihil repellat quo doloribus repellat.', 0, '1995-02-05 01:35:59', '1990-12-31 11:00:04');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('198', '30', '13', 'Aut accusantium modi itaque dicta omnis numquam asperiores.', 0, '2019-06-23 17:57:22', '2009-01-29 16:11:40');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('199', '3', '84', 'Itaque corrupti sapiente debitis blanditiis iusto occaecati aspernatur.', 1, '2008-07-22 02:46:30', '1970-09-12 13:52:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `txt`, `is_delivered`, `created_at`, `updated_at`) VALUES ('200', '17', '67', 'Sint sequi et debitis non.', 1, '2017-01-07 18:12:28', '2002-05-02 09:58:45');


#
# TABLE STRUCTURE FOR: profiles
#

DROP TABLE IF EXISTS `profiles`;

CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `gender` enum('f','m','x') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthday` date NOT NULL,
  `photo_id` int(10) unsigned DEFAULT NULL,
  `city` varchar(130) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(130) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('1', 'f', '1986-06-03', 963, 'Kovacekhaven', 'Saint Vincent and the Grenadines');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('3', 'm', '1977-10-14', 198, 'Port Carminetown', 'American Samoa');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('4', 'x', '1981-06-06', 216, 'Sabinamouth', 'Rwanda');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('5', 'm', '2012-09-19', 638, 'Benedictfurt', 'Montserrat');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('6', 'f', '1988-02-11', 938, 'Port Joannie', 'Costa Rica');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('10', 'm', '1993-02-18', 922, 'Wunschhaven', 'Zambia');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('13', 'f', '2001-03-05', 88, 'Lake Cassieview', 'Uruguay');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('16', 'x', '2004-10-22', 478, 'Krajcikfort', 'Russian Federation');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('17', 'x', '1977-12-25', 561, 'Lake Rickport', 'Saint Helena');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('18', 'm', '1980-03-09', 596, 'Koryfurt', 'Cocos (Keeling) Islands');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('19', 'm', '2015-10-05', 42, 'Kesslerbury', 'Cote d\'Ivoire');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('20', 'x', '2013-01-11', 336, 'South Mellie', 'Thailand');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('22', 'x', '2013-12-12', 577, 'Antonettamouth', 'Aruba');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('23', 'x', '2012-01-29', 782, 'Port Sincere', 'Guyana');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('24', 'm', '2015-07-28', 697, 'New Vinnietown', 'Gibraltar');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('25', 'f', '2017-09-04', 937, 'North Wade', 'Libyan Arab Jamahiriya');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('26', 'f', '1992-02-13', 898, 'Reichertborough', 'Chile');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('27', 'x', '1975-11-18', 733, 'Lake Efren', 'Switzerland');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('28', 'f', '2001-02-26', 55, 'Sharonland', 'Mozambique');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('30', 'x', '1976-07-04', 498, 'Borerview', 'Mauritania');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('31', 'f', '1975-12-04', 148, 'Simonisfurt', 'American Samoa');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('32', 'x', '1985-06-25', 692, 'Giovanibury', 'Canada');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('33', 'x', '2011-12-01', 190, 'Deshawnburgh', 'Nigeria');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('35', 'm', '2011-01-29', 441, 'Donatoborough', 'Japan');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('36', 'm', '1985-01-16', 883, 'Mrazfort', 'Azerbaijan');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('37', 'x', '2021-06-29', 695, 'Mollieborough', 'Slovakia (Slovak Republic)');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('38', 'f', '1984-01-20', 293, 'East Florian', 'Libyan Arab Jamahiriya');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('40', 'f', '1995-05-17', 102, 'Kubmouth', 'United States of America');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('44', 'f', '1999-10-06', 549, 'East Erahaven', 'Ecuador');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('45', 'f', '1991-05-11', 550, 'Ryleeton', 'Kyrgyz Republic');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('47', 'f', '2017-06-25', 237, 'East Carlishire', 'Tokelau');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('48', 'x', '1986-05-14', 424, 'Minabury', 'Svalbard & Jan Mayen Islands');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('51', 'x', '1975-04-02', 645, 'South Idaville', 'Palestinian Territory');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('52', 'f', '2012-11-13', 888, 'Framiview', 'Gambia');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('53', 'x', '1978-06-01', 133, 'Johnsstad', 'Pakistan');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('54', 'x', '1986-04-27', 319, 'Feilfort', 'Tokelau');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('55', 'x', '1973-12-25', 448, 'New Bryanatown', 'Guernsey');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('57', 'f', '1985-05-19', 546, 'New Destiny', 'Hungary');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('58', 'x', '1972-09-22', 723, 'East Andyhaven', 'Kuwait');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('59', 'x', '1981-05-20', 968, 'West Modesto', 'Barbados');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('61', 'f', '2004-06-07', 912, 'South Rosemary', 'Timor-Leste');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('62', 'x', '2006-11-19', 172, 'Lake Kayville', 'Rwanda');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('64', 'f', '1981-02-26', 774, 'Naomiestad', 'Northern Mariana Islands');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('65', 'm', '2013-02-14', 212, 'New Jettiefurt', 'South Georgia and the South Sandwich Islands');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('69', 'f', '2007-05-24', 810, 'Edisonburgh', 'Palau');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('70', 'x', '1990-10-30', 200, 'South Jaqueline', 'Saint Martin');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('71', 'f', '1982-02-02', 313, 'Douglasberg', 'Jamaica');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('72', 'f', '1971-12-30', 7, 'West Josiebury', 'Uganda');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('73', 'm', '1982-03-18', 773, 'Wehnerborough', 'Tokelau');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('74', 'x', '1981-04-17', 297, 'Littleborough', 'Saint Helena');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('75', 'f', '1980-07-07', 39, 'Jessiefort', 'Burkina Faso');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('76', 'm', '1995-09-13', 966, 'Prestonview', 'Bermuda');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('78', 'm', '2021-06-03', 182, 'Vandervorttown', 'Montserrat');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('81', 'x', '2008-02-03', 820, 'Stuartchester', 'Saint Kitts and Nevis');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('82', 'x', '2003-07-02', 527, 'Alfordstad', 'British Virgin Islands');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('83', 'x', '2000-10-21', 110, 'Adamport', 'Netherlands Antilles');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('84', 'm', '1977-10-29', 315, 'Johnsbury', 'United States Minor Outlying Islands');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('85', 'f', '2012-05-13', 389, 'Terrencechester', 'Wallis and Futuna');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('88', 'f', '1970-07-25', 352, 'Kirlintown', 'Sri Lanka');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('89', 'm', '1998-06-18', 948, 'South Magali', 'Malawi');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('91', 'f', '1973-09-27', 248, 'Berniecefurt', 'South Africa');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('92', 'm', '2013-12-30', 392, 'New Magnoliaburgh', 'Gabon');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('97', 'f', '1992-08-20', 978, 'Lake Richmond', 'Djibouti');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('98', 'm', '2019-11-09', 921, 'Zboncakberg', 'Qatar');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`) VALUES ('99', 'x', '2009-09-19', 252, 'Colleenshire', 'Israel');


#
# TABLE STRUCTURE FOR: users
#

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ФАМИЛИЯ',
  `email` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` char(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` char(65) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `users_email_idx` (`email`),
  KEY `users_phone_idx` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('1', 'Kassandra', 'Schroeder', 'lind.max@example.org', '07776854843', '8b93e80d38cd844e62301add4a31d3410ee08a33', '2020-12-05 10:33:22');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('2', 'Leo', 'Robel', 'brakus.jacynthe@example.com', '91793897991', '80a399981211a78672a9978c9d99a305ae451be9', '2020-10-06 21:44:27');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('3', 'Keyshawn', 'Okuneva', 'ola.gutmann@example.net', '84756628928', '6c9cd6ae081728a883eeca50341c2d3d0d27da99', '2018-09-29 01:41:29');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('4', 'Richmond', 'Mills', 'tyreek18@example.com', '22460441367', '09e250463144fa939c465bbb6247473baba210de', '2013-10-23 10:27:46');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('5', 'Chaya', 'Hyatt', 'mabel54@example.org', '48195197515', 'ceca5a13d98c33e8f36c6b31f91c44764393e729', '1975-04-12 09:02:50');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('6', 'Agustina', 'Zulauf', 'kellie96@example.com', '29706010024', 'e18b7bcc1518e7afca557b037ca1035041973b60', '1972-03-24 13:47:59');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('7', 'Jerel', 'Pfeffer', 'ewindler@example.org', '23257614588', '4b3a4254038308601ef2c3ae3f62afdfdca3a403', '1971-11-23 07:24:52');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('8', 'Ricky', 'Dickinson', 'satterfield.tremaine@example.net', '26541206043', 'cfd7355d2839b61d6ccbc319a139f706a25cde96', '1989-12-27 18:43:15');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('9', 'Moses', 'Terry', 'edd63@example.net', '61029915595', '1c4e0ef3cc2ac00dcb4564074e347ffbc1f38b81', '2010-03-06 17:18:53');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('10', 'Larissa', 'Rogahn', 'eriberto83@example.org', '62364094353', '09cae7a913218267d808785da7f526034da15ff4', '1985-03-31 19:10:32');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('11', 'Bailey', 'Cassin', 'yhammes@example.org', '29029298002', 'a92746a9812ccb0a189f257867a4cc35e221ecc6', '2004-01-27 04:03:53');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('12', 'Presley', 'Jones', 'schowalter.monty@example.net', '39610320722', '4c75abce7073fac6dbb1fdaa0e90b28c0e12fa9c', '1973-05-14 01:18:51');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('13', 'Yasmin', 'Hickle', 'gleichner.anna@example.org', '29641956052', 'a115e8cd31325425036bac9d2dfc8c9dd1dcfeaa', '1994-04-19 00:51:36');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('14', 'Romaine', 'Jacobs', 'gudrun46@example.org', '83698470236', 'e42a4bd5095e2f2112b9b0273c16258c07d5e532', '1984-07-05 14:11:11');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('15', 'Arely', 'Pagac', 'oquigley@example.com', '85222654977', 'b3a9bcad69cd372c9f617aa667d1035683f76400', '1976-03-18 20:38:36');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('16', 'Rubye', 'Koss', 'casey.hettinger@example.com', '71882551443', '8eae86770bc22067f81948768230b1c7f3d4edb9', '2016-02-16 00:43:09');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('17', 'Blanca', 'Shields', 'wellington12@example.org', '83164843127', '4e0be9c0400216c0f652ca5d836616742213a611', '1999-11-04 10:01:09');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('18', 'Jarred', 'Jerde', 'edgar.wilderman@example.com', '26457918534', 'c1f8116ff5edbeb4e5c342557504a9b9d81f9ae5', '1980-09-28 04:24:05');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('19', 'Uriah', 'Jacobson', 'rfriesen@example.org', '04181640027', '753f341873e5a12adfc070b6be19120408893832', '1986-10-07 22:09:41');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('20', 'Myron', 'Lesch', 'lavinia56@example.net', '83981521358', 'db99d864cd75c154fa170544b64c7f05d8842be7', '2010-03-14 21:54:48');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('21', 'Dasia', 'Will', 'brooks28@example.org', '12047900138', 'd4806b5c088e95eaad42b36b96b4bdd371c4caf7', '2011-01-29 08:48:08');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('22', 'Hassie', 'Nitzsche', 'gillian.lockman@example.net', '06126266999', '88b5b77c933070c1af3347e28e806a97a4d0697f', '1986-03-11 03:47:19');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('23', 'Moriah', 'Keeling', 'anibal58@example.org', '66315861457', 'dca8a7569af5a15ffa6dd3e6154dd59656aadd0a', '1972-02-26 00:06:12');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('24', 'Finn', 'Jacobi', 'zoila.toy@example.org', '31939512509', '81e836cf5d15a7e0d32ef403e6f4629143ed9c2b', '1973-07-10 21:20:08');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('25', 'Elton', 'Heaney', 'maximillian84@example.net', '03278009946', '526d94674fe23cd0e8e833e13c28a806cf4de549', '1988-08-19 16:23:52');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('26', 'Kadin', 'Boyer', 'kreichert@example.net', '28311990034', '109428083e8791987bf62da1c80d83646117b12a', '2005-12-31 13:18:15');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('27', 'Jayde', 'Wisoky', 'kwuckert@example.com', '37324180538', '1f21d9915c00247d8cf51ecd5179cdb46b8e3777', '1980-11-14 03:32:01');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('28', 'Marcella', 'Schmeler', 'bessie47@example.org', '97220643116', 'b0b9f264a2f9ad4c10f3de450afa916043ede200', '1999-04-22 13:27:35');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('29', 'Monty', 'Renner', 'cornell.yundt@example.net', '39657472559', '20e97b7ec20913365a202188884d9896d2ca1c4e', '2001-11-07 13:29:21');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('30', 'Cheyenne', 'Senger', 'kamille79@example.com', '71220442273', 'b4df4fdb229b4dc413d8c22cd8c3c52cba6603bb', '2003-05-18 23:19:36');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('31', 'Krystal', 'Ward', 'shaun.jaskolski@example.com', '30659919314', 'af01dc1af018385578f5b1e581ba9c08d11e180f', '1988-12-14 19:52:34');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('32', 'Sienna', 'Walker', 'joshua22@example.com', '12510705599', '675d1e7c45b37ea9a35656e0c0527e76c18c7bbc', '1970-07-04 11:56:28');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('33', 'Elsa', 'Aufderhar', 'rodrick.roob@example.org', '90266812473', 'fceb02ad2876c715aea3826343a89a591ddb6f26', '2015-10-15 04:10:27');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('34', 'Brett', 'Kiehn', 'hayes.carole@example.com', '52403562306', 'b6a3d36ecb2d9c9269516803808bc9e2faabd091', '2016-01-21 18:39:15');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('35', 'Brandyn', 'Beer', 'lee.morissette@example.com', '28830134962', 'e77ee8dac0f376db82d7090788c6aaebe13ac315', '2014-05-11 22:51:59');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('36', 'Ari', 'Ryan', 'bert.effertz@example.net', '06392812021', '877bbc450c3ae6e6a64b4067aa3c25468ddaf639', '2019-02-19 16:48:51');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('37', 'Garfield', 'Legros', 'bethel.mills@example.org', '78167253621', '506b21bbd80ec02e3e123e2792c80fc5c47dde4d', '1974-06-25 08:39:09');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('38', 'Ettie', 'Funk', 'kgreenfelder@example.net', '12947842854', 'ea58405abcb2e0d40b4a940675a7c0b7743f01d7', '1987-03-28 04:20:10');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('39', 'Kelsi', 'Stamm', 'jonathon.walsh@example.com', '97480104866', 'd2216eacee15dd6b1495fc6be55ce716560bcbdf', '1972-02-04 15:27:15');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('40', 'Gay', 'Schamberger', 'koelpin.graciela@example.net', '37591163747', 'ea6a05df9086af758fd78b47d25b6854498e2e2d', '1979-09-24 18:16:43');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('41', 'Zena', 'Smith', 'cartwright.dayana@example.org', '43807584383', 'ea09fef8526bbc886c81e78b488721901d52d78f', '2017-04-27 22:52:29');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('42', 'Leanna', 'Lindgren', 'dock.davis@example.net', '02018452376', '107acbe83d9bdccaa475e14c22a9aafe4812813e', '2002-07-08 09:05:04');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('43', 'Destiney', 'Langworth', 'ali48@example.org', '69334050284', '2b798a04647a0b38f7ba5758d91bcde4b68d2c2f', '2004-03-19 23:12:45');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('44', 'Ava', 'Nader', 'kiel.hodkiewicz@example.net', '19406119812', 'e3fcc1b84dc11c766c7c73582842a4ec53782c63', '1980-10-08 15:44:47');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('45', 'Melissa', 'Herzog', 'hintz.alexie@example.net', '35460356755', 'c11b4f46b5cfe593a1a881d0d0c4b6b346bb7b01', '2012-10-06 07:13:13');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('46', 'Madeline', 'Purdy', 'domenic42@example.org', '43472375579', 'e51baa73e253c38315724dd795fcf21332b79c31', '1982-09-12 06:06:40');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('47', 'Jarrell', 'Hyatt', 'kyra82@example.com', '99358605583', '61efbb6339284226501f244db2d4ccf0828d717e', '2011-08-28 01:01:17');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('48', 'Leanne', 'Roberts', 'sid.christiansen@example.com', '81115536690', '0b7c574bfcb339d3b28c27811e1d2bcd898bea16', '2000-11-11 00:01:15');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('49', 'Adrianna', 'Corkery', 'hubert.botsford@example.com', '88313439188', '89546a980d36c08ef80acd7d4d87c7fa39f3c3cb', '1978-12-04 14:12:41');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('50', 'Eva', 'Ullrich', 'daphnee.leannon@example.com', '49360570759', 'c62e2ff18a1f3b08e8e13c73e51c7eee44efdd09', '2009-08-21 13:46:25');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('51', 'Hudson', 'O\'Keefe', 'tyra85@example.net', '57663427659', '75302bee91409a2fb6da3bfde8eb65e620cb0aff', '2019-01-01 19:27:51');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('52', 'Sarina', 'Fisher', 'iwolff@example.org', '24262131841', 'fb832a3cef77e38c2b67a45df3ced3b0e9eb2275', '2015-01-13 05:41:19');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('53', 'Cassandra', 'Ritchie', 'eloise.monahan@example.net', '05455430544', 'a20127b828c43b24643eae1c57fa0da94b6c38a1', '2002-09-21 22:02:26');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('54', 'Amaya', 'Mosciski', 'vita.hudson@example.org', '05422000307', 'd1f6703e721b179a8326904faf22c9d34f1feade', '1992-01-25 20:42:28');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('55', 'Ubaldo', 'Heidenreich', 'weichmann@example.org', '50414272723', 'ce470b431ce87dcd768fdb3e72185628ee7eb2bc', '1979-06-13 04:14:20');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('56', 'Delbert', 'Mraz', 'greta.gleason@example.com', '40612379606', '6955bbdb79e267a8bca3589c52e7f31d771bb217', '1994-05-19 01:19:47');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('57', 'Gage', 'Cummerata', 'zjohnson@example.org', '96871536556', '30143e6160f4a35caf6e4238859b4a8ca0e682d6', '2006-06-24 23:22:09');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('58', 'Jacques', 'Orn', 'domenick.waters@example.org', '48499811473', '6ec34854d48e1259fdcedb6121af4e24f918d3b6', '1973-06-17 13:25:21');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('59', 'Missouri', 'Gibson', 'marianne76@example.net', '60890792501', '8c88b26a7a68f246ec86cd4cb27a7a8c2af96847', '1976-04-20 14:14:15');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('60', 'Elisha', 'Casper', 'zlesch@example.net', '61234779790', 'efc3995a4a6760b2c2dea596173cb3f87a2b81b5', '1986-04-24 05:29:15');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('61', 'Jabari', 'Willms', 'sonny88@example.org', '57675666652', 'fae297fc2aaddc6887c41d85c9be673573fae7a0', '1990-05-23 07:54:46');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('62', 'Gabriel', 'Rutherford', 'allene08@example.org', '48609190661', '8fa985d1fb1d51124a1c8150fec560d43017230d', '1990-06-07 18:02:59');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('63', 'Urban', 'Davis', 'bartholome84@example.net', '32383822883', '746a32d930edcfa88b34b14b6eb54ecad5456ec9', '2010-04-23 04:15:47');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('64', 'Mike', 'Ebert', 'kshlerin.jalyn@example.net', '22274488796', '018a8186261d91e89f2f3411d28781fac8a0e0eb', '1973-05-18 09:42:02');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('65', 'Solon', 'Torp', 'rcremin@example.com', '93945433031', '836d261fe198cc9281eefae3675b8805e38c25ac', '1975-03-16 08:01:08');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('66', 'Demario', 'Eichmann', 'martina62@example.net', '59912732297', '5cd2754ed8338f5fb0156d62ed553978432cc480', '1970-09-04 08:59:43');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('67', 'Alysha', 'Hilpert', 'nakia68@example.net', '96021300112', 'bb3d3b0b241519086e8a21d03d228bb6a364bb72', '1987-11-23 04:18:13');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('68', 'Alaina', 'Thompson', 'omckenzie@example.net', '04690309445', '817944fac97801999d935d9bccb1cdceae958cb7', '2015-11-03 16:44:02');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('69', 'Anastasia', 'Walter', 'rcremin@example.org', '69232519372', 'afc0b416ab3e6387e3ddf17b2aad17f02976ef33', '2020-10-24 07:02:53');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('70', 'Javier', 'Stroman', 'towne.myah@example.com', '89133551166', 'f584912ac517bd504501b2c04f862461050fa382', '1974-05-24 23:06:10');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('71', 'Erik', 'Lebsack', 'crist.destiney@example.org', '90251767070', 'b8ccf1800c1fd27f42a75e2eb50abc15b94ea233', '1972-05-27 21:52:27');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('72', 'Monty', 'Jaskolski', 'leon95@example.net', '22844250523', '9bde7c201d0fa69b69f36aa9e6584e6ea2736ff7', '1990-09-25 08:23:08');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('73', 'Alejandra', 'Daniel', 'kilback.vicenta@example.com', '20246846537', '119530992fa0d9432bd0969accc23e4dc54ef1ed', '1985-10-11 06:40:44');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('74', 'Whitney', 'Rogahn', 'harley.heidenreich@example.net', '56550941051', 'd02ca6e603aa62ac9c052c5c06c3c1aecd1f7497', '2006-08-07 09:13:48');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('75', 'Chauncey', 'Bartell', 'monte.white@example.com', '51294208664', '84d671f9ac0d2f38b9766be509e46ccb99b64246', '2009-07-17 15:37:15');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('76', 'Zachery', 'Trantow', 'rblock@example.net', '05282243448', '4be1d73217243fd17ad62bef3d5b4f75bb72ea87', '2018-08-04 14:26:19');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('77', 'Brook', 'Strosin', 'heaney.georgianna@example.org', '03024708383', '09d91f0843e628b9b7cbf8e8e29ac63c07c57b46', '1981-08-05 09:06:30');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('78', 'Joshuah', 'Zemlak', 'jeramy27@example.org', '37433209904', '05eee321a03cb397da669061a73a780ffda28d0d', '1975-09-17 22:05:15');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('79', 'Leola', 'Cartwright', 'agustin.ritchie@example.com', '83877063157', 'd8221228a121c7f8688531a0244f75a6e9d927f3', '2013-06-10 23:29:32');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('80', 'Gaston', 'Hintz', 'larissa.roberts@example.org', '64465797457', '75a35f276f1c5427bbe2660ccb7e6fefc81baf3d', '2012-09-30 23:37:38');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('81', 'Caterina', 'Sipes', 'cheyenne34@example.org', '91931225902', '7f9342c6721c356fa96ee14798c9758e10cbe8ba', '2000-04-29 22:05:16');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('82', 'Edgar', 'Thiel', 'purdy.horace@example.net', '36482219498', 'a5e7c3a03b554f02e4629301abe7a1a5873cedbb', '1970-02-23 18:24:06');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('83', 'Alysson', 'Zemlak', 'eladio17@example.net', '41032821256', '1cc388d0f235b6483eef96052f27d7d64ddda7d8', '2004-11-11 22:14:28');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('84', 'Tia', 'McGlynn', 'norma.schulist@example.com', '43784755271', 'a19e104e987c80f450203b349a6df5210214b1e2', '1987-09-29 11:29:36');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('85', 'Annabelle', 'Wyman', 'wolff.delphine@example.org', '95287409026', 'aabb5b8bd279a428a366992e932e2b6a63f5180d', '1983-08-23 06:34:27');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('86', 'Giovanna', 'Lehner', 'cesar59@example.net', '52789953753', '78c81a51863f06e18893f4a26382292a6ca59e06', '1996-06-18 10:39:16');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('87', 'Neha', 'Larkin', 'deonte41@example.com', '16815750031', 'da84f4236fe8757fbc45f4347bddbeb2c24f2151', '2000-07-05 23:48:00');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('88', 'Flo', 'Ward', 'teagan50@example.com', '33476047504', '1007ffd93c06eff3bb31b17725dc351f416e18c1', '2003-12-18 21:43:28');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('89', 'Ara', 'Cartwright', 'schoen.luis@example.org', '49533674146', '1c2d9b88d382a647cd60d0cecbfa8dd2c7d7e5df', '2012-11-01 00:10:14');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('90', 'Norma', 'Reichel', 'altenwerth.asia@example.org', '62012627715', '776ae0a7faac68c4239e0ea4331787aaf225d617', '1979-08-29 17:30:00');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('91', 'Crystel', 'Strosin', 'lweimann@example.net', '77072356824', '22f0bd5e79f8e96381509e4a06e51429f37be139', '1976-01-24 22:05:24');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('92', 'Ashley', 'Dach', 'nking@example.org', '55917014042', 'a704e8401a4631d72e59b29a42ab04143982441a', '1993-11-24 04:39:47');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('93', 'Emerson', 'Crooks', 'roger.o\'conner@example.com', '91665427193', '93f0b76b1530e0fcc89866799d040d53e2b641c9', '1996-08-22 06:19:07');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('94', 'Meghan', 'Hyatt', 'cesar.gleason@example.com', '64502833266', '76a5fe0e19a0205235ccb7ad2ea4d1910b0d43d7', '2015-06-25 10:48:24');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('95', 'Jaleel', 'Ebert', 'walsh.rocio@example.org', '77620687972', '06d6656877a5812fe03816f2c1a85396521bd07b', '1991-02-05 22:05:20');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('96', 'Pietro', 'Gibson', 'dustin.volkman@example.org', '96224923882', 'eae1ce69af0a22e221b7bb4e39bb9ecddaa9b3e3', '2015-04-07 04:31:52');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('97', 'Silas', 'Ledner', 'langworth.melissa@example.org', '39999236476', 'fe6b24051694f1422905d2ab4831c8590b6a4b79', '2015-12-16 22:25:55');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('98', 'Tracey', 'Nader', 'nicola54@example.com', '55924147675', '82aca44ee8c12b36f426d95b1e616668faac864c', '1994-05-03 01:35:03');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('99', 'Magnus', 'Ward', 'gia07@example.org', '57008564202', '5ca954665075d330bb86743800a7ef74c25ace31', '2008-11-26 21:30:28');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password_hash`, `created_at`) VALUES ('100', 'Dedrick', 'Wehner', 'madeline67@example.org', '79539074556', '387afd57b3b35c956d2d64d514c291a0dd705328', '1987-11-26 00:40:51');


