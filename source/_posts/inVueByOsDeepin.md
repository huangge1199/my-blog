---
title: deepin下安装vue
date: 2022-06-03 14:51:52
tags: [deepin,安装部署]
categories: [安装部署]
---

# 1、前置条件

安装好nodejs

参考：[deepin下安装nodejs](http://192.168.0.198:5080/post/inNodejsByOsDeepin/)

# 2、全局安装Vue

执行命令：

```shell
# 下面两个版本的二选一哦
npm install -g @vue/cli		//vue3.0
npm install -g vue-cli		//vue2.0
```

我这边安装的是3.0版本的

![image-20220603114033774](https://img.huangge1199.cn/blog/inVueByOsDeepin/image-20220603114033774.png)

# 3、全局安装webpack

```shell
npm install -g webpack
```

![image-20220603114219499](https://img.huangge1199.cn/blog/inVueByOsDeepin/image-20220603114219499.png)

# 4、创建软链接

```shell
# 创建Vue软链接
sudo ln -s /home/deepin/app/node/bin/vue /usr/local/bin/
# 创建webpack软链接
sudo ln -s /home/deepin/app/node/bin/webpack /usr/local/bin/
# 查看软链接列表
sudo ls -l /usr/local/bin/
```

![image-20220603114513508](https://img.huangge1199.cn/blog/inVueByOsDeepin/image-20220603114513508.png)

# 5、查看Vue版本

```shell
vue --version
```

![image-20220603114616673](https://img.huangge1199.cn/blog/inVueByOsDeepin/image-20220603114616673.png)
