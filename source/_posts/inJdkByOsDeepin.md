---
title: deepin下安装jdk
date: 2022-06-03 14:43:52
tags: [deepin,安装部署]
categories: [安装部署]
---

# 1、jdk 下载

[官网下载地址](https://www.oracle.com/java/technologies/downloads/#java11)如下：

![image-20220603015920009](https://img.huangge1199.cn/blog/inJdkByOsDeepin/image-20220603015920009.png)

> 注意区分是哪个版本的

# 2、安装deb包

终端进入到deb文件所在目录，执行安装命令：

```shell
sudo dpkg -i jdk-11.0.15.1_linux-x64_bin.deb
```

![image-20220603020439325](https://img.huangge1199.cn/blog/inJdkByOsDeepin/image-20220603020439325.png)

# 3、配置环境变量

终端执行命令：

```shell
sudo vi /etc/profile
```

然后输入密码，在文件的最后加上下面的内容

```
#configuration java development enviroument
export JAVA_HOME=/usr/lib/jvm/jdk-11
export PATH=$JAVA_HOME/bin:$PATH 
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar 
```

# 4、使环境变量生效

执行命令：

```shell
source /etc/profile
```

![image-20220603021925685](https://img.huangge1199.cn/blog/inJdkByOsDeepin/image-20220603021925685.png)

# 5、检查是否成功

执行命令：

```she
java -version
```

![image-20220603022022217](https://img.huangge1199.cn/blog/inJdkByOsDeepin/image-20220603022022217.png)
