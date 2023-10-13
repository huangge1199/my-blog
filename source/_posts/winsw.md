---
title: Windows系统下设置程序开机自启（WinSW）
tags: [工具]
categories: [工具]
date: 2023-10-13 08:45:13
---

# 介绍

WinSW可以将Windows上的任何程序作为系统服务进行管理，已达到开机自启的效果。

# 支持的平台

WinSW需要运行在拥有.NET Framework 4.6.1或者更新版本的Windows平台下

# 下载

- github： [下载地址](https://github.com/winsw/winsw/releases)

- 百度网盘（v2.12.0）：[WinSW-x86](https://pan.baidu.com/s/1mCdn2cLyKkA6BSuYtvA-1A?pwd=ktt7)  [WinSW-x64](https://pan.baidu.com/s/1suXVU4I7v3mHApy5UQSO9g?pwd=f3i1)

# 使用说明

## 全局应用

1. 获取`WinSW.exe`文件
2. 编写*myapp.xml*文件（详细内容看[XML配置文件](# XML配置文件)）
3. 运行`winsw install myapp.xml [options]`安装服务，使其写入系统服务中
4. 运行`winsw start myapp.xml` 开启服务
5. 运行`winsw status myapp.xml` 查看服务的运行状态

## 单一应用

1. 获取`WinSW.exe`文件并将其更名为你的服务名(例如*myapp.exe*).
2. 编写*myapp.xml*文件
3. 请确保前面两个文件在同一目录
4. 运行`myapp.exe install [options]`安装服务，使其写入系统服务中
5. 运行`myapp.exe start`开启服务
6. 运行`myapp status myapp.xml` 查看服务的运行状态

# 命令

除了使用说明中的`install`、`start`、`status`三个命令外，WinSW还提供了其他的命令，具体命令及说明如下：

- install：安装服务

- uninstall：卸载服务

- start：启动服务

- stop：停止服务

- restart：重启服务

- status：检查服务状态

- refresh：刷新服务属性

- customize：自定义包装器可执行文件

- dev：扩展命令（具体看下方）

扩展命令：

- dev ps：绘制与服务相关的进程树

- dev kill：如果服务停止响应，则终止该服务

- dev list：列出当前可执行文件管理的服务

# XML配置文件

## 文件结构

xml文件的根元素必须是 `<service>`, 并支持以下的子元素

例子：

```xml
<service>
  <id>jenkins</id>
  <name>Jenkins</name>
  <description>This service runs Jenkins continuous integration system.</description>
  <env name="JENKINS_HOME" value="%BASE%"/>
  <executable>java</executable>
  <arguments>-Xrs -Xmx256m -jar "%BASE%\jenkins.war" --httpPort=8080</arguments>
  <log mode="roll"></log>
</service>
```

## 环境变量扩展

配置 XML 文件可以包含 %Name% 形式的环境变量扩展。如果发现这种情况，将自动用变量的实际值替换。如果引用了未定义的环境变量，则不会进行替换。

此外，服务包装器还会自行设置环境变量 BASE，该变量指向包含重命名后的 WinSW.exe 的目录。这对引用同一目录中的其他文件非常有用。由于这本身就是一个环境变量，因此也可以从服务包装器启动的子进程中访问该值。

## 配置条目
