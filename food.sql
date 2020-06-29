/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.1.115
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : 192.168.1.115:3306
 Source Schema         : order

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 30/04/2020 20:16:10
*/
CREATE DATABASE `order` DEFAULT CHARACTER SET = `utf8mb4`;
USE  `order`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for app_access_log
-- ----------------------------
DROP TABLE IF EXISTS `app_access_log`;
CREATE TABLE `app_access_log`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `uid` bigint(0) NOT NULL DEFAULT 0 COMMENT 'uid',
  `referer_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '当前访问的refer',
  `target_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '访问的url',
  `query_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'get和post参数',
  `ua` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '访问ua',
  `ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '访问ip',
  `note` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'json格式备注字段',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_uid`(`uid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户访问记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for app_error_log
-- ----------------------------
DROP TABLE IF EXISTS `app_error_log`;
CREATE TABLE `app_error_log`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `referer_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '当前访问的refer',
  `target_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '访问的url',
  `query_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'get和post参数',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日志内容',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'app错误日表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for food
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cat_id` int(0) NOT NULL DEFAULT 0 COMMENT '分类id',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '书籍名称',
  `price` decimal(10, 2) NOT NULL COMMENT '售卖金额',
  `main_image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '主图',
  `summary` varchar(10000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '描述',
  `stock` int(0) NOT NULL DEFAULT 0 COMMENT '库存量',
  `tags` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'tag关键字，以\",\"连接',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态 1：有效 0：无效',
  `month_count` int(0) NOT NULL DEFAULT 0 COMMENT '月销售数量',
  `total_count` int(0) NOT NULL DEFAULT 0 COMMENT '总销售量',
  `view_count` int(0) NOT NULL DEFAULT 0 COMMENT '总浏览次数',
  `comment_count` int(0) NOT NULL DEFAULT 0 COMMENT '总评论量',
  `updated_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后更新时间',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后插入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '食品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of food
-- ----------------------------

-- ----------------------------
-- Table structure for food_cat
-- ----------------------------
DROP TABLE IF EXISTS `food_cat`;
CREATE TABLE `food_cat`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '类别名称',
  `weight` tinyint(0) NOT NULL DEFAULT 1 COMMENT '权重',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态 1：有效 0：无效',
  `updated_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后一次更新时间',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_name`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '食品分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of food_cat
-- ----------------------------

-- ----------------------------
-- Table structure for food_sale_change_log
-- ----------------------------
DROP TABLE IF EXISTS `food_sale_change_log`;
CREATE TABLE `food_sale_change_log`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `food_id` int(0) NOT NULL DEFAULT 0 COMMENT '商品id',
  `quantity` int(0) NOT NULL DEFAULT 0 COMMENT '售卖数量',
  `price` decimal(10, 2) NOT NULL COMMENT '售卖金额',
  `member_id` int(0) NOT NULL DEFAULT 0 COMMENT '会员id',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '售卖时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_food_id_id`(`food_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品销售情况' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of food_sale_change_log
-- ----------------------------

-- ----------------------------
-- Table structure for food_stock_change_log
-- ----------------------------
DROP TABLE IF EXISTS `food_stock_change_log`;
CREATE TABLE `food_stock_change_log`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `food_id` int(0) NOT NULL COMMENT '书籍商品id',
  `unit` int(0) NOT NULL DEFAULT 0 COMMENT '变更多少',
  `total_stock` int(0) NOT NULL DEFAULT 0 COMMENT '变更之后总量',
  `note` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '备注字段',
  `created_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_food_id`(`food_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '数据库存变更表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of food_stock_change_log
-- ----------------------------

-- ----------------------------
-- Table structure for images
-- ----------------------------
DROP TABLE IF EXISTS `images`;
CREATE TABLE `images`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `file_key` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of images
-- ----------------------------

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nickname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '会员名',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '会员手机号码',
  `sex` tinyint(1) NOT NULL DEFAULT 0 COMMENT '性别 1：男 2：女',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '会员头像',
  `salt` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '随机salt',
  `reg_ip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '注册ip',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态 1：有效 0：无效',
  `updated_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后一次更新时间',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member
-- ----------------------------

-- ----------------------------
-- Table structure for member_address
-- ----------------------------
DROP TABLE IF EXISTS `member_address`;
CREATE TABLE `member_address`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `member_id` int(0) NOT NULL DEFAULT 0 COMMENT '会员id',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '收货人手机号码',
  `province_id` int(0) NOT NULL DEFAULT 0 COMMENT '省id',
  `province_str` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '省名称',
  `city_id` int(0) NOT NULL DEFAULT 0 COMMENT '城市id',
  `city_str` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '市名称',
  `area_id` int(0) NOT NULL DEFAULT 0 COMMENT '区域id',
  `area_str` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '区域名称',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '详细地址',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效 1：有效 0：无效',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '默认地址',
  `updated_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后一次更新时间',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_member_id_status`(`member_id`, `status`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员收货地址' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_address
-- ----------------------------

-- ----------------------------
-- Table structure for member_cart
-- ----------------------------
DROP TABLE IF EXISTS `member_cart`;
CREATE TABLE `member_cart`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `member_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '会员id',
  `food_id` int(0) NOT NULL DEFAULT 0 COMMENT '图书id',
  `quantity` int(0) NOT NULL DEFAULT 0 COMMENT '数量',
  `updated_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后一次更新时间',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_member_id`(`member_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '购物车' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_cart
-- ----------------------------

-- ----------------------------
-- Table structure for member_comments
-- ----------------------------
DROP TABLE IF EXISTS `member_comments`;
CREATE TABLE `member_comments`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `member_id` int(0) NOT NULL DEFAULT 0 COMMENT '会员id',
  `food_ids` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '商品ids',
  `pay_order_id` int(0) NOT NULL DEFAULT 0 COMMENT '订单id',
  `score` tinyint(0) NOT NULL DEFAULT 0 COMMENT '评分',
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '评论内容',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_member_id`(`member_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member_comments
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_access_token
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_token`;
CREATE TABLE `oauth_access_token`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `access_token` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `expired_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '过期时间',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_expired_time`(`expired_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '微信的access_token 用户调用其他接口的' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_access_token
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_member_bind
-- ----------------------------
DROP TABLE IF EXISTS `oauth_member_bind`;
CREATE TABLE `oauth_member_bind`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `member_id` int(0) NOT NULL DEFAULT 0 COMMENT '会员id',
  `client_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '客户端来源类型。qq,weibo,weixin',
  `type` tinyint(0) NOT NULL DEFAULT 0 COMMENT '类型 type 1:wechat ',
  `openid` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '第三方id',
  `unionid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `extra` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '额外字段',
  `updated_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后更新时间',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_type_openid`(`type`, `openid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '第三方登录绑定关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_member_bind
-- ----------------------------

-- ----------------------------
-- Table structure for pay_order
-- ----------------------------
DROP TABLE IF EXISTS `pay_order`;
CREATE TABLE `pay_order`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '随机订单号',
  `member_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '会员id',
  `total_price` decimal(10, 2) NOT NULL COMMENT '订单应付金额',
  `yun_price` decimal(10, 2) NOT NULL COMMENT '运费金额',
  `pay_price` decimal(10, 2) NOT NULL COMMENT '订单实付金额',
  `pay_sn` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '第三方流水号',
  `prepay_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '第三方预付id',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '备注信息',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '1：支付完成 0 无效 -1 申请退款 -2 退款中 -9 退款成功  -8 待支付  -7 完成支付待确认',
  `express_status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '快递状态，-8 待支付 -7 已付款待发货 1：确认收货 0：失败',
  `express_address_id` int(0) NOT NULL DEFAULT 0 COMMENT '快递地址id',
  `express_info` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '快递信息',
  `comment_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '评论状态',
  `pay_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '付款到账时间',
  `updated_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最近一次更新时间',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_order_sn`(`order_sn`) USING BTREE,
  INDEX `idx_member_id_status`(`member_id`, `status`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '在线购买订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_order
-- ----------------------------

-- ----------------------------
-- Table structure for pay_order_callback_data
-- ----------------------------
DROP TABLE IF EXISTS `pay_order_callback_data`;
CREATE TABLE `pay_order_callback_data`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `pay_order_id` int(0) NOT NULL DEFAULT 0 COMMENT '支付订单id',
  `pay_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '支付回调信息',
  `refund_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '退款回调信息',
  `updated_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后一次更新时间',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `pay_order_id`(`pay_order_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_order_callback_data
-- ----------------------------

-- ----------------------------
-- Table structure for pay_order_item
-- ----------------------------
DROP TABLE IF EXISTS `pay_order_item`;
CREATE TABLE `pay_order_item`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pay_order_id` int(0) NOT NULL DEFAULT 0 COMMENT '订单id',
  `member_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '会员id',
  `quantity` int(0) NOT NULL DEFAULT 1 COMMENT '购买数量 默认1份',
  `price` decimal(10, 2) NOT NULL COMMENT '商品总价格，售价 * 数量',
  `food_id` int(0) NOT NULL DEFAULT 0 COMMENT '美食表id',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '备注信息',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1：成功 0 失败',
  `updated_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最近一次更新时间',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_order_id`(`pay_order_id`) USING BTREE,
  INDEX `idx_food_id`(`food_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单详情表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_order_item
-- ----------------------------

-- ----------------------------
-- Table structure for queue_list
-- ----------------------------
DROP TABLE IF EXISTS `queue_list`;
CREATE TABLE `queue_list`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '队列名字',
  `data` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '队列数据',
  `status` tinyint(1) NOT NULL DEFAULT -1 COMMENT '状态 -1 待处理 1 已处理',
  `updated_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后一次更新时间',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '事件队列表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of queue_list
-- ----------------------------

-- ----------------------------
-- Table structure for stat_daily_food
-- ----------------------------
DROP TABLE IF EXISTS `stat_daily_food`;
CREATE TABLE `stat_daily_food`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `food_id` int(0) NOT NULL DEFAULT 0 COMMENT '菜品id',
  `total_count` int(0) NOT NULL DEFAULT 0 COMMENT '售卖总数量',
  `total_pay_money` decimal(10, 2) NOT NULL COMMENT '总售卖金额',
  `updated_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后一次更新时间',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `date_food_id`(`date`, `food_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '书籍售卖日统计' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stat_daily_food
-- ----------------------------

-- ----------------------------
-- Table structure for stat_daily_member
-- ----------------------------
DROP TABLE IF EXISTS `stat_daily_member`;
CREATE TABLE `stat_daily_member`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL COMMENT '日期',
  `member_id` int(0) NOT NULL DEFAULT 0 COMMENT '会员id',
  `total_shared_count` int(0) NOT NULL DEFAULT 0 COMMENT '当日分享总次数',
  `total_pay_money` decimal(10, 2) NOT NULL COMMENT '当日付款总金额',
  `updated_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后一次更新时间',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_date_member_id`(`date`, `member_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员日统计' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stat_daily_member
-- ----------------------------

-- ----------------------------
-- Table structure for stat_daily_site
-- ----------------------------
DROP TABLE IF EXISTS `stat_daily_site`;
CREATE TABLE `stat_daily_site`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL COMMENT '日期',
  `total_pay_money` decimal(10, 2) NOT NULL COMMENT '当日应收总金额',
  `total_member_count` int(0) NOT NULL COMMENT '会员总数',
  `total_new_member_count` int(0) NOT NULL COMMENT '当日新增会员数',
  `total_order_count` int(0) NOT NULL COMMENT '当日订单数',
  `total_shared_count` int(0) NOT NULL,
  `updated_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后一次更新时间',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_date`(`date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '全站日统计' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stat_daily_site
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `uid` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '用户uid',
  `nickname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '手机号码',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '邮箱地址',
  `sex` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1：男 2：女 0：没填写',
  `avatar` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '头像',
  `login_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '登录用户名',
  `login_pwd` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '登录密码',
  `login_salt` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '登录密码的随机加密秘钥',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1：有效 0：无效',
  `updated_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后一次更新时间',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE INDEX `login_name`(`login_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表（管理员）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '13878645879', 'admin@qq.com', 0, '', 'admin123', '44a19bc54bfc5c590c398fe1e3365e16', 'fgEqnN2PiZ23am6K', 1, '2020-04-30 20:14:34', '2020-04-30 20:14:34');

-- ----------------------------
-- Table structure for wx_share_history
-- ----------------------------
DROP TABLE IF EXISTS `wx_share_history`;
CREATE TABLE `wx_share_history`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `member_id` int(0) NOT NULL DEFAULT 0 COMMENT '会员id',
  `share_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '分享的页面url',
  `created_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '微信分享记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wx_share_history
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
