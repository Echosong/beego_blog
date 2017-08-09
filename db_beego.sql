/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50719
Source Host           : 127.0.0.1:3306
Source Database       : db_beego

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2017-08-09 20:45:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tb_category`
-- ----------------------------
DROP TABLE IF EXISTS `tb_category`;
CREATE TABLE `tb_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tb_category
-- ----------------------------
INSERT INTO `tb_category` VALUES ('2', 'dsfdsf', '2017-08-08 13:52:03', '2017-08-08 13:52:03');
INSERT INTO `tb_category` VALUES ('4', 'aaaaa', '2017-08-08 14:45:38', '2017-08-08 14:45:38');

-- ----------------------------
-- Table structure for `tb_comment`
-- ----------------------------
DROP TABLE IF EXISTS `tb_comment`;
CREATE TABLE `tb_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(200) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ip` varchar(100) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_comment
-- ----------------------------
INSERT INTO `tb_comment` VALUES ('4', 'dsdfsfdsfds', 'fsdfdsfds', '2017-08-16 15:34:09', '[', '0');
INSERT INTO `tb_comment` VALUES ('5', 'dsfds', 'fdsfds', '2017-08-09 15:41:12', '111', '1');
INSERT INTO `tb_comment` VALUES ('7', 'fsdfdsfdsfds', 'sdfdsfdsf', null, '[', '8');
INSERT INTO `tb_comment` VALUES ('8', 'sdfdsfds', 'fsdfdsfdsfds', null, '[', '8');
INSERT INTO `tb_comment` VALUES ('9', 'fdsfdsfdsfds', '<p style=\"text-align: left;\"><b>fdsfdsfdsffdsfdsfdsfdsfdsdsfdsfds</b></p><p style=\"text-align: left;\"><b><br></b></p><p style=\"text-align: left;\"><b>a. fsdfdsf</b></p>', '2017-08-09 15:42:54', '[', '8');

-- ----------------------------
-- Table structure for `tb_config`
-- ----------------------------
DROP TABLE IF EXISTS `tb_config`;
CREATE TABLE `tb_config` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_config
-- ----------------------------
INSERT INTO `tb_config` VALUES ('1', 'title', 'fdsfdsfdsfdsfds');
INSERT INTO `tb_config` VALUES ('2', 'url', 'http://www.ptapp.cnsdfdsfds');
INSERT INTO `tb_config` VALUES ('5', 'keywords', 'dsfds');
INSERT INTO `tb_config` VALUES ('6', 'description', 'fdsfdsfdsfdsfdsfds');
INSERT INTO `tb_config` VALUES ('7', 'email', 'lisijie86@gmail.com');
INSERT INTO `tb_config` VALUES ('9', 'timezone', '8');
INSERT INTO `tb_config` VALUES ('11', 'start', '1');
INSERT INTO `tb_config` VALUES ('12', 'qq', '1212121');

-- ----------------------------
-- Table structure for `tb_post`
-- ----------------------------
DROP TABLE IF EXISTS `tb_post`;
CREATE TABLE `tb_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '下载地址',
  `content` mediumtext,
  `tags` varchar(100) NOT NULL,
  `views` mediumint(9) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `is_top` tinyint(4) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `category_id` int(11) NOT NULL,
  `types` tinyint(4) DEFAULT NULL COMMENT '1. 文章 0 下载',
  `info` varchar(500) CHARACTER SET utf8 DEFAULT NULL COMMENT '简介',
  `image` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tb_post
-- ----------------------------
INSERT INTO `tb_post` VALUES ('1', '23', '2323', '232', '2323', '232', '3232', '1', '0', '2017-08-08 15:25:26', '2017-08-08 15:25:26', '2', null, null, null);
INSERT INTO `tb_post` VALUES ('2', '1', '2232', '2323', '232323', '222', '1', '1', '0', '2017-08-08 15:37:14', '2017-08-08 15:37:14', '1', null, null, null);
INSERT INTO `tb_post` VALUES ('3', '1', '2333334dffdsf', 'dsfdsf', 'dsfsdfs', 'dsfdsf', '3', '1', '0', '2017-08-08 15:37:31', '2017-08-08 15:37:31', '3', null, null, null);
INSERT INTO `tb_post` VALUES ('4', '1', '', 'http://www.baidu.com', '<p>dsfdsfsdfdsfdsf</p>', 'sdfds,fdsfds,aaa,', '0', '0', '0', '2017-08-08 16:58:27', '2017-08-08 16:58:27', '2', '0', null, null);
INSERT INTO `tb_post` VALUES ('5', '1', 'fdsfdsfdsf', 'http://www.baidu.com', '<p>fdsfsdfdsfdsfds</p>', 'dsfdsfds', '0', '0', '0', '2017-08-08 17:02:30', '2017-08-08 17:02:30', '4', '0', null, null);
INSERT INTO `tb_post` VALUES ('6', '1', '2333334dffdsf', 'http://aaa.com', '<p>dsfsdfs</p>', 'dsfdsf', '0', '0', '1', '2017-08-08 17:07:48', '2017-08-08 17:07:48', '4', '0', null, null);
INSERT INTO `tb_post` VALUES ('7', '1', 'sdfdsfdsfdsf', 'http://www.baidu.com', '<p>dsfdsf</p>', 'fsdfdsf', '0', '0', '1', '2017-08-08 17:08:53', '2017-08-08 17:08:53', '2', '0', null, null);
INSERT INTO `tb_post` VALUES ('8', '1', 'dsfdsfds', 'http://www.baidu.com', '<p>fdsfdsfdsfdsfds</p>', 'aaaa,xxxx,dddd,uuu,xxx', '0', '0', '1', '2017-08-08 17:09:22', '2017-08-08 17:09:22', '2', '1', null, null);
INSERT INTO `tb_post` VALUES ('9', '1', 'dfsfdsf', 'http://sfdsfds.omc', '<p>fsdfdsfds</p>', 'fsdfds', '0', '0', '1', '2017-08-08 17:09:41', '2017-08-08 17:09:41', '2', '0', null, null);

-- ----------------------------
-- Table structure for `tb_tag`
-- ----------------------------
DROP TABLE IF EXISTS `tb_tag`;
CREATE TABLE `tb_tag` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '标签名',
  `count` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '使用次数',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_tag
-- ----------------------------
INSERT INTO `tb_tag` VALUES ('1', 'iPhone', '3', '2017-08-08 10:58:39', '2017-08-08 10:58:39');
INSERT INTO `tb_tag` VALUES ('2', '越狱', '3', '2017-08-08 10:58:39', '2017-08-08 10:58:39');

-- ----------------------------
-- Table structure for `tb_tag_post`
-- ----------------------------
DROP TABLE IF EXISTS `tb_tag_post`;
CREATE TABLE `tb_tag_post` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tag_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '标签id',
  `post_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '内容id',
  PRIMARY KEY (`id`),
  KEY `tagid` (`tag_id`),
  KEY `postid` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_tag_post
-- ----------------------------
INSERT INTO `tb_tag_post` VALUES ('1', '1', '22');
INSERT INTO `tb_tag_post` VALUES ('2', '2', '22');
INSERT INTO `tb_tag_post` VALUES ('3', '1', '21');
INSERT INTO `tb_tag_post` VALUES ('4', '2', '21');
INSERT INTO `tb_tag_post` VALUES ('5', '1', '20');
INSERT INTO `tb_tag_post` VALUES ('6', '2', '20');

-- ----------------------------
-- Table structure for `tb_user`
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `login_count` int(11) DEFAULT NULL,
  `last_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `last_ip` varchar(200) DEFAULT 'current_timestamp()',
  `state` tinyint(4) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES ('1', 'admin', ' e10adc3949ba59abbe56e057f20f883e', '', '9', null, '[', '0', null, '2017-08-08 19:48:05');
