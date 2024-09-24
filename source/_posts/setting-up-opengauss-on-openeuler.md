---
title: 如何在openEuler上安装和配置openGauss数据库
tags: [数据库]
categories: [数据库]
date: 2024-09-24 10:39:46
---

本文将详细介绍如何在openEuler 22.03 LTS SP1上安装和配置openGauss数据库，包括数据库的启动、停止、远程连接配置等关键步骤。

# 1、安装

使用[OpenEuler-22.03-LTS-SP1-x64](https://www.openeuler.org/zh/download/archive/detail/?version=openEuler%2022.03%20LTS%20SP1)版本的系统，通过命令行安装openGauss数据库。

## 1.1、确保系统软件包索引是最新的

以root权限执行以下命令：

```shell
sudo dnf update -y
```

## 1.2、安装openGauss

以root权限执行以下命令：

```shell
sudo dnf install -y opengauss
```

安装完成后，二进制文件目录在 `/usr/local/opengauss`：

```shell
ls -l /usr/local/opengauss
```

![](https://img.huangge1199.cn/blog/setting-up-opengauss-on-openeuler/2024-09-24-11-04-56-image.png)

默认数据目录在 `/var/lib/opengauss/data`：

```shell
ls -l /var/lib/opengauss/data
```

![](https://img.huangge1199.cn/blog/setting-up-opengauss-on-openeuler/2024-09-24-11-06-02-image.png)

# 2、数据库启动停止

需要切换到opengauss用户下操作：

```shell
su - opengauss
```

![](https://img.huangge1199.cn/blog/setting-up-opengauss-on-openeuler/2024-09-24-11-12-14-image.png) 

## 2.1、查询数据库状态

在opengauss用户下执行命令：

```shell
ps ux
```

![](https://img.huangge1199.cn/blog/setting-up-opengauss-on-openeuler/2024-09-24-11-17-06-image.png)

可以看到opengauss已经启动了

## 2.2、停止数据库

执行以下命令停止数据库：

```shell
# 停止命令
gs_ctl stop -D /var/lib/opengauss/data -Z single_node
# 查看状态确认停止
ps ux
```

![](https://img.huangge1199.cn/blog/setting-up-opengauss-on-openeuler/2024-09-24-11-20-11-image.png)

## 2.3、启动数据库

执行以下命令启动数据库：

```shell
# 启动命令
gs_ctl start -D /var/lib/opengauss/data -Z single_node
# 查看状态确认停止
ps ux
```

![](https://img.huangge1199.cn/blog/setting-up-opengauss-on-openeuler/2024-09-24-11-22-41-image.png)

## 2.4、重启数据库

执行以下命令重启数据库：

```shell
# 重启命令
gs_ctl restart -D /var/lib/opengauss/data -Z single_node
# 查看状态确认停止
ps ux
```

![](https://img.huangge1199.cn/blog/setting-up-opengauss-on-openeuler/2024-09-24-11-24-58-image.png)

# 3、密码规则配置

建议在数据库安装好后立即配置。在`/var/lib/opengauss/data/postgresql.conf`文件的108行左右，去掉注释，设置成0或1。

![](https://img.huangge1199.cn/blog/setting-up-opengauss-on-openeuler/2024-09-24-11-37-47-image.png)

# 4、远程连接

数据库默认安装完是不能远程连接的，需要修改配置文件。数据库的远程操作不能使用默认的超级用户，需要新建一个业务用户，而数据库的操作需要有密码，因此整个步骤如下：

1. 修改配置文件

2. 超级用户连接数据库

3. 给超级用户设置密码

4. 通过超级用户创建业务用户并设置密码

5. 给业务用户分配权限

6. 远程连接测试 

## 4.1、修改配置文件

- 在`/var/lib/opengauss/data/postgresql.conf`文件中，设置 `listen_addresses = '*'`（大约第68行）

- 在`/var/lib/opengauss/data/pg_hba.conf`文件中，设置`host all all 0.0.0.0/0 md5`（大约在91行）

修改完后需要重启数据库。

## 4.2、超级用户连接数据库

以超级用户opengauss连接数据库：

```shell
gsql -d postgres -p 7654 -r
```

![](https://img.huangge1199.cn/blog/setting-up-opengauss-on-openeuler/2024-09-24-11-28-56-image.png)

## 4.3、给超级用户设置密码

执行以下命令：

```sql
ALTER USER opengauss WITH PASSWORD 'opengauss@123';
```

![](https://img.huangge1199.cn/blog/setting-up-opengauss-on-openeuler/2024-09-24-11-57-12-image.png)

## 4.4、创建业务用户并设置密码

执行以下命令：

```sql
CREATE USER admin WITH PASSWORD 'admin@123';
```

![](https://img.huangge1199.cn/blog/setting-up-opengauss-on-openeuler/2024-09-24-12-00-03-image.png)

## 4.5、给业务用户分配权限

执行以下命令：

```sql
GRANT ALL PRIVILEGES ON DATABASE postgres TO admin;
```

![](https://img.huangge1199.cn/blog/setting-up-opengauss-on-openeuler/2024-09-24-13-06-01-image.png)

## 4.6、远程连接测试

使用`Navicat Premium Lite 17`作为测试工具进行远程连接。

![](https://img.huangge1199.cn/blog/setting-up-opengauss-on-openeuler/2024-09-24-13-23-39-image.png)

# 5、总结

通过上述步骤，已经成功在openEuler上安装并配置了openGauss数据库，确保能够进行正常的数据库操作和远程连接。
