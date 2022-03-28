---
title: influxdb安装（centos7）
date: 2022-03-12 18:14:53
tags: [安装部署]
categories: [安装部署]
cover: https://blog.huangge1199.cn/post/jpaCompositePK/bg.jpg
---

# 1、获取安装包

```sh
wget https://dl.influxdata.com/influxdb/releases/influxdb-1.8.10.x86_64.rpm
```

![](influxdbInstall/2022-03-12-18-28-41-image.png)

# 2、安装

```sh
yum localinstall influxdb-1.8.10.x86_64.rpm
```

# 3、配置

```shell
vim /etc/influxdb/influxdb.conf
```

用户名密码（非必须）

![](influxdbInstall/2022-03-12-18-41-44-image.png)

开启influx功能

![](influxdbInstall/2022-03-12-18-42-25-image.png)

# 4、启动服务

```shell
systemctl start influxdb
```

# 5、启动

```shell
influx
```

在客户端工具窗口中执行以下语句设置用户名和密码（非必须）：

```shell
# 创建管理员权限的用户
CREATE USER root WITH PASSWORD 'root' WITH ALL PRIVILEGES
```

# 6、验证

用其他机器远程连接：

```shell
influx -host ip地址 -port 端口号
```

![](influxdbInstall/2022-03-12-18-54-58-image.png)

这里创建数据库时报错，是因为我这边配置了用户名和密码，需要连接时带上用户名和密码才行

```shell
iinflux -host ip地址 -port 端口号 -username 用户名 -password 密码
```

![](influxdbInstall/2022-03-12-18-56-23-image.png)
