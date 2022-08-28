---
title: 一条命令运行rancher
date: 2022-05-26 08:49:12
tags: [docker,安装部署,云原生]
categories: [云原生]
---

# 1、rancher安装

控制台中rke用户下执行docker命令：

```shell
docker run --name=rancher -d --privileged --restart=unless-stopped -p 30040:80 -p 30050:443 rancher/rancher:latest
```

![](https://img.huangge1199.cn/blog/inReacherByDC/2022-06-04-20-05-14-image.png) 

# 2、检查是否正常启动

可通过下面两个命令查看：

```shell
docker ps | grep rancher           ## 查看正在运行中的docker容器
```

# 3、浏览器访问

输入https://IP:PORT

![](https://img.huangge1199.cn/blog/inReacherByDC/2022-06-04-20-10-27-image.png)

点击高级，然后点击继续前往

![](https://img.huangge1199.cn/blog/inReacherByDC/2022-06-04-20-11-34-image.png)

# 4、密码

根据提示，输入并修改密码

![](https://img.huangge1199.cn/blog/inReacherByDC/2022-06-04-20-12-49-image.png)

![](https://img.huangge1199.cn/blog/inReacherByDC/2022-06-04-20-13-57-image.png)

浏览器输入密码后，选择红框的，并在下方输入自己想要设置的密码

![](https://img.huangge1199.cn/blog/inReacherByDC/2022-06-04-20-15-39-image.png)

进入后里面有一个默认的k3s

![](https://img.huangge1199.cn/blog/inReacherByDC/2022-06-04-20-18-34-image.png)

# 5、加入其他存在的集群

点击`Import Existing`

![](https://img.huangge1199.cn/blog/inReacherByDC/2022-06-04-20-19-37-image.png)

选择`Generic`

![](https://img.huangge1199.cn/blog/inReacherByDC/2022-06-04-20-20-46-image.png)

集群名字随意输入，只要你能记住

![](https://img.huangge1199.cn/blog/inReacherByDC/2022-06-04-20-22-26-image.png)

根据红框的操作执行命令注册进来

![](https://img.huangge1199.cn/blog/inReacherByDC/2022-06-04-20-23-58-image.png)

执行命令

```shell
kubectl apply -f https://172.17.8.51:30050/v3/import/2llq4b95zbspwqlcjrb898dtwqmqgtcxtfxjdlkgp8c79jpzf8tfn6_c-m-5ffgdfz6.yaml
```

![](https://img.huangge1199.cn/blog/inReacherByDC/2022-06-04-20-24-48-image.png)

报了认证的问题，执行第二个命令

```shell
curl --insecure -sfL https://172.17.8.51:30050/v3/import/2llq4b95zbspwqlcjrb898dtwqmqgtcxtfxjdlkgp8c79jpzf8tfn6_c-m-5ffgdfz6.yaml | kubectl apply -f -
```

![](https://img.huangge1199.cn/blog/inReacherByDC/2022-06-04-20-26-55-image.png)

我这边是运行成功了
