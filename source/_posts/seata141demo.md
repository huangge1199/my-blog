---
title: seata1.4.1服务端部署及应用
date: 2022-02-02 09:37:59
tags: [java,seata]
categories: [java,seata]
---
# seata1.4.1服务端部署及应用

springcloud-nacos-seata

**分布式事务组件seata的使用demo，AT模式，集成nacos、springboot、springcloud、mybatis-plus、feign，数据库采用mysql**

demo中使用的相关版本号，具体请看代码。如果搭建个人demo不成功，验证是否是由版本导致，由于目前这几个项目更新比较频繁，版本稍有变化便会出现许多奇怪问题

* seata 1.4.1
* spring-cloud-alibaba-seata 2.2.0.RELEASE
* spring-cloud-starter-alibaba-nacos-discovery  2.1.1.RELEASE
* springboot 2.1.10.RELEASE
* springcloud Greenwich.SR4

----------

# 1. 服务端配置

seata-server为release版本1.4.1，采用docker部署方式

https://github.com/seata/seata/releases/tag/v1.4.1)

## 1.1 docker拉取镜像

```shell
docker pull seataio/seata-server:1.4.1
```

## 1.2 启动临时容器

```shell
docker run --rm --name seata-server -d -p 8091:8091 seataio/seata-server:1.4.1
```

![](https://file.huangge1199.cn/group1/M00/00/00/CgAYB2H54oaAImNHAAAUub2sTS4448.png)

## 1.3 将配置文件拷贝出来

```shell
docker cp d5cd81d60189:/seata-server/resources/ ./conf/
```

![](https://file.huangge1199.cn/group1/M00/00/00/CgAYB2H54uCAAGPGAAALD6FSnY8866.png)

## 1.4 修改conf/registry.conf文件

修改文件，用nacos做注册中心和配置中心

```shell
vi ./conf/registry.conf
```

原始内容：

```java
registry {
  # file 、nacos 、eureka、redis、zk、consul、etcd3、sofa
  type = "file"
  loadBalance = "RandomLoadBalance"
  loadBalanceVirtualNodes = 10

  nacos {
    application = "seata-server"
    serverAddr = "127.0.0.1:8848"
    group = "SEATA_GROUP"
    namespace = ""
    cluster = "default"
    username = ""
    password = ""
  }
  eureka {
    serviceUrl = "http://localhost:8761/eureka"
    application = "default"
    weight = "1"
  }
  redis {
    serverAddr = "localhost:6379"
    db = 0
    password = ""
    cluster = "default"
    timeout = 0
  }
  zk {
    cluster = "default"
    serverAddr = "127.0.0.1:2181"
    sessionTimeout = 6000
    connectTimeout = 2000
    username = ""
    password = ""
  }
  consul {
    cluster = "default"
    serverAddr = "127.0.0.1:8500"
  }
  etcd3 {
    cluster = "default"
    serverAddr = "http://localhost:2379"
  }
  sofa {
    serverAddr = "127.0.0.1:9603"
    application = "default"
    region = "DEFAULT_ZONE"
    datacenter = "DefaultDataCenter"
    cluster = "default"
    group = "SEATA_GROUP"
    addressWaitTime = "3000"
  }
  file {
    name = "file.conf"
  }
}

config {
  # file、nacos 、apollo、zk、consul、etcd3
  type = "file"

  nacos {
    serverAddr = "127.0.0.1:8848"
    namespace = ""
    group = "SEATA_GROUP"
    username = ""
    password = ""
  }
  consul {
    serverAddr = "127.0.0.1:8500"
  }
  apollo {
    appId = "seata-server"
    apolloMeta = "http://192.168.1.204:8801"
    namespace = "application"
    apolloAccesskeySecret = ""
  }
  zk {
    serverAddr = "127.0.0.1:2181"
    sessionTimeout = 6000
    connectTimeout = 2000
    username = ""
    password = ""
  }
  etcd3 {
    serverAddr = "http://localhost:2379"
  }
  file {
    name = "file.conf"
  }
}

```

修改后的内容：

```java
registry {
  # file 、nacos 、eureka、redis、zk、consul、etcd3、sofa
  type = "nacos" # 改为nacos
  loadBalance = "RandomLoadBalance"
  loadBalanceVirtualNodes = 10

  nacos {
    application = "seata-server"
    serverAddr = "IP:端口" # 改为nacos实际的IP:端口
    group = "SEATA_GROUP"
    namespace = ""
    cluster = "default"
    username = "nacos" # 改为nacos的账号
    password = "nacos" # 改为nacos的密码
  }
  eureka {
    serviceUrl = "http://localhost:8761/eureka"
    application = "default"
    weight = "1"
  }
  redis {
    serverAddr = "localhost:6379"
    db = 0
    password = ""
    cluster = "default"
    timeout = 0
  }
  zk {
    cluster = "default"
    serverAddr = "127.0.0.1:2181"
    sessionTimeout = 6000
    connectTimeout = 2000
    username = ""
    password = ""
  }
  consul {
    cluster = "default"
    serverAddr = "127.0.0.1:8500"
  }
  etcd3 {
    cluster = "default"
    serverAddr = "http://localhost:2379"
  }
  sofa {
    serverAddr = "127.0.0.1:9603"
    application = "default"
    region = "DEFAULT_ZONE"
    datacenter = "DefaultDataCenter"
    cluster = "default"
    group = "SEATA_GROUP"
    addressWaitTime = "3000"
  }
  file {
    name = "file.conf"
  }
}

config {
  # file、nacos 、apollo、zk、consul、etcd3
  type = "nacos" # 改为nacos

  nacos {
    serverAddr = "IP:端口" # 改为nacos实际的IP:端口
    namespace = ""
    group = "SEATA_GROUP"
    username = "nacos" # 改为nacos的账号
    password = "nacos" # 改为nacos的密码
  }
  consul {
    serverAddr = "127.0.0.1:8500"
  }
  apollo {
    appId = "seata-server"
    apolloMeta = "http://192.168.1.204:8801"
    namespace = "application"
    apolloAccesskeySecret = ""
  }
  zk {
    serverAddr = "127.0.0.1:2181"
    sessionTimeout = 6000
    connectTimeout = 2000
    username = ""
    password = ""
  }
  etcd3 {
    serverAddr = "http://localhost:2379"
  }
  file {
    name = "file.conf"
  }
}

```

## 1.5 执行SQL语句

seata配置使用db事务日志存储方式

SQL文件下载地址：[seata/script/server/db at develop · seata/seata (github.com)](https://github.com/seata/seata/tree/develop/script/server/db)

## 1.6 创建config.txt并修改

config.txt文件地址：[seata/config.txt at develop · seata/seata (github.com)](https://github.com/seata/seata/blob/develop/script/config-center/config.txt)

config.txt原件：

```properties
transport.type=TCP
transport.server=NIO
transport.heartbeat=true
transport.enableClientBatchSendRequest=true
transport.threadFactory.bossThreadPrefix=NettyBoss
transport.threadFactory.workerThreadPrefix=NettyServerNIOWorker
transport.threadFactory.serverExecutorThreadPrefix=NettyServerBizHandler
transport.threadFactory.shareBossWorker=false
transport.threadFactory.clientSelectorThreadPrefix=NettyClientSelector
transport.threadFactory.clientSelectorThreadSize=1
transport.threadFactory.clientWorkerThreadPrefix=NettyClientWorkerThread
transport.threadFactory.bossThreadSize=1
transport.threadFactory.workerThreadSize=default
transport.shutdown.wait=3
service.vgroupMapping.my_test_tx_group=default
service.default.grouplist=127.0.0.1:8091
service.enableDegrade=false
service.disableGlobalTransaction=false
client.rm.asyncCommitBufferLimit=10000
client.rm.lock.retryInterval=10
client.rm.lock.retryTimes=30
client.rm.lock.retryPolicyBranchRollbackOnConflict=true
client.rm.reportRetryCount=5
client.rm.tableMetaCheckEnable=false
client.rm.tableMetaCheckerInterval=60000
client.rm.sqlParserType=druid
client.rm.reportSuccessEnable=false
client.rm.sagaBranchRegisterEnable=false
client.rm.tccActionInterceptorOrder=-2147482648
client.tm.commitRetryCount=5
client.tm.rollbackRetryCount=5
client.tm.defaultGlobalTransactionTimeout=60000
client.tm.degradeCheck=false
client.tm.degradeCheckAllowTimes=10
client.tm.degradeCheckPeriod=2000
client.tm.interceptorOrder=-2147482648
store.mode=file
store.lock.mode=file
store.session.mode=file
store.publicKey=
store.file.dir=file_store/data
store.file.maxBranchSessionSize=16384
store.file.maxGlobalSessionSize=512
store.file.fileWriteBufferCacheSize=16384
store.file.flushDiskMode=async
store.file.sessionReloadReadSize=100
store.db.datasource=druid
store.db.dbType=mysql
store.db.driverClassName=com.mysql.jdbc.Driver
store.db.url=jdbc:mysql://127.0.0.1:3306/seata?useUnicode=true&rewriteBatchedStatements=true
store.db.user=username
store.db.password=password
store.db.minConn=5
store.db.maxConn=30
store.db.globalTable=global_table
store.db.branchTable=branch_table
store.db.queryLimit=100
store.db.lockTable=lock_table
store.db.maxWait=5000
store.redis.mode=single
store.redis.single.host=127.0.0.1
store.redis.single.port=6379
store.redis.sentinel.masterName=
store.redis.sentinel.sentinelHosts=
store.redis.maxConn=10
store.redis.minConn=1
store.redis.maxTotal=100
store.redis.database=0
store.redis.password=
store.redis.queryLimit=100
server.recovery.committingRetryPeriod=1000
server.recovery.asynCommittingRetryPeriod=1000
server.recovery.rollbackingRetryPeriod=1000
server.recovery.timeoutRetryPeriod=1000
server.maxCommitRetryTimeout=-1
server.maxRollbackRetryTimeout=-1
server.rollbackRetryTimeoutUnlockEnable=false
server.distributedLockExpireTime=10000
client.undo.dataValidation=true
client.undo.logSerialization=jackson
client.undo.onlyCareUpdateColumns=true
server.undo.logSaveDays=7
server.undo.logDeletePeriod=86400000
client.undo.logTable=undo_log
client.undo.compress.enable=true
client.undo.compress.type=zip
client.undo.compress.threshold=64k
log.exceptionRate=100
transport.serialization=seata
transport.compressor=none
metrics.enabled=false
metrics.registryType=compact
metrics.exporterList=prometheus
metrics.exporterPrometheusPort=9898
```

这里根据自己需求做调整，我这里的配置如下：

```properties
service.vgroupMapping.order-service-group=default
service.vgroupMapping.storage-service-group=default
service.enableDegrade=false
service.disableGlobalTransaction=false
store.mode=db
store.db.datasource=druid
store.db.dbType=mysql
#store.db.driverClassName=com.mysql.jdbc.Driver 这个是mysql8以下的驱动
store.db.driverClassName=com.mysql.cj.jdbc.Driver #这个是mysql8的驱动
store.db.url=jdbc:mysql://192.168.0.1:3306/seata?useUnicode=true #这个是mysql的连接信息
store.db.user=root #这个是mysql的用户名
store.db.password=123456 #这个是mysql的密码
store.db.minConn=5
store.db.maxConn=30
store.db.globalTable=global_table
store.db.branchTable=branch_table
store.db.queryLimit=100
store.db.lockTable=lock_table
store.db.maxWait=5000
```



## 1.7 创建nacos-config.sh

在conf中

nacos-config.sh获取地址：[seata/script/config-center/nacos at develop · seata/seata (github.com)](https://github.com/seata/seata/tree/develop/script/config-center/nacos)

## 1.8 上传seata配置信息到nacos

先确认目录结构正确

![](https://file.huangge1199.cn/group1/M00/00/00/CgAYB2H54zyAYKwlAAAi_TSko4g044.png)

```sh
./nacos-config.sh -h docker所在机器IP -p 8848 -g SEATA_GROUP  -u nacos -w nacos
```



#### 1.2.2 修改conf/nacos-config.txt 配置

service.vgroup_mapping.${your-service-gruop}=default，中间的${your-service-gruop}为自己定义的服务组名称，服务中的application.properties文件里配置服务组名称。

demo中有两个服务，分别是storage-service和order-service，所以配置如下

~~~properties
service.vgroup_mapping.storage-service-group=defaultservice.vgroup_mapping.order-service-group=default
~~~

** 注意这里,高版本中应该是vgroupMapping 同时后面的如: order-service-group  不能定义为 order_service_group**


#### 1.3 启动seata-server

**分两步，如下**

~~~shell
# 初始化seata 的nacos配置cd confsh nacos-config.sh 192.168.21.89# 启动seata-servercd binsh seata-server.sh -p 8091 -m file
~~~

----------

# 2. 应用配置

### 2.1 数据库初始化

~~~SQL
-- 创建 order库、业务表、undo_log表create database seata_order;use seata_order;DROP TABLE IF EXISTS `order_tbl`;CREATE TABLE `order_tbl` (  `id` int(11) NOT NULL AUTO_INCREMENT,  `user_id` varchar(255) DEFAULT NULL,  `commodity_code` varchar(255) DEFAULT NULL,  `count` int(11) DEFAULT 0,  `money` int(11) DEFAULT 0,  PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;CREATE TABLE `undo_log`(  `id`            BIGINT(20)   NOT NULL AUTO_INCREMENT,  `branch_id`     BIGINT(20)   NOT NULL,  `xid`           VARCHAR(100) NOT NULL,  `context`       VARCHAR(128) NOT NULL,  `rollback_info` LONGBLOB     NOT NULL,  `log_status`    INT(11)      NOT NULL,  `log_created`   DATETIME     NOT NULL,  `log_modified`  DATETIME     NOT NULL,  `ext`           VARCHAR(100) DEFAULT NULL,  PRIMARY KEY (`id`),  UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`)) ENGINE = InnoDB  AUTO_INCREMENT = 1  DEFAULT CHARSET = utf8;-- 创建 storage库、业务表、undo_log表create database seata_storage;use seata_storage;DROP TABLE IF EXISTS `storage_tbl`;CREATE TABLE `storage_tbl` (  `id` int(11) NOT NULL AUTO_INCREMENT,  `commodity_code` varchar(255) DEFAULT NULL,  `count` int(11) DEFAULT 0,  PRIMARY KEY (`id`),  UNIQUE KEY (`commodity_code`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;CREATE TABLE `undo_log`(  `id`            BIGINT(20)   NOT NULL AUTO_INCREMENT,  `branch_id`     BIGINT(20)   NOT NULL,  `xid`           VARCHAR(100) NOT NULL,  `context`       VARCHAR(128) NOT NULL,  `rollback_info` LONGBLOB     NOT NULL,  `log_status`    INT(11)      NOT NULL,  `log_created`   DATETIME     NOT NULL,  `log_modified`  DATETIME     NOT NULL,  `ext`           VARCHAR(100) DEFAULT NULL,  PRIMARY KEY (`id`),  UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`)) ENGINE = InnoDB  AUTO_INCREMENT = 1  DEFAULT CHARSET = utf8;-- 初始化库存模拟数据INSERT INTO seata_storage.storage_tbl (id, commodity_code, count) VALUES (1, 'product-1', 9999999);INSERT INTO seata_storage.storage_tbl (id, commodity_code, count) VALUES (2, 'product-2', 0);
~~~

### 2.2 应用配置

见代码

几个重要的配置

1. 每个应用的resource里需要配置一个registry.conf ，demo中与seata-server里的配置相同
2. application.propeties 的各个配置项，注意spring.cloud.alibaba.seata.tx-service-group 是服务组名称，与nacos-config.txt 配置的service.vgroup_mapping.${your-service-gruop}具有对应关系

----------

# 3. 测试

1. 分布式事务成功，模拟正常下单、扣库存

   localhost:9091/order/placeOrder/commit

2. 分布式事务失败，模拟下单成功、扣库存失败，最终同时回滚

   localhost:9091/order/placeOrder/rollback 





