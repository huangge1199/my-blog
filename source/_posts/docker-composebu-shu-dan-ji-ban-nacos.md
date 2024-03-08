---
title: docker-compose部署单机版nacos
tags: [安装部署]
categories: [安装部署]
date: 2024-03-08 16:47:43
---

# nacos数据库建表语句
```sql
/*
 * Copyright 1999-2018 Alibaba Group Holding Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info   */
/******************************************/
CREATE TABLE `config_info` (
                               `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                               `data_id` VARCHAR(255) NOT NULL COMMENT 'data_id',
                               `group_id` VARCHAR(255) DEFAULT NULL,
                               `content` LONGTEXT NOT NULL COMMENT 'content',
                               `md5` VARCHAR(32) DEFAULT NULL COMMENT 'md5',
                               `gmt_create` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `gmt_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                               `src_user` TEXT COMMENT 'source user',
                               `src_ip` VARCHAR(50) DEFAULT NULL COMMENT 'source ip',
                               `app_name` VARCHAR(128) DEFAULT NULL,
                               `tenant_id` VARCHAR(128) DEFAULT '' COMMENT '租户字段',
                               `c_desc` VARCHAR(256) DEFAULT NULL,
                               `c_use` VARCHAR(64) DEFAULT NULL,
                               `effect` VARCHAR(64) DEFAULT NULL,
                               `type` VARCHAR(64) DEFAULT NULL,
                               `c_schema` TEXT,
                               `encrypted_data_key` TEXT NOT NULL COMMENT '秘钥',
                               PRIMARY KEY (`id`),
                               UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info';

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info_aggr   */
/******************************************/
CREATE TABLE `config_info_aggr` (
                                    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                    `data_id` VARCHAR(255) NOT NULL COMMENT 'data_id',
                                    `group_id` VARCHAR(255) NOT NULL COMMENT 'group_id',
                                    `datum_id` VARCHAR(255) NOT NULL COMMENT 'datum_id',
                                    `content` LONGTEXT NOT NULL COMMENT '内容',
                                    `gmt_modified` DATETIME NOT NULL COMMENT '修改时间',
                                    `app_name` VARCHAR(128) DEFAULT NULL,
                                    `tenant_id` VARCHAR(128) DEFAULT '' COMMENT '租户字段',
                                    PRIMARY KEY (`id`),
                                    UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='增加租户字段';


/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info_beta   */
/******************************************/
CREATE TABLE `config_info_beta` (
                                    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                    `data_id` VARCHAR(255) NOT NULL COMMENT 'data_id',
                                    `group_id` VARCHAR(128) NOT NULL COMMENT 'group_id',
                                    `app_name` VARCHAR(128) DEFAULT NULL COMMENT 'app_name',
                                    `content` LONGTEXT NOT NULL COMMENT 'content',
                                    `beta_ips` VARCHAR(1024) DEFAULT NULL COMMENT 'betaIps',
                                    `md5` VARCHAR(32) DEFAULT NULL COMMENT 'md5',
                                    `gmt_create` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `gmt_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                    `src_user` TEXT COMMENT 'source user',
                                    `src_ip` VARCHAR(50) DEFAULT NULL COMMENT 'source ip',
                                    `tenant_id` VARCHAR(128) DEFAULT '' COMMENT '租户字段',
                                    `encrypted_data_key` TEXT NOT NULL COMMENT '秘钥',
                                    PRIMARY KEY (`id`),
                                    UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_beta';

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info_tag   */
/******************************************/
CREATE TABLE `config_info_tag` (
                                   `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                                   `data_id` VARCHAR(255) NOT NULL COMMENT 'data_id',
                                   `group_id` VARCHAR(128) NOT NULL COMMENT 'group_id',
                                   `tenant_id` VARCHAR(128) DEFAULT '' COMMENT 'tenant_id',
                                   `tag_id` VARCHAR(128) NOT NULL COMMENT 'tag_id',
                                   `app_name` VARCHAR(128) DEFAULT NULL COMMENT 'app_name',
                                   `content` LONGTEXT NOT NULL COMMENT 'content',
                                   `md5` VARCHAR(32) DEFAULT NULL COMMENT 'md5',
                                   `gmt_create` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                   `gmt_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                   `src_user` TEXT COMMENT 'source user',
                                   `src_ip` VARCHAR(50) DEFAULT NULL COMMENT 'source ip',
                                   PRIMARY KEY (`id`),
                                   UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_tag';

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_tags_relation   */
/******************************************/
CREATE TABLE `config_tags_relation` (
                                        `id` BIGINT(20) NOT NULL COMMENT 'id',
                                        `tag_name` VARCHAR(128) NOT NULL COMMENT 'tag_name',
                                        `tag_type` VARCHAR(64) DEFAULT NULL COMMENT 'tag_type',
                                        `data_id` VARCHAR(255) NOT NULL COMMENT 'data_id',
                                        `group_id` VARCHAR(128) NOT NULL COMMENT 'group_id',
                                        `tenant_id` VARCHAR(128) DEFAULT '' COMMENT 'tenant_id',
                                        `nid` BIGINT(20) NOT NULL AUTO_INCREMENT,
                                        PRIMARY KEY (`nid`),
                                        UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`),
                                        KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_tag_relation';

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = group_capacity   */
/******************************************/
CREATE TABLE `group_capacity` (
                                  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                  `group_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
                                  `quota` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
                                  `usage` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '使用量',
                                  `max_size` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
                                  `max_aggr_count` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
                                  `max_aggr_size` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
                                  `max_history_count` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
                                  `gmt_create` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                  `gmt_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                  PRIMARY KEY (`id`),
                                  UNIQUE KEY `uk_group_id` (`group_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='集群、各Group容量信息表';

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = his_config_info   */
/******************************************/
CREATE TABLE `his_config_info` (
                                   `id` BIGINT(64) UNSIGNED NOT NULL,
                                   `nid` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
                                   `data_id` VARCHAR(255) NOT NULL,
                                   `group_id` VARCHAR(128) NOT NULL,
                                   `app_name` VARCHAR(128) DEFAULT NULL COMMENT 'app_name',
                                   `content` LONGTEXT NOT NULL,
                                   `md5` VARCHAR(32) DEFAULT NULL,
                                   `gmt_create` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                   `gmt_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                   `src_user` TEXT,
                                   `src_ip` VARCHAR(50) DEFAULT NULL,
                                   `op_type` CHAR(10) DEFAULT NULL,
                                   `tenant_id` VARCHAR(128) DEFAULT '' COMMENT '租户字段',
                                   `encrypted_data_key` TEXT NOT NULL COMMENT '秘钥',
                                   PRIMARY KEY (`nid`),
                                   KEY `idx_gmt_create` (`gmt_create`),
                                   KEY `idx_gmt_modified` (`gmt_modified`),
                                   KEY `idx_did` (`data_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='多租户改造';


/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = tenant_capacity   */
/******************************************/
CREATE TABLE `tenant_capacity` (
                                   `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                   `tenant_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT 'Tenant ID',
                                   `quota` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
                                   `usage` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '使用量',
                                   `max_size` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
                                   `max_aggr_count` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
                                   `max_aggr_size` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
                                   `max_history_count` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
                                   `gmt_create` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                   `gmt_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                   PRIMARY KEY (`id`),
                                   UNIQUE KEY `uk_tenant_id` (`tenant_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='租户容量信息表';


CREATE TABLE `tenant_info` (
                               `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
                               `kp` VARCHAR(128) NOT NULL COMMENT 'kp',
                               `tenant_id` VARCHAR(128) DEFAULT '' COMMENT 'tenant_id',
                               `tenant_name` VARCHAR(128) DEFAULT '' COMMENT 'tenant_name',
                               `tenant_desc` VARCHAR(256) DEFAULT NULL COMMENT 'tenant_desc',
                               `create_source` VARCHAR(32) DEFAULT NULL COMMENT 'create_source',
                               `gmt_create` BIGINT(20) NOT NULL COMMENT '创建时间',
                               `gmt_modified` BIGINT(20) NOT NULL COMMENT '修改时间',
                               PRIMARY KEY (`id`),
                               UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`),
                               KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='tenant_info';

CREATE TABLE `users` (
                         `username` VARCHAR(50) NOT NULL PRIMARY KEY,
                         `password` VARCHAR(500) NOT NULL,
                         `enabled` BOOLEAN NOT NULL
);

CREATE TABLE `roles` (
                         `username` VARCHAR(50) NOT NULL,
                         `role` VARCHAR(50) NOT NULL,
                         UNIQUE INDEX `idx_user_role` (`username` ASC, `role` ASC) USING BTREE
);

CREATE TABLE `permissions` (
                               `role` VARCHAR(50) NOT NULL,
                               `resource` VARCHAR(255) NOT NULL,
                               `action` VARCHAR(8) NOT NULL,
                               UNIQUE INDEX `uk_role_permission` (`role`,`resource`,`action`) USING BTREE
);

INSERT INTO users (username, PASSWORD, enabled) VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', TRUE);

INSERT INTO roles (username, role) VALUES ('nacos', 'ROLE_ADMIN');
```
# docker-compose.yaml内容如下：
```yaml
version: "3.0"
services:
  nacos:
    image: nacos/nacos-server:2.0.3
    container_name: nacos
    volumes:
      - ./logs/:/home/nacos/logs
    ports:
      - "8848:8848"
      - "9848:9848"
    environment:
      MODE: standalone
      PREFER_HOST_MODE: hostname
      SPRING_DATASOURCE_PLATFORM: mysql
      MYSQL_SERVICE_HOST: 数据库IP地址（例：127.0.0.1）
      MYSQL_SERVICE_DB_NAME: 数据库名称
      MYSQL_SERVICE_PORT: 数据库端口号
      MYSQL_SERVICE_USER: 数据库连接用户名
      MYSQL_SERVICE_PASSWORD: 数据库连接密码
    restart: always
```
# web登录页
http://IP:8848/nacos
用户名和密码都是nacos