---
title: deepin下安装docker-compose
date: 2022-07-05 21:57:49
tags: [docker,deepin]
categories: [docker,deepin]
---

# 下载文件

```shell
sudo wget -c -t 0 https://github.com/docker/compose/releases/download/1.26.0/docker-compose-`uname -s`-`uname -m` -O /usr/local/bin/docker-compose
```

![](https://img.huangge1199.cn/blog/inDCByOsDeepin/2022-07-05-21-18-26-image.png)

# 添加执行权限

```shell
sudo chmod a+rx /usr/local/bin/docker-compose
```

![](https://img.huangge1199.cn/blog/inDCByOsDeepin/2022-07-05-21-20-08-image.png)

# 验证是否安装成功

```shell
docker-compose -v
```

![](https://img.huangge1199.cn/blog/inDCByOsDeepin/2022-07-05-21-20-46-image.png)

# 卸载

```shell
sudo rm /usr/local/bin/docker-compose
```
