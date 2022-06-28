---
title: Jenkins通过kubernetes plugin连接K8s集群
date: 2022-06-28 22:21:47
tags: [云原生]
categories: [云原生]
---

## 一、Jenkins安装kubernetes plugin插件

### 1.1 点击左侧系统管理

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-22-26-15-image.png)

### 1.2 点击插件管理

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-22-27-34-image.png)

### 1.3 安装插件Kubernetes plugin

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-22-28-53-image.png)

### 1.4 安装好后重启Jenkins

浏览器输入http://192.168.0.196:8080/restart，页面点击“是”重启Jenkins

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-22-30-31-image.png)

## 二、进入配置页

### 2.1 左侧点击系统管理

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-22-31-51-image.png)

### 2.2 点击节点管理

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-22-32-25-image.png)

### 2.3 点击Configure Clouds

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-22-33-15-image.png)

## 三、配置

### 3.1 下拉框选择Kubernetes

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-22-34-14-image.png)

### 3.2 点击Kubernetes Cloud details...进入配置详情页

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-22-35-00-image.png)

### 3.3 填入认证信息

需要填写红框内的4个内容

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-22-42-49-image.png)

#### Kubernetes 地址

这个通过命令行 查看

```shell
kubectl cluster-info
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-23-16-34-image.png)

红框内的就是地址

#### Kubernetes 服务证书 key

为/root/.kube/config中的certificate-authority-data部分，并通过base64加密

终端输入下面的命令查看certificate-authority-data：

```shell
cat .kube/config
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-22-46-52-image.png)

在执行下面的命令进行base64加密：

```shell
echo "certificate-authority-data冒号后面的内容" | base64 -d
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-22-52-27-image.png)

红框的内容填入“Kubernetes 服务证书 key”中

#### Kubernetes 命名空间

使用default默认就好

#### 凭据

这地方需要添加一个凭借

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-22-54-22-image.png)

在弹出的页面中类型选Secret text

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-22-57-05-image.png)

下面的Secret通过终端添加：

- 创建一个

```shell
kubectl create sa jenkins
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-23-19-07-image.png)

获取token名

```shell
kubectl describe sa jenkins
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-23-19-57-image.png)

获取token值

```shell
kubectl describe secrets jenkins-token-szvg9 -n default
```

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-23-21-36-image.png)

上图中的token即为Secret填入的内容

最后的描述可以随意填写

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-23-07-30-image.png)

点击添加，凭据就好了

## 四、验证

点击连接测试，左侧显示k8s集群版本

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-23-23-35-image.png)  

下面把Jenkins地址填上，再点击保存按钮就完成了

![](https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/images/bindK8sToJenkins/2022-06-28-23-26-16-image.png)
