---
title: deepin主机下通过Kubeadm方式安装K8S
date: 2022-06-24 21:39:51
tags: [安装部署]
categories: [云原生,deepin]
---

# 1、关闭swap

依次执行下面的命令：

```shell
# 查看分区的使用状态
free -mh
# 禁用swap分区
sudo swapoff -a
# 查看分区的使用状态
free -mh
```

![](https://img.huangge1199.cn/blog/inK8sByKubeadmByDeepin/2022-06-24-21-45-13-image.png)

# 2、添加k8s源

编辑文件/etc/apt/sources.list.d/kubernetes.list

```shell
sudo vi /etc/apt/sources.list.d/kubernetes.list
```

插入以下内容：

```yaml
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
```

再执行命令查看：

```shell
cat /etc/apt/sources.list.d/kubernetes.list
```

![](https://img.huangge1199.cn/blog/inK8sByKubeadmByDeepin/2022-06-24-22-10-06-image.png)

# 3、导入k8s密钥

执行命令：

```shell
sudo curl -fsSL https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -
```

![](https://img.huangge1199.cn/blog/inK8sByKubeadmByDeepin/2022-06-24-22-16-25-image.png)

# 4、更新并安装kubeadm, kubelet 和 kubectl

执行命令：

```shell
sudo apt-get update
sudo apt-get install kubelet kubeadm kubectl
```

# 5、设置阿里云镜像加速

编辑文件/etc/docker/daemon.json：

```shell
sudo vi /etc/docker/daemon.json
```

修改成如下内容：

```yaml
{
    "registry-mirrors": [
            "https://{阿里云分配的地址}.mirror.aliyuncs.com",
            "https://registry-1.docker.io/v2/"
    ]
}
```

再执行命令查看：

```shell
cat /etc/docker/daemon.json
```

![](https://img.huangge1199.cn/blog/inK8sByKubeadmByDeepin/2022-06-24-22-49-46-image.png)

# 6、拉取镜像

从阿里云拉取镜像并转换tag，执行命令如下：

```shell
for  i  in  `kubeadm config images list`;  do
    imageName=${i#k8s.gcr.io/}
    docker pull registry.aliyuncs.com/google_containers/$imageName
    docker tag registry.aliyuncs.com/google_containers/$imageName k8s.gcr.io/$imageName
    docker rmi registry.aliyuncs.com/google_containers/$imageName
done;
```

如果有拉取不下来的，可以再上网找找镜像然后转换tag，或者直接执行下面的命令用docker官方镜像拉取，但是官方镜像拉取速度可能会很慢

```shell
for  i  in  `kubeadm config images list`;  do
    docker pull i
done;
```

# 7、kubeadm初始化

执行命令:

```shell
kubeadm init --pod-network-cidr=10.244.0.0/16
```

![](https://img.huangge1199.cn/blog/inK8sByKubeadmByDeepin/2022-06-24-23-00-07-image.png)

# 8、执行提示的命令

```shell
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

![](https://img.huangge1199.cn/blog/inK8sByKubeadmByDeepin/2022-06-24-23-02-42-image.png)

# 9、安装网络插件

执行命令：

```shell
kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml
```

![](https://img.huangge1199.cn/blog/inK8sByKubeadmByDeepin/2022-06-24-23-05-02-image.png)

# 10、安装Ingress

执行命令：

```shell
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.0/deploy/static/provider/cloud/deploy.yaml
```

查看命令：

```shell
kubectl get pods --all-namespaces
```

![](https://img.huangge1199.cn/blog/inK8sByKubeadmByDeepin/2022-06-24-23-41-18-image.png)
