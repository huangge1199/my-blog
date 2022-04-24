---
title: docker-compose安装
date: 2022-04-24 15:12:03
tags: [docker]
categories: [docker]
---
docker-compose安装

按照官方来即可，[docker-compose安装文档](https://docs.docker.com/compose/install/)

按照自己的系统来安装：

![](dockerComposeInstall\2022-04-21-00-36-46-image.png)

# 1、下载docker-compose

下面两个二选一，建议国内源，速度快

官方：

```shell
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

国内源：

```shell
curl -L https://get.daocloud.io/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
```

![](dockerComposeInstall\2022-04-21-00-40-56-image.png)

# 2、授予权限

```shell
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

# 3、验证

```shell
docker-compose --version
```

输入命令后，出现版本号，则为安装成功

![](dockerComposeInstall\2022-04-21-00-44-14-image.png)
