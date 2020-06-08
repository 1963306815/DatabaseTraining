/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : e-commerce

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 05/06/2020 13:07:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for 仓库
-- ----------------------------
DROP TABLE IF EXISTS `仓库`;
CREATE TABLE `仓库`  (
  `仓库id` int(0) UNSIGNED NOT NULL,
  `地址` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`仓库id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 会员
-- ----------------------------
DROP TABLE IF EXISTS `会员`;
CREATE TABLE `会员`  (
  `用户id` int(0) UNSIGNED NOT NULL,
  `商家id` int(0) UNSIGNED NOT NULL,
  INDEX `用户id`(`用户id`) USING BTREE,
  INDEX `商家id`(`商家id`) USING BTREE,
  CONSTRAINT `会员_ibfk_1` FOREIGN KEY (`用户id`) REFERENCES `用户` (`用户id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `会员_ibfk_2` FOREIGN KEY (`商家id`) REFERENCES `商家` (`商家id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 供应
-- ----------------------------
DROP TABLE IF EXISTS `供应`;
CREATE TABLE `供应`  (
  `仓库id` int(0) UNSIGNED NOT NULL,
  `商品id` int(0) UNSIGNED NOT NULL,
  `供应量` int(0) UNSIGNED NOT NULL,
  `供应日期` date NOT NULL,
  PRIMARY KEY (`仓库id`) USING BTREE,
  INDEX `商品id`(`商品id`) USING BTREE,
  CONSTRAINT `供应_ibfk_1` FOREIGN KEY (`仓库id`) REFERENCES `仓库` (`仓库id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `供应_ibfk_2` FOREIGN KEY (`商品id`) REFERENCES `商品` (`商品id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 商品
-- ----------------------------
DROP TABLE IF EXISTS `商品`;
CREATE TABLE `商品`  (
  `商品id` int(0) UNSIGNED NOT NULL,
  `商品名` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `商品型号id` int(0) UNSIGNED NOT NULL,
  `价格` decimal(65, 2) UNSIGNED NOT NULL,
  `会员价格` decimal(65, 2) UNSIGNED NULL DEFAULT NULL,
  `公共属性值1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `公共属性值2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `公共属性值3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `公共属性值4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `公共属性值5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `非公共属性` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`商品id`) USING BTREE,
  INDEX `商品型号id`(`商品型号id`) USING BTREE,
  CONSTRAINT `商品_ibfk_1` FOREIGN KEY (`商品型号id`) REFERENCES `商品型号` (`商品型号id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 商品型号
-- ----------------------------
DROP TABLE IF EXISTS `商品型号`;
CREATE TABLE `商品型号`  (
  `商品型号id` int(0) UNSIGNED NOT NULL,
  `型号名称` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `商品类别id` int(0) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`商品型号id`) USING BTREE,
  INDEX `商品类别id`(`商品类别id`) USING BTREE,
  CONSTRAINT `商品型号_ibfk_1` FOREIGN KEY (`商品类别id`) REFERENCES `商品类别` (`商品类别id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 商品类别
-- ----------------------------
DROP TABLE IF EXISTS `商品类别`;
CREATE TABLE `商品类别`  (
  `商品类别id` int(0) UNSIGNED NOT NULL,
  `类别名称` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `公共属性1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `公共属性2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `公共属性3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `公共属性4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `公共属性5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`商品类别id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 商家
-- ----------------------------
DROP TABLE IF EXISTS `商家`;
CREATE TABLE `商家`  (
  `商家id` int(0) UNSIGNED NOT NULL,
  `商家名称` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `状态` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '1表示在用，0表示停用',
  PRIMARY KEY (`商家id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 商家-仓库
-- ----------------------------
DROP TABLE IF EXISTS `商家-仓库`;
CREATE TABLE `商家-仓库`  (
  `商家id` int(0) UNSIGNED NOT NULL,
  `仓库id` int(0) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`商家id`) USING BTREE,
  INDEX `仓库id`(`仓库id`) USING BTREE,
  CONSTRAINT `商家-仓库_ibfk_1` FOREIGN KEY (`商家id`) REFERENCES `商家` (`商家id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `商家-仓库_ibfk_2` FOREIGN KEY (`仓库id`) REFERENCES `仓库` (`仓库id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 实时库存
-- ----------------------------
DROP TABLE IF EXISTS `实时库存`;
CREATE TABLE `实时库存`  (
  `仓库id` int(0) UNSIGNED NOT NULL,
  `商品id` int(0) UNSIGNED NOT NULL,
  `库存量` int(0) UNSIGNED NOT NULL,
  PRIMARY KEY (`仓库id`) USING BTREE,
  INDEX `商品id`(`商品id`) USING BTREE,
  CONSTRAINT `实时库存_ibfk_1` FOREIGN KEY (`仓库id`) REFERENCES `仓库` (`仓库id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `实时库存_ibfk_2` FOREIGN KEY (`商品id`) REFERENCES `商品` (`商品id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 收货信息
-- ----------------------------
DROP TABLE IF EXISTS `收货信息`;
CREATE TABLE `收货信息`  (
  `收货信息id` int(0) UNSIGNED NOT NULL,
  `用户id` int(0) UNSIGNED NOT NULL,
  `收货人` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `手机号` int(11) UNSIGNED ZEROFILL NOT NULL,
  `国家` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `省` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `市` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `区` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `详细地址` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`收货信息id`) USING BTREE,
  INDEX `用户id`(`用户id`) USING BTREE,
  CONSTRAINT `收货信息_ibfk_1` FOREIGN KEY (`用户id`) REFERENCES `用户` (`用户id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 欲购买
-- ----------------------------
DROP TABLE IF EXISTS `欲购买`;
CREATE TABLE `欲购买`  (
  `仓库id` int(0) UNSIGNED NOT NULL,
  `商品id` int(0) UNSIGNED NOT NULL,
  `欲购买量` int(0) UNSIGNED NOT NULL,
  `欲购买日期` date NOT NULL,
  PRIMARY KEY (`仓库id`) USING BTREE,
  INDEX `商品id`(`商品id`) USING BTREE,
  CONSTRAINT `欲购买_ibfk_1` FOREIGN KEY (`仓库id`) REFERENCES `仓库` (`仓库id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `欲购买_ibfk_2` FOREIGN KEY (`商品id`) REFERENCES `商品` (`商品id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 物流公司
-- ----------------------------
DROP TABLE IF EXISTS `物流公司`;
CREATE TABLE `物流公司`  (
  `物流公司id` int(0) UNSIGNED NOT NULL,
  `物流公司名称` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `联系电话` int(11) UNSIGNED ZEROFILL NULL DEFAULT NULL,
  PRIMARY KEY (`物流公司id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 用户
-- ----------------------------
DROP TABLE IF EXISTS `用户`;
CREATE TABLE `用户`  (
  `用户id` int(0) UNSIGNED NOT NULL,
  `用户名` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `生日` date NULL DEFAULT NULL,
  `邮箱` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `状态` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '1表示在用，0表示停用',
  `注册日期` date NULL DEFAULT NULL,
  PRIMARY KEY (`用户id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 订单
-- ----------------------------
DROP TABLE IF EXISTS `订单`;
CREATE TABLE `订单`  (
  `订单流水号` int(18) UNSIGNED ZEROFILL NOT NULL,
  `用户id` int(0) UNSIGNED NOT NULL,
  `商品id` int(0) UNSIGNED NOT NULL,
  `仓库id` int(0) UNSIGNED NOT NULL,
  `购买量` int(0) UNSIGNED NOT NULL,
  `下单日期` date NOT NULL,
  `收货日期` date NULL DEFAULT NULL,
  `物流公司id` int(0) UNSIGNED NULL DEFAULT NULL,
  `成交价格` int(0) UNSIGNED NOT NULL,
  `评星` enum('1','2','3','4','5') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `评论` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`订单流水号`) USING BTREE,
  INDEX `用户id`(`用户id`) USING BTREE,
  INDEX `商品id`(`商品id`) USING BTREE,
  INDEX `仓库id`(`仓库id`) USING BTREE,
  INDEX `物流公司id`(`物流公司id`) USING BTREE,
  CONSTRAINT `订单_ibfk_1` FOREIGN KEY (`用户id`) REFERENCES `用户` (`用户id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `订单_ibfk_2` FOREIGN KEY (`商品id`) REFERENCES `商品` (`商品id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `订单_ibfk_3` FOREIGN KEY (`仓库id`) REFERENCES `仓库` (`仓库id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `订单_ibfk_4` FOREIGN KEY (`物流公司id`) REFERENCES `物流公司` (`物流公司id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- View structure for 商家总评价
-- ----------------------------
DROP VIEW IF EXISTS `商家总评价`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `商家总评价` AS select `商家-仓库`.`商家id` AS `商家id`,avg(`订单`.`评星`) AS `平均评星`,avg((to_days(`订单`.`收货日期`) - to_days(`订单`.`下单日期`))) AS `平均物流时效` from (`商家-仓库` join `订单` on((`商家-仓库`.`仓库id` = `订单`.`仓库id`))) group by `商家-仓库`.`商家id` order by `平均评星`;

-- ----------------------------
-- View structure for 最近30天仓库供应量-销售量
-- ----------------------------
DROP VIEW IF EXISTS `最近30天仓库供应量-销售量`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `最近30天仓库供应量-销售量` AS select `temp1`.`仓库id` AS `仓库id`,`temp1`.`商品id` AS `商品id`,`temp1`.`供应总量` AS `供应总量`,`temp2`.`欲购买总量` AS `欲购买总量`,concat(round((((`temp1`.`供应总量` - `temp2`.`欲购买总量`) / `temp1`.`供应总量`) * 100),3),'%') AS `建议的供应变化率(%)` from ((select `供应`.`仓库id` AS `仓库id`,`供应`.`商品id` AS `商品id`,sum(`供应`.`供应量`) AS `供应总量` from `供应` where ((to_days(now()) - to_days(`供应`.`供应日期`)) <= 30) group by `供应`.`仓库id`,`供应`.`商品id`) `temp1` left join (select `欲购买`.`仓库id` AS `仓库id`,`欲购买`.`商品id` AS `商品id`,sum(`欲购买`.`欲购买量`) AS `欲购买总量` from `欲购买` where ((to_days(now()) - to_days(`欲购买`.`欲购买日期`)) <= 30) group by `欲购买`.`仓库id`,`欲购买`.`商品id`) `temp2` on(((`temp1`.`仓库id` = `temp2`.`仓库id`) and (`temp1`.`商品id` = `temp2`.`商品id`))));

-- ----------------------------
-- View structure for 物流公司时效
-- ----------------------------
DROP VIEW IF EXISTS `物流公司时效`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `物流公司时效` AS select `订单`.`物流公司id` AS `物流公司id`,(to_days(`订单`.`收货日期`) - to_days(`订单`.`下单日期`)) AS `平均物流时效` from `订单` order by (to_days(`订单`.`收货日期`) - to_days(`订单`.`下单日期`));

-- ----------------------------
-- View structure for 用户消费力
-- ----------------------------
DROP VIEW IF EXISTS `用户消费力`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `用户消费力` AS select `用户`.`用户id` AS `用户id`,`用户`.`注册日期` AS `注册日期`,`temp`.`消费总额` AS `消费总额`,(`temp`.`消费总额` / (to_days(now()) - to_days(`用户`.`注册日期`))) AS `日均消费额` from (`用户` join (select `订单`.`用户id` AS `用户id`,sum(`订单`.`成交价格`) AS `消费总额` from `订单` group by `订单`.`用户id` order by `订单`.`用户id`) `temp` on((`用户`.`用户id` = `temp`.`用户id`))) order by (`temp`.`消费总额` / (to_days(now()) - to_days(`用户`.`注册日期`))) desc;

SET FOREIGN_KEY_CHECKS = 1;
