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

 Date: 31/12/2020 15:18:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `order_id` int NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `user_id` int NOT NULL COMMENT '用户id',
  `order_status` int NOT NULL COMMENT '订单状态',
  `order_date` datetime(0) NOT NULL COMMENT '订单下单时间',
  `order_money` int NULL DEFAULT NULL COMMENT '订单金额',
  PRIMARY KEY (`order_id`, `user_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (11, 34434, 2, '2020-12-05 17:55:49', 264);
INSERT INTO `orders` VALUES (23, 34435, 3, '2020-12-08 00:46:17', 14);
INSERT INTO `orders` VALUES (24, 34435, 3, '2020-12-08 00:46:57', 22);
INSERT INTO `orders` VALUES (26, 34435, 2, '2020-12-11 00:23:36', 22);
INSERT INTO `orders` VALUES (27, 34435, 3, '2020-12-11 14:09:40', 28);
INSERT INTO `orders` VALUES (34, 34435, 2, '2020-12-11 21:27:46', 75);
INSERT INTO `orders` VALUES (35, 34435, 3, '2020-12-12 17:17:30', 81);
INSERT INTO `orders` VALUES (38, 34435, 2, '2020-12-12 17:41:26', 14);
INSERT INTO `orders` VALUES (44, 34435, 2, '2020-12-22 01:39:41', 40);
INSERT INTO `orders` VALUES (45, 34435, 3, '2020-12-22 01:48:54', 20);
INSERT INTO `orders` VALUES (49, 34435, 2, '2020-12-22 15:49:57', 22);
INSERT INTO `orders` VALUES (53, 34435, 3, '2020-12-31 15:06:22', 45);
INSERT INTO `orders` VALUES (54, 34435, 2, '2020-12-31 15:10:08', 12);

SET FOREIGN_KEY_CHECKS = 1;
