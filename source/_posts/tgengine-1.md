---
title: TDengine安装使用
date: 2022-11-24 15:03:40
tags: [deepin,安装部署]
categories: [安装部署]
---

# 引言

近期，听说了时序数据库TDengine，本人的好奇心又出来了，同是时序数据库的InfluxDB不也挺好的嘛？通过一些网上的资料以及些简单的实际操作，本人得出的结论是：

- 数据量少时，InfluxDB的性能好些

- 当数据量越来越大之后，TDengine就更适合你使用了

# 内容介绍

本文将会围绕TGengine进行简单的介绍，当然我也是初次使用，这份文档也只是初步的学习记录，如果有朋友在实际中使用了TGengine并且觉得这篇文章有什么问题，还请在下方留言，我会根据实际情况对文章进行修改，这样也是为了防止给别人留坑

1. 对TGengine做下简单介绍（摘抄自官方文档）

2. 安装TGengine服务端的过程

3. TDengine 数据建模

4. DataGrip如何查看数据

5. 使用java语言进行REST连接测试

另外，我这边服务端是使用`TDengine-server-2.6.0.30-Linux-x64.tar.gz`进行安装的

# 介绍

> 注：本段内容摘自[官方文档](https://docs.taosdata.com/2.6/intro/)

TDengine 是一款高性能、分布式、支持 SQL 的时序数据库 (Database)，其核心代码，包括集群功能全部开源（开源协议，AGPL v3.0）。TDengine 能被广泛运用于物联网、工业互联网、车联网、IT 运维、金融等领域。除核心的时序数据库 (Database) 功能外，TDengine 还提供缓存、数据订阅、流式计算等大数据平台所需要的系列功能，最大程度减少研发和运维的复杂度。

# 牢骚

在对比的过程中，我发现TDengine的官方文档不是太好，怎么说尼，虽然更改方面都提及到了，但是需要看很多内容之后才能完全的解决好，这个就不是太好了。比如说安装，虽然在立即开始里面有，但是详细的安装卸载是放在运维指南里面，按照我们的习惯，从上往下，从左往右，可能看到最后，才看到安装和卸载，但是在这之前却是有大量的实际操作文档在中间夹杂。

![](https://img.huangge1199.cn/blog/tgengine-1/2022-11-24-15-26-47-image.png)

# 安装服务端

目前 2.X 版服务端 taosd 和 taosAdapter 仅在 Linux 系统上安装和运行，应用驱动 taosc 与 TDengine CLI 可以在 Windows 或 Linux 上安装和运行。另外在 2.4 之前的版本中没有 taosAdapter，RESTful 接口是由 taosd 内置的 HTTP 服务提供的。

1. 下载安装包<font color='green'>TDengine-server-2.6.0.30-Linux-x64.tar.gz (45 M)</font>并上传至服务器
   
   链接: https://pan.baidu.com/s/1-w7O2xUuq0iaF1glh36bow?pwd=ansm 提取码: ansm 

2. 进入安装包所在目录，解压文件
   
   ```shell
   # 解压命令
   tar -zxvf TDengine-server-2.6.0.30-Linux-x64.tar.gz
   ```

3. 进入解压目录，执行其中的 install.sh 安装脚本
   
   ```shell
   # 进入解压目录命令（目录根据自己的解决自行更改）
   cd /app/TDengine-server-2.6.0.30
   # 执行安装命令
   ./install.sh
   ```

> 注：中途两次输入，直接回车就好，什么都不用输入

![2022-11-24-16-07-50-image.png](https://img.huangge1199.cn/blog/tgengine-1/42c99f658589ee0c93af7c4742ce9616684c4ef6.png)

4. 启动taosd并确认状态
   
   ```shell
   # 启动命令
   systemctl start taosd
   # 确认状态
   systemctl status taosd
   ```

![](https://img.huangge1199.cn/blog/tgengine-1/2022-11-24-16-16-30-image.png)

5. 启动taosAdapter并确认状态
   
   > 注：TDengine 在 2.4 版本之后包含一个独立组件 taosAdapter 需要使用 systemctl 命令管理 taosAdapter 服务的启动和停止，不符合的要跳过本步骤
   
   ```shell
   ```shell
   # 启动命令
   systemctl start taosadapter
   # 确认状态
   systemctl status taosadapter
   ```
   ```

![](https://img.huangge1199.cn/blog/tgengine-1/2022-11-24-16-23-43-image.png) 

6. 进入taos，确认安装成功、
   
   ```shell
   # 启动命令(默认密码taosdata)
   taos -p
   ```

![](https://img.huangge1199.cn/blog/tgengine-1/2022-11-24-16-27-20-image.png) 

# TDengine 数据建模

1. 创建数据库
   
   ```shell
   # 创建数据库命令
   CREATE DATABASE power;
   # 切换数据库
   USE power;
   ```

![](https://img.huangge1199.cn/blog/tgengine-1/2022-11-24-16-33-10-image.png)

2. 创建表
   
   ```shell
   # 创建表
   create table t (ts timestamp, speed int);
   # 插入2条数据(建议插入两条记录时隔几秒)
   insert into t values (now, 10);
   insert into t values (now, 20);
   ```

![](https://img.huangge1199.cn/blog/tgengine-1/2022-11-24-16-37-22-image.png)

3. 查询表数据
   
   ```shell
   # 查询表 t
   select * from t;
   ```

![](https://img.huangge1199.cn/blog/tgengine-1/2022-11-24-16-38-51-image.png)

# DataGrip查看数据

1. 编译jar
   
   从 GitHub 仓库克隆 JDBC 连接器的源码，`git clone https://github.com/taosdata/taos-connector-jdbc.git -b 2.0.40`（此处推荐 -b 指定发布了的 Tags 版本）
   
   克隆完源码后，若是编译 2.0.40 及以下版本的將commons-logging 依赖包的 scope 值由 test 改为 compile
   
   ![](https://img.huangge1199.cn/blog/tgengine-1/2022-11-24-16-59-32-image.png)
   
   在目录下执行：`mvn clean package -D maven.test.skip=true`

![](https://img.huangge1199.cn/blog/tgengine-1/2022-11-24-17-02-35-image.png)

2. 自建驱动
   
   使用Driver and Data Source，自建驱动，注意红框内容，jar包是之前编译生成的

![](https://img.huangge1199.cn/blog/tgengine-1/2022-11-24-16-48-41-image.png)

3. 创建数据库连接
   
   第一个红框Driver选择之前自建的，第二个红框URL 写`jdbc:TAOS-RS://IP:6041/数据库名`

![](https://img.huangge1199.cn/blog/tgengine-1/2022-11-24-17-08-57-image.png)

# java进行REST连接测试

新建Springboot项目，maven引入jar包

```xml
<dependency>
    <groupId>com.taosdata.jdbc</groupId>
    <artifactId>taos-jdbcdriver</artifactId>
    <version>2.0.40</version>
</dependency>
```

main 方法:

```java
public static void main(String[] args) throws SQLException {
    String jdbcUrl = "jdbc:TAOS-RS://IP:6041/数据库名?user=用户名&password=密码";
    Connection conn = DriverManager.getConnection(jdbcUrl);
    System.out.println("Connected");
    conn.close();
}
```

测试结果：

![](https://img.huangge1199.cn/blog/tgengine-1/2022-11-24-17-15-33-image.png)
