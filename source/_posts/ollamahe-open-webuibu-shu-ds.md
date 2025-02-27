---
title: ollama和open-webui部署ds
tags: [安装部署]
categories: [安装部署]
date: 2025-02-26 15:59:39
---

# 引言

最近，deepseek是越来越火，我也趁着这个机会做了下私有化部署，我这边使用的ollama和  open-webui实现的web版本

# ollama

## 简介

Ollama 是一个开源的工具，专门用于简化机器学习和 AI 模型的部署。它提供了一个统一的平台，允许你通过命令行工具创建、管理和更新模型。无论你是想在本地开发环境中运行模型，还是将其部署到云端，Ollama 都可以简化这一过程。

Ollama 支持多种常见的机器学习模型框架，包括但不限于 TensorFlow、PyTorch、Hugging Face Transformers 等，此外还支持类似 **DeepSeek** 这种自定义的搜索引擎模型。

## 核心特性

- **易于使用的命令行界面**：Ollama 提供了简单直观的命令行工具，可以通过几条命令就完成模型的创建、启动、更新等操作。
- **环境隔离**：Ollama 可以为每个模型提供独立的运行环境，避免了不同模型之间的依赖冲突。
- **跨平台支持**：无论你是使用 Linux、Mac 还是 Windows，Ollama 都可以无缝运行。
- **自动更新**：Ollama 会自动为模型提供更新，确保你使用的是最新的版本。
- **高效的资源管理**：通过 Ollama，你可以有效地管理计算资源，包括 CPU 和 GPU 的使用，确保模型运行的高效性。

## 安装

### Linux

使用root用户执行下面的命令：

```shell
curl -fsSL https://ollama.com/install.sh | sh
```

### windows

直接下载安装包：[windows安装包](https://ollama.com/download/OllamaSetup.exehttps://ollama.com/download/OllamaSetup.exe)

### macos

下载压缩包：https://ollama.com/download/Ollama-darwin.zip

## 环境变量

为了Ollama能够对外提供服务，需要设置OLLAMA_HOST

### 在Linux上设置

如果Ollama作为systemd服务运行，通过systemctl设置环境变量：

1. 使用systemctl edit ollama.service命令编辑systemd服务，将打开一个编辑器。

2. 对每个环境变量，在[Service]部分添加两行行Environment：
   
   ```
   Environment="OLLAMA_HOST=0.0.0.0"
   Environment="OLLAMA_ORIGINS=*"
   ```
   
   ![](https://img.huangge1199.cn/blog/ollamahe-open-webuibu-shu-ds/2025-02-27-09-20-06-image.png)
   
   > 红框内为后加的两行代码

3. 保存并退出。

4. 重新加载systemd并重启Ollama：
   
   ```
   systemctl daemon-reload
   systemctl restart ollama
   ```

### 在Windows上设置

在Windows上，Ollama会继承您的用户和系统环境变量。

1. 首先通过任务栏图标退出Ollama，
2. 从控制面板编辑系统环境变量，
3. 为OLLAMA_HOST、OLLAMA_ORIGINS等编辑或新建变量。
4. 点击OK/Apply保存，
5. 然后从新的终端窗口运行ollama。

## 启动ollama服务

执行命令

```shell
systemctl start ollama
```

# 部署 DeepSeek

通过`https://ollama.com/library`找到对应的模型，点进模型有拉取运行的命令，比如说

deepseek-r1:7b的模型，执行下面的命令就可以拉取并运行其模型：

```shell
ollama run deepseek-r1
```

下面是操作截图，如果你已经拉取并运行模型了，可以直接进行open-webui的步骤了

从`https://ollama.com/library`开始，页面如下：

![](https://img.huangge1199.cn/blog/ollamahe-open-webuibu-shu-ds/2025-02-27-09-06-12-image.png)

点击你需要的模型`deepseek-r1`，点击后页面如下：

![](https://img.huangge1199.cn/blog/ollamahe-open-webuibu-shu-ds/2025-02-27-09-09-27-image.png)

左侧红框是你需要下载的版本，这里默认就是7b版本了，如果你需要其他版本可以通过下拉列表切换

右侧红框就是你需要执行的命令，执行该命令就可以拉取并运行其模型

# open-webui

现在ds已经可以用了，但是还缺少应该web界面，我这边选择的是open-webui，可以直接通过浏览器访问

## docker-compose安装open-webui

这个就相对简单了，我使用的docker-compose部署，下面是docker-compose文件：

```yaml
services:
  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    volumes:
      - ./data:/app/backend/data
    ports:
      - "8088:8080"
    restart: always
```

不过这个启动后要等很久的时间，原因是默认的docker镜像是以openai为主的，但是默认情况下没有配，所以等的时间比较久。

出现下图中最后一行就是部署好了：

![](https://img.huangge1199.cn/blog/ollamahe-open-webuibu-shu-ds/2025-02-27-09-22-32-image.png)

## open-webui配置 ollama+deepseek

看到`http://0.0.0.0:8080`这个说明可以在浏览器中打开了，注意，浏览器打开时，端口是你docker-compose里面引出的，不一定是8080，我这个docker-compose端口就是8088，接下来浏览器输入`http://ip:8088/`打开，页面如下：

![](https://img.huangge1199.cn/blog/ollamahe-open-webuibu-shu-ds/2025-02-27-09-25-59-image.png)

首次使用需要创建管理员账号，点击开始使用进行创建，页面如下：

![](https://img.huangge1199.cn/blog/ollamahe-open-webuibu-shu-ds/2025-02-27-09-27-16-image.png)

内容输入完，点击”创建管理员账号“，因为默认的openai，这一步一样的需要等很长一段时间，不要着急，慢慢等，出现下面的界面就可以进行下一步了：

![](https://img.huangge1199.cn/blog/ollamahe-open-webuibu-shu-ds/2025-02-27-09-33-15-image.png)

点击红框的按钮后，依次按照下面图片的顺序进行操作

![](https://img.huangge1199.cn/blog/ollamahe-open-webuibu-shu-ds/2025-02-27-09-34-16-image.png)

![](https://img.huangge1199.cn/blog/ollamahe-open-webuibu-shu-ds/2025-02-27-09-37-12-image.png)

![](https://img.huangge1199.cn/blog/ollamahe-open-webuibu-shu-ds/2025-02-27-09-37-37-image.png)

![](https://img.huangge1199.cn/blog/ollamahe-open-webuibu-shu-ds/2025-02-27-09-46-11-image.png)

这地方注意下，1那地方的如果你不使用OpenAI API，一定要想我上面截图中那样给关了，要不之后再进页面，还是需要等很长一段时间，然后设置好ollama的连接，按照我文档中安装的话，填入的内容就是`http://IP:11434`，全部填完后保存

![](https://img.huangge1199.cn/blog/ollamahe-open-webuibu-shu-ds/2025-02-27-09-49-03-image.png)

保存后右上角出现提示，这时候就已经完全配好了，接下来，可以重新打开页面`http://IP:8088/`看看效果了

页面如下，打开后页面直接进入了，而且左上角的模型也默认加载出来了，如果你的ollama安装的多个模型，可以通过红框的下拉列表切换

![](https://img.huangge1199.cn/blog/ollamahe-open-webuibu-shu-ds/2025-02-27-09-50-44-image.png)

最后，就是看看提问效果了，当然，我这个服务器配置不行，速度一般般，但是提问的结果已经显示出来了

![](https://img.huangge1199.cn/blog/ollamahe-open-webuibu-shu-ds/2025-02-27-10-34-25-image.png)
