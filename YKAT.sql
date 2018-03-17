/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : localhost
 Source Database       : YKAT

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : utf-8

 Date: 03/17/2018 20:01:54 PM
*/

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `ykat_bankcards`
-- ----------------------------
DROP TABLE IF EXISTS `ykat_bankcards`;
CREATE TABLE `ykat_bankcards` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `card_id` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '银行卡卡号',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '银行卡类型',
  `owner_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '所属人姓名',
  `owner_id_card` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '所属人身份证',
  `bank_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '银行名称',
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_card_id` (`card_id`) USING BTREE,
  CONSTRAINT `xk_user_id` FOREIGN KEY (`user_id`) REFERENCES `ykat_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `ykat_deposit_recharge_records`
-- ----------------------------
DROP TABLE IF EXISTS `ykat_deposit_recharge_records`;
CREATE TABLE `ykat_deposit_recharge_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `recharge_money` int(11) DEFAULT NULL COMMENT '补足金额',
  `recharge_time` datetime DEFAULT NULL COMMENT '补足时间',
  `store_id` int(11) DEFAULT NULL COMMENT '门店ID',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `current_money` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `bankcard_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_8` (`store_id`),
  KEY `fk_bankcard_id` (`bankcard_id`) USING BTREE,
  CONSTRAINT `FK_Reference_8` FOREIGN KEY (`store_id`) REFERENCES `ykat_stores` (`id`),
  CONSTRAINT `fk_bankcard_id` FOREIGN KEY (`bankcard_id`) REFERENCES `ykat_bankcards` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `ykat_drivers`
-- ----------------------------
DROP TABLE IF EXISTS `ykat_drivers`;
CREATE TABLE `ykat_drivers` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `balance` int(11) DEFAULT NULL COMMENT '余额',
  `driver_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '司机名称',
  `driver_phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '司机电话号',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `ykat_employee_relations`
-- ----------------------------
DROP TABLE IF EXISTS `ykat_employee_relations`;
CREATE TABLE `ykat_employee_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `employee_id` int(11) DEFAULT NULL COMMENT '雇员ID',
  `store_id` int(11) DEFAULT NULL COMMENT '门店ID',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_2` (`employee_id`),
  KEY `FK_Reference_3` (`store_id`),
  CONSTRAINT `FK_Reference_2` FOREIGN KEY (`employee_id`) REFERENCES `ykat_users` (`id`),
  CONSTRAINT `FK_Reference_3` FOREIGN KEY (`store_id`) REFERENCES `ykat_stores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `ykat_kbs`
-- ----------------------------
DROP TABLE IF EXISTS `ykat_kbs`;
CREATE TABLE `ykat_kbs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '知识名',
  `type` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '知识类型',
  `descp` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '知识描述',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `ykat_logs`
-- ----------------------------
DROP TABLE IF EXISTS `ykat_logs`;
CREATE TABLE `ykat_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `opt_usr_id` int(11) DEFAULT NULL COMMENT '操作者ID',
  `opt_type` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '操作类型',
  `opt_descp` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '操作内容',
  `operation_at` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_14` (`opt_usr_id`),
  CONSTRAINT `FK_Reference_14` FOREIGN KEY (`opt_usr_id`) REFERENCES `ykat_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=360 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `ykat_orders`
-- ----------------------------
DROP TABLE IF EXISTS `ykat_orders`;
CREATE TABLE `ykat_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '订单类型',
  `status` int(11) DEFAULT NULL COMMENT '订单状态',
  `order_id` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '订单号',
  `project_id` int(11) DEFAULT NULL COMMENT '项目编号',
  `store_id` int(11) DEFAULT NULL COMMENT '门店ID',
  `driver_id` int(11) DEFAULT NULL COMMENT '司机ID',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `ordered_at` datetime DEFAULT NULL COMMENT '预约时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `xk_order_id` (`order_id`),
  KEY `FK_Reference_11` (`store_id`),
  KEY `FK_Reference_12` (`driver_id`),
  KEY `FK_Reference_4` (`project_id`),
  CONSTRAINT `FK_Reference_11` FOREIGN KEY (`store_id`) REFERENCES `ykat_stores` (`id`),
  CONSTRAINT `FK_Reference_12` FOREIGN KEY (`driver_id`) REFERENCES `ykat_drivers` (`id`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`project_id`) REFERENCES `ykat_projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=319 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `ykat_projects`
-- ----------------------------
DROP TABLE IF EXISTS `ykat_projects`;
CREATE TABLE `ykat_projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `price` int(11) DEFAULT NULL COMMENT '项目价格',
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '项目类型',
  `descp` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '项目描述',
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xk_user_id` (`user_id`) USING BTREE,
  KEY `xk_type` (`type`) USING BTREE,
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `ykat_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `ykat_settle_account_records`
-- ----------------------------
DROP TABLE IF EXISTS `ykat_settle_account_records`;
CREATE TABLE `ykat_settle_account_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `set_acc_id` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '结算单号',
  `trade_money` int(11) DEFAULT NULL COMMENT '交易金额',
  `status` int(11) DEFAULT NULL COMMENT '结算状态',
  `traded_at` datetime DEFAULT NULL COMMENT '结算时间',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `order_id` int(11) DEFAULT NULL COMMENT '订单编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `xk_set_acc_id` (`set_acc_id`),
  KEY `FK_Reference_13` (`order_id`),
  CONSTRAINT `FK_Reference_13` FOREIGN KEY (`order_id`) REFERENCES `ykat_orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `ykat_stores`
-- ----------------------------
DROP TABLE IF EXISTS `ykat_stores`;
CREATE TABLE `ykat_stores` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `company_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '公司名称',
  `id_card` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '身份证号',
  `pic_head_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '身份证正面照URL',
  `pic_tail_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '身份证反面照URL',
  `service_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '服务类型',
  `location` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '位置信息',
  `user_id` int(11) DEFAULT NULL COMMENT 'user表ID',
  `deposit` int(11) DEFAULT NULL COMMENT '保证金总额',
  `reserve_phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备用电话',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_1` (`user_id`),
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`user_id`) REFERENCES `ykat_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `ykat_users`
-- ----------------------------
DROP TABLE IF EXISTS `ykat_users`;
CREATE TABLE `ykat_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '姓名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '密码',
  `role` int(11) DEFAULT NULL COMMENT '角色',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '电话',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `xk_phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;

-- ----------------------------
--  View structure for `order_info_v`
-- ----------------------------
DROP VIEW IF EXISTS `order_info_v`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_info_v` AS select `o`.`id` AS `id`,`o`.`order_id` AS `order_id`,`o`.`created_at` AS `order_created_at`,`o`.`ordered_at` AS `order_ordered_at`,`o`.`status` AS `order_status`,`o`.`type` AS `order_type`,`p`.`descp` AS `project_descp`,`p`.`price` AS `project_price`,`p`.`type` AS `project_type`,`d`.`driver_name` AS `driver_name`,`d`.`driver_phone` AS `driver_phone`,`s`.`company_name` AS `company_name`,`s`.`user_id` AS `user_id` from (((`ykat_orders` `o` join `ykat_projects` `p`) join `ykat_stores` `s`) join `ykat_drivers` `d`) where ((`o`.`project_id` = `p`.`id`) and (`o`.`driver_id` = `d`.`id`) and (`o`.`store_id` = `s`.`id`));

-- ----------------------------
--  Procedure structure for `genBillsNoPROC`
-- ----------------------------
DROP PROCEDURE IF EXISTS `genBillsNoPROC`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `genBillsNoPROC`(IN tableName VARCHAR(30),IN colName VARCHAR(30),OUT billsNoResult VARCHAR(100))
BEGIN   
  
DECLARE sql_2 VARCHAR(1000);   
  
DECLARE sql_4 VARCHAR(1000);   
DECLARE sql_5 VARCHAR(1000);  

  
SET sql_2 = CONCAT("select max(",colName,"),instr(max(",colName,"),DATE_FORMAT(NOW(),'%Y%m%d')) into @tableMaxValue,@sqlResult from ",tableName);  
#执行sql_2SQL语句;  
SET @second_sql=sql_2;   
PREPARE stmt2 FROM @second_sql;   
EXECUTE stmt2;   
  

  
#打印变量的值;  
SELECT @sqlResult;  
  
IF @sqlResult > 0 THEN  
    #根据最大的单号如:SP20140101001 单号前缀SP ，最大单号长度-单号前缀长度 = 数字部分 ->转成数字 +1生成下一个单号  
    SET sql_4 = CONCAT("select CONVERT(",@tableMaxValue,",SIGNED)+1 into @billsNo from dual");  
    #执行sql_4SQL语句;  
    SET @four_sql=sql_4;   
    PREPARE stmt4 FROM @four_sql;   
    EXECUTE stmt4;   
ELSE  
    SET sql_5 = CONCAT("SELECT concat(DATE_FORMAT(NOW(),'%Y%m%d'),'000001') into @billsNo from dual");   
    #执行sql_5SQL语句;  
    SET @five_sql=sql_5;   
    PREPARE stmt5 FROM @five_sql;   
    EXECUTE stmt5;   
END IF;  
  
#设置返回结果(单号前缀+数字部分如:20140410001);  
SET billsNoResult := @billsNo;
END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `insert_employee_relation_p`
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_employee_relation_p`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_employee_relation_p`(in userId INTEGER,in staffId INTEGER)
begin
	declare storeId integer;
	select id into storeId  from ykat_stores where user_id = userId;
	
	insert into ykat_employee_relations(employee_id,store_id) values (staffId,storeId);
end
 ;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
