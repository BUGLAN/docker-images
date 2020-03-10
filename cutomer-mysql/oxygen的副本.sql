/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : 127.0.0.1:3306
 Source Schema         : oxygen

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 25/10/2019 17:22:44
*/



SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE oxygen CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

use oxygen;

-- ----------------------------
-- Table structure for app_forward_records
-- ----------------------------
DROP TABLE IF EXISTS `app_forward_records`;
CREATE TABLE `app_forward_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '该服务对应事件',
  `token_field` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '该服务验证的token的对应字段',
  `app_id` int(11) NOT NULL COMMENT '关联 # oxygen.apps.id',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '注册的url',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `exchange_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `routing_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='事件回调 url app 映射表';

-- ----------------------------
-- Table structure for approval_records
-- ----------------------------
DROP TABLE IF EXISTS `approval_records`;
CREATE TABLE `approval_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NOT NULL COMMENT 'oxyge user id',
  `approval_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '审批类型 | 加班 | 请假 | 补卡',
  `approval_sub_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '子类型: 事假 | 周末加班等',
  `status` tinyint(4) NOT NULL COMMENT '审批状态 1通过, 2拒接, 3撤销, 4等待',
  `message_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '钉钉 返回过来的message_id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `type` int(11) DEFAULT NULL COMMENT '类型 1:加班 2:请假 3:补卡',
  `approval_start_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '审批开始时间',
  `approval_end_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '审批结束时间',
  `origin_message_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '钉钉 修改 更改 之后的 原始 message id',
  `biz_action` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '审批状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `approval_records_message_id_index` (`message_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23093 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of approval_records
-- ----------------------------
BEGIN;
INSERT INTO `approval_records` VALUES (23086, 35, '加班', '周末加班', 1, '0eb8c112-0c08-466f-ae76-35a21db38699', '2019-10-25 15:22:10', '2019-10-25 15:22:10', 1, '2019-10-19 12:00:00', '2019-10-19 23:59:59', NULL, 'NONE');
INSERT INTO `approval_records` VALUES (23087, 91, '补卡', '补卡: 下班时间18:00', 1, '3d5d3f50-329e-4c71-8f4e-fec0e7f9a729', '2019-10-25 15:22:11', '2019-10-25 15:22:11', 3, '2019-10-18 18:00:00', '2019-10-18 18:00:00', NULL, 'NONE');
INSERT INTO `approval_records` VALUES (23088, 91, '补卡', '补卡: 上班时间09:00', 1, '7c42505c-adad-43fd-9783-4eabfaf07c7f', '2019-10-25 15:22:12', '2019-10-25 15:22:12', 3, '2019-10-18 09:00:00', '2019-10-18 09:00:00', NULL, 'NONE');
INSERT INTO `approval_records` VALUES (23089, 35, '外出', '外出', 1, '460f72a0-8e16-451c-bde4-c3ab0035afef', '2019-10-25 15:22:14', '2019-10-25 15:22:14', 4, '2019-10-21 00:00:00', '2019-10-21 23:59:59', NULL, 'NONE');
INSERT INTO `approval_records` VALUES (23090, 91, '加班', '周末加班', 1, 'c9b87b6e-28f9-4c65-8e33-07ce6e3af958', '2019-10-25 15:23:21', '2019-10-25 15:23:21', 1, '2019-10-13 00:00:00', '2019-10-13 23:59:59', NULL, 'NONE');
INSERT INTO `approval_records` VALUES (23091, 35, '外出', '外出', 1, '64b1fffb-f218-4fa5-8a73-89f94e9d4d20', '2019-10-25 15:23:25', '2019-10-25 15:23:25', 4, '2019-10-14 00:00:00', '2019-10-18 23:59:59', NULL, 'NONE');
INSERT INTO `approval_records` VALUES (23092, 35, '外出', '外出', 1, 'f0073bcc-7b4a-42fb-bb47-765d5a79f406', '2019-10-25 15:23:26', '2019-10-25 15:23:26', 4, '2019-10-10 00:00:00', '2019-10-12 23:59:59', NULL, 'NONE');
COMMIT;

-- ----------------------------
-- Table structure for apps
-- ----------------------------
DROP TABLE IF EXISTS `apps`;
CREATE TABLE `apps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '服务方的描述',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '服务方的简称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='事件回调 注册服务表';

-- ----------------------------
-- Table structure for attendance_group
-- ----------------------------
DROP TABLE IF EXISTS `attendance_group`;
CREATE TABLE `attendance_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '考勤组名称',
  `attendance_type` int(11) DEFAULT NULL COMMENT '考勤类型',
  `cycles` int(11) DEFAULT NULL COMMENT '排班周期',
  `plan` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '排班计划',
  `min_attendance_days` int(11) DEFAULT NULL COMMENT '最低出勤天数',
  `shift_rule_id` int(11) DEFAULT NULL COMMENT '班次规则ID',
  `overtime_rule_id` int(11) DEFAULT NULL COMMENT '加班规则ID',
  `is_omit` tinyint(4) DEFAULT '1' COMMENT '是否允许普通管理人员删除',
  `is_edit` tinyint(4) DEFAULT '1' COMMENT '是否允许普通管理人员编辑',
  `table_code` int(11) DEFAULT '2000' COMMENT '表类型代码',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '删除标志',
  `application_record` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参与考勤部门人员记录',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='考勤组';

-- ----------------------------
-- Records of attendance_group
-- ----------------------------
BEGIN;
INSERT INTO `attendance_group` VALUES (74, '契约考勤组', 103, NULL, '1111111000', 21, 100, 88, 1, 1, 2000, '2019-06-16 15:23:57', '2019-09-09 15:28:33', 0, '|9||127, 119');
INSERT INTO `attendance_group` VALUES (75, '常规考勤组', 101, 7, '1111100', 0, 102, 88, 1, 1, 2000, '2019-06-16 15:24:04', '2019-10-25 15:47:48', 0, '2,3,4|8|119,127,200,215|71');
INSERT INTO `attendance_group` VALUES (76, 'AIBOSS考勤组', 104, NULL, '11111100', 21, 100, 88, 1, 1, 2000, '2019-06-16 15:24:16', '2019-09-09 15:28:33', 0, '|10||200,215');
COMMIT;

-- ----------------------------
-- Table structure for attendance_statistics_result
-- ----------------------------
DROP TABLE IF EXISTS `attendance_statistics_result`;
CREATE TABLE `attendance_statistics_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recorded_duration` datetime NOT NULL COMMENT '数据记录年月',
  `user_id` int(11) NOT NULL COMMENT '用户(员工)id',
  `user_name` varchar(31) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名字',
  `is_regular` tinyint(4) DEFAULT '0' COMMENT '是否是正式员工',
  `studio_id` int(11) NOT NULL COMMENT '工作室id',
  `attendance_id` int(11) NOT NULL COMMENT '考勤组ID',
  `job_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工号',
  `graduated_time` timestamp NULL DEFAULT NULL COMMENT '毕业时间',
  `hired_time` timestamp NULL DEFAULT NULL COMMENT '入职时间',
  `working_age` tinyint(4) DEFAULT NULL COMMENT '工龄',
  `atd_should_days` float DEFAULT '0' COMMENT '应出勤天数',
  `atd_actual_days` float DEFAULT '0' COMMENT '实际出勤天数',
  `atd_miss_on_duty` tinyint(4) DEFAULT '0' COMMENT '缺失早上打卡的次数',
  `atd_miss_off_duty` tinyint(4) DEFAULT '0' COMMENT '缺失的下午打卡次数',
  `atd_early_retirement` tinyint(4) DEFAULT '0' COMMENT '早退天数',
  `atd_absenteeism_and_lateness` tinyint(4) DEFAULT '0' COMMENT '旷工迟到天数',
  `atd_absenteeism_days` tinyint(4) DEFAULT '0' COMMENT '缺勤(旷工/翘班)天数',
  `annlv_apply` float DEFAULT '0' COMMENT '当月请年假天数',
  `annlv_actual_days` float DEFAULT '0' COMMENT '当年实际可休天数',
  `annlv_actual_residue` float DEFAULT '0' COMMENT '当年实际剩余年假天数',
  `annlv_last_residue` tinyint(4) DEFAULT '0' COMMENT '上一年转结年假剩余天数',
  `ot_weekend` float DEFAULT '0' COMMENT '周末加班天数',
  `ot_holiday` float DEFAULT '0' COMMENT '节假日加班天数',
  `ot_meal_subsidy` tinyint(4) DEFAULT '0' COMMENT '加班餐补次数',
  `linl_expired` float DEFAULT '0' COMMENT '结转工资调休天数',
  `linl_remaining` float DEFAULT '0' COMMENT '剩余调休天数',
  `linl_used` float DEFAULT '0' COMMENT '申请调休天数',
  `lvdt_detail` varchar(511) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请假记录',
  `is_delete` int(11) DEFAULT '0',
  `late_day_count` tinyint(4) DEFAULT '0' COMMENT '迟到天数',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `extra_detail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '{}' COMMENT '统计额外的细节信息',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16797 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for attendance_user_records
-- ----------------------------
DROP TABLE IF EXISTS `attendance_user_records`;
CREATE TABLE `attendance_user_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '考勤记录表主键',
  `user_id` int(11) NOT NULL COMMENT '用户表主键',
  `calendar_id` int(11) NOT NULL COMMENT '日历表主键',
  `date` timestamp NULL DEFAULT NULL COMMENT '当天时间帮助查询',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `work` tinyint(11) NOT NULL COMMENT '是否工作',
  `is_regular` tinyint(11) NOT NULL DEFAULT '0' COMMENT '0未知1正式2实习',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `calendar_id` (`calendar_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3469 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='考勤记录表';

-- ----------------------------
-- Table structure for attendance_user_results
-- ----------------------------
DROP TABLE IF EXISTS `attendance_user_results`;
CREATE TABLE `attendance_user_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `date` date DEFAULT NULL COMMENT '当天时间',
  `user_id` int(11) NOT NULL COMMENT 'oxygen.users.id',
  `work` int(11) NOT NULL DEFAULT '0' COMMENT '当天是否工作',
  `extra` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '额外属性',
  `attendance_id` int(11) NOT NULL COMMENT '考勤组id',
  `work_type` int(11) NOT NULL DEFAULT '1' COMMENT '工作类型 1正常, 2加班, 3调休, 4迟到, 5早退, 6外勤, 7请假',
  `shift_rule_id` int(11) NOT NULL,
  `overtime_rule_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `miss_state` tinyint(4) DEFAULT NULL COMMENT '缺卡状态，30， 31（上午）， 32（下午），33（全天）',
  `check_in_result` tinyint(4) DEFAULT NULL COMMENT '打卡结果',
  `extra_detail` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT '{}' COMMENT '每日考勤额外的细节信息|',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `union_date_id` (`user_id`,`date`,`attendance_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14322761 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='所有用户排班表';

-- ----------------------------
-- Records of attendance_user_results
-- ----------------------------
BEGIN;
INSERT INTO `attendance_user_results` VALUES (14322699, '2019-10-01', 35, 1, '正常(节假日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u8282\\u5047\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322700, '2019-10-02', 35, 1, '正常(节假日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u8282\\u5047\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322701, '2019-10-03', 35, 1, '正常(节假日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u8282\\u5047\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322702, '2019-10-04', 35, 3, '正常(休息日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u4f11\\u606f\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322703, '2019-10-05', 35, 3, '正常(休息日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u4f11\\u606f\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322704, '2019-10-06', 35, 3, '正常(休息日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u4f11\\u606f\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322705, '2019-10-07', 35, 3, '正常(休息日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u4f11\\u606f\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322706, '2019-10-08', 35, 0, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322707, '2019-10-09', 35, 0, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322708, '2019-10-10', 35, 0, '外出 全天', 75, 7, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"holiday_days\": [\"\\u5916\\u51fa \\u5168\\u5929\"], \"holiday_status\": 3, \"work_late\": {\"status\": 10, \"desc\": \"\\u5916\\u51fa \\u5168\\u5929\", \"work_type\": 7}}');
INSERT INTO `attendance_user_results` VALUES (14322709, '2019-10-11', 35, 0, '外出 全天', 75, 7, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"holiday_days\": [\"\\u5916\\u51fa \\u5168\\u5929\"], \"holiday_status\": 3, \"work_late\": {\"status\": 10, \"desc\": \"\\u5916\\u51fa \\u5168\\u5929\", \"work_type\": 7}}');
INSERT INTO `attendance_user_results` VALUES (14322710, '2019-10-12', 35, 2, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"holiday_days\": [\"\\u5916\\u51fa \\u5168\\u5929\"], \"holiday_status\": 3, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322711, '2019-10-13', 35, 3, '正常(休息日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u4f11\\u606f\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322712, '2019-10-14', 35, 0, '外出 全天', 75, 7, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"holiday_days\": [\"\\u5916\\u51fa \\u5168\\u5929\"], \"holiday_status\": 3, \"work_late\": {\"status\": 10, \"desc\": \"\\u5916\\u51fa \\u5168\\u5929\", \"work_type\": 7}}');
INSERT INTO `attendance_user_results` VALUES (14322713, '2019-10-15', 35, 0, '外出 全天', 75, 7, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"holiday_days\": [\"\\u5916\\u51fa \\u5168\\u5929\"], \"holiday_status\": 3, \"work_late\": {\"status\": 10, \"desc\": \"\\u5916\\u51fa \\u5168\\u5929\", \"work_type\": 7}}');
INSERT INTO `attendance_user_results` VALUES (14322714, '2019-10-16', 35, 0, '外出 全天', 75, 7, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"holiday_days\": [\"\\u5916\\u51fa \\u5168\\u5929\"], \"holiday_status\": 3, \"work_late\": {\"status\": 10, \"desc\": \"\\u5916\\u51fa \\u5168\\u5929\", \"work_type\": 7}}');
INSERT INTO `attendance_user_results` VALUES (14322715, '2019-10-17', 35, 0, '外出 全天', 75, 7, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"holiday_days\": [\"\\u5916\\u51fa \\u5168\\u5929\"], \"holiday_status\": 3, \"work_late\": {\"status\": 10, \"desc\": \"\\u5916\\u51fa \\u5168\\u5929\", \"work_type\": 7}}');
INSERT INTO `attendance_user_results` VALUES (14322716, '2019-10-18', 35, 0, '外出 全天', 75, 7, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"holiday_days\": [\"\\u5916\\u51fa \\u5168\\u5929\"], \"holiday_status\": 3, \"work_late\": {\"status\": 10, \"desc\": \"\\u5916\\u51fa \\u5168\\u5929\", \"work_type\": 7}}');
INSERT INTO `attendance_user_results` VALUES (14322717, '2019-10-19', 35, 3, '加班 半天', 75, 2, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', NULL, 20, '{\"early\": {}, \"late\": {}, \"work_late\": {\"desc\": \"\\u52a0\\u73ed \\u534a\\u5929\", \"work_type\": 2, \"status\": 20}}');
INSERT INTO `attendance_user_results` VALUES (14322718, '2019-10-20', 35, 3, '正常(休息日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u4f11\\u606f\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322719, '2019-10-21', 35, 0, '外出 全天', 75, 7, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"holiday_days\": [\"\\u5916\\u51fa \\u5168\\u5929\"], \"holiday_status\": 3, \"work_late\": {\"status\": 10, \"desc\": \"\\u5916\\u51fa \\u5168\\u5929\", \"work_type\": 7}}');
INSERT INTO `attendance_user_results` VALUES (14322720, '2019-10-22', 35, 0, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {\"level\": 2, \"time\": [\"4:30\", \"1:0\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322721, '2019-10-23', 35, 0, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322722, '2019-10-24', 35, 0, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {\"level\": 1, \"time\": [\"2:30\", \"0:30\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322723, '2019-10-25', 35, 0, '下班缺卡', 75, 11, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 32, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u4e0b\\u73ed\\u7f3a\\u5361\", \"work_type\": 11}}');
INSERT INTO `attendance_user_results` VALUES (14322724, '2019-10-26', 35, 3, '', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:20', NULL, NULL, '{}');
INSERT INTO `attendance_user_results` VALUES (14322725, '2019-10-27', 35, 3, '', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:20', NULL, NULL, '{}');
INSERT INTO `attendance_user_results` VALUES (14322726, '2019-10-28', 35, 0, '', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:20', NULL, NULL, '{}');
INSERT INTO `attendance_user_results` VALUES (14322727, '2019-10-29', 35, 0, '', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:20', NULL, NULL, '{}');
INSERT INTO `attendance_user_results` VALUES (14322728, '2019-10-30', 35, 0, '', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:20', NULL, NULL, '{}');
INSERT INTO `attendance_user_results` VALUES (14322729, '2019-10-31', 35, 0, '', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:20', NULL, NULL, '{}');
INSERT INTO `attendance_user_results` VALUES (14322730, '2019-10-01', 91, 1, '正常(节假日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u8282\\u5047\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322731, '2019-10-02', 91, 1, '正常(节假日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u8282\\u5047\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322732, '2019-10-03', 91, 1, '正常(节假日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u8282\\u5047\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322733, '2019-10-04', 91, 3, '正常(休息日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u4f11\\u606f\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322734, '2019-10-05', 91, 3, '正常(休息日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u4f11\\u606f\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322735, '2019-10-06', 91, 3, '正常(休息日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u4f11\\u606f\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322736, '2019-10-07', 91, 3, '正常(休息日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u4f11\\u606f\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322737, '2019-10-08', 91, 0, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {\"level\": 2, \"time\": [\"4:30\", \"1:0\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"status\": 11, \"time\": 27, \"level\": 0, \"desc\": \"\\u666e\\u901a\\u8fdf\\u5230 27\\u5206\\u949f\", \"work_type\": 4}}');
INSERT INTO `attendance_user_results` VALUES (14322738, '2019-10-09', 91, 0, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {\"level\": 2, \"time\": [\"4:30\", \"1:0\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"status\": 11, \"time\": 13, \"level\": 0, \"desc\": \"\\u666e\\u901a\\u8fdf\\u5230 13\\u5206\\u949f\", \"work_type\": 4}}');
INSERT INTO `attendance_user_results` VALUES (14322739, '2019-10-10', 91, 0, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {\"level\": 2, \"time\": [\"4:30\", \"1:0\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"status\": 11, \"time\": 4, \"level\": 0, \"desc\": \"\\u666e\\u901a\\u8fdf\\u5230 4\\u5206\\u949f\", \"work_type\": 4}}');
INSERT INTO `attendance_user_results` VALUES (14322740, '2019-10-11', 91, 0, '普通迟到 2分钟', 75, 4, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 11, '{\"early\": {}, \"late\": {\"level\": 2, \"time\": [\"4:30\", \"1:0\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"status\": 11, \"time\": 3, \"level\": 0, \"desc\": \"\\u666e\\u901a\\u8fdf\\u5230 3\\u5206\\u949f\", \"work_type\": 4}}');
INSERT INTO `attendance_user_results` VALUES (14322741, '2019-10-12', 91, 2, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {\"level\": 2, \"time\": [\"4:30\", \"1:0\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322742, '2019-10-13', 91, 3, '加班 全天', 75, 2, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', NULL, 20, '{\"early\": {}, \"late\": {\"level\": 2, \"time\": [\"4:30\", \"1:0\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"desc\": \"\\u52a0\\u73ed \\u5168\\u5929\", \"work_type\": 2, \"status\": 20}}');
INSERT INTO `attendance_user_results` VALUES (14322743, '2019-10-14', 91, 0, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {\"level\": 2, \"time\": [\"4:30\", \"1:0\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322744, '2019-10-15', 91, 0, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {\"level\": 3, \"time\": [\"6:30\", \"1:30\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322745, '2019-10-16', 91, 0, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {\"level\": 2, \"time\": [\"4:30\", \"1:0\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322746, '2019-10-17', 91, 0, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {\"level\": 1, \"time\": [\"2:30\", \"0:30\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322747, '2019-10-18', 91, 0, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322748, '2019-10-19', 91, 3, '正常(休息日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u4f11\\u606f\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322749, '2019-10-20', 91, 3, '正常(休息日)', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38(\\u4f11\\u606f\\u65e5)\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322750, '2019-10-21', 91, 0, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {\"level\": 2, \"time\": [\"4:30\", \"1:0\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322751, '2019-10-22', 91, 0, '正常', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 10, '{\"early\": {}, \"late\": {\"level\": 2, \"time\": [\"4:30\", \"1:0\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"status\": 10, \"desc\": \"\\u6b63\\u5e38\", \"work_type\": 1}}');
INSERT INTO `attendance_user_results` VALUES (14322752, '2019-10-23', 91, 0, '普通迟到 6分钟', 75, 4, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 11, '{\"early\": {}, \"late\": {\"level\": 2, \"time\": [\"4:30\", \"1:0\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"status\": 11, \"time\": 6, \"level\": 0, \"desc\": \"\\u666e\\u901a\\u8fdf\\u5230 6\\u5206\\u949f\", \"work_type\": 4}}');
INSERT INTO `attendance_user_results` VALUES (14322753, '2019-10-24', 91, 0, '普通迟到 1分钟', 75, 4, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 30, 11, '{\"early\": {}, \"late\": {\"level\": 2, \"time\": [\"4:30\", \"1:0\"], \"time_fmt\": \"%H:%M\"}, \"work_late\": {\"status\": 11, \"time\": 1, \"level\": 0, \"desc\": \"\\u666e\\u901a\\u8fdf\\u5230 1\\u5206\\u949f\", \"work_type\": 4}}');
INSERT INTO `attendance_user_results` VALUES (14322754, '2019-10-25', 91, 0, '下班缺卡', 75, 11, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:33', 32, 10, '{\"early\": {}, \"late\": {}, \"work_late\": {\"status\": 10, \"desc\": \"\\u4e0b\\u73ed\\u7f3a\\u5361\", \"work_type\": 11}}');
INSERT INTO `attendance_user_results` VALUES (14322755, '2019-10-26', 91, 3, '', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:20', NULL, NULL, '{}');
INSERT INTO `attendance_user_results` VALUES (14322756, '2019-10-27', 91, 3, '', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:20', NULL, NULL, '{}');
INSERT INTO `attendance_user_results` VALUES (14322757, '2019-10-28', 91, 0, '', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:20', NULL, NULL, '{}');
INSERT INTO `attendance_user_results` VALUES (14322758, '2019-10-29', 91, 0, '', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:20', NULL, NULL, '{}');
INSERT INTO `attendance_user_results` VALUES (14322759, '2019-10-30', 91, 0, '', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:20', NULL, NULL, '{}');
INSERT INTO `attendance_user_results` VALUES (14322760, '2019-10-31', 91, 0, '', 75, 1, 102, 88, '2019-10-25 17:15:20', '2019-10-25 17:15:20', NULL, NULL, '{}');
COMMIT;

-- ----------------------------
-- Table structure for calendars
-- ----------------------------
DROP TABLE IF EXISTS `calendars`;
CREATE TABLE `calendars` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日历 日期',
  `date_ymd` date NOT NULL COMMENT '当天日期: 年 月 日',
  `date_year` int(11) NOT NULL COMMENT '年',
  `date_month` int(11) NOT NULL COMMENT '月',
  `date_day` int(11) NOT NULL COMMENT '日',
  `weekday` int(11) NOT NULL COMMENT '周几',
  `holiday` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '节日显示',
  `date_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0：正常工作日 1：法定节假日 2：节假日调休补班 3: 休息日',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=366 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='日期表';

-- ----------------------------
-- Records of calendars
-- ----------------------------
BEGIN;
INSERT INTO `calendars` VALUES (1, '2019-01-01', 2019, 1, 1, 2, '元旦', 1, '2019-05-17 14:47:12', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (2, '2019-01-02', 2019, 1, 2, 3, NULL, 0, '2019-05-17 14:47:12', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (3, '2019-01-03', 2019, 1, 3, 4, NULL, 0, '2019-05-17 14:47:13', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (4, '2019-01-04', 2019, 1, 4, 5, NULL, 0, '2019-05-17 14:47:13', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (5, '2019-01-05', 2019, 1, 5, 6, NULL, 3, '2019-05-17 14:47:13', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (6, '2019-01-06', 2019, 1, 6, 7, NULL, 3, '2019-05-17 14:47:13', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (7, '2019-01-07', 2019, 1, 7, 1, NULL, 0, '2019-05-17 14:47:13', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (8, '2019-01-08', 2019, 1, 8, 2, NULL, 0, '2019-05-17 14:47:13', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (9, '2019-01-09', 2019, 1, 9, 3, NULL, 0, '2019-05-17 14:47:14', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (10, '2019-01-10', 2019, 1, 10, 4, NULL, 0, '2019-05-17 14:47:14', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (11, '2019-01-11', 2019, 1, 11, 5, NULL, 0, '2019-05-17 14:47:14', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (12, '2019-01-12', 2019, 1, 12, 6, NULL, 3, '2019-05-17 14:47:14', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (13, '2019-01-13', 2019, 1, 13, 7, NULL, 3, '2019-05-17 14:47:14', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (14, '2019-01-14', 2019, 1, 14, 1, NULL, 0, '2019-05-17 14:47:14', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (15, '2019-01-15', 2019, 1, 15, 2, NULL, 0, '2019-05-17 14:47:15', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (16, '2019-01-16', 2019, 1, 16, 3, NULL, 0, '2019-05-17 14:47:15', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (17, '2019-01-17', 2019, 1, 17, 4, NULL, 0, '2019-05-17 14:47:15', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (18, '2019-01-18', 2019, 1, 18, 5, NULL, 0, '2019-05-17 14:47:15', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (19, '2019-01-19', 2019, 1, 19, 6, NULL, 3, '2019-05-17 14:47:15', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (20, '2019-01-20', 2019, 1, 20, 7, NULL, 3, '2019-05-17 14:47:15', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (21, '2019-01-21', 2019, 1, 21, 1, NULL, 0, '2019-05-17 14:47:15', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (22, '2019-01-22', 2019, 1, 22, 2, NULL, 0, '2019-05-17 14:47:15', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (23, '2019-01-23', 2019, 1, 23, 3, NULL, 0, '2019-05-17 14:47:16', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (24, '2019-01-24', 2019, 1, 24, 4, NULL, 0, '2019-05-17 14:47:17', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (25, '2019-01-25', 2019, 1, 25, 5, NULL, 0, '2019-05-17 14:47:17', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (26, '2019-01-26', 2019, 1, 26, 6, NULL, 3, '2019-05-17 14:47:17', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (27, '2019-01-27', 2019, 1, 27, 7, NULL, 3, '2019-05-17 14:47:17', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (28, '2019-01-28', 2019, 1, 28, 1, NULL, 0, '2019-05-17 14:47:17', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (29, '2019-01-29', 2019, 1, 29, 2, NULL, 0, '2019-05-17 14:47:17', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (30, '2019-01-30', 2019, 1, 30, 3, NULL, 0, '2019-05-17 14:47:18', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (31, '2019-01-31', 2019, 1, 31, 4, NULL, 0, '2019-05-17 14:47:18', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (32, '2019-02-01', 2019, 2, 1, 5, NULL, 0, '2019-05-17 14:47:18', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (33, '2019-02-02', 2019, 2, 2, 6, NULL, 2, '2019-05-17 14:47:18', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (34, '2019-02-03', 2019, 2, 3, 7, NULL, 2, '2019-05-17 14:47:18', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (35, '2019-02-04', 2019, 2, 4, 1, NULL, 3, '2019-05-17 14:47:18', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (36, '2019-02-05', 2019, 2, 5, 2, '春节', 1, '2019-05-17 14:47:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (37, '2019-02-06', 2019, 2, 6, 3, '春节', 1, '2019-05-17 14:47:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (38, '2019-02-07', 2019, 2, 7, 4, '春节', 1, '2019-05-17 14:47:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (39, '2019-02-08', 2019, 2, 8, 5, NULL, 3, '2019-05-17 14:47:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (40, '2019-02-09', 2019, 2, 9, 6, NULL, 3, '2019-05-17 14:47:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (41, '2019-02-10', 2019, 2, 10, 7, NULL, 3, '2019-05-17 14:47:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (42, '2019-02-11', 2019, 2, 11, 1, NULL, 0, '2019-05-17 14:47:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (43, '2019-02-12', 2019, 2, 12, 2, NULL, 0, '2019-05-17 14:47:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (44, '2019-02-13', 2019, 2, 13, 3, NULL, 0, '2019-05-17 14:47:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (45, '2019-02-14', 2019, 2, 14, 4, NULL, 0, '2019-05-17 14:47:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (46, '2019-02-15', 2019, 2, 15, 5, NULL, 0, '2019-05-17 14:47:20', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (47, '2019-02-16', 2019, 2, 16, 6, NULL, 3, '2019-05-17 14:47:20', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (48, '2019-02-17', 2019, 2, 17, 7, NULL, 3, '2019-05-17 14:47:20', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (49, '2019-02-18', 2019, 2, 18, 1, NULL, 0, '2019-05-17 14:47:20', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (50, '2019-02-19', 2019, 2, 19, 2, NULL, 0, '2019-05-17 14:47:20', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (51, '2019-02-20', 2019, 2, 20, 3, NULL, 0, '2019-05-17 14:47:21', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (52, '2019-02-21', 2019, 2, 21, 4, NULL, 0, '2019-05-17 14:47:21', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (53, '2019-02-22', 2019, 2, 22, 5, NULL, 0, '2019-05-17 14:47:21', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (54, '2019-02-23', 2019, 2, 23, 6, NULL, 3, '2019-05-17 14:47:21', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (55, '2019-02-24', 2019, 2, 24, 7, NULL, 3, '2019-05-17 14:47:21', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (56, '2019-02-25', 2019, 2, 25, 1, NULL, 0, '2019-05-17 14:47:21', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (57, '2019-02-26', 2019, 2, 26, 2, NULL, 0, '2019-05-17 14:47:21', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (58, '2019-02-27', 2019, 2, 27, 3, NULL, 0, '2019-05-17 14:47:21', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (59, '2019-02-28', 2019, 2, 28, 4, NULL, 0, '2019-05-17 14:47:21', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (60, '2019-03-01', 2019, 3, 1, 5, NULL, 0, '2019-05-17 14:47:22', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (61, '2019-03-02', 2019, 3, 2, 6, NULL, 3, '2019-05-17 14:47:22', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (62, '2019-03-03', 2019, 3, 3, 7, NULL, 3, '2019-05-17 14:47:22', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (63, '2019-03-04', 2019, 3, 4, 1, NULL, 0, '2019-05-17 14:47:22', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (64, '2019-03-05', 2019, 3, 5, 2, NULL, 0, '2019-05-17 14:47:22', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (65, '2019-03-06', 2019, 3, 6, 3, NULL, 0, '2019-05-17 14:47:22', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (66, '2019-03-07', 2019, 3, 7, 4, NULL, 0, '2019-05-17 14:47:22', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (67, '2019-03-08', 2019, 3, 8, 5, NULL, 0, '2019-05-17 14:47:23', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (68, '2019-03-09', 2019, 3, 9, 6, NULL, 3, '2019-05-17 14:47:23', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (69, '2019-03-10', 2019, 3, 10, 7, NULL, 3, '2019-05-17 14:47:23', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (70, '2019-03-11', 2019, 3, 11, 1, NULL, 0, '2019-05-17 14:47:24', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (71, '2019-03-12', 2019, 3, 12, 2, NULL, 0, '2019-05-17 14:47:24', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (72, '2019-03-13', 2019, 3, 13, 3, NULL, 0, '2019-05-17 14:47:24', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (73, '2019-03-14', 2019, 3, 14, 4, NULL, 0, '2019-05-17 14:47:24', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (74, '2019-03-15', 2019, 3, 15, 5, NULL, 0, '2019-05-17 14:47:24', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (75, '2019-03-16', 2019, 3, 16, 6, NULL, 3, '2019-05-17 14:47:24', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (76, '2019-03-17', 2019, 3, 17, 7, NULL, 3, '2019-05-17 14:47:24', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (77, '2019-03-18', 2019, 3, 18, 1, NULL, 0, '2019-05-17 14:47:25', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (78, '2019-03-19', 2019, 3, 19, 2, NULL, 0, '2019-05-17 14:47:25', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (79, '2019-03-20', 2019, 3, 20, 3, NULL, 0, '2019-05-17 14:47:25', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (80, '2019-03-21', 2019, 3, 21, 4, NULL, 0, '2019-05-17 14:47:25', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (81, '2019-03-22', 2019, 3, 22, 5, NULL, 0, '2019-05-17 14:47:25', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (82, '2019-03-23', 2019, 3, 23, 6, NULL, 3, '2019-05-17 14:47:25', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (83, '2019-03-24', 2019, 3, 24, 7, NULL, 3, '2019-05-17 14:47:26', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (84, '2019-03-25', 2019, 3, 25, 1, NULL, 0, '2019-05-17 14:47:26', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (85, '2019-03-26', 2019, 3, 26, 2, NULL, 0, '2019-05-17 14:47:26', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (86, '2019-03-27', 2019, 3, 27, 3, NULL, 0, '2019-05-17 14:47:26', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (87, '2019-03-28', 2019, 3, 28, 4, NULL, 0, '2019-05-17 14:47:26', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (88, '2019-03-29', 2019, 3, 29, 5, NULL, 0, '2019-05-17 14:47:26', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (89, '2019-03-30', 2019, 3, 30, 6, NULL, 3, '2019-05-17 14:47:26', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (90, '2019-03-31', 2019, 3, 31, 7, NULL, 3, '2019-05-17 14:47:27', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (91, '2019-04-01', 2019, 4, 1, 1, NULL, 0, '2019-05-17 14:47:27', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (92, '2019-04-02', 2019, 4, 2, 2, NULL, 0, '2019-05-17 14:47:27', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (93, '2019-04-03', 2019, 4, 3, 3, NULL, 0, '2019-05-17 14:47:27', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (94, '2019-04-04', 2019, 4, 4, 4, NULL, 0, '2019-05-17 14:47:27', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (95, '2019-04-05', 2019, 4, 5, 5, '清明', 1, '2019-05-17 14:47:27', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (96, '2019-04-06', 2019, 4, 6, 6, NULL, 3, '2019-05-17 14:47:28', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (97, '2019-04-07', 2019, 4, 7, 7, NULL, 3, '2019-05-17 14:47:28', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (98, '2019-04-08', 2019, 4, 8, 1, NULL, 0, '2019-05-17 14:47:28', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (99, '2019-04-09', 2019, 4, 9, 2, NULL, 0, '2019-05-17 14:47:28', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (100, '2019-04-10', 2019, 4, 10, 3, NULL, 0, '2019-05-17 14:47:28', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (101, '2019-04-11', 2019, 4, 11, 4, NULL, 0, '2019-05-17 14:47:28', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (102, '2019-04-12', 2019, 4, 12, 5, NULL, 0, '2019-05-17 14:47:28', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (103, '2019-04-13', 2019, 4, 13, 6, NULL, 3, '2019-05-17 14:47:28', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (104, '2019-04-14', 2019, 4, 14, 7, NULL, 3, '2019-05-17 14:47:28', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (105, '2019-04-15', 2019, 4, 15, 1, NULL, 0, '2019-05-17 14:47:29', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (106, '2019-04-16', 2019, 4, 16, 2, NULL, 0, '2019-05-17 14:47:29', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (107, '2019-04-17', 2019, 4, 17, 3, NULL, 0, '2019-05-17 14:47:29', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (108, '2019-04-18', 2019, 4, 18, 4, NULL, 0, '2019-05-17 14:47:29', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (109, '2019-04-19', 2019, 4, 19, 5, NULL, 0, '2019-05-17 14:47:29', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (110, '2019-04-20', 2019, 4, 20, 6, NULL, 3, '2019-05-17 14:47:30', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (111, '2019-04-21', 2019, 4, 21, 7, NULL, 3, '2019-05-17 14:47:30', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (112, '2019-04-22', 2019, 4, 22, 1, NULL, 0, '2019-05-17 14:47:30', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (113, '2019-04-23', 2019, 4, 23, 2, NULL, 0, '2019-05-17 14:47:30', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (114, '2019-04-24', 2019, 4, 24, 3, NULL, 0, '2019-05-17 14:47:30', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (115, '2019-04-25', 2019, 4, 25, 4, NULL, 0, '2019-05-17 14:47:31', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (116, '2019-04-26', 2019, 4, 26, 5, NULL, 0, '2019-05-17 14:47:31', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (117, '2019-04-27', 2019, 4, 27, 6, NULL, 3, '2019-05-17 14:47:31', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (118, '2019-04-28', 2019, 4, 28, 7, NULL, 2, '2019-05-17 14:47:31', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (119, '2019-04-29', 2019, 4, 29, 1, NULL, 0, '2019-05-17 14:47:31', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (120, '2019-04-30', 2019, 4, 30, 2, NULL, 0, '2019-05-17 14:47:31', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (121, '2019-05-01', 2019, 5, 1, 3, '劳动节', 1, '2019-05-17 14:47:31', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (122, '2019-05-02', 2019, 5, 2, 4, NULL, 3, '2019-05-17 14:47:32', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (123, '2019-05-03', 2019, 5, 3, 5, NULL, 3, '2019-05-17 14:47:32', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (124, '2019-05-04', 2019, 5, 4, 6, NULL, 3, '2019-05-17 14:47:32', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (125, '2019-05-05', 2019, 5, 5, 7, NULL, 2, '2019-05-17 14:47:32', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (126, '2019-05-06', 2019, 5, 6, 1, NULL, 0, '2019-05-17 14:47:32', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (127, '2019-05-07', 2019, 5, 7, 2, NULL, 0, '2019-05-17 14:47:33', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (128, '2019-05-08', 2019, 5, 8, 3, NULL, 0, '2019-05-17 14:47:33', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (129, '2019-05-09', 2019, 5, 9, 4, NULL, 0, '2019-05-17 14:47:33', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (130, '2019-05-10', 2019, 5, 10, 5, NULL, 0, '2019-05-17 14:47:33', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (131, '2019-05-11', 2019, 5, 11, 6, NULL, 3, '2019-05-17 14:47:33', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (132, '2019-05-12', 2019, 5, 12, 7, NULL, 3, '2019-05-17 14:47:33', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (133, '2019-05-13', 2019, 5, 13, 1, NULL, 0, '2019-05-17 14:47:34', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (134, '2019-05-14', 2019, 5, 14, 2, NULL, 0, '2019-05-17 14:47:34', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (135, '2019-05-15', 2019, 5, 15, 3, NULL, 0, '2019-05-17 14:47:35', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (136, '2019-05-16', 2019, 5, 16, 4, NULL, 0, '2019-05-17 14:47:35', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (137, '2019-05-17', 2019, 5, 17, 5, NULL, 0, '2019-05-17 14:47:35', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (138, '2019-05-18', 2019, 5, 18, 6, NULL, 3, '2019-05-17 14:47:36', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (139, '2019-05-19', 2019, 5, 19, 7, NULL, 3, '2019-05-17 14:47:36', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (140, '2019-05-20', 2019, 5, 20, 1, NULL, 0, '2019-05-17 14:47:36', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (141, '2019-05-21', 2019, 5, 21, 2, NULL, 0, '2019-05-17 14:47:36', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (142, '2019-05-22', 2019, 5, 22, 3, NULL, 0, '2019-05-17 14:47:36', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (143, '2019-05-23', 2019, 5, 23, 4, NULL, 0, '2019-05-17 14:47:36', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (144, '2019-05-24', 2019, 5, 24, 5, NULL, 0, '2019-05-17 14:47:37', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (145, '2019-05-25', 2019, 5, 25, 6, NULL, 3, '2019-05-17 14:47:37', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (146, '2019-05-26', 2019, 5, 26, 7, NULL, 3, '2019-05-17 14:47:38', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (147, '2019-05-27', 2019, 5, 27, 1, NULL, 0, '2019-05-17 14:47:39', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (148, '2019-05-28', 2019, 5, 28, 2, NULL, 0, '2019-05-17 14:47:39', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (149, '2019-05-29', 2019, 5, 29, 3, NULL, 0, '2019-05-17 14:47:40', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (150, '2019-05-30', 2019, 5, 30, 4, NULL, 0, '2019-05-17 14:47:40', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (151, '2019-05-31', 2019, 5, 31, 5, NULL, 0, '2019-05-17 14:47:40', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (152, '2019-06-01', 2019, 6, 1, 6, NULL, 3, '2019-05-17 14:47:40', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (153, '2019-06-02', 2019, 6, 2, 7, NULL, 3, '2019-05-17 14:47:40', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (154, '2019-06-03', 2019, 6, 3, 1, NULL, 0, '2019-05-17 14:47:41', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (155, '2019-06-04', 2019, 6, 4, 2, NULL, 0, '2019-05-17 14:47:42', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (156, '2019-06-05', 2019, 6, 5, 3, NULL, 0, '2019-05-17 14:47:43', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (157, '2019-06-06', 2019, 6, 6, 4, NULL, 0, '2019-05-17 14:47:43', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (158, '2019-06-07', 2019, 6, 7, 5, '端午节', 1, '2019-05-17 14:47:43', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (159, '2019-06-08', 2019, 6, 8, 6, NULL, 3, '2019-05-17 14:47:43', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (160, '2019-06-09', 2019, 6, 9, 7, NULL, 3, '2019-05-17 14:47:44', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (161, '2019-06-10', 2019, 6, 10, 1, NULL, 0, '2019-05-17 14:47:44', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (162, '2019-06-11', 2019, 6, 11, 2, NULL, 0, '2019-05-17 14:47:44', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (163, '2019-06-12', 2019, 6, 12, 3, NULL, 0, '2019-05-17 14:47:44', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (164, '2019-06-13', 2019, 6, 13, 4, NULL, 0, '2019-05-17 14:47:45', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (165, '2019-06-14', 2019, 6, 14, 5, NULL, 0, '2019-05-17 14:47:45', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (166, '2019-06-15', 2019, 6, 15, 6, NULL, 3, '2019-05-17 14:47:45', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (167, '2019-06-16', 2019, 6, 16, 7, NULL, 3, '2019-05-17 14:47:45', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (168, '2019-06-17', 2019, 6, 17, 1, NULL, 0, '2019-05-17 14:47:45', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (169, '2019-06-18', 2019, 6, 18, 2, NULL, 0, '2019-05-17 14:47:45', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (170, '2019-06-19', 2019, 6, 19, 3, NULL, 0, '2019-05-17 14:47:46', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (171, '2019-06-20', 2019, 6, 20, 4, NULL, 0, '2019-05-17 14:47:46', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (172, '2019-06-21', 2019, 6, 21, 5, NULL, 0, '2019-05-17 14:47:46', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (173, '2019-06-22', 2019, 6, 22, 6, NULL, 3, '2019-05-17 14:47:47', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (174, '2019-06-23', 2019, 6, 23, 7, NULL, 3, '2019-05-17 14:47:47', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (175, '2019-06-24', 2019, 6, 24, 1, NULL, 0, '2019-05-17 14:47:47', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (176, '2019-06-25', 2019, 6, 25, 2, NULL, 0, '2019-05-17 14:47:47', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (177, '2019-06-26', 2019, 6, 26, 3, NULL, 0, '2019-05-17 14:47:48', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (178, '2019-06-27', 2019, 6, 27, 4, NULL, 0, '2019-05-17 14:47:48', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (179, '2019-06-28', 2019, 6, 28, 5, NULL, 0, '2019-05-17 14:47:48', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (180, '2019-06-29', 2019, 6, 29, 6, NULL, 3, '2019-05-17 14:47:48', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (181, '2019-06-30', 2019, 6, 30, 7, NULL, 3, '2019-05-17 14:47:48', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (182, '2019-07-01', 2019, 7, 1, 1, NULL, 0, '2019-05-17 14:47:48', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (183, '2019-07-02', 2019, 7, 2, 2, NULL, 0, '2019-05-17 14:47:49', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (184, '2019-07-03', 2019, 7, 3, 3, NULL, 0, '2019-05-17 14:47:49', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (185, '2019-07-04', 2019, 7, 4, 4, NULL, 0, '2019-05-17 14:47:49', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (186, '2019-07-05', 2019, 7, 5, 5, NULL, 0, '2019-05-17 14:47:49', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (187, '2019-07-06', 2019, 7, 6, 6, NULL, 3, '2019-05-17 14:47:50', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (188, '2019-07-07', 2019, 7, 7, 7, NULL, 3, '2019-05-17 14:47:50', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (189, '2019-07-08', 2019, 7, 8, 1, NULL, 0, '2019-05-17 14:47:50', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (190, '2019-07-09', 2019, 7, 9, 2, NULL, 0, '2019-05-17 14:47:50', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (191, '2019-07-10', 2019, 7, 10, 3, NULL, 0, '2019-05-17 14:47:50', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (192, '2019-07-11', 2019, 7, 11, 4, NULL, 0, '2019-05-17 14:47:51', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (193, '2019-07-12', 2019, 7, 12, 5, NULL, 0, '2019-05-17 14:47:51', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (194, '2019-07-13', 2019, 7, 13, 6, NULL, 3, '2019-05-17 14:47:51', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (195, '2019-07-14', 2019, 7, 14, 7, NULL, 3, '2019-05-17 14:47:51', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (196, '2019-07-15', 2019, 7, 15, 1, NULL, 0, '2019-05-17 14:47:51', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (197, '2019-07-16', 2019, 7, 16, 2, NULL, 0, '2019-05-17 14:47:52', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (198, '2019-07-17', 2019, 7, 17, 3, NULL, 0, '2019-05-17 14:47:52', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (199, '2019-07-18', 2019, 7, 18, 4, NULL, 0, '2019-05-17 14:47:52', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (200, '2019-07-19', 2019, 7, 19, 5, NULL, 0, '2019-05-17 14:47:52', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (201, '2019-07-20', 2019, 7, 20, 6, NULL, 3, '2019-05-17 14:47:52', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (202, '2019-07-21', 2019, 7, 21, 7, NULL, 3, '2019-05-17 14:47:52', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (203, '2019-07-22', 2019, 7, 22, 1, NULL, 0, '2019-05-17 14:47:53', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (204, '2019-07-23', 2019, 7, 23, 2, NULL, 0, '2019-05-17 14:47:53', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (205, '2019-07-24', 2019, 7, 24, 3, NULL, 0, '2019-05-17 14:47:53', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (206, '2019-07-25', 2019, 7, 25, 4, NULL, 0, '2019-05-17 14:47:53', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (207, '2019-07-26', 2019, 7, 26, 5, NULL, 0, '2019-05-17 14:47:53', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (208, '2019-07-27', 2019, 7, 27, 6, NULL, 3, '2019-05-17 14:47:53', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (209, '2019-07-28', 2019, 7, 28, 7, NULL, 3, '2019-05-17 14:47:54', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (210, '2019-07-29', 2019, 7, 29, 1, NULL, 0, '2019-05-17 14:47:54', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (211, '2019-07-30', 2019, 7, 30, 2, NULL, 0, '2019-05-17 14:47:54', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (212, '2019-07-31', 2019, 7, 31, 3, NULL, 0, '2019-05-17 14:47:56', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (213, '2019-08-01', 2019, 8, 1, 4, NULL, 0, '2019-05-17 14:47:56', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (214, '2019-08-02', 2019, 8, 2, 5, NULL, 0, '2019-05-17 14:47:57', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (215, '2019-08-03', 2019, 8, 3, 6, NULL, 3, '2019-05-17 14:47:58', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (216, '2019-08-04', 2019, 8, 4, 7, NULL, 3, '2019-05-17 14:47:58', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (217, '2019-08-05', 2019, 8, 5, 1, NULL, 0, '2019-05-17 14:47:58', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (218, '2019-08-06', 2019, 8, 6, 2, NULL, 0, '2019-05-17 14:47:58', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (219, '2019-08-07', 2019, 8, 7, 3, NULL, 0, '2019-05-17 14:47:59', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (220, '2019-08-08', 2019, 8, 8, 4, NULL, 0, '2019-05-17 14:48:00', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (221, '2019-08-09', 2019, 8, 9, 5, NULL, 0, '2019-05-17 14:48:00', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (222, '2019-08-10', 2019, 8, 10, 6, NULL, 3, '2019-05-17 14:48:01', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (223, '2019-08-11', 2019, 8, 11, 7, NULL, 3, '2019-05-17 14:48:01', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (224, '2019-08-12', 2019, 8, 12, 1, NULL, 0, '2019-05-17 14:48:02', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (225, '2019-08-13', 2019, 8, 13, 2, NULL, 0, '2019-05-17 14:48:02', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (226, '2019-08-14', 2019, 8, 14, 3, NULL, 0, '2019-05-17 14:48:03', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (227, '2019-08-15', 2019, 8, 15, 4, NULL, 0, '2019-05-17 14:48:03', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (228, '2019-08-16', 2019, 8, 16, 5, NULL, 0, '2019-05-17 14:48:03', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (229, '2019-08-17', 2019, 8, 17, 6, NULL, 3, '2019-05-17 14:48:03', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (230, '2019-08-18', 2019, 8, 18, 7, NULL, 3, '2019-05-17 14:48:03', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (231, '2019-08-19', 2019, 8, 19, 1, NULL, 0, '2019-05-17 14:48:04', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (232, '2019-08-20', 2019, 8, 20, 2, NULL, 0, '2019-05-17 14:48:04', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (233, '2019-08-21', 2019, 8, 21, 3, NULL, 0, '2019-05-17 14:48:04', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (234, '2019-08-22', 2019, 8, 22, 4, NULL, 0, '2019-05-17 14:48:04', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (235, '2019-08-23', 2019, 8, 23, 5, NULL, 0, '2019-05-17 14:48:05', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (236, '2019-08-24', 2019, 8, 24, 6, NULL, 3, '2019-05-17 14:48:05', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (237, '2019-08-25', 2019, 8, 25, 7, NULL, 3, '2019-05-17 14:48:05', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (238, '2019-08-26', 2019, 8, 26, 1, NULL, 0, '2019-05-17 14:48:05', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (239, '2019-08-27', 2019, 8, 27, 2, NULL, 0, '2019-05-17 14:48:06', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (240, '2019-08-28', 2019, 8, 28, 3, NULL, 0, '2019-05-17 14:48:06', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (241, '2019-08-29', 2019, 8, 29, 4, NULL, 0, '2019-05-17 14:48:06', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (242, '2019-08-30', 2019, 8, 30, 5, NULL, 0, '2019-05-17 14:48:06', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (243, '2019-08-31', 2019, 8, 31, 6, NULL, 3, '2019-05-17 14:48:07', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (244, '2019-09-01', 2019, 9, 1, 7, NULL, 3, '2019-05-17 14:48:07', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (245, '2019-09-02', 2019, 9, 2, 1, NULL, 0, '2019-05-17 14:48:07', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (246, '2019-09-03', 2019, 9, 3, 2, NULL, 0, '2019-05-17 14:48:08', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (247, '2019-09-04', 2019, 9, 4, 3, NULL, 0, '2019-05-17 14:48:08', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (248, '2019-09-05', 2019, 9, 5, 4, NULL, 0, '2019-05-17 14:48:08', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (249, '2019-09-06', 2019, 9, 6, 5, NULL, 0, '2019-05-17 14:48:09', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (250, '2019-09-07', 2019, 9, 7, 6, NULL, 3, '2019-05-17 14:48:09', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (251, '2019-09-08', 2019, 9, 8, 7, NULL, 3, '2019-05-17 14:48:09', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (252, '2019-09-09', 2019, 9, 9, 1, NULL, 0, '2019-05-17 14:48:09', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (253, '2019-09-10', 2019, 9, 10, 2, NULL, 0, '2019-05-17 14:48:09', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (254, '2019-09-11', 2019, 9, 11, 3, NULL, 0, '2019-05-17 14:48:09', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (255, '2019-09-12', 2019, 9, 12, 4, NULL, 0, '2019-05-17 14:48:10', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (256, '2019-09-13', 2019, 9, 13, 5, '中秋节', 1, '2019-05-17 14:48:10', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (257, '2019-09-14', 2019, 9, 14, 6, NULL, 3, '2019-05-17 14:48:10', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (258, '2019-09-15', 2019, 9, 15, 7, NULL, 3, '2019-05-17 14:48:10', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (259, '2019-09-16', 2019, 9, 16, 1, NULL, 0, '2019-05-17 14:48:10', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (260, '2019-09-17', 2019, 9, 17, 2, NULL, 0, '2019-05-17 14:48:10', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (261, '2019-09-18', 2019, 9, 18, 3, NULL, 0, '2019-05-17 14:48:11', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (262, '2019-09-19', 2019, 9, 19, 4, NULL, 0, '2019-05-17 14:48:11', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (263, '2019-09-20', 2019, 9, 20, 5, NULL, 0, '2019-05-17 14:48:11', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (264, '2019-09-21', 2019, 9, 21, 6, NULL, 3, '2019-05-17 14:48:11', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (265, '2019-09-22', 2019, 9, 22, 7, NULL, 3, '2019-05-17 14:48:11', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (266, '2019-09-23', 2019, 9, 23, 1, NULL, 0, '2019-05-17 14:48:11', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (267, '2019-09-24', 2019, 9, 24, 2, NULL, 0, '2019-05-17 14:48:12', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (268, '2019-09-25', 2019, 9, 25, 3, NULL, 0, '2019-05-17 14:48:12', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (269, '2019-09-26', 2019, 9, 26, 4, NULL, 0, '2019-05-17 14:48:12', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (270, '2019-09-27', 2019, 9, 27, 5, NULL, 0, '2019-05-17 14:48:12', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (271, '2019-09-28', 2019, 9, 28, 6, NULL, 3, '2019-05-17 14:48:12', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (272, '2019-09-29', 2019, 9, 29, 7, NULL, 2, '2019-05-17 14:48:13', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (273, '2019-09-30', 2019, 9, 30, 1, NULL, 0, '2019-05-17 14:48:13', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (274, '2019-10-01', 2019, 10, 1, 2, '国庆', 1, '2019-05-17 14:48:13', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (275, '2019-10-02', 2019, 10, 2, 3, '国庆', 1, '2019-05-17 14:48:13', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (276, '2019-10-03', 2019, 10, 3, 4, '国庆', 1, '2019-05-17 14:48:13', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (277, '2019-10-04', 2019, 10, 4, 5, NULL, 3, '2019-05-17 14:48:13', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (278, '2019-10-05', 2019, 10, 5, 6, NULL, 3, '2019-05-17 14:48:13', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (279, '2019-10-06', 2019, 10, 6, 7, NULL, 3, '2019-05-17 14:48:14', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (280, '2019-10-07', 2019, 10, 7, 1, NULL, 3, '2019-05-17 14:48:14', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (281, '2019-10-08', 2019, 10, 8, 2, NULL, 0, '2019-05-17 14:48:15', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (282, '2019-10-09', 2019, 10, 9, 3, NULL, 0, '2019-05-17 14:48:15', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (283, '2019-10-10', 2019, 10, 10, 4, NULL, 0, '2019-05-17 14:48:15', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (284, '2019-10-11', 2019, 10, 11, 5, NULL, 0, '2019-05-17 14:48:16', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (285, '2019-10-12', 2019, 10, 12, 6, NULL, 2, '2019-05-17 14:48:16', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (286, '2019-10-13', 2019, 10, 13, 7, NULL, 3, '2019-05-17 14:48:16', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (287, '2019-10-14', 2019, 10, 14, 1, NULL, 0, '2019-05-17 14:48:16', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (288, '2019-10-15', 2019, 10, 15, 2, NULL, 0, '2019-05-17 14:48:17', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (289, '2019-10-16', 2019, 10, 16, 3, NULL, 0, '2019-05-17 14:48:17', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (290, '2019-10-17', 2019, 10, 17, 4, NULL, 0, '2019-05-17 14:48:17', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (291, '2019-10-18', 2019, 10, 18, 5, NULL, 0, '2019-05-17 14:48:17', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (292, '2019-10-19', 2019, 10, 19, 6, NULL, 3, '2019-05-17 14:48:17', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (293, '2019-10-20', 2019, 10, 20, 7, NULL, 3, '2019-05-17 14:48:18', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (294, '2019-10-21', 2019, 10, 21, 1, NULL, 0, '2019-05-17 14:48:18', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (295, '2019-10-22', 2019, 10, 22, 2, NULL, 0, '2019-05-17 14:48:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (296, '2019-10-23', 2019, 10, 23, 3, NULL, 0, '2019-05-17 14:48:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (297, '2019-10-24', 2019, 10, 24, 4, NULL, 0, '2019-05-17 14:48:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (298, '2019-10-25', 2019, 10, 25, 5, NULL, 0, '2019-05-17 14:48:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (299, '2019-10-26', 2019, 10, 26, 6, NULL, 3, '2019-05-17 14:48:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (300, '2019-10-27', 2019, 10, 27, 7, NULL, 3, '2019-05-17 14:48:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (301, '2019-10-28', 2019, 10, 28, 1, NULL, 0, '2019-05-17 14:48:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (302, '2019-10-29', 2019, 10, 29, 2, NULL, 0, '2019-05-17 14:48:19', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (303, '2019-10-30', 2019, 10, 30, 3, NULL, 0, '2019-05-17 14:48:20', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (304, '2019-10-31', 2019, 10, 31, 4, NULL, 0, '2019-05-17 14:48:20', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (305, '2019-11-01', 2019, 11, 1, 5, NULL, 0, '2019-05-17 14:48:20', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (306, '2019-11-02', 2019, 11, 2, 6, NULL, 3, '2019-05-17 14:48:20', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (307, '2019-11-03', 2019, 11, 3, 7, NULL, 3, '2019-05-17 14:48:21', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (308, '2019-11-04', 2019, 11, 4, 1, NULL, 0, '2019-05-17 14:48:21', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (309, '2019-11-05', 2019, 11, 5, 2, NULL, 0, '2019-05-17 14:48:21', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (310, '2019-11-06', 2019, 11, 6, 3, NULL, 0, '2019-05-17 14:48:22', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (311, '2019-11-07', 2019, 11, 7, 4, NULL, 0, '2019-05-17 14:48:22', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (312, '2019-11-08', 2019, 11, 8, 5, NULL, 0, '2019-05-17 14:48:22', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (313, '2019-11-09', 2019, 11, 9, 6, NULL, 3, '2019-05-17 14:48:22', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (314, '2019-11-10', 2019, 11, 10, 7, NULL, 3, '2019-05-17 14:48:22', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (315, '2019-11-11', 2019, 11, 11, 1, NULL, 0, '2019-05-17 14:48:23', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (316, '2019-11-12', 2019, 11, 12, 2, NULL, 0, '2019-05-17 14:48:23', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (317, '2019-11-13', 2019, 11, 13, 3, NULL, 0, '2019-05-17 14:48:24', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (318, '2019-11-14', 2019, 11, 14, 4, NULL, 0, '2019-05-17 14:48:24', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (319, '2019-11-15', 2019, 11, 15, 5, NULL, 0, '2019-05-17 14:48:24', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (320, '2019-11-16', 2019, 11, 16, 6, NULL, 3, '2019-05-17 14:48:24', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (321, '2019-11-17', 2019, 11, 17, 7, NULL, 3, '2019-05-17 14:48:24', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (322, '2019-11-18', 2019, 11, 18, 1, NULL, 0, '2019-05-17 14:48:24', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (323, '2019-11-19', 2019, 11, 19, 2, NULL, 0, '2019-05-17 14:48:25', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (324, '2019-11-20', 2019, 11, 20, 3, NULL, 0, '2019-05-17 14:48:25', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (325, '2019-11-21', 2019, 11, 21, 4, NULL, 0, '2019-05-17 14:48:25', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (326, '2019-11-22', 2019, 11, 22, 5, NULL, 0, '2019-05-17 14:48:25', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (327, '2019-11-23', 2019, 11, 23, 6, NULL, 3, '2019-05-17 14:48:25', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (328, '2019-11-24', 2019, 11, 24, 7, NULL, 3, '2019-05-17 14:48:25', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (329, '2019-11-25', 2019, 11, 25, 1, NULL, 0, '2019-05-17 14:48:26', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (330, '2019-11-26', 2019, 11, 26, 2, NULL, 0, '2019-05-17 14:48:26', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (331, '2019-11-27', 2019, 11, 27, 3, NULL, 0, '2019-05-17 14:48:26', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (332, '2019-11-28', 2019, 11, 28, 4, NULL, 0, '2019-05-17 14:48:26', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (333, '2019-11-29', 2019, 11, 29, 5, NULL, 0, '2019-05-17 14:48:26', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (334, '2019-11-30', 2019, 11, 30, 6, NULL, 3, '2019-05-17 14:48:26', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (335, '2019-12-01', 2019, 12, 1, 7, NULL, 3, '2019-05-17 14:48:26', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (336, '2019-12-02', 2019, 12, 2, 1, NULL, 0, '2019-05-17 14:48:27', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (337, '2019-12-03', 2019, 12, 3, 2, NULL, 0, '2019-05-17 14:48:27', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (338, '2019-12-04', 2019, 12, 4, 3, NULL, 0, '2019-05-17 14:48:27', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (339, '2019-12-05', 2019, 12, 5, 4, NULL, 0, '2019-05-17 14:48:27', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (340, '2019-12-06', 2019, 12, 6, 5, NULL, 0, '2019-05-17 14:48:27', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (341, '2019-12-07', 2019, 12, 7, 6, NULL, 3, '2019-05-17 14:48:27', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (342, '2019-12-08', 2019, 12, 8, 7, NULL, 3, '2019-05-17 14:48:28', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (343, '2019-12-09', 2019, 12, 9, 1, NULL, 0, '2019-05-17 14:48:28', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (344, '2019-12-10', 2019, 12, 10, 2, NULL, 0, '2019-05-17 14:48:28', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (345, '2019-12-11', 2019, 12, 11, 3, NULL, 0, '2019-05-17 14:48:28', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (346, '2019-12-12', 2019, 12, 12, 4, NULL, 0, '2019-05-17 14:48:29', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (347, '2019-12-13', 2019, 12, 13, 5, NULL, 0, '2019-05-17 14:48:29', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (348, '2019-12-14', 2019, 12, 14, 6, NULL, 3, '2019-05-17 14:48:29', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (349, '2019-12-15', 2019, 12, 15, 7, NULL, 3, '2019-05-17 14:48:29', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (350, '2019-12-16', 2019, 12, 16, 1, NULL, 0, '2019-05-17 14:48:29', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (351, '2019-12-17', 2019, 12, 17, 2, NULL, 0, '2019-05-17 14:48:29', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (352, '2019-12-18', 2019, 12, 18, 3, NULL, 0, '2019-05-17 14:48:30', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (353, '2019-12-19', 2019, 12, 19, 4, NULL, 0, '2019-05-17 14:48:30', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (354, '2019-12-20', 2019, 12, 20, 5, NULL, 0, '2019-05-17 14:48:30', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (355, '2019-12-21', 2019, 12, 21, 6, NULL, 3, '2019-05-17 14:48:30', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (356, '2019-12-22', 2019, 12, 22, 7, NULL, 3, '2019-05-17 14:48:30', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (357, '2019-12-23', 2019, 12, 23, 1, NULL, 0, '2019-05-17 14:48:30', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (358, '2019-12-24', 2019, 12, 24, 2, NULL, 0, '2019-05-17 14:48:30', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (359, '2019-12-25', 2019, 12, 25, 3, NULL, 0, '2019-05-17 14:48:31', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (360, '2019-12-26', 2019, 12, 26, 4, NULL, 0, '2019-05-17 14:48:31', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (361, '2019-12-27', 2019, 12, 27, 5, NULL, 0, '2019-05-17 14:48:31', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (362, '2019-12-28', 2019, 12, 28, 6, NULL, 3, '2019-05-17 14:48:31', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (363, '2019-12-29', 2019, 12, 29, 7, NULL, 3, '2019-05-17 14:48:31', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (364, '2019-12-30', 2019, 12, 30, 1, NULL, 0, '2019-05-17 14:48:31', '2019-10-18 20:30:06');
INSERT INTO `calendars` VALUES (365, '2019-12-31', 2019, 12, 31, 2, NULL, 0, '2019-05-17 14:48:31', '2019-10-18 20:30:06');
COMMIT;

-- ----------------------------
-- Table structure for check_in_records
-- ----------------------------
DROP TABLE IF EXISTS `check_in_records`;
CREATE TABLE `check_in_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '打卡流水表 主键',
  `original_record_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '钉钉原始记录的 id',
  `user_id` int(11) NOT NULL COMMENT '成员id',
  `date` date NOT NULL COMMENT '工作日',
  `timestamp` bigint(50) NOT NULL COMMENT '打卡时间戳',
  `check_type` tinyint(4) NOT NULL COMMENT '打卡类型, 0 上班 1 下班',
  `check_in_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '打卡时间',
  `source_type` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '打开类型',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `original_record_id` (`original_record_id`) USING BTREE,
  KEY `date` (`date`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43898827 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='打卡流水表';

-- ----------------------------
-- Table structure for check_in_results
-- ----------------------------
DROP TABLE IF EXISTS `check_in_results`;
CREATE TABLE `check_in_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '打卡结果表 主键',
  `user_id` int(11) NOT NULL COMMENT '成员id',
  `date` date NOT NULL COMMENT '当天日期',
  `start_time` bigint(50) DEFAULT NULL COMMENT '打卡开始时间',
  `end_time` bigint(50) DEFAULT NULL COMMENT '打卡结束时间',
  `check_in_type` tinyint(4) DEFAULT NULL COMMENT '工作类型, 如加班, 迟到',
  `miss_state` tinyint(4) DEFAULT NULL COMMENT '上午/下午 打卡缺失状态',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `check_in_result` tinyint(4) DEFAULT NULL COMMENT '打卡结果统计（计算后状态）, 记录：正常、迟到、早退、旷班早退等。数值具体意义见config下const',
  `late_minute` tinyint(4) DEFAULT '0' COMMENT '迟到分钟数, 提供给每日详情 显示严重迟到状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `user_id` (`user_id`,`date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=52103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='打卡结果表';

-- ----------------------------
-- Table structure for check_in_rule
-- ----------------------------
DROP TABLE IF EXISTS `check_in_rule`;
CREATE TABLE `check_in_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_allow` int(11) NOT NULL COMMENT '是否启用该补卡guize',
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '补卡规则名',
  `count` int(11) NOT NULL COMMENT '补卡总次数',
  `max_period` int(11) NOT NULL COMMENT '补卡限制时间（周期）',
  `limit_count` int(11) NOT NULL DEFAULT '0' COMMENT '勾选设置补卡次数标志',
  `limit_max_period` int(11) NOT NULL DEFAULT '0' COMMENT '勾选限制补卡时间标志',
  `is_delete` int(11) DEFAULT '0' COMMENT '删除标志',
  `table_code` int(11) DEFAULT '5000' COMMENT '表类型码',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='补卡规则表';

-- ----------------------------
-- Records of check_in_rule
-- ----------------------------
BEGIN;
INSERT INTO `check_in_rule` VALUES (17, 1, '默认补卡规则', 3, 30, 1, 1, 0, 5000, '2019-10-18 20:31:08', '2019-10-18 20:31:08');
COMMIT;

-- ----------------------------
-- Table structure for common_configs
-- ----------------------------
DROP TABLE IF EXISTS `common_configs`;
CREATE TABLE `common_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '配置表, 配置一些可能会修改的文本',
  `key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置的键, 唯一',
  `desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '配置键的描述',
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'content 内容的类型',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '配置内容',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key` (`key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='配置表';

-- ----------------------------
-- Records of common_configs
-- ----------------------------
BEGIN;
INSERT INTO `common_configs` VALUES (1, 'oxygen-max-admin', '子管理员最大数量', 'int', '5', '2019-05-16 17:52:54', '2019-06-17 10:01:07');
INSERT INTO `common_configs` VALUES (2, 'oxygen-mobile-approval-list', '审批人除直接主管后面几位', 'json', '[\n  {\n    \"approval\": \"吴佳佳\",\n    \"approval_avatar\": \"https://static-legacy.dingtalk.com/media/lADPBE1XYK9nTP7NA-jNA-E_993_1000.jpg\",\n    \"approval_ding_user_id\": \"011062106021366164\",\n    \"approval_position\": \"HRD\"\n  },\n  {\n    \"approval\": \"叶诗琪\",\n    \"approval_avatar\": \"https://static-legacy.dingtalk.com/media/lADPBE1XYLAjnYnNA-jNA-g_1000_1000.jpg\",\n    \"approval_ding_user_id\": \"056764550621795241\",\n    \"approval_position\": \"行政专员实习生\"\n  },\n  {\n    \"approval\": \"刘克亮\",\n    \"approval_avatar\": \"https://static-legacy.dingtalk.com/media/lADPBE1XYMCteDHNA-jNA-g_1000_1000.jpg\",\n    \"approval_ding_user_id\": \"0469262920861659\",\n    \"approval_position\": \"CEO\"\n  }\n]\n', '2019-06-08 11:35:36', '2019-08-08 18:33:28');
INSERT INTO `common_configs` VALUES (4, 'oxygen-treasure-rule', '起点基金规则', 'json', '{\"fund_rules\": [[0, 15, 100], [18, 200, 150], [201, 500, 200]], \"extra_start\": 150, \"award_money\": 100, \"fine_money\": 15}', '2019-06-21 15:50:48', '2019-07-10 15:46:38');
INSERT INTO `common_configs` VALUES (5, 'gitlab-and-ding-ids', '不再@的员工列表', 'json', '{\"white_list\": [2, 15, 42, 43, 44, 100, 112, 151, 186, 236, 275, 299, 311, 324, 340, 453, 461, 71, 555], \"username_users\": [11, 131, 208, 270, 344, 406, 437, 447, 538, 546, 555], \"email_users\": [533, 534, 536, 537, 538, 539, 540, 541, 542, 543], \"account_users\": [522, 533, 534, 536, 537, 538, 539, 540, 541, 542, 543, 553, 554]}', '2019-08-29 16:26:51', '2019-09-06 14:18:11');
COMMIT;

-- ----------------------------
-- Table structure for departments
-- ----------------------------
DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门 主键',
  `dept_id` int(11) NOT NULL COMMENT '钉钉部门id',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '部门名称',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间, 一般为定时任务完成后的时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `dept_id` (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='部门表';

-- ----------------------------
-- Records of departments
-- ----------------------------
BEGIN;
INSERT INTO `departments` VALUES (6, 102225001, '职能中心', '2019-10-24 22:13:09', '2019-10-24 22:13:09');
INSERT INTO `departments` VALUES (7, 102225061, '产研中心', '2019-10-24 22:13:09', '2019-10-24 22:13:09');
INSERT INTO `departments` VALUES (8, 102225063, '内容中心', '2019-10-24 22:13:09', '2019-10-24 22:13:09');
INSERT INTO `departments` VALUES (9, 102225064, '运营中心', '2019-10-24 22:13:09', '2019-10-24 22:13:09');
INSERT INTO `departments` VALUES (10, 102536114, 'CEO', '2019-10-24 22:13:09', '2019-10-24 22:13:09');
COMMIT;

-- ----------------------------
-- Table structure for holiday_rule
-- ----------------------------
DROP TABLE IF EXISTS `holiday_rule`;
CREATE TABLE `holiday_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '假期规则名称',
  `min_unit` int(11) NOT NULL COMMENT '最小请假单位',
  `mode` int(11) DEFAULT '0' COMMENT '计算方式',
  `is_balance` tinyint(4) DEFAULT NULL COMMENT '是否有余额规则',
  `balance_mode` int(11) DEFAULT NULL COMMENT '余额发放方式',
  `balance_days` int(11) DEFAULT NULL COMMENT '发放天数',
  `extension_rule` int(11) DEFAULT NULL COMMENT '有效期间规则',
  `extension_allow` int(11) DEFAULT NULL COMMENT '允许延长',
  `extension_time` int(11) DEFAULT NULL COMMENT '最长周期',
  `table_code` int(11) DEFAULT '1000' COMMENT '类型码',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  `is_edit` tinyint(4) DEFAULT '1' COMMENT '是否可编辑',
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='假期规则表';

-- ----------------------------
-- Records of holiday_rule
-- ----------------------------
BEGIN;
INSERT INTO `holiday_rule` VALUES (1, '事假', 1, 4, NULL, 6, NULL, NULL, NULL, NULL, 1000, '2019-05-20 15:33:07', '2019-05-30 16:45:58', 0, 0);
INSERT INTO `holiday_rule` VALUES (2, '病假', 1, 4, NULL, 6, NULL, NULL, NULL, NULL, 1000, '2019-05-20 15:33:08', '2019-05-22 15:12:36', 0, 0);
INSERT INTO `holiday_rule` VALUES (3, '例假', 1, 4, NULL, 6, NULL, NULL, NULL, NULL, 1000, '2019-05-20 15:33:08', '2019-05-22 15:12:36', 0, 0);
INSERT INTO `holiday_rule` VALUES (4, '年假', 1, 4, 7, 5, NULL, NULL, NULL, NULL, 1000, '2019-05-20 15:33:09', '2019-05-30 16:58:36', 0, 0);
INSERT INTO `holiday_rule` VALUES (5, '调休', 1, 4, 10, 6, NULL, NULL, NULL, NULL, 1000, '2019-05-20 15:33:09', '2019-05-22 15:12:36', 0, 0);
INSERT INTO `holiday_rule` VALUES (6, '婚假', 13, 3, NULL, 6, NULL, NULL, NULL, NULL, 1000, '2019-05-20 15:33:09', '2019-05-30 16:58:36', 0, 0);
INSERT INTO `holiday_rule` VALUES (7, '产假', 1, 3, NULL, 6, NULL, NULL, NULL, NULL, 1000, '2019-05-20 15:33:10', '2019-05-22 15:12:36', 0, 0);
INSERT INTO `holiday_rule` VALUES (8, '产检假', 1, 4, NULL, 6, NULL, NULL, NULL, NULL, 1000, '2019-05-20 15:33:10', '2019-05-22 15:12:36', 0, 0);
INSERT INTO `holiday_rule` VALUES (9, '陪产假', 1, 3, NULL, 6, NULL, NULL, NULL, NULL, 1000, '2019-05-20 15:33:10', '2019-05-22 15:12:36', 0, 0);
INSERT INTO `holiday_rule` VALUES (10, '工伤假', 1, 3, NULL, 6, NULL, NULL, NULL, NULL, 1000, '2019-05-20 15:33:11', '2019-05-22 15:12:36', 0, 0);
INSERT INTO `holiday_rule` VALUES (11, '丧假', 1, 3, NULL, 6, NULL, NULL, NULL, NULL, 1000, '2019-05-20 15:33:12', '2019-06-10 17:45:58', 0, 0);
INSERT INTO `holiday_rule` VALUES (21, '外出', 1, 4, NULL, 6, NULL, NULL, NULL, NULL, 1000, '2019-06-17 09:06:01', '2019-07-02 14:49:17', 1, 0);
INSERT INTO `holiday_rule` VALUES (22, '其他', 1, 4, NULL, 6, NULL, NULL, NULL, NULL, 1000, '2019-06-17 09:07:03', '2019-07-02 14:49:17', 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for late_arrival_rule
-- ----------------------------
DROP TABLE IF EXISTS `late_arrival_rule`;
CREATE TABLE `late_arrival_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shift_rule_id` int(11) NOT NULL COMMENT '班次id',
  `time_late` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '晚走时长',
  `work_start` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '可以晚到时长',
  `table_code` int(11) DEFAULT '3100',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of late_arrival_rule
-- ----------------------------
BEGIN;
INSERT INTO `late_arrival_rule` VALUES (36, 41, '0230', '0020', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (37, 41, '0430', '0045', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (38, 41, '0830', '0120', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (39, 42, '0330', '0030', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (46, 47, '0100', '0001', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (51, 52, '0200', '0020', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (52, 52, '0400', '0040', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (55, 57, '0230', '0020', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (56, 57, '0430', '0045', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (57, 57, '0630', '0120', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (59, 95, '0230', '0020', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (60, 95, '0430', '0045', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (61, 95, '0630', '0120', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (62, 96, '0230', '0020', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (63, 96, '0430', '0045', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (64, 96, '0630', '0120', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (65, 97, '0230', '0020', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (66, 97, '0130', '0045', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (67, 97, '0630', '0120', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (68, 98, '0230', '0020', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (69, 98, '0430', '0045', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (70, 98, '0630', '0120', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (71, 99, '0230', '0020', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (72, 99, '0430', '0045', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (73, 99, '0430', '0120', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (74, 100, '0230', '0020', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (75, 100, '0430', '0045', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
INSERT INTO `late_arrival_rule` VALUES (76, 100, '0630', '0120', 3100, '2019-10-18 20:32:38', '2019-10-18 20:32:38');
COMMIT;

-- ----------------------------
-- Table structure for leave_details
-- ----------------------------
DROP TABLE IF EXISTS `leave_details`;
CREATE TABLE `leave_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请假人名字',
  `user_id` int(11) NOT NULL COMMENT '请假人id',
  `studio_id` int(11) NOT NULL COMMENT '请假人所属工作室id',
  `is_regular` int(11) NOT NULL COMMENT '0: 实习, 1：正式',
  `graduated_time` date DEFAULT NULL COMMENT '请假人毕业时间',
  `hired_time` date DEFAULT NULL COMMENT '请假人入职时间',
  `working_age` int(11) NOT NULL COMMENT '工龄',
  `leave_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请假类型：事假，病假等',
  `holiday_rule_id` int(11) NOT NULL COMMENT '对应假期规则id',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `last_time` decimal(4,1) DEFAULT NULL COMMENT '请假总时长',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `message_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '钉钉返回的message_id',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `leave_details_message_id_index` (`message_id`) USING BTREE,
  KEY `leave_details_user_id_index` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11999 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for message_user_records
-- ----------------------------
DROP TABLE IF EXISTS `message_user_records`;
CREATE TABLE `message_user_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'message user 中间表主键',
  `user_id` int(11) NOT NULL COMMENT '用户 主键',
  `message_id` int(11) NOT NULL COMMENT '消息主键',
  `is_read` int(11) NOT NULL DEFAULT '0' COMMENT '是否已读',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `message_id` (`message_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消息 用户 附表';

-- ----------------------------
-- Table structure for messages
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息列表 主键',
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '消息列表类型',
  `text` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '消息类型文本',
  `content` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '消息列表内容',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '前端请求请求url',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消息列表表';

-- ----------------------------
-- Table structure for modify_records
-- ----------------------------
DROP TABLE IF EXISTS `modify_records`;
CREATE TABLE `modify_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL COMMENT '管理员id',
  `user_id` int(11) DEFAULT NULL COMMENT '被修改信息的雇员id',
  `table_code` int(11) DEFAULT NULL COMMENT '基础表类型编码',
  `old_id` int(11) DEFAULT NULL COMMENT '修改原记录id',
  `new_id` int(11) DEFAULT NULL COMMENT '修改记录的新ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '简单描述',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=477 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作记录表';

-- ----------------------------
-- Table structure for operator_logs
-- ----------------------------
DROP TABLE IF EXISTS `operator_logs`;
CREATE TABLE `operator_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '操作日志log',
  `user_id` int(11) NOT NULL COMMENT '成员id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '日志操作时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志';

-- ----------------------------
-- Table structure for option_desc
-- ----------------------------
DROP TABLE IF EXISTS `option_desc`;
CREATE TABLE `option_desc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '选项名称',
  `intro` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '选项简介',
  `table_type` int(11) NOT NULL COMMENT '规则类型代码',
  `type_code` int(11) NOT NULL COMMENT '选项类型代码',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for overtime_records
-- ----------------------------
DROP TABLE IF EXISTS `overtime_records`;
CREATE TABLE `overtime_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '申请人姓名',
  `user_id` int(11) NOT NULL COMMENT '申请人id',
  `ding_user_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '员工钉钉userID',
  `user_type` tinyint(4) NOT NULL COMMENT '申请人类别',
  `studio_id` int(11) NOT NULL COMMENT '工作室id',
  `attendance_id` int(11) NOT NULL COMMENT '考勤组ID',
  `graduated_time` timestamp NULL DEFAULT NULL COMMENT '毕业时间',
  `hired_time` timestamp NULL DEFAULT NULL COMMENT '入职时间',
  `working_age` tinyint(4) DEFAULT NULL COMMENT '工龄',
  `apply_start` varchar(31) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '申请加班开始日期',
  `apply_type` tinyint(4) NOT NULL COMMENT '申请加班类型',
  `duration_time` decimal(3,1) DEFAULT NULL COMMENT '实际时长',
  `used_time` decimal(3,1) DEFAULT NULL COMMENT '使用时间',
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '删除标志',
  `used_desc` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_vacation_days` tinyint(4) DEFAULT '0' COMMENT '0:不是法定假日, 1:是法定假日',
  `message_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '钉钉审批实例id',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7718 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='加班调休记录表';

-- ----------------------------
-- Records of overtime_records
-- ----------------------------
BEGIN;
INSERT INTO `overtime_records` VALUES (7716, '兰胜', 35, '2516546057679276', 0, 2, 75, '2019-07-01 00:00:00', '2019-02-28 00:00:00', 0, '2019-10-19 12:00:00', 4, 0.5, NULL, 0, NULL, 0, '0eb8c112-0c08-466f-ae76-35a21db38699', NULL, NULL);
INSERT INTO `overtime_records` VALUES (7717, '周依依', 91, '185057260321417480', 1, 4, 75, '2017-11-01 00:00:00', '2018-05-03 00:00:00', 2, '2019-10-13 00:00:00', 3, 1.0, NULL, 0, NULL, 0, 'c9b87b6e-28f9-4c65-8e33-07ce6e3af958', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for overtime_rule
-- ----------------------------
DROP TABLE IF EXISTS `overtime_rule`;
CREATE TABLE `overtime_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '加班规则名',
  `min_unit` decimal(3,1) DEFAULT '0.5' COMMENT '最小加班单位',
  `conversion` decimal(3,1) DEFAULT '8.0' COMMENT '折算基准',
  `is_add_relax` tinyint(4) DEFAULT '0' COMMENT '是否增加休息时间',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  `table_code` int(11) DEFAULT '3000' COMMENT '类型码',
  `is_omit` tinyint(4) DEFAULT '1' COMMENT '是否允许普通管理人员删除',
  `is_edit` tinyint(4) DEFAULT '1' COMMENT '是否允许普通管理人员编辑',
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '删除标志',
  `crisis_Time` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT '1100' COMMENT '临界时间',
  `crisis_max_day` decimal(3,1) DEFAULT '0.5' COMMENT '临界后最大天数',
  `holiday_approval_type` int(11) DEFAULT '111' COMMENT '休息日、节假日  审批方式',
  `overtime_to` int(11) DEFAULT '0' COMMENT '加班时长处理方式',
  `is_allow_overtime` tinyint(4) DEFAULT '0' COMMENT '工作日允许加班',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='加班规则表';

-- ----------------------------
-- Records of overtime_rule
-- ----------------------------
BEGIN;
INSERT INTO `overtime_rule` VALUES (88, '加班默认规则', 0.5, 8.0, 1, '2019-06-16 12:15:16', '2019-06-23 18:02:29', 3000, 1, 1, 0, '1100', 0.5, 111, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for relax_time
-- ----------------------------
DROP TABLE IF EXISTS `relax_time`;
CREATE TABLE `relax_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_time` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '开始时间',
  `end_time` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '结束时间',
  `overtime_rule_id` int(11) NOT NULL COMMENT '加班规则id',
  `table_code` int(11) DEFAULT '4100',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='休息时间';

-- ----------------------------
-- Table structure for rules
-- ----------------------------
DROP TABLE IF EXISTS `rules`;
CREATE TABLE `rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '班次名称',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  `is_omit` int(11) DEFAULT '1' COMMENT '是否允许普通管理人员删除',
  `is_delete` int(11) DEFAULT '0' COMMENT '删除标志',
  `table_code` int(11) DEFAULT '4000',
  `settings_data` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'json数据格式的设置集',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='班次规则';

-- ----------------------------
-- Records of rules
-- ----------------------------
BEGIN;
INSERT INTO `rules` VALUES (100, '运营班次', '2019-09-08 10:06:19', '2019-09-09 15:28:17', 0, 0, 4000, '{\"work_time\": {\"start\": \"10:00\", \"end\": \"19:00\"}, \"relax_time\": {\"start\": \"12:00\", \"end\": \"14:00\"}, \"late_total\": {\"status\": true, \"minute\": 45}, \"late_allow\": {\"status\": false, \"minute\": 0}, \"late_skipped\": {\"status\": true, \"minute\": 90}, \"arrival_late\": {\"status\": true, \"times\": [[\"03:30\", \"0:30\"]], \"time_fmt\": \"%H:%M\", \"table_code\": 3100}, \"arrival_early\": {\"status\": true, \"times\": [[\"01:00\"], [\"0:30\"]], \"time_fmt\": \"%H:%M\"}}');
INSERT INTO `rules` VALUES (102, '常规班次__2019-10-25 25 15:47:48', '2019-10-25 14:19:09', '2019-10-25 15:55:41', 0, 0, 4000, '{\"work_time\": {\"start\": \"09:00\", \"end\": \"18:00\"}, \"relax_time\": {\"start\": \"12:00\", \"end\": \"14:00\"}, \"late_total\": {\"status\": true, \"minute\": 45}, \"late_allow\": {\"status\": false, \"minute\": 0}, \"late_skipped\": {\"status\": true, \"minute\": 90}, \"arrival_late\": {\"status\": true, \"times\": [[\"2:30\", \"0:30\"], [\"4:30\", \"1:0\"], [\"6:30\", \"1:30\"]], \"time_fmt\": \"%H:%M\", \"table_code\": 3100}, \"arrival_early\": {\"status\": true, \"times\": [[\"1:0\"], [\"0:30\"]], \"time_fmt\": \"%H:%M\"}}');
COMMIT;

-- ----------------------------
-- Table structure for shift_rule
-- ----------------------------
DROP TABLE IF EXISTS `shift_rule`;
CREATE TABLE `shift_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '班次名称',
  `start_time` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '上班时间',
  `end_time` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '下班时间',
  `start_relax` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '休息开始时间',
  `end_relax` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '休息结束时间',
  `is_allow` int(11) DEFAULT '0' COMMENT '允许晚到',
  `setting_lates` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT '000' COMMENT '迟到分钟数应用与否设置',
  `allow_late` int(11) DEFAULT '0' COMMENT '允许迟到分钟数',
  `seriously_late` int(11) DEFAULT '0' COMMENT '原：严重迟到分钟数，现已经弃用',
  `skipped_late` int(11) DEFAULT '0' COMMENT '原：视为旷工分钟数， 现：严重迟到分钟数',
  `allow_late_total` int(11) DEFAULT '0' COMMENT '每月允许迟到分钟总数',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  `is_omit` int(11) DEFAULT '1' COMMENT '是否允许普通管理人员删除',
  `is_delete` int(11) DEFAULT '0' COMMENT '删除标志',
  `table_code` int(11) DEFAULT '4000',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='班次规则';

-- ----------------------------
-- Records of shift_rule
-- ----------------------------
BEGIN;
INSERT INTO `shift_rule` VALUES (41, '常规班次__2019-06-16 16 10:31:30', '0900', '1800', '1200', '1400', 1, '111', 0, 30, 90, 0, '2019-06-10 22:23:59', '2019-06-16 10:31:30', 1, 1, 4000);
INSERT INTO `shift_rule` VALUES (42, '运营班次', '1000', '1900', '1200', '1400', 1, '111', 0, 30, 40, 0, '2019-06-10 22:25:24', '2019-06-14 22:48:22', 1, 0, 4000);
INSERT INTO `shift_rule` VALUES (57, '常规班次__2019-08-12 12 15:56:36', '0900', '1800', '1200', '1400', 1, '111', 8, 30, 90, 0, '2019-06-16 10:31:30', '2019-08-12 15:56:36', 1, 1, 4000);
INSERT INTO `shift_rule` VALUES (94, '测试线上环境，会立即删除@2019-07-08 14:40:45', '0900', '1900', '1200', '1400', 0, '000', NULL, NULL, NULL, 0, '2019-07-08 11:58:21', '2019-07-08 14:40:46', 1, 1, 4000);
INSERT INTO `shift_rule` VALUES (95, '常规班次__2019-08-12 12 15:56:49', '0900', '1800', '1200', '1400', 1, '111', 0, 0, 90, 0, '2019-08-12 15:56:36', '2019-08-12 15:56:50', 1, 1, 4000);
INSERT INTO `shift_rule` VALUES (96, '常规班次__2019-08-15 15 11:18:47', '0900', '1800', '1200', '1400', 1, '111', 8, 30, 90, 0, '2019-08-12 15:56:50', '2019-08-15 11:18:47', 1, 1, 4000);
INSERT INTO `shift_rule` VALUES (97, '常规班次__2019-08-15 15 11:18:55', '0900', '1800', '1200', '1400', 1, '111', 8, 30, 90, 0, '2019-08-15 11:18:47', '2019-08-15 11:18:56', 1, 1, 4000);
INSERT INTO `shift_rule` VALUES (98, '常规班次__2019-08-15 15 14:21:08', '0900', '1800', '1200', '1400', 1, '111', 8, 30, 90, 0, '2019-08-15 11:18:56', '2019-08-15 14:21:09', 1, 1, 4000);
INSERT INTO `shift_rule` VALUES (99, '常规班次__2019-08-15 15 14:21:20', '0900', '1800', '1200', '1400', 1, '111', 8, 30, 90, 0, '2019-08-15 14:21:09', '2019-08-15 14:21:21', 1, 1, 4000);
INSERT INTO `shift_rule` VALUES (100, '常规班次', '0900', '1800', '1200', '1400', 1, '111', 8, 30, 90, 0, '2019-08-15 14:21:21', NULL, 1, 0, 4000);
COMMIT;

-- ----------------------------
-- Table structure for studios
-- ----------------------------
DROP TABLE IF EXISTS `studios`;
CREATE TABLE `studios` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'studio 主键',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '工作室名称',
  `dept_id` int(11) NOT NULL COMMENT '部门 id',
  `department_id` int(11) DEFAULT NULL COMMENT '部门表主键',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `supervisor` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '部门主管ding_user_id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `department_id` (`department_id`) USING BTREE,
  KEY `dept_id` (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='工作室 部门表';

-- ----------------------------
-- Records of studios
-- ----------------------------
BEGIN;
INSERT INTO `studios` VALUES (1, 'O₂工作室', 13266115, NULL, '2019-09-10 12:00:00', '2019-09-10 12:00:00', NULL);
INSERT INTO `studios` VALUES (2, '矩阵工作室(Matrix Studio)', 13271010, NULL, '2019-09-10 12:00:01', '2019-09-10 12:00:01', NULL);
INSERT INTO `studios` VALUES (3, '有工作室', 19448130, NULL, '2019-09-10 12:00:01', '2019-09-10 12:00:01', NULL);
INSERT INTO `studios` VALUES (4, '聚风工作室', 22848278, NULL, '2019-09-10 12:00:01', '2019-09-10 12:00:01', NULL);
INSERT INTO `studios` VALUES (5, '立方工作室', 65006854, NULL, '2019-09-10 12:00:01', '2019-09-10 12:00:01', NULL);
INSERT INTO `studios` VALUES (6, '三秋书工作室', 13271012, NULL, '2019-09-10 12:00:03', '2019-09-10 12:00:03', NULL);
INSERT INTO `studios` VALUES (7, '对象工作室', 102225065, NULL, '2019-09-10 12:00:03', '2019-09-10 12:00:03', NULL);
INSERT INTO `studios` VALUES (8, '布道师工作室', 53974079, NULL, '2019-09-10 12:00:04', '2019-09-10 12:00:04', NULL);
INSERT INTO `studios` VALUES (9, '契约工作室', 89929059, NULL, '2019-09-10 12:00:04', '2019-09-10 12:00:04', NULL);
INSERT INTO `studios` VALUES (10, '启蒙工作室', 102124097, NULL, '2019-09-10 12:00:04', '2019-09-10 12:00:04', NULL);
INSERT INTO `studios` VALUES (11, 'CEO', 118919708, NULL, '2019-09-10 12:00:07', '2019-09-10 12:00:07', NULL);
COMMIT;

-- ----------------------------
-- Table structure for treasure_extract
-- ----------------------------
DROP TABLE IF EXISTS `treasure_extract`;
CREATE TABLE `treasure_extract` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `studio_id` int(11) DEFAULT NULL COMMENT '工作室id',
  `user_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '申请人姓名',
  `user_id` int(11) NOT NULL COMMENT '申请人id',
  `ding_user_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '员工钉钉userID',
  `extract_money` int(11) NOT NULL COMMENT '提取金额',
  `reviewer_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '审核人名',
  `reviewer_id` int(11) NOT NULL COMMENT '审核人id',
  `reviewer_ding_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '审核人钉钉id',
  `extract_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='夺宝提取记录';

-- ----------------------------
-- Table structure for treasure_fine
-- ----------------------------
DROP TABLE IF EXISTS `treasure_fine`;
CREATE TABLE `treasure_fine` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `studio_id` int(11) DEFAULT NULL COMMENT '工作室id',
  `user_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '申请人姓名',
  `user_id` int(11) NOT NULL COMMENT '申请人id',
  `ding_user_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '员工钉钉userID',
  `late_count` int(11) DEFAULT NULL COMMENT '夺宝迟到次数',
  `all_time_award` int(11) DEFAULT NULL COMMENT '全勤奖',
  `start_fund` int(11) DEFAULT NULL COMMENT '新人起点基金',
  `should_fine` int(11) DEFAULT NULL COMMENT '应缴纳',
  `actual_fine` int(11) DEFAULT NULL COMMENT '实际缴纳',
  `date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '记录时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='夺宝罚款记录';

-- ----------------------------
-- Table structure for treasure_record
-- ----------------------------
DROP TABLE IF EXISTS `treasure_record`;
CREATE TABLE `treasure_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `studio_id` int(11) NOT NULL COMMENT '工作室id',
  `studio_name` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工作室名字',
  `studio_dept_id` int(11) DEFAULT NULL COMMENT '工作室dept-id',
  `initial_member` int(11) DEFAULT NULL COMMENT '基初人数',
  `incoming_member` int(11) DEFAULT NULL COMMENT '新入职人数',
  `fund` int(11) DEFAULT NULL COMMENT '人均起点基金',
  `arrive_late_count` int(11) DEFAULT NULL COMMENT '迟到次数',
  `full_attendance` int(11) DEFAULT NULL COMMENT '全勤次数',
  `initial_amount` int(11) DEFAULT NULL COMMENT '初期金额',
  `amount_payable` int(11) DEFAULT NULL COMMENT '应发',
  `deduction` int(11) DEFAULT NULL COMMENT '扣减',
  `draw_down` int(11) DEFAULT NULL COMMENT '提取',
  `balance` int(11) DEFAULT NULL COMMENT '结余',
  `fine_total_amount` int(11) DEFAULT NULL COMMENT '总金额',
  `fine_receivable` int(11) DEFAULT NULL COMMENT '当月应收',
  `fine_accumulated_unpaid` int(11) DEFAULT NULL COMMENT '累计未付',
  `total_amount` int(11) DEFAULT NULL COMMENT '总金额',
  `date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '记录时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=359 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='夺宝记录';

-- ----------------------------
-- Records of treasure_record
-- ----------------------------
BEGIN;
INSERT INTO `treasure_record` VALUES (348, 1, 'O₂工作室', 13266115, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, NULL, '2019-10-01 00:00:00', NULL, NULL);
INSERT INTO `treasure_record` VALUES (349, 2, '矩阵工作室(Matrix Studio)', 13271010, 1, 0, 100, 0, 1, 0, 100, 0, 0, 100, NULL, 0, NULL, NULL, '2019-10-01 00:00:00', NULL, NULL);
INSERT INTO `treasure_record` VALUES (350, 6, '三秋书工作室', 13271012, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, NULL, '2019-10-01 00:00:00', NULL, NULL);
INSERT INTO `treasure_record` VALUES (351, 3, '有工作室', 19448130, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, NULL, '2019-10-01 00:00:00', NULL, NULL);
INSERT INTO `treasure_record` VALUES (352, 4, '聚风工作室', 22848278, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, NULL, '2019-10-01 00:00:00', NULL, NULL);
INSERT INTO `treasure_record` VALUES (353, 8, '布道师工作室', 53974079, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, NULL, '2019-10-01 00:00:00', NULL, NULL);
INSERT INTO `treasure_record` VALUES (354, 5, '立方工作室', 65006854, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, NULL, '2019-10-01 00:00:00', NULL, NULL);
INSERT INTO `treasure_record` VALUES (355, 9, '契约工作室', 89929059, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, NULL, '2019-10-01 00:00:00', NULL, NULL);
INSERT INTO `treasure_record` VALUES (356, 10, '启蒙工作室', 102124097, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, NULL, '2019-10-01 00:00:00', NULL, NULL);
INSERT INTO `treasure_record` VALUES (357, 7, '对象工作室', 102225065, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, NULL, '2019-10-01 00:00:00', NULL, NULL);
INSERT INTO `treasure_record` VALUES (358, 11, 'CEO', 118919708, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, NULL, '2019-10-01 00:00:00', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'user 主键',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '姓名',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `position` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '岗位',
  `studio_id` int(11) NOT NULL COMMENT '工作室id',
  `job_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工号',
  `ding_user_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '钉钉用户 user id',
  `ding_union_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '钉钉 union id',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '员工状态 1 为已离职',
  `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '权限id',
  `permission` int(11) DEFAULT '0' COMMENT '权限字段',
  `is_regular` int(11) DEFAULT '1' COMMENT '是否为正式员工',
  `graduated_time` timestamp NULL DEFAULT NULL COMMENT '毕业时间',
  `hired_time` timestamp NULL DEFAULT NULL COMMENT '入职时间',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `attendance_id` int(11) NOT NULL DEFAULT '0' COMMENT '考勤组id',
  `resignation_date` datetime DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `username` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'gitlab唯一用户名',
  `gitlab_uid` int(11) DEFAULT '0' COMMENT 'gitalb用户id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `ding_union_id` (`ding_union_id`) USING BTREE,
  UNIQUE KEY `ding_user_id` (`ding_user_id`) USING BTREE,
  KEY `role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=772 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表存储 所有员工';

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES (35, '兰胜', 'https://static-legacy.dingtalk.com/media/lADPBE1XYL7QJj7NA-jNA-g_1000_1000.jpg', 'lansheng@forchange.tech', '后端开发工程师', 2, 'S1272', '2516546057679276', 'eDzfJDYcw3tghMm26tiih5giEiE', 0, 1, 100, 0, '2019-07-01 00:00:00', '2019-02-28 00:00:00', '2019-09-10 12:00:26', '2019-09-10 12:00:26', 75, NULL, '18879478306', '', 0);
INSERT INTO `users` VALUES (91, '周依依', 'https://static-legacy.dingtalk.com/media/lADPBE1XYReTtQbNA-fNA-g_1000_999.jpg', 'zhouyiyi@forchange.tech', '产品经理', 4, 'S1123', '185057260321417480', 'f15Ng6vv3S31MYePgvpKVwiEiE', 0, 1, 0, 1, '2017-11-01 00:00:00', '2018-05-03 00:00:00', '2019-09-10 12:01:01', '2019-09-10 12:01:01', 75, NULL, '18800117261', '', 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
