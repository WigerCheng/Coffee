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

 Date: 31/12/2020 15:18:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for orderdetail
-- ----------------------------
DROP TABLE IF EXISTS `orderdetail`;
CREATE TABLE `orderdetail`  (
  `detail_id` int NOT NULL AUTO_INCREMENT COMMENT '订单详情ID',
  `detail_coffee_id` int NOT NULL COMMENT '咖啡ID',
  `detail_order_id` int NOT NULL COMMENT '订单ID',
  `detail_quantity` int NOT NULL COMMENT '订单咖啡数量',
  `detail_sugar` int NULL DEFAULT NULL COMMENT '订单咖啡甜度',
  `detail_temperature` int NULL DEFAULT NULL COMMENT '订单咖啡温度',
  `detail_size` int NULL DEFAULT NULL COMMENT '订单咖啡大小',
  PRIMARY KEY (`detail_id`) USING BTREE,
  INDEX `fk_coffee`(`detail_coffee_id`) USING BTREE,
  INDEX `fk_order`(`detail_order_id`) USING BTREE,
  CONSTRAINT `fk_coffee` FOREIGN KEY (`detail_coffee_id`) REFERENCES `coffee` (`coffee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_order` FOREIGN KEY (`detail_order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderdetail
-- ----------------------------
INSERT INTO `orderdetail` VALUES (12, 12, 11, 2, 1, 1, 1);
INSERT INTO `orderdetail` VALUES (25, 9, 23, 1, 1, 1, 1);
INSERT INTO `orderdetail` VALUES (26, 12, 24, 1, 1, 1, 1);
INSERT INTO `orderdetail` VALUES (27, 12, 26, 1, 1, 1, 1);
INSERT INTO `orderdetail` VALUES (28, 9, 27, 2, 1, 1, 1);
INSERT INTO `orderdetail` VALUES (33, 11, 34, 2, 1, 2, 1);
INSERT INTO `orderdetail` VALUES (34, 12, 34, 1, 1, 1, 1);
INSERT INTO `orderdetail` VALUES (35, 10, 34, 1, 2, 1, 1);
INSERT INTO `orderdetail` VALUES (37, 9, 35, 1, 1, 1, 1);
INSERT INTO `orderdetail` VALUES (38, 10, 35, 1, 2, 1, 1);
INSERT INTO `orderdetail` VALUES (39, 11, 35, 1, 1, 2, 1);
INSERT INTO `orderdetail` VALUES (40, 12, 35, 1, 1, 1, 1);
INSERT INTO `orderdetail` VALUES (41, 9, 38, 1, 1, 1, 1);
INSERT INTO `orderdetail` VALUES (47, 11, 44, 2, 1, 2, 1);
INSERT INTO `orderdetail` VALUES (48, 11, 45, 1, 1, 2, 1);
INSERT INTO `orderdetail` VALUES (53, 21, 49, 2, 4, 2, 1);
INSERT INTO `orderdetail` VALUES (58, 11, 53, 1, 1, 2, 1);
INSERT INTO `orderdetail` VALUES (59, 10, 53, 2, 1, 2, 1);
INSERT INTO `orderdetail` VALUES (60, 19, 54, 1, 1, 2, 1);

SET FOREIGN_KEY_CHECKS = 1;
