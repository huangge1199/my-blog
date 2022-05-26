---
title: 用nexus部署maven私服
date: 2022-01-12 19:52:40
tags: [maven,nexus,安装部署]
categories: nexus
cover: bg.jpeg
---
# nexus 服务部署

由于本人习惯问题，本次继续用docker部署

## 查找docker镜像
通过https://hub.docker.com/ 网站查找，选用了官方的sonatype/nexus3

## 拉取镜像

```sh
docker pull sonatype/nexus3
```

![image-20220112202513617](image-20220112202513617.png)

## 创建宿主机挂载目录并编写docker-compose.yml

执行命令：

```sh
vi docker-compose.yml
mkdir nexus-data
```

docker-compose.yml内容：

```sh
version: '3'
services:
    nexus3:
        container_name: nexus3
        image: sonatype/nexus3:latest
        environment:
            - TZ=Asia/Shanghai
        volumes: 
            - ./nexus-data:/var/nexus-data
        ports: 
            - 8081:8081
        restart: always
```

![image-20220112203927784](image-20220112203927784.png)

## 启动容器

```sh
docker-compose up -d
```

![image-20220112204407509](image-20220112204407509.png)

## 浏览器验证

浏览器中输入http://IP:8081/，出现下面的页面启动完成

![image-20220112204921432](image-20220112204921432.png)

# Nexus 服务的配置

## 浏览器中点击右上角的登录

![image-20220112205557025](image-20220112205557025.png)

##  登录

首次登录会提示密码保存在**/nexus-data/admin.password**（位置可能会变，看提示）

![image-20220112214506743](image-20220112214506743.png)

由于这个目录我们的docker并没有引出来，所以我们要去docker容器内查看

```sh
docker exec -it nexus3 /bin/bash
cat /nexus-data/admin.password
```

这地方注意下，cat后不会换行，注意看下密码，用户名是admin，文件中存的就是密码

![image-20220112214220341](image-20220112214220341.png)

## 设置密码

登录后：

![image-20220112214637528](image-20220112214637528.png)

点击next设置新密码

![image-20220112214717867](image-20220112214717867.png)

![image-20220112214820826](image-20220112214820826.png)

![image-20220112214831857](image-20220112214831857.png)

## 增加阿里云公共仓库

由于默认的里面没有阿里云仓库，用maven的仓库速度慢，所以增加一个阿里云仓库

![image-20220112215708898](image-20220112215708898.png)

![image-20220112215809631](image-20220112215809631.png)

![image-20220112215951755](image-20220112215951755.png)

![image-20220112220131151](image-20220112220131151.png)

接下来填写信息：name这个随意填，为了方便记忆我填写的aliyun-public-proxy，下面的配置阿里云地址https://maven.aliyun.com/repository/public，两个填好后点击最下方的Create repository

![image-20220112220511830](image-20220112220511830.png)

![image-20220112220741095](image-20220112220741095.png)

## 统一私服

- 编辑**maven-public**

![image-20220112221401367](image-20220112221401367.png)

- 将刚刚的aliyun-public-proxy放入 **group** 中，并调整优先级，然后保存

![image-20220112221517343](image-20220112221517343.png)

![image-20220112221637473](image-20220112221637473.png)

## 查看私服地址

回到上一个页面，点击copy，弹出来的地址就是私服地址

![image-20220112221849871](image-20220112221849871.png)

# 使用私服

注：maven地址：E:\maven\apache-maven-3.6.3

## maven中setting.xml 文件配置

- 下载依赖

  找到mirrors位置，并将其标签内容修改如下

  ```xml
  <mirrors>
    <!-- mirror
     | Specifies a repository mirror site to use instead of a given repository. The repository that
     | this mirror serves has an ID that matches the mirrorOf element of this mirror. IDs are used
     | for inheritance and direct lookup purposes, and must be unique across the set of mirrors.
     |
    <mirror>
      <id>mirrorId</id>
      <mirrorOf>repositoryId</mirrorOf>
      <name>Human Readable Name for this Mirror.</name>
      <url>http://my.repository.com/repo/path</url>
    </mirror>
     -->
  	<mirror>
      <!--该镜像的唯一标识符。id用来区分不同的mirror元素。 -->
      <id>maven-public</id>
      <!--镜像名称 -->
      <name>maven-public</name>
      <!--*指的是访问任何仓库都使用我们的私服-->
      <mirrorOf>*</mirrorOf>
      <!--该镜像的URL。构建系统会优先考虑使用该URL，而非使用默认的服务器URL。 -->
      <url>http://192.168.1.187:8081/repository/maven-public/</url>     
    </mirror>
  </mirrors>
  ```

- 发布依赖

  找到servers位置，并将其标签内容修改如下

  ```xml
  <servers>
    <!-- server
     | Specifies the authentication information to use when connecting to a particular server, identified by
     | a unique name within the system (referred to by the 'id' attribute below).
     |
     | NOTE: You should either specify username/password OR privateKey/passphrase, since these pairings are
     |       used together.
     |
    <server>
      <id>deploymentRepo</id>
      <username>repouser</username>
      <password>repopwd</password>
    </server>
    -->
    <!-- Another sample, using keys to authenticate.
    <server>
      <id>siteServer</id>
      <privateKey>/path/to/private/key</privateKey>
      <passphrase>optional; leave empty if not used.</passphrase>
    </server>
    -->
    <server>
        <id>releases</id>
        <username>admin</username>
        <password>123456</password>
    </server>
    <server>
        <id>snapshots</id>
        <username>admin</username>
        <password>123456</password>
    </server>
  </servers>
  ```

## 新建maven项目

我这边建了一个Springboot项目

![image-20220112223312451](image-20220112223312451.png)

设置maven路径

![image-20220112224909515](image-20220112224909515.png)

## 发布依赖

1. 项目pom中添加 **distributionManagement** 节点

   ```xml
   <distributionManagement>
       <repository>
           <id>releases</id>
           <name>Releases</name>
           <url>http://192.168.1.187:8081/repository/maven-releases/</url>
       </repository>
       <snapshotRepository>
           <id>snapshots</id>
           <name>Snapshot</name>
           <url>http://192.168.1.187:8081/repository/maven-snapshots/</url>
       </snapshotRepository>
   </distributionManagement>
   ```

   注：**repository** 里的 **id** 需要和上一步里的 **server id** 名称保持一致。

2. 执行 **mvn deploy** 命令发布：

   ![image-20220112230213213](image-20220112230213213.png)

3. 查看网页，是否部署成功

   注：

   - 若项目版本号末尾带有 **-SNAPSHOT**，则会发布到 **snapshots** 快照版本仓库
   - 若项目版本号末尾带有 **-RELEASES** 或什么都不带，则会发布到 **releases** 正式版本仓库

   ![image-20220112230645860](image-20220112230645860.png)
