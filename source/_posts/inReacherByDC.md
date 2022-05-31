---
title: 一条命令运行rancher（未完成）
date: 2022-05-26 08:49:12
tags: [docker,安装部署]
categories: [云原生]
---

# 1、命令行操作部分

## 1.1、rancher安装

控制台中rke用户下执行docker命令：

```shell
docker run --name=rancher -d --privileged --restart=unless-stopped -p 30040:80 -p 30050:443 rancher/rancher:latest
```

## 1.2 检查是否正常启动

可通过下面两个命令查看：

```shell
docker ps                          ## 查看正在运行中的docker容器
docker logs -f --tail 100 rancher  ## 查看rancher容器执行日志
```
