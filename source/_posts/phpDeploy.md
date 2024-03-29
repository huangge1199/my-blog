---
title: PhpStorm自动上传修改的内容到服务器
date: 2022-04-30 16:40:05
tags: [PHP]
categories: [PHP]
---

# 前言

今天，在修改WordPress时，发现利用宝塔的在线编辑好麻烦，找到方法，确无法直接跳过去，于是乎，我把代码下载到本地了，本来想着利用编辑器来修改就可以跳转了，没想到呀，PhpStorm给了我一个大惊喜，原来它只要配置好久可以直接在本地修改，WordPress刷新就可以直接看到效果。



接下来，我就详细的说明一下配置的步骤



# 配置步骤

## 1、设置连接

打开File-->Setting

![](https://img.huangge1199.cn/blog/phpDeploy/2022-04-30-16-52-00-image.png)

左侧Build,Execution,Deployment-->Deployment，然后右侧加号添加配置选择SFTP

![](https://img.huangge1199.cn/blog/phpDeploy/2022-04-30-16-54-56-image.png)

弹出的窗口内输入配置的名称，可随意输入，方便记住就好

![](https://img.huangge1199.cn/blog/phpDeploy/2022-04-30-20-14-03-image.png)

点击红框的位置添加ssh连接

![](https://img.huangge1199.cn/blog/phpDeploy/2022-04-30-20-12-36-image.png)

在弹出的窗口点击 加号，右边配置

![](https://img.huangge1199.cn/blog/phpDeploy/2022-04-30-20-20-22-image.png)

点击OK后，ssh会自动添加上，同时再把IP加入到下面的红框内

![](https://img.huangge1199.cn/blog/phpDeploy/2022-04-30-20-32-37-image.png)

## 2、设置文件映射关系

点击mapping，将服务器上项目的根目录添加到Deployment Path中，如果点击OK

![](https://img.huangge1199.cn/blog/phpDeploy/2022-04-30-20-35-23-image.png)

## 3、设置自动上传

在PhpStorm中依次点击Tool-->Deployment-->Options...

![](https://img.huangge1199.cn/blog/phpDeploy/2022-04-30-20-42-16-image.png)

在弹出的窗口中，将红框下拉框设置成第二个，之后只要按Ctrl+S就可将修改的代码上传到服务器上

![](https://img.huangge1199.cn/blog/phpDeploy/2022-04-30-20-44-58-image.png)
