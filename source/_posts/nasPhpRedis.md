---
title: 群晖nas为PHP配置Redis扩展
tags: [nas]
categories: [nas]
date: 2023-07-27 10:12:03
---

首先，介绍下我的环境

- 机器：群晖920+

- PHP版本：7.4（套件安装的）

- 系统：群晖7.2

接下来，进入正题

首先要使用ssh进入到群晖，账户要切换到root用户

接下来，看下目前PHP7.4有哪些扩展，根据你安装位置的硬盘不同，`volume1`可能有所区别，命令如下：

```shell
ll /volume1/@appstore/PHP7.4/usr/local/lib/php74/modules
```

![](https://img.huangge1199.cn/blog/nasPhpRedis/2023-07-27-10-26-27-image.png)

从上图中，我发现套件版的PHP7.4默认已经有了Redis扩展，接下来，再看看配置文件中是否配置了Redis，当然我这边是没有配置

打开配置文件`php-fpm.ini`，我这边喜欢用`vi`命令，当然也可以使用`vim`，具体用哪一个看你系统支持已经个人喜好了，下面的`volume1`一样有区别的自行修改

```shell
vi /volume1/@appstore/PHP7.4/misc/php-fpm.ini
```

将下面的代码放到配置文件`php-fpm.ini`末尾，然后保存退出

```shell
[Redis]
extension_dir = "/volume1/@appstore/PHP7.4/usr/local/lib/php74/modules/"
extension = redis.so
```

![](https://img.huangge1199.cn/blog/nasPhpRedis/2023-07-27-10-46-52-image.png)

扩展有了，配置文件也加上了，最后就是重启PHP7.4了，命令如下：

```shell
synopkg restart PHP7.4
```

![](https://img.huangge1199.cn/blog/nasPhpRedis/2023-07-27-10-48-36-image.png)

看到重启成功了，至此，完成收工了
