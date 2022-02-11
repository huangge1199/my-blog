---
title: 代码提交到多个git仓库
date: 2022-02-11 17:34:25
tags: [git]
categories: [git]
---

现在我们都习惯于把自己的代码放到远程仓库中，毫无疑问GitHub是首选，但由于国内的网络等各种原因，会导致我们连接不上，这时候我们会考虑放到自建的代码管理仓库或者是gitee上面。

我们还不想放弃GitHub，那么我们就要考虑将代码提交到多个仓库中。

比如，我分别在GitHub和gitee上都有格子的仓库：

- https://github.com/huangge1199/my-blog.git
- https://gitee.com/huangge1199_admin/my-blog.git

那么，我可以通过以下命令来进行添加仓库：

先添加第一个GitHub的仓库地址：
```
git remote add origin https://github.com/huangge1199/my-blog.git
```

再添加gitee的仓库地址
```
git remote set-url --add origin https://gitee.com/huangge1199_admin/my-blog.git
```
这样的话我们push时，就会将代码同时推送到两个仓库了。

当然不想用命令的形式操作，也可以直接修改项目目录下隐藏目录.git中的config文件，在[remote "origin"]中添加多个仓库地址就可以了，参考如下：

```
[remote "origin"]
	url = https://gitee.com/huangge1199_admin/my-blog.git
	fetch = +refs/heads/*:refs/remotes/origin/*
	url = https://github.com/huangge1199/my-blog.git
```



