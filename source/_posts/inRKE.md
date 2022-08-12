---
title: RKE方式安装k8s集群和Dashboard
date: 2022-05-03 16:44:17
tags: [安装部署]
categories: [云原生]
---

# 前言

需要在电脑上安装好VirtualBox和Vagrant

# 构建3台虚拟机

## 1、编写Vagrantfile文件

内容如下：

```
Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.provider 'virtualbox' do |vb|
  vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000 ]
  end  
  $num_instances = 3
  # curl https://discovery.etcd.io/new?size=3
  (1..$num_instances).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.box = "centos/7"
      node.vm.hostname = "node#{i}"
      ip = "172.17.8.#{i+100}"
      node.vm.network "private_network", ip: ip
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "8192"
        if i==1 then
            vb.cpus = 2
        else
            vb.cpus = 1
        end
        vb.name = "node#{i}"
      end
    end
  end
end
```

## 2、启动3台虚拟机

在Vagrantfile文件所在目录的控制台下执行命令：

```bash
vagrant up
```

等待完成，完成后，在VirtualBox主页：

![](2022-05-04-16-24-28-image.png)

# 虚拟机配置用户名密码ssh连接

3台虚拟机都需要安装

配置参考：[windows下VirtualBox和vagrant组合安装centos](https://site.huangge1199.cn/189.html) 中的“用户名密码ssh”

# 虚拟机docker安装

3台虚拟机都需要安装

安装教程：[docker安装教程]([docker安装-龙儿之家](http://192.168.0.198:5080/post/dockerInstall/))

# 安装 Kubernetes 命令行工具 kubectl

3台虚拟机都需要安装

执行命令：

```shell
yum install wget
wget https://dl.k8s.io/release/v1.24.0/bin/linux/amd64/kubectl && chmod +x kubectl && cp kubectl /usr/bin/
```

如果报错：curl: (1) Protocol “https not supported or disabled in libcurl

# 安装RKE命令行工具

只有主节点做即可

```shell
wget https://rancher-mirror.rancher.cn/rke/v1.3.10/rke_linux-amd64 && mv rke_linux-amd64 rke && chmod +x rke && ./rke --version && cp rke /usr/bin/
```

# 进行机器配置

adduser rke -G docker

## 1、禁用 SELinux

```shell
vi /etc/selinux/config
```

将第七行SELINUX=enforcing改为SELINUX=disabled

![](2022-05-04-17-23-24-image.png)

## 2、禁用 swap

```shell
vi /etc/fstab
```

使用 # 注释掉有 swap 的一行

![](2022-05-04-17-27-23-image.png)

## 3、关闭防火墙

```shell
systemctl stop firewalld.service
systemctl disable firewalld.service
```

## 4、重启查看效果

```shell
reboot
/usr/sbin/sestatus -v
free -h
```

![](2022-05-04-17-33-11-image.png)

## 5、设置用户

CentOS7不能使用root用户安装

添加用户：

```shell
adduser rke -G docker
```

给新添加的用户设置密码：

```shell
passwd rke
```

中途需要输入2次密码

![](2022-05-04-17-38-29-image.png)

确认新用户是否有权限：

```shell
su rke
docker ps -a
```

![](2022-05-04-17-40-07-image.png)

## 6、设置SSH

这个地方要给全部的机器配置ssh（包括自己）注意在<mark>新用户</mark>下操作：

```shell
ssh-keygen
ssh-copy-id rke@172.17.8.101
ssh-copy-id rke@172.17.8.102
ssh-copy-id rke@172.17.8.103
```

第一个红框位置输入yes，第二个红框位置输入密码

![](2022-05-04-17-46-31-image.png)

# 编辑rke.yaml

仅在主节点，在<mark>新用户</mark>下操作

```shell
vi rke.yaml
```

rke.yaml内容（里面的IP换成各自的IP哦）：

```yaml
nodes:
  - address: 172.17.8.101
    user: rke
    role: [controlplane, worker, etcd]
  - address: 172.17.8.102
    user: rke
    role: [controlplane, worker, etcd]
  - address: 172.17.8.103
    user: rke
    role: [worker]

services:
  etcd:
    snapshot: true
    creation: 6h
    retention: 24h

# 当使用外部 TLS 终止，并且使用 ingress-nginx v0.22或以上版本时，必须。
ingress:
  provider: nginx
  options:
    use-forwarded-headers: “true”
ded-headers: “true”
```

# 安装集群

也是在<mark>新用户</mark>下操作：

```shell
rke up --config rke.yaml
```

这步执行时间较长，多等一会，需要下载很多镜像~~~~

运行完成后执行 ：

```shell
mkdir ~/.kube && mv kube_config_rke.yaml ~/.kube/config
```

最后，执行下面的命令确认集群安装完成

```shell
kubectl get node
```

# 安装kubernetes Dashboard

依然是在新用户下：

切换到~目录下

## 1、获取dashboard的yaml文件

```shell
wget https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.4/aio/deploy/recommended.yaml
```

## 2、修改文件

修改service部分，默认service是ClusterIP类型，这里改称NodePort类型，是集群外部能否访问

下面标红框的地方为新增加的：

![](2022-05-04-19-41-19-image.png)

## 3、执行yaml文件

```shell
kubectl apply -f recommended.yaml
```

## 4、查看服务状态

```shell
kubectl get all -n kubernetes-dashboard
```

下面红框的可以看出服务已经运行了

![](2022-05-04-19-47-43-image.png)

## 5、接下来浏览器访问

IP：30010，端口就是你在第二步中添加的，输入网址后，点击高级继续访问就出现下面的页面了

![](2022-05-04-19-48-18-image.png)

## 6、创建登录用户信息

创建文件admin-role.yaml，内容如下：

```yaml
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: admin
  annotations:
    rbac.authorization.kubernetes.io/autoupdate: "true"
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
subjects:
- kind: ServiceAccount
  name: admin
  namespace: kube-system
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin
  namespace: kube-system
  labels:
    kubernetes.io/cluster-service: "true"
    addonmanager.kubernetes.io/mode: Reconcile
```

将其执行到集群中：

```shell
kubectl apply -f admin-role.yaml
```

## 7、获取token

查看kubernetes-dashboard下面的secret

```shell

```

![](2022-05-04-20-50-13-image.png)

在执行下面的命令：

```shell
kubectl -n kube-system describe secret 红框的名字
```

红框内就是token

![](2022-05-04-20-50-57-image.png)
