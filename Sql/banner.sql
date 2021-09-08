/*
 Navicat Premium Data Transfer

 Source Server         : Mysql
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : localhost:3306
 Source Schema         : coffee

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 31/12/2020 15:18:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner`  (
  `banner_id` int NOT NULL AUTO_INCREMENT COMMENT '轮播图id',
  `banner_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '轮播图',
  PRIMARY KEY (`banner_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 577013 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES (577009, '31629e487f5b46cd8aec4d01693b0aa8.jpg');
INSERT INTO `banner` VALUES (577012, 'dd069e308c8847288e74c192bd8607f0.png');

SET FOREIGN_KEY_CHECKS = 1;
