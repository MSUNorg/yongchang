--永昌B2B 数据库表结构
--state状态 0=有效(默认),1=无效
SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id`          	bigint(20)    NOT NULL    AUTO_INCREMENT,
  `create_time` 	datetime      NOT NULL    COMMENT '数据记录创建时间',
  `update_time` 	datetime      NOT NULL    COMMENT '数据记录更新时间',
  `last_login_time` datetime      			  COMMENT '上次登录时间',
  `name`        	varchar(64)   NOT NULL    COMMENT '用户名称',
  `passwd`      	varchar(128)  NOT NULL    COMMENT '用户密码',
  `realname`    	varchar(128)              COMMENT '身份证真实名字',
  `role_id`        	bigint(20)     			  COMMENT '用户权限角色',
  `phone`       	varchar(64)   			  COMMENT '用户手机号',
  `email`       	varchar(256)  DEFAULT ''  COMMENT '用户邮箱',
  `state`  			int(2)        DEFAULT 1   COMMENT '状态: 0=未审核,1=正常,2=停止',
  
  `type`  			int(2)        DEFAULT 1   COMMENT '类型:1=B端供应商,2=B端采购商,0=运营平台',
  `level`           int(2)        DEFAULT 1   COMMENT '资质级别(A=1,B=2,C=3,D=4)',
  `company`        	varchar(64)       		  COMMENT '公司单位名称',
  `province`        varchar(64)       		  COMMENT '省',
  `city`            varchar(64)       		  COMMENT '市',
  `county`          varchar(128)       		  COMMENT '区/县',
  `address`         varchar(128)       		  COMMENT '公司单位地址',
  `logo`            varchar(64)       		  COMMENT '公司单位Logo',
  `qq`              varchar(32)       		  COMMENT '公司单位qq',
  `tel`             varchar(64)       		  COMMENT '公司电话',
  `fax`             varchar(64)       		  COMMENT '公司传真',
  `mobile`          varchar(64)       		  COMMENT '公司手机',
  `aboutus`         varchar(1024)             COMMENT '公司简介',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50000 DEFAULT CHARSET=utf8 COMMENT='用户表';
--alter table `user` add column `avatar` 	    varchar(64) after `state`;
--admin账号
INSERT INTO `user` (`id`, `create_time`, `update_time`, `last_login_time`, `name`, `passwd`, `realname`, `role_id`, `phone`, `email`, `state`, `type`, `level`, `company`, `province`, `city`, `county`, `address`, `logo`, `qq`, `tel`, `fax`, `mobile`, `aboutus`)
VALUES(50054, '2016-06-26 18:11:46', '2016-06-26 18:11:46', NULL, 'admin', '12345678', NULL, 0, '13178986754', 'admin@admin.com', 1, 1, 1, '永昌', '上海市', '上海市市辖区', NULL, '上海市市辖区', NULL, NULL, NULL, NULL, NULL, NULL);

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id`          	bigint(20)    NOT NULL    AUTO_INCREMENT,
  `create_time` 	datetime      NOT NULL    COMMENT '数据记录创建时间',
  `name`        	varchar(64)   NOT NULL    COMMENT '角色名称',
  `state`  			int(2)        DEFAULT 1   COMMENT '状态:1=正常,2=停止',
  `resource`        varchar(2048)       	  COMMENT '可访问资源列表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50000 DEFAULT CHARSET=utf8 COMMENT='角色表';
--super role
INSERT INTO `yongchang`.`role` (`id`,`create_time`, `name`, `resource`) 
VALUES (0,'2016-07-04 20:52:20', '超级管理员', '/**');
UPDATE `yongchang`.`role` SET `id`=0 WHERE  `id`=4;

DROP TABLE IF EXISTS `code`;
CREATE TABLE `code` (
  `id`          	bigint(20)    NOT NULL     AUTO_INCREMENT,
  `create_time` 	datetime      NOT NULL     COMMENT '数据记录创建时间',
  `lost_time` 	    datetime      NOT NULL     COMMENT '过期时间',
  `code`       	    varchar(64)   DEFAULT ''   COMMENT '认证码',
  `type`  			int(2)        DEFAULT 1   COMMENT '类型:1=B端供应商,2=B端采购商',
  `state`  			int(2)        DEFAULT 1    COMMENT '状态: 0=正常,未使用,1=已使用,2=过期',
  `level`       	int(2)        DEFAULT 1    COMMENT '资质级别(A=1,B=2,C=3,D=4)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='认证码表';

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id`          	bigint(20)    NOT NULL     AUTO_INCREMENT,
  `create_time` 	datetime      NOT NULL     COMMENT '数据记录创建时间',
  `name`        	varchar(64)   NOT NULL     COMMENT '类目名称',
  `code`       	    varchar(256)  DEFAULT ''   COMMENT '类目编码',
  `state`  			int(2)        DEFAULT 1    COMMENT '状态: 1=正常,2=停止',
  `remark`       	varchar(256)  DEFAULT ''   COMMENT '类目说明',
  
  `parent_id`  		int(11)       DEFAULT NULL COMMENT '父类目id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='产品类别表';

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id`          	bigint(20)    NOT NULL    AUTO_INCREMENT,
  `create_time` 	datetime      NOT NULL    COMMENT '数据记录创建时间',
  `code`        	varchar(64)               COMMENT '商品编码',
  `title`        	varchar(64)   NOT NULL    COMMENT '商品标题',
  `introduction`    varchar(256)  DEFAULT ''  COMMENT '商品说明',
  `content`    		text  		  DEFAULT ''  COMMENT '商品具体内容',
  `state`  			int(2)        DEFAULT 0   COMMENT '状态: 0=未审核,1=正常出售中,2=停止',
  
  `unit`  			varchar(32)        		  COMMENT '单位,如组,斤,瓶,kg',
  `price`  			decimal(10,2) DEFAULT 0   COMMENT '产品价格,产品指导价格,单位元',
  `sales_price`  	decimal(10,2) DEFAULT 0   COMMENT '产品销售价格,单位元',
  `sales_num`  		int(5)        DEFAULT 0   COMMENT '商品已销售数量',
  `brand`        	varchar(64)   NOT NULL    COMMENT '品牌',
  `model`        	varchar(64)   NOT NULL    COMMENT '规格',
  `produce`        	varchar(64)   NOT NULL    COMMENT '产地',
  `envionment`      varchar(64)   NOT NULL    COMMENT '存储环境',
  `service`      	varchar(64)   NOT NULL    COMMENT '支持服务(24小时退换货,限时配送,自提)',
  
  `freight`  		decimal(10,2) DEFAULT 0   COMMENT '运费,单位元',
  `loss`  			decimal(10,2) DEFAULT 0   COMMENT '损耗字段,单位元',
  
  `category_id`     bigint(20)    NOT NULL    COMMENT '商品类别id',
  `min_order_qty` 	 decimal(10,2) unsigned   DEFAULT '0'  COMMENT '最小订购数量',
  `price_add_amount` decimal(10,2) unsigned   DEFAULT NULL COMMENT '加价幅度',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='产品基础信息表,由管理后台维护';

alter table `product` MODIFY `min_order_qty` decimal(10,2);
alter table `product` drop column `showcase`;

DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `id`          	bigint(20)    NOT NULL    AUTO_INCREMENT,
  `create_time` 	datetime      NOT NULL    COMMENT '数据记录创建时间',
  `code`        	varchar(64)               COMMENT '商品编码',
  `title`        	varchar(64)   NOT NULL    COMMENT '商品标题',
  `img`       	    varchar(1024) DEFAULT ''  COMMENT '商品图片,多个逗号分隔',
  `count`  			decimal(10,2) DEFAULT 0   COMMENT '缺货数量,供货数量,可销售数量,浮点数kg',
  `item_price`  	decimal(10,2) DEFAULT 0   COMMENT '商品价格,单位元',
  `adjust_price`  	decimal(10,2) DEFAULT 0   COMMENT '商品销售价格,单位元',
  `unit`  			int(5)        DEFAULT 0   COMMENT '单位,如组,斤,瓶,kg',
  `type`  			int(2)        DEFAULT 1   COMMENT '类型:1=缺货数量,平台或采购商,2=供货数量,供应商,0=可销售数量,平台',
  `state`  			int(2)        DEFAULT 0   COMMENT '状态: 0=未审核,1=正常出售中,2=停止',
  `detail`    		varchar(1024) DEFAULT ''  COMMENT '商品说明',
  `comment`    		varchar(1024) DEFAULT ''  COMMENT '平台评价',
  `showcase`  		int(2)        DEFAULT 0   COMMENT '橱窗推荐: 0=不推荐,1=推荐',
  
  `product_id`      bigint(20)    NOT NULL    COMMENT '商品基础id',
  `user_id`         bigint(20)    NOT NULL    COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='商品表,供货表';

alter table `item` add column `showcase` int(2)  COMMENT '橱窗推荐: 0=不推荐,1=推荐' after `comment`;
alter table `item` MODIFY `count` decimal(10,2);
--20160822新需求增加字段
alter table `item` add column `freight` 		 decimal(10,2)  DEFAULT 0 COMMENT '运费,单位元'  after `showcase`;
alter table `item` add column `loss` 			 decimal(10,2)  DEFAULT 0 COMMENT '损耗字段,单位元'   after `freight`;
alter table `item` add column `price_add_amount` decimal(10,2)  unsigned DEFAULT NULL COMMENT '加价金额' after `loss`;

alter table `item` add column `description` varchar(1024) DEFAULT '' COMMENT '审核不通过说明' after `showcase`;


DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id`          	bigint(20)    NOT NULL    AUTO_INCREMENT,
  `create_time` 	datetime      NOT NULL    COMMENT '数据记录创建时间',
  `state`  			int(2)        DEFAULT 0   COMMENT '订单状态: 0=未下单,1=已下单,2=关闭,取消',
  `amount`  		decimal(10,2) DEFAULT 0   COMMENT '商品总金额,单位元',
  `count` 			decimal(10,2) DEFAULT 0   COMMENT '购买数量,浮点数kg',
  
  `item_id`         bigint(20)    NOT NULL    COMMENT '商品id',
  `user_id`         bigint(20)    NOT NULL    COMMENT '下单者用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='购物车表';

alter table `cart` MODIFY `count` decimal(10,2);

DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `id`          	bigint(20)    NOT NULL    AUTO_INCREMENT,
  `create_time` 	datetime      NOT NULL    COMMENT '数据记录创建时间',
  `update_time` 	datetime      NOT NULL    COMMENT '数据记录更新时间',
  `title`        	varchar(64)               COMMENT '商品标题',
  `img`       	    varchar(256)    		  COMMENT '商品主图片',
  `price`  			decimal(10,2) DEFAULT 0   COMMENT '商品价格,单位元',
  `adjust_price`  	decimal(10,2) DEFAULT 0   COMMENT '调整价格,单位元',
  `count` 			decimal(10,2) DEFAULT 0   COMMENT '购买数量,浮点数kg',
  `amount`  		decimal(10,2) DEFAULT 0   COMMENT '商品总金额,小计金额,单位元',
  
  `item_id`         bigint(20)    NOT NULL    COMMENT '商品id',
  `order_id`        bigint(20)    NOT NULL    COMMENT '主订单id',
  `item_user_id`    bigint(20)    NOT NULL    COMMENT '产品用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='订单子项表';

alter table `order_detail` MODIFY `count` decimal(10,2);

DROP TABLE IF EXISTS `store_order`;
CREATE TABLE `store_order` (
  `id`          	bigint(20)    NOT NULL    AUTO_INCREMENT,
  `create_time` 	datetime      NOT NULL    COMMENT '数据记录创建时间',
  `update_time` 	datetime      NOT NULL    COMMENT '数据记录更新时间',
  `order_num`       varchar(64)   DEFAULT ''  COMMENT '订单编号',
  `name`        	varchar(64)   NOT NULL    COMMENT '订单名称',
  `state`  			int(2)        DEFAULT 0   COMMENT '订单状态: 0=未审核,1=正常,2=停止',
  `type`            int(2)        NOT NULL    COMMENT '订单类型(1=供货单,2=采购单)',
  `remark`        	varchar(64)               COMMENT '订单备注',
  `order_price`  	decimal(10,2) DEFAULT 0   COMMENT '订单价格,单位元',
  `adjust_price`  	decimal(10,2) DEFAULT 0   COMMENT '订单调整价格,单位元',
  
  `consignee`       varchar(64)      		  COMMENT '收货人',
  `province`        varchar(32)      		  COMMENT '省份',
  `city`        	varchar(32)               COMMENT '城市',
  `area`        	varchar(64)               COMMENT '区县',
  `address`        	varchar(128)              COMMENT '地址',
  `zipcode`        	varchar(16)               COMMENT '区号',
  `tel_num`        	varchar(16)               COMMENT '电话',
  `mobile`        	varchar(16)               COMMENT '手机',
  
  `expres_type`     varchar(64)               COMMENT '物流公司',
  `expres_time`     datetime              	  COMMENT '物流时间',
  `expres_num`      varchar(64)               COMMENT '物流单号',
  `expres_price`    decimal(10,2)             COMMENT '物流价格,单位元',
  
  `pay_time` 	    datetime                  COMMENT '支付时间',
  `pay_state`  		int(2)        DEFAULT 0   COMMENT '支付状态: 0=未支付,1=已支付,2=已发货',
  `pay_type`        varchar(64)               COMMENT '支付类型 (网上支付，货到付款)',
  `pay_plat`        varchar(64)               COMMENT '支付平台 例如 支付宝 ',
  `pay_method`      varchar(64)               COMMENT '支付方式 银行/或者货到付款的现金/POST机',
  
  `invoice`         int(2)               	  COMMENT '是否需要发票:0=不需要,1=需要',
  `invoice_type`    varchar(64)               COMMENT '发票类型(个人，公司)',
  `invoice_title`   varchar(64)               COMMENT '发票抬头',
  
  `user_id`         bigint(20)    NOT NULL    COMMENT '下单者用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='订单表:1=平台向供应商下的订单,2=采购商向平台下的订单';

alter table `store_order` add column `order_num` varchar(64)  COMMENT '订单编号' after `update_time`;

DROP TABLE IF EXISTS `item_sum`;
CREATE TABLE `item_sum` (
  `id` 				bigint(20) 		NOT NULL 		AUTO_INCREMENT,
  `create_time` 	datetime 		NOT NULL 		COMMENT '数据记录创建时间',
  `sum_date` 		varchar(64)		NOT NULL		COMMENT '汇总日期',
  `state`  			int(2)          DEFAULT 0       COMMENT '处理状态: 0=未下单,1=已下单,2=关闭',
  
  `count` 			decimal(10,2)	DEFAULT 0 		COMMENT '缺货数量,供货数量,可销售数量,浮点数kg',
  `item_id` 		bigint(20) 		NOT NULL		COMMENT '供货id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='每日商品订货汇总表';

alter table `item_sum` MODIFY `count` decimal(10,2);

DROP TABLE IF EXISTS `model`;
CREATE TABLE `model` (
  `id` 				bigint(20) 		NOT NULL 		AUTO_INCREMENT,
  `create_time` 	datetime 		NOT NULL 		COMMENT '数据记录创建时间',
  `name` 			varchar(64)			 			COMMENT '计量名称',
  `weight` 			int(5) 						    COMMENT '重量换算(千克),浮点数kg',
  `state`  			int(2)          DEFAULT 0   	COMMENT '状态: 0=有效,1=停止',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='规格说明表';

alter table `model` MODIFY `weight` decimal(10,2);

DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
	`id` 					bigint(20)	NOT NULL 		AUTO_INCREMENT,
	`create_time` 			datetime 	NOT NULL 		COMMENT '数据记录创建时间',
	`user_id`				int(11)						COMMENT '用户id,接收人用户id',
	`un_read`				int(2) 						COMMENT '是否阅读: 0=已读,1=未读',
	`content`				varchar(1024)				COMMENT '通知内容详情',
	`action_user_id`		int(11) 					COMMENT '发起人用户id',
	`notification_action`	int(2) 						COMMENT '发起的动作',
	`notification_type`		int(2) 						COMMENT '通知类型',
	
	PRIMARY KEY  (`id`)
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='通知信息表';

--商品名称，需求量，已中标量，状态，竞标起始价，截止日期
DROP TABLE IF EXISTS `plat_require`;
CREATE TABLE `plat_require` (
	`id` 					bigint(20)	NOT NULL 		AUTO_INCREMENT,
	`create_time` 			datetime 	NOT NULL 		COMMENT '数据记录创建时间',
	`deadline_time` 		datetime 	NOT NULL 		COMMENT '截止日期',
	`title`				    varchar(128)				COMMENT '商品名称',
	`require_count`			decimal(10,2) 				COMMENT '需求量',
	`finish_count`			decimal(10,2)				COMMENT '已中标量',
	`state`					int(2) 						COMMENT '状态',
	`start_price`			decimal(10,2)				COMMENT '竞标起始价',
	`product_id` 			bigint(20)  NOT NULL		COMMENT '关联商品基础信息id',
	PRIMARY KEY  (`id`)
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='平台需求表';

--竞标的价格，供应重量
DROP TABLE IF EXISTS `bid`;
CREATE TABLE `bid` (
	`id` 					bigint(20)	NOT NULL 		AUTO_INCREMENT,
	`create_time` 			datetime 	NOT NULL 		COMMENT '数据记录创建时间',
	`state`					int(2) 						COMMENT '状态',
	`bid_count`				decimal(10,2) 				COMMENT '供应重量',
	`bid_price`				decimal(10,2)				COMMENT '竞标的价格',
	`require_id` 			bigint(20)  NOT NULL		COMMENT '平台需求id',
	`user_id`         		bigint(20)  NOT NULL    	COMMENT '竞标者id',
	PRIMARY KEY  (`id`)
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='供应商竞标表';

--首页轮播图
DROP TABLE IF EXISTS `slideshow`;
CREATE TABLE `slideshow` (
	`id` 					bigint(20)	NOT NULL 		AUTO_INCREMENT,
	`create_time` 			datetime 	NOT NULL 		COMMENT '数据记录创建时间',
	`state`					int(2) 						COMMENT '状态(0=有效,1=无效)',
	`title`				    varchar(128)				COMMENT '标题,可为空',
	`link`				    varchar(128)				COMMENT '跳转链接,可为空',
	`pic`				    varchar(128)				COMMENT '图片,可为空',
	`type`				    int(2)						COMMENT '类型',
	PRIMARY KEY  (`id`)
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='首页轮播图';
--20160822新需求增加字段
alter table `slideshow` add column `turn` int(2)  COMMENT '排序' after `pic`;
