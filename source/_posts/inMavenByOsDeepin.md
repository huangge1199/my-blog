---
title: deepin下安装Maven
date: 2022-06-03 14:46:52
tags: [deepin,安装部署]
categories: [安装部署]
---

# 1、前置条件

安装好jdk

参考：[deepin下安装jdk](https://site.huangge1199.cn/399.html)

# 2、下载安装包

官网地址：[maven下载页面](https://maven.apache.org/download.cgi)

![image-20220603115702494](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inMavenByOsDeepin/image-20220603115702494.png)

我这边下载的是3.8.5版本的，如果下载其他版本，用下面的链接：

[其他版本maven](https://archive.apache.org/dist/maven/maven-3/)

![image-20220603120000596](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inMavenByOsDeepin/image-20220603120000596.png)

# 3、解压

```shell
tar -xf apache-maven-3.8.5-bin.tar.gz
ls -l
```

![image-20220603120156243](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inMavenByOsDeepin/image-20220603120156243.png)

# 4、移动

```shell
mv apache-maven-3.8.5 ../app/
ls -l
ls -l ../app/
```

![image-20220603120347751](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inMavenByOsDeepin/image-20220603120347751.png)

# 5、配置环境变量

```shell
sudo vi /etc/profile
```

文件最下面加入下面的内容

```
# configuration maven development enviroument
export MAVEN_HOME=/home/deepin/app/apache-maven-3.8.5
export PATH=$PATH:$MAVEN_HOME/bin
```

![image-20220603121051155](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inMavenByOsDeepin/image-20220603121051155.png)

执行命令让配置文件生效：

```shell
source /etc/profile
```

![image-20220603121153205](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inMavenByOsDeepin/image-20220603121153205.png)

# 6、验证

查看maven版本做验证：

```shell
mvn -v
```

![image-20220603121458972](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inMavenByOsDeepin/image-20220603121458972.png)

# 7、配置仓库文件目录

```shell
vi /home/deepin/app/apache-maven-3.8.5/conf/settings.xml
```

找到localRepository，在下方加入下面的内容：

```xml
<localRepository>/home/deepin/repo</localRepository>
```

红框内容为新加入的

![image-20220603122200505](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inMavenByOsDeepin/image-20220603122200505.png)

# 8、添加阿里镜像源

```shell
vi /home/deepin/app/apache-maven-3.8.5/conf/settings.xml
```

找到mirror添加下面的内容：

```xml
<mirror>	
    <id>alimaven</id>
    <mirrorOf>*</mirrorOf>
    <name>aliyun maven</name>
    <url>https://maven.aliyun.com/repository/public</url>
</mirror>
```

下面红框内容为添加的

![image-20220603122859128](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inMavenByOsDeepin/image-20220603122859128.png)
