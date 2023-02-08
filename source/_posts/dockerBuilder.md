---
title: docker镜像构建以及宿主机和容器间的相互拷贝
date: 2023-02-08 15:36:29
tags: [云原生2023]
categories: [云原生2023]
---

# 前言

主要学习docker的相关操作，构建镜像、docker容器运行、从容器内往外拷贝文件，向容器内拷贝文件，进入容器

# docker构建镜像

编写Dockerfile文件：

```shell
vi Dockerfile
```

文件内输入

```shell
from nginx
```

![](https://img.huangge1199.cn/blog/dockerBuilder/2023-02-08-15-47-05-image.png)

在同目录执行构建命令：

```shell
docker build -t my-nginx .
```

![](https://img.huangge1199.cn/blog/dockerBuilder/2023-02-08-15-48-33-image.png)

# docker容器运行

执行命令：

```shell
# 运行命令
docker run --name my-nginx -d -p 40080:80 my-nginx
# 查看所有容器信息
docker ps -a
```

![](https://img.huangge1199.cn/blog/dockerBuilder/2023-02-08-15-54-23-image.png)

浏览器输入`IP:40080`，显示默认nginx页面

![](https://img.huangge1199.cn/blog/dockerBuilder/2023-02-08-16-02-20-image.png)

# 从容器内往外拷贝文件

执行命令：

```shell
# 拷贝文件
docker cp my-nginx:/usr/share/nginx/html/index.html index.html
# 查看文件内容
cat index.html
# 修改文件内容
vi index.html
# 查看文件内容
cat index.html
```

![](https://img.huangge1199.cn/blog/dockerBuilder/2023-02-08-16-06-03-image.png)

# 向容器内拷贝文件

执行命令：

```shell
# 拷贝文件
docker cp index.html my-nginx:/usr/share/nginx/html/index.html 
```

![](https://img.huangge1199.cn/blog/dockerBuilder/2023-02-08-16-08-22-image.png)

浏览器输入`IP:40080`，显示页面已经改变

![](https://img.huangge1199.cn/blog/dockerBuilder/2023-02-08-16-09-59-image.png)

# 进入容器

为了方便查看变化，这里拷贝了一份不一样的文件进人容器，执行命令：

```shell
# 修改文件名
mv index.html new.html
# 修改文件内容
vi new.html
# 拷贝文件进容器
docker cp new.html my-nginx:/usr/share/nginx/html/new.html
# 查看修改文件的内容
cat new.html
```

![](https://img.huangge1199.cn/blog/dockerBuilder/2023-02-08-16-34-23-image.png)

执行命令：

```shell
# 从容器中拷贝nginx配置文件
docker cp my-nginx:/etc/nginx/conf.d/default.conf .
# 查看配置文件
cat default.conf
```

![](https://img.huangge1199.cn/blog/dockerBuilder/2023-02-08-16-29-28-image.png)

```shell
# 修改配置文件
vi default.conf
# 查看修改后的配置文件
cat default.conf
```

![](https://img.huangge1199.cn/blog/dockerBuilder/2023-02-08-16-30-01-image.png)

```shell
# 再将配置文件拷贝回容器
docker cp default.conf my-nginx:/etc/nginx/conf.d/default.conf
# 进入容器
docker exec -it my-nginx /bin/bash
# 查看拷贝进容器的文件
cat /usr/share/nginx/html/new.html
```

![](https://img.huangge1199.cn/blog/dockerBuilder/2023-02-08-16-37-58-image.png)

```shell
# 查看拷贝进容器的nginx配置文件
cat /etc/nginx/conf.d/default.conf
# 重启nginx
nginx -s reload
# 退出容器
exit
```

![](https://img.huangge1199.cn/blog/dockerBuilder/2023-02-08-16-38-52-image.png)

浏览器输入`IP:40080`，显示页面已经改变

![](https://img.huangge1199.cn/blog/dockerBuilder/2023-02-08-16-39-30-image.png)