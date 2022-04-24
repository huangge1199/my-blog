---
title: docker安装
date: 2022-04-24 13:59:34
tags: [docker]
categories: [docker]
---
安装docker

这部分基本就是按照docker官网的来，[centos安装docker文档](https://docs.docker.com/engine/install/centos/)

# 1、卸载旧版本docker

```sh
yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
```

![](dockerInstall/2022-04-20-23-44-07-image.png)

# 2、设置docker软件源

下面官网软件源和阿里软件源二选一，个人建议用阿里的，国内的速度快

官网软件源 ：速度慢，可以考虑阿里的

```shell
yum install -y yum-utils
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
```

![](dockerInstall/2022-04-20-23-47-39-image.png)

阿里软件源：

![](dockerInstall/2022-04-21-00-00-59-image.png)

# 3、安装docker

```shell
yum install docker-ce docker-ce-cli containerd.io
```

命令输入后，中途出现下面的内容，输入`y`，然后按回车确认

![](dockerInstall/2022-04-20-23-50-06-image.png)

中途出现下面的内容，输入`y`，然后按回车确认

![](dockerInstall/2022-04-21-00-05-16-image.png)

# 4、更改docker仓库地址，用Docker中国区官方替换掉，要不之后拉取镜像速度太慢了

```shell
vi /etc/docker/daemon.json
```

daemon.json内容：

```json
{
 "registry-mirrors": ["https://registry.docker-cn.com"]
}
```

# 5、启动docker

```shell
systemctl start docker
```

![](dockerInstall/2022-04-21-00-22-21-image.png)

# 6、设置开机启动docker

```shell
systemctl enable docker
```

![](dockerInstall/2022-04-21-00-22-43-image.png)

# 7、验证

通过查询docker版本确认docker是否正常启动

```shell
docker -v
```

执行命令后正常显示docker版本则为安装启动成功
