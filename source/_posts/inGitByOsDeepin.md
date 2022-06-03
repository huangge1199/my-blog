---
title: deepin下安装git
date: date: 2022-06-03 14:30:52
tags: [deepin,安装部署]
categories: [安装部署]
---

> 个人建议直接终端安装，下面的安装也是终端命令行安装的

# 1、安装git

执行安装命令：

```she
sudo apt-get install git
```

![image-20220603103757605](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inGitByOsDeepin/image-20220603103757605.png)

# 2、确认git安装成功

执行查看git版本的命令，以此确认安装成功

```shell
git --version
```

![image-20220603103959058](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inGitByOsDeepin/image-20220603103959058.png)

# 3、配置git全局用户名和邮箱

配置全局用户名：

```shell
git config --global user.name "用户名"
```

![image-20220603104225094](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inGitByOsDeepin/image-20220603104225094.png)

配置全局邮箱：

```shel
git config --global user.email "邮箱"
```

![image-20220603104335664](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inGitByOsDeepin/image-20220603104335664.png)

# 4、确认配置结果

查看配置信息确认

```shell
git config --list
```

![image-20220603104447770](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inGitByOsDeepin/image-20220603104447770.png)
