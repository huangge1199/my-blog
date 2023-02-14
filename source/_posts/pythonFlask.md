---
title: Python Flask 学习笔记
date: 2023-02-14 15:47:27
tags: [学习笔记,python]
categories: python
---

本篇文章是[Python Flask 建站框架入门课程_编程实战微课_w3cschool](https://www.w3cschool.cn/minicourse/play/pyflask)微课的学习笔记，根据课程整理而来，本人使用版本如下：

| Python | 3.10.0 |
| ------ | ------ |
| Flask  | 2.2.2  |

# 简介

- Flask是一个轻量级的可定制的web框架

- Flask 可以很好地结合MVC模式进行开发

- Flask还有很强的很强的扩展性和兼容性

# 核心函数库

Flask主要包括Werkzeug和Jinja2两个核心函数库，它们分别负责业务处理和安全方面的功能，这些基础函数为web项目开发过程提供了丰富的基础组件。

## Werkzeug

Werkzeug库十分强大，功能比较完善，支持URL路由请求集成，一次可以响应多个用户的访问请求；

支持Cookie和会话管理，通过身份缓存数据建立长久连接关系，并提高用户访问速度；支持交互式Javascript调试，提高用户体验；

可以处理HTTP基本事务，快速响应客户端推送过来的访问请求。

## Jinja2

Jinja2库支持自动HTML转移功能，能够很好控制外部黑客的脚本攻击；

系统运行速度很快，页面加载过程会将源码进行编译形成python字节码，从而实现模板的高效运行；

模板继承机制可以对模板内容进行修改和维护，为不同需求的用户提供相应的模板。

# 安装

通过pip安装即可

```batch
pip install Flask
# pip3
pip3 install Flask
```

# 目录结构

## 新项目创建后的结构

![](pythonFlask/2023-02-14-17-10-32-image.png)

static文件夹：存放静态文件，比如css、js、图片等

templates文件夹：模板文件目录

app.py：应用启动程序

# 获取URL参数

## 列出所有URL参数

`request.args.__str__()`

```python
from flask import Flask, request

app = Flask(__name__)


@app.route('/')
def hello_world():  # put application's code here
    return request.args.__str__()


if __name__ == '__main__':
    app.run()

```

在浏览器中访问`http://127.0.0.1:5000/?name=Loen&age&app=ios&app=android`，将显示：

```
ImmutableMultiDict([('name', 'Loen'), ('age', ''), ('app', 'ios'), ('app', 'android')])
```

## 列出浏览器传给我们的Flask服务的数据

```python
from flask import Flask, request

app = Flask(__name__)


@app.route('/')
def hello_world():  # put application's code here

    # 列出访问地址
    print(request.path)

    # 列出访问地址及参数
    print(request.full_path)

    return request.args.__str__()


if __name__ == '__main__':
    app.run()

```

在浏览器中访问`http://127.0.0.1:5000/?name=Loen&age&app=ios&app=android`，控制台中显示

```
/
/?name=Loen&age&app=ios&app=android
```

## 获取指定的参数值

```python
from flask import Flask, request

app = Flask(__name__)


@app.route('/')
def hello_world():  # put application's code here

    return request.args.get('name')


if __name__ == '__main__':
    app.run()

```

在浏览器中访问`http://127.0.0.1:5000/?name=Loen&age&app=ios&app=android`，将显示：

```
Loen
```
