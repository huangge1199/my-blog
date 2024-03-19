---
title: win电脑安装绿色版MySQL8
tags: [安装部署]
categories: [安装部署]
date: 2024-03-19 13:17:52
---

# 一、下载压缩包

下载mysql server的zip文件，地址：[Windows (x86, 64-bit), ZIP Archive](https://dev.mysql.com/downloads/file/?id=526085)

解压后：

![](https://img.huangge1199.cn/blog/win-dian-nao-an-zhuang-lv-se-ban-mysql8/2024-03-19-13-28-15-image.png)

# 二、创建配置文件（可忽略）

配置文件可存放位置及名称：

- C:\WINDOWS\my.ini

- C:\WINDOWS\my.cnf

- C:\my.ini

- C:\my.cnf

- 解压目录的根目录下（mysql-8.3.0-winx64）\my.ini 

- 解压目录的根目录下（mysql-8.3.0-winx64）\my.cnf

# 三、初始化数据库

以管理员身份运行`cmd`，进入到`bin`目录，运行下面的命令创建mysql默认的数据库，并创建一个root账号，空密码

```bash
mysqld --initialize-insecure
```

# 四、启动MySQL服务

我使用的是安装到服务的方式，执行下面的命令

```bash
mysqld --install-manual
```

![](https://img.huangge1199.cn/blog/win-dian-nao-an-zhuang-lv-se-ban-mysql8/2024-03-19-13-43-14-image.png)

默认创建的服务名称为MySQL，然后在服务中启动

![](https://img.huangge1199.cn/blog/win-dian-nao-an-zhuang-lv-se-ban-mysql8/2024-03-19-13-44-34-image.png)

也可以直接运行一下命令

```bash
mysqld
```

这是最简单的方式了，但是无法安装到服务中，其他详细的可参看帮助说明

```bash
mysqld --verbose --help | more
```

![](https://img.huangge1199.cn/blog/win-dian-nao-an-zhuang-lv-se-ban-mysql8/2024-03-19-13-39-49-image.png)

红色框内的是安装相关的命令，蓝色框内是移除服务相关的命令

# 五、测试

运行命令确认MySQL能够使用

```bash
mysql -uroot
```

![](https://img.huangge1199.cn/blog/win-dian-nao-an-zhuang-lv-se-ban-mysql8/2024-03-19-13-47-00-image.png)

# 六、修改root密码

由于前面的方式，root用户没有密码，需要添加个密码，MySQL进入后，执行下面的命令给root设置密码

```bash
use mysql；
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '新密码';
FLUSH PRIVILEGES;
```
