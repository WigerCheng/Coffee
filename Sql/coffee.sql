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

 Date: 31/12/2020 15:18:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for coffee
-- ----------------------------
DROP TABLE IF EXISTS `coffee`;
CREATE TABLE `coffee`  (
  `coffee_id` int NOT NULL AUTO_INCREMENT COMMENT '咖啡id',
  `coffee_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '咖啡名称',
  `coffee_price` decimal(10, 2) NOT NULL COMMENT '咖啡价格',
  `coffee_information` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '咖啡介绍',
  `coffee_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '咖啡图片地址',
  `coffee_status` int NOT NULL COMMENT '咖啡状态',
  `coffee_sugar` int NULL DEFAULT NULL COMMENT '咖啡甜度',
  `coffee_temperature` int NULL DEFAULT NULL COMMENT '咖啡温度',
  `coffee_size` int NULL DEFAULT NULL COMMENT '咖啡规格',
  PRIMARY KEY (`coffee_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of coffee
-- ----------------------------
INSERT INTO `coffee` VALUES (9, '黑咖啡', 14.00, '好喝的黑咖啡', '37a39779c2c047278bb07987b0d83c1a.jpg', 0, 7, 1, 1);
INSERT INTO `coffee` VALUES (10, '美式咖啡', 12.50, '好喝的美式咖啡', 'ef9854beff454313ae75c1f0ba69b344.jpg', 0, 3, 3, 1);
INSERT INTO `coffee` VALUES (11, '哥伦比亚咖啡', 20.00, '来自哥伦比亚的咖啡', '72fa3d4c16754057a09be1505bd66590.jpg', 0, 1, 2, 1);
INSERT INTO `coffee` VALUES (12, '意大利咖啡', 22.00, '来自意大利的咖啡', 'bc948b87cda14d8d8a04d2f40d8ca1cb.jpg', 1, 3, 1, 1);
INSERT INTO `coffee` VALUES (19, '咖啡', 12.10, '', '16d84ea69f964723b9ead32f8ce98d77.jpg', 0, 1, 2, 1);
INSERT INTO `coffee` VALUES (21, 'COFFEE', 12.00, 'ADAFSDFSAFASDFSD', 'bcbbfa2bb5554cb4913feac254ae0522.jpg', 0, 7, 3, 3);
INSERT INTO `coffee` VALUES (22, 'kkkfff', 12.50, 'adsfsdfsf', 'd84b3b3ccfc449fbaa587baaa3450c93.jpg', 0, 3, 2, 1);

SET FOREIGN_KEY_CHECKS = 1;
