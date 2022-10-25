---
title: 群晖nas上部署gitea后修改IP地址
date: 2022-10-25 11:14:24
tags: [nas]
categories: [nas,安装部署]
---

# 事件

今天，我在nas的套件中心中发现了Gitea这个套件，想到自己的代码都是保存在GitHub或者Gitee上面的，
于是乎我边在nas上面装了这个套件，装备将代码在nas里面也备份一份

我的nas所在网络没有公网IP，用内网穿透形式弄的，但是在用穿透后的`IP:端口`进入时，就报了下面的警告

![](https://img.huangge1199.cn/blog/giteaNas/2022-10-25-12-25-02-image.png)

看介绍，是说地址不一样了，绿框中的地址分别是我本地地址和穿透后的公网地址，为了方便，我就想把地址换成
公网的地址，这样以后复制地址什么的也方便

# 换IP

有两种方法：

1. 每次都将本地IP改为穿透的公网ip
2. 修改配置文件`conf.ini`

第一种方法需要每一次都改，太麻烦了，我这里使用的是第二种方法

群晖的gitea的配置文件是在安装目录下的`/var`下面，我安装在`/var/packages`里

![](https://img.huangge1199.cn/blog/giteaNas/2022-10-25-12-24-05-1666671836575.jpg)

打开`conf.ini`文件，注意这地方需要root权限，因此执行命令

```shell
sudo vi conf.ini
```

![](https://img.huangge1199.cn/blog/giteaNas/2022-10-25-12-31-55-image.png)

将12行这地方改成穿透后的公网IP

# 重启gitea套件

1. 在套件中心中找到gitea，然后停用

![](https://img.huangge1199.cn/blog/giteaNas/2022-10-25-12-38-13-image.png)

2. 启动gitea

![](https://img.huangge1199.cn/blog/giteaNas/2022-10-25-12-39-15-image.png)

# 完成验证

为了确保成功，完成后再通过穿透后的公网进入，页面的红框消失
