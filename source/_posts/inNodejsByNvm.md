```
title: nvm安装nodejs
date: 2022-06-03 14:46:52
tags: [deepin,安装部署]
categories: [安装部署]
```

# nvm下载

[nvm的GitHub下载地址](https://github.com/coreybutler/nvm-windows)

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-22-23-07-image.png)

进入后下载

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-22-24-26-image.png)

# nvm安装

下载后双击exe文件进行安装，同意后点击next

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-22-26-41-image.png)

设置安装目录

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-22-28-55-image.png)

设置nodejs目录，最好不要带空格

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-22-31-09-image.png)

点击install安装

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-22-31-34-image.png)

点击Finish安装完成

# nvm添加淘宝镜像

打开nvm安装目录下的settings.txt文件，添加淘宝镜像地址，红框内为新增的

```yaml
node_mirror: https://npm.taobao.org/mirrors/node/
npm_mirror: https://npm.taobao.org/mirrors/npm/
```

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-22-40-28-image.png)

# nvm设置环境变量

此电脑右键点击属性

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-22-47-21-image.png)

点击高级系统设置

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-23-06-30-image.png)

点击环境变量

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-23-08-12-image.png)

确认环境变量中有NVM_HOME和NVM_SYMLINK

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-23-10-10-image.png)

确认

管理员身份运行cmd，执行查看的命令确认安装成功

```bash
nvm -v
```

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-23-16-26-image.png)

# node安装

执行命令列出有效可下载的node版本

```bash
nvm list available
```

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-23-20-11-image.png)

执行安装命令安装指定版本的node

```bash
nvm install <version>
```

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-23-21-39-image.png)

执行命令查看已安装的node版本

```bash
nvm list
```

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-23-22-47-image.png)

执行命令使用某个版本的node

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-23-25-48-image.png)

执行命令查看node版本

```bash
node -v
```

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-23-26-48-image.png)

# node环境变量

新建目录node_global、node_cache，可以建在nodejs目录下 

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-23-33-44-image.png)

新建环境变量，变量名：NODE_PATH，变量值：node_global路径\node_modules

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-23-37-35-image.png)

在Path环境变量中增加node_global路径

![](https://img.huangge1199.cn/blog/inNodejsByNvm/2023-01-14-23-41-08-image.png)
