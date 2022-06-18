---
title: Helm安装Rancher
date: 2022-06-18 10:44:37
tags: [云原生,安装部署]
categories: [云原生]
---

# 前置

本人是直接在<font color='red'>deeepin</font>系统上用rke安装的k8s集群形式，但是只有一个节点，<font color='red'>rke</font>是<font color='red'>1.3.10</font>版本的，安装好的<font color='red'>k8s</font>是<font color='red'>1.22.9</font>的版本

# 前提条件 -- helm安装

安照官网说明安装就可以：[官网安装步骤](https://helm.sh/zh/docs/intro/install/)

简单说明：

我这边是二进制形式安装的

- 下载 需要的版本
- 解压(tar -zxvf helm-v3.9.0-linux-amd64.tar.gz)
- 在解压目中找到helm程序，移动到需要的目录中(mv linux-amd64/helm /usr/local/bin/helm)

# 1、安装证书管理

> 这里选用 Rancher 生成的 TLS 证书，因此需要 cert-manager

## 1.1 添加配置

执行命令：

```shell
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.5.1/cert-manager.crds.yaml
```

![2022-06-18-11-12-15-image.png](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRancherByHelm/ca771f4aa96e9cafe14c329195308b345c23427b.png)

## 1.2 添加 Jetstack Helm 仓库

执行命令：

```shell
helm repo add jetstack https://charts.jetstack.io
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRancherByHelm/2022-06-18-11-51-51-image.png)

## 1.3 更新本地 Helm chart 仓库缓存

执行命令：

```shell
helm repo update
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRancherByHelm/2022-06-18-11-53-22-image.png)

## 1.4 安装 cert-manager Helm chart

执行命令：

```shell
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.5.1
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRancherByHelm/2022-06-18-11-55-29-image.png)

如果报错内容如下：

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRancherByHelm/2022-06-18-11-56-38-image.png)

可做如下操作：

```shell
# 列出空间列表
helm ls --all-namespaces
# 删除
kubectl delete namespace cert-manager
# 列出空间列表
helm ls --all-namespaces
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRancherByHelm/2022-06-18-11-59-43-image.png)

然后在重新执行命令即可

## 1.5 确认安装成功

执行命令：

```shell
kubectl get pods --namespace cert-manager
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRancherByHelm/2022-06-18-12-02-27-image.png)

# 2、安装ingress-nginx

## 2.1 添加ingress-nginx repo

执行命令：

```shell
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRancherByHelm/2022-06-18-12-10-24-image.png)

## 2.2 安装

执行命令：

```shell
helm install ingress-nginx ingress-nginx/ingress-nginx -n kube-system \
```

# 3、安装rancher

## 3.1 添加rancher repo

执行命令：

```shell
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
```

## 3.2 查看列表

执行命令：

```shell
helm repo list
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRancherByHelm/2022-06-18-12-12-48-image.png)

## 3.3 安装

```shell
helm install rancher rancher-stable/rancher \
>   --namespace cattle-system \
>   --create-namespace \
>   --set hostname=rancher.my.org \
>   --no-hooks \
>   --version 2.6.5
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRancherByHelm/2022-06-18-12-18-50-image.png)

> 配置的hostname=rancher.my.org，这个域名需要添加到 `/etc/hosts`

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRancherByHelm/2022-06-18-12-24-48-image.png)

## 3.4 运行

```shell
kubectl -n cattle-system rollout status deploy/rancher
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRancherByHelm/2022-06-18-12-19-21-image.png)

## 3.5 查看 Rancher 运行状态

```shell
kubectl -n cattle-system get deploy rancher
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRancherByHelm/2022-06-18-12-20-59-image.png)

至此，Rancher部署完成

## 3.6 浏览器查看

https://rancher.my.org/ ，进入后简单配置下就可以了

默认密码在终端输入下面的命令，显示的就是默认密码，之后可以修改成自己好记的密码

```shell
kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}{{"\n"}}'
```

进入后的样子：

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRancherByHelm/2022-06-18-12-27-32-image.png)
