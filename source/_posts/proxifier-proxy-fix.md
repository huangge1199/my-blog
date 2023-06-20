---
title: 浏览器不走代理Proxifier问题解决
tags: [网站建设]
categories: [问题记录,网站建设]
date: 2023-06-20 13:47:50
---

环境需要用到代理软件Proxifier，但配好后chrome浏览器访问对应代理的应用却不行，之前还明明可以的，今天就突然不行了，于是乎，我去排查了原因，本篇文章就是我排查的记录吧，最后问题是解决了。每个人的情况不同，可能我的办法不一定适用于你的，因此，本篇文章仅做参考。

# 确认Proxifier设置

1. 打开Proxifier，选择菜单栏的“Profile” - “Proxification Rules”。

2. 在“Proxification Rules”中，确认走代理的应用程序包含浏览器。如果不包含，可单击右键选择“Edit Selected Rule”，在“Edit Rule”中，设置“Any”为“Applications”后点击OK。
   
   # 确认系统代理设置
   
   首先，说明一下，本人是Win11的系统，可能会与你的有出入，下面是详细步骤：

3. 点击电脑的开始菜单，打开设置。

4. 点击左侧的“网络和Internet”，再点击右侧的代理。

![](https://img.huangge1199.cn/blog/proxifier-proxy-fix/2023-06-20-15-45-42-image.png)

3. 确认页面中红框的内容全是关闭状态，如果不是，改为关闭状态

![](https://img.huangge1199.cn/blog/proxifier-proxy-fix/2023-06-20-15-46-58-image.png)
