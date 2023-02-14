---
title: deepin下安装nvm
date: 2022-06-03 14:51:52
tags: [deepin,安装部署]
categories: [安装部署]
---

# 1、下载安装包

```shell
wget https://github.com/nvm-sh/nvm/archive/refs/tags/v0.39.2.tar.gz -O nvm-0.39.2.tar.gz
```

![image-20221209002248521](/home/huangge1199/Projects/my-blog/source/_posts/inNvmByOsDeepin/image-20221209002248521.png)

# 2、解压

```shell
tar -zxvf nvm-0.39.2.tar.gz
```

# 3、安装

```shell
# 切换目录
cd nvm-0.39.2/
# 执行安装命令
./install.sh
# 查看nvm版本，检查是否安装成功
nvm -v
```

![image-20221209004412627](/home/huangge1199/Projects/my-blog/source/_posts/inNvmByOsDeepin/image-20221209004412627.png)