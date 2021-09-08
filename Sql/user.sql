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

 Date: 31/12/2020 15:19:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户名称',
  `password` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户密码',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户性别',
  `account` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户账号',
  `status` int NULL DEFAULT NULL COMMENT '用户状态(0顾客，1管理员)',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户电话',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `uni_account`(`account`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34475 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (34434, '无名1', '123456', '男', 'root', 1, '13800138000');
INSERT INTO `user` VALUES (34435, '爱丽丝', '123456', '女', 'alice', 0, '13000000000');
INSERT INTO `user` VALUES (34436, '小明', '111111', '男', 'ming', 0, '13000000001');
INSERT INTO `user` VALUES (34437, '小红', '111111', '女', 'red', 0, '13000000002');
INSERT INTO `user` VALUES (34439, '小白', '111111', '女', 'white', 0, '19216813724');
INSERT INTO `user` VALUES (34440, '比伯', '12345678', '男', 'bobbb', 0, '10086');
INSERT INTO `user` VALUES (34442, '超级管理员A', '123456', '男', 'admin', 1, '15553123233');
INSERT INTO `user` VALUES (34468, '测试用户A', '111111', '男', 'testC', 0, '1234567890');
INSERT INTO `user` VALUES (34469, 'test', '111', '男', 'test', 1, '111');
INSERT INTO `user` VALUES (34474, 'rrrr', '111111', '女', 'rrrr', 1, '111111');

SET FOREIGN_KEY_CHECKS = 1;
