---
title: helm不需要证书安装rancher
date: 2022-06-26 11:16:37
tags: [云原生,安装部署]
categories: [云原生]
---

## 前置

安装好k8s和helm

![](2022-06-26-16-48-16-image.png)

## 安装命令

```shell
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.my.org \
  --set replicas=1 \
  --set ingress.tls.source=secret
```

![](2022-06-26-16-49-50-image.png)

## 设置域名映射

```shell
sudo vi /etc/hosts

# 添加域名映射 
127.0.0.1 rancher.my.org

# cat /etc/hosts
```

![](2022-06-26-16-51-20-image.png)

## 确认安装完成

```shell
kubectl -n cattle-system get deploy rancher
```

![](2022-06-26-16-56-27-image.png)

## 浏览器访问

浏览器输入 [https://rancher.my.org/](https://rancher.my.org/)

高级--》继续访问

![](2022-06-26-16-59-29-image.png)

## 密码查看

终端输入，查看密码

```shell
kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}{{"\n"}}'
```

![](2022-06-26-17-01-02-image.png)

## 设置自己好记的密码

输入密码进入后，选择Set a specific password to use，然后下方设置自己的密码

![](2022-06-26-17-02-18-image.png)

## 进入的页面

![](2022-06-26-17-04-28-image.png)

至此，rancher部署完成
