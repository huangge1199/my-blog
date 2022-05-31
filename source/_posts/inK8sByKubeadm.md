---
title: 通过Kubeadm方式安装K8S
date: 2022-05-31 14:10:52
tags: [安装部署]
categories: [云原生]
---

# 1、前提条件

## 1.1、docker

{% hideToggle 已经安装好docker %}

1.1.1 验证：

执行下面的命令：

```shell
docker ps 
```

![](inK8sByKubeadm/2022-05-31-14-46-19-image.png)

1.1.2 安装：

[docker 安装]([docker安装-龙儿之家](https://site.huangge1199.cn/113.html))

{% endhideToggle %}
{% hideToggle 防火墙已经关闭 %}
{% endhideToggle %}
{% hideToggle selinux已经关闭 %}
{% endhideToggle %}
{% hideToggle swap已经关闭 %}
{% endhideToggle %}
