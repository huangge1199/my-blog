---
title: 通过Kubeadm方式安装K8S
date: 2022-05-31 14:10:52
tags: [安装部署]
categories: [云原生]
---

# 1、前提条件

安装好docker

{% hideToggle docker安装 %}

如果没有安装，可参考下面的文章进行安装：

[docker 安装]([docker安装-龙儿之家](https://site.huangge1199.cn/113.html))

{% endhideToggle %}

防火墙已经关闭
{% hideToggle 防火墙关闭操作 %}

关闭防火墙：

```shell
systemctl stop firewalld.service
systemctl disable firewalld.service
```

{% endhideToggle %}

selinux已经关闭
{% hideToggle selinux关闭操作 %}

禁用 SELinux：

```shell
vi /etc/selinux/config
```

将第七行SELINUX=enforcing改为SELINUX=disabled

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRKE/2022-05-04-17-23-24-image.png)
{% endhideToggle %}

swap已经关闭
{% hideToggle swap关闭操作 %}

禁用 swap

```shell
vi /etc/fstab
```

使用 # 注释掉有 swap 的一行

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRKE/2022-05-04-17-27-23-image.png)
{% endhideToggle %}

防火墙、SELinux、swap关闭验证：

```shell
reboot
/usr/sbin/sestatus -v
free -h
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/inRKE/2022-05-04-17-33-11-image.png)

# 2、安装 kubeadm，kubelet 和 kubectl

添加yum源：

```shell
cat > /etc/yum.repos.d/kubernetes.repo << EOF
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
```

安装：

```shell
yum install -y kubelet kubeadm kubectl
```

设置开机自启kubelet：

```shell
systemctl enable kubelet
```
