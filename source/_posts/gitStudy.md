---
title: 你一看就懂的Git详解
tags: [git]
categories: [git]
date: 2024-07-22 10:22:13
---

# Git基础

## git简介

### 1、简介

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-10-28-02-image.png)

Git 是一个开源的分布式版本控制系统，用于敏捷高效地处理任何或小或大的项目。

Git 是 Linus Torvalds 为了帮助管理 Linux 内核开发而开发的一个开放源码的版本控制软件。

Git 与常用的版本控制工具 CVS, Subversion 等不同，它采用了分布式版本库的方式，不必服务器端软件支持。

### 2、Git 与 SVN 区别

1. GIT 是分布式的，SVN 不是：这是 GIT 和其它非分布式的版本控制系统，例如 SVN，CVS 等，最核心的区别。

2. GIT 把内容按元数据方式存储，而 SVN 是按文件：所有的资源控制系统都是把文件的元信息隐藏在一个类似 .svn , .cvs 等的文件夹里。

3. GIT 分支和SVN的分支不同：分支在SVN中一点不特别，就是版本库中的另外的一个目录。

4. GIT 没有一个全局的版本号，而 SVN 有：目前为止这是跟 SVN 相比 GIT 缺少的最大的一个特征。

5. GIT 的内容完整性要优于 SVN：GIT 的内容存储使用的是 SHA-1哈希算法。这能确保代码内容的完整性，确保在遇到磁盘故障和网络问题时降低对版本库的破坏。

## git安装

### 1、安装

在使用 Git 前我们需要先安装 Git。Git 目前支持 Linux/Unix、Solaris、Mac 和 Windows 平台上运行。

Git 各平台安装包下载地址为：[Git - Downloads](http://git-scm.com/downloads)

### 2、在Linux 平台上安装

首先，你可以试着输入 git，看看系统有没有安装 Git：

```shell
git
```

显示下面的情况就是安装过git

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-10-35-57-image.png)

如果未安装，可选择直接用命令安装或者是源码安装

#### 命令安装

根据Linux的不同版本安装命令不同，下面是各版本的命令：

##### Debian/Ubuntu

```shell
apt-get install git
```

##### Fedora

```shell
# Fedora 21 及以下
yum install git
# Fedora 22 及之后
dnf install git
```

##### Gentoo

```shell
emerge --ask --verbose dev-vcs/git
```

##### Arch Linux

```shell
pacman -S git
```

##### openSUSE

```shell
zypper install git
```

##### Mageia

```shell
urpmi git
```

##### Nix/NixOS

```shell
nix-env -i git
```

##### FreeBSD

```shell
pkg install git
```

##### Solaris 9/10/11 ([OpenCSW](https://www.opencsw.org/))

```shell
pkgutil -i git
```

##### Solaris 11 Express

```shell
pkg install developer/versioning/git
```

##### OpenBSD

```shell
pkg_add git
```

##### Alpine

```shell
apk add git
```

#### 源码安装

我们来学习在 Linux 中如何使用源代码安装 Git, 有些 Linux 版本自带的安装包更新起来并不及时，那么从源代码安装其实该算是最佳选择。

Git 的工作需要调用 curl，zlib，openssl，expat，libiconv 等库的代码，所以需要先安装这些依赖工具。

在有 yum 的系统上（比如 Fedora）可以用下面的命令安装：

```shell
yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel
```

在有 apt-get 的系统上（比如 Debian 体系）可以用下面的命令安装：

```shell
$ apt-get install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev
```

之后，从下面的 Git 官方站点下载最新版本源代码：[http://git-scm.com/download](http://git-scm.com/download)

然后编译并安装：

```shell
# 解压
tar -zxf git-1.7.2.2.tar.gz
# 切换目录
cd git-1.7.2.2
# 设置变量
make prefix=/usr/local all
# 安装
sudo make prefix=/usr/local install
```

### 3、在 Windows 平台上安装

在 Windows 平台上安装 Git 同样轻松，直接下载exe安装包即可。

安装包下载地址：[Git - Downloading Package](https://git-scm.com/download/win)

### 4、在 Mac 平台上安装

既可以通过命令安装也可以通过安装器安装

### Homebrew

如果有它，可以直接使用下面的命令安装：

```shell
brew install git
```

### MacPorts

如果有它，可以直接使用下面的命令安装：

```shell
sudo port install git
```

### 安装器

可以使用图形化 Git 安装工具

下载地址为：[git-osx-installer (abandoned) download | SourceForge.net](http://sourceforge.net/projects/git-osx-installer/)

## Git 工作流程

Git 的一般工作流程如下：

- 克隆 Git 资源作为工作目录。
- 在克隆的资源上添加或修改文件。
- 如果其他人修改了，你可以更新资源。
- 在提交前查看修改。
- 提交修改。
- 在修改完成后，如果发现错误，可以撤回提交并再次修改并提交。

**下图展示了 Git 的工作流程：**

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-11-36-00-image.png)

下面来理解下Git 工作区、暂存区和版本库概念

- 工作区：就是你在电脑里能看到的目录。
- 暂存区：英文叫 stage, 或 index。一般存放在 ".git目录下" 下的 index 文件（.git/index）中，所以我们把暂存区有时也叫作索引（index）。
- 版本库：工作区有一个隐藏目录 .git，这个不算工作区，而是 Git 的版本库。

# Git基本操作

## 创建版本库 ( git init )

### 描述

用 git init 在目录中创建新的 Git 仓库。 你可以在任何时候、任何目录中这么做，完全是本地化的。

### 语法

```shell
git init
```

### 例子

比如我们创建 gitlearn 项目：

```shell
# 创建项目目录
mkdir gitlearn
# 切换目录
cd gitlearn
# 创建版本库
git init
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-11-55-28-image.png)

## 添加到暂存区 ( git add )

### 描述

当我们初始化项目后, 在工作区里进行增加, 修改, 删除 文件操作.

然后可以通过 git add 将文件添加到暂存区，作为下次提交的(部分或全部)内容。

### 语法

```shell
git add <文件/文件夹> [<args>]
```

**git add .** ：他会监控工作区的状态树，使用它会把工作时的所有变化提交到暂存区，包括文件内容修改(modified)以及新文件(new)，但不包括被删除的文件。

**git add -u** ：他仅监控已经被add的文件（即tracked file），他会将被修改的文件提交到暂存区。add -u 不会提交新文件（untracked file）。（git add --update的缩写）

**git add -A** ：是上面两个功能的合集, 也就是说包括删除的文件也会被提交（git add --all的缩写）

### 例子

我们在 gitlearn 项目添加两个文件并添加到暂存区

```shell
# 创建空文件README
touch README
# 创建空文件hello.php
touch hello.php
# 查看当前目录
ls -al
# 查看项目的当前状态
git status -s
# 将README和hello.php添加到暂存区
git add README hello.php
# 查看项目的当前状态
git status -s
# 在 README 中添加内容
echo "Git 测试" >> README
# 查看项目的当前状态
git status -s
将目录下的所有内容添加到暂存区
git add .
# 查看项目的当前状态
git status -s
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-13-09-50-image.png)

"A" 状态的意思是，这个文件已经添加到缓存中

"AM" 状态的意思是，这个文件在我们将它添加到缓存之后又有改动

## 查看状态 ( git status )

### 描述

**git status** 查看本地工作区、暂存区中文件的修改状态

### 语法

```shell
git status
```

### 例子

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-13-19-48-image.png)

## 查看改动 ( git diff )

### 描述

执行 **git diff** 来查看执行 **git status** 的结果的详细信息。

git diff 命令显示已写入缓存与已修改但尚未写入缓存的改动的区别。

### 语法

```shell
# 尚未缓存的改动
git diff
# 查看已缓存的改动
git diff --cached
# 查看已缓存的与未缓存的所有改动
git diff HEAD
# 显示摘要而非整个 diff
git diff --stat
```

### 例子

```shell
# 向hello.php中添加内容
echo -e "<?php\necho '查看改动test';">>hello.php
# 查看hello.php文件内容
cat hello.php
# 查看项目的当前状态
git status -s
# 查看尚未缓存的改动
git diff
# 将hello.php的改动添加到暂存区
git add hello.php
# 查看项目的当前状态
git status -s
# 查看已缓存的改动
git diff --cached
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-13-36-34-image.png)

## 向仓库提交代码 ( git commit )

### 描述

使用 **git add** 命令将想要快照的内容写入缓存区， 而执行 **git commit** 将缓存区内容添加到仓库中。

如果你觉得 **git add** 提交缓存的流程太过繁琐，Git 也允许你用 -a 选项跳过这一步。

Git 为你的每一个提交都记录你的名字与电子邮箱地址，所以第一步需要配置用户名和邮箱地址。

```shell
# 配置全局的名称
git config --global user.name 'huangge1199'
# 配置全局的邮箱
git config --global user.email huangge1199@hotmail.com
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-13-44-45-image.png)

### 语法

```shell
# 将想要快照的内容写入缓存区
git add 
# 将缓存区内容添加到仓库
git commit

# 将想要快照的内容添加到仓库
# 注：和前面的两条命令效果相同
git commit -a
```

### 例子一

```shell
# 我们使用 -m 选项以在命令行中提供提交注释
git commit -m '初始化项目'
git status
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-13-58-11-image.png)

以上输出说明我们在最近一次提交之后，没有做任何改动，是一个"working directory clean：干净的工作目录"。

> 如果你没有设置 -m 选项，Git 会尝试为你打开一个编辑器以填写提交信息。 如果 Git 在你对它的配置中找不到相关信息，默认(Linux)会打开 vim。

### 例子二

如果你觉得 **git add** 提交缓存的流程太过繁琐，Git 也允许你用 -a 选项跳过这一步。

```shell
echo -e "echo '向仓库提交代码测试：git commit -a';">>hello.php
git status
git commit -am '修改hello'
git status
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-14-03-00-image.png)

## 取消已缓存的内容 ( git reset HEAD )

### 语法

```shell
git reset HEAD -- <文件/文件夹>
```

### 例子

```shell
echo -e "echo '取消缓存测试';">>hello.php
echo -e "取消缓存测试">>README
git status -s
git add .
git status -s
git reset HEAD -- hello.php
git status -s
git commit -m '修改README'
git status -s
git commit -am '修改 hello 文件'
git status
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-14-16-33-image.png)

## 删除文件 ( git rm )

### 语法

```shell
# git rm 从版本库中删除文件
git rm <文件>
# 如果删除之前修改过并且已经放到暂存区域的话，则必须要用强制删除选项 -f
git rm -f <文件>
# 如果把文件从暂存区域移除，但仍然希望保留在当前工作目录中，换句话说，仅是从跟踪清单中删除，使用 --cached 选项即可
git rm --cached <文件>
# 用版本库里的版本替换工作区的版本，无论工作区是修改还是删除，都可以“一键还原”
git checkout -- <文件>
# 递归删除目录下的所有文件和子目录
git rm –r <文件夹>
```

### 例子：从版本库中和工作区中删除

```shell
echo "# 这是一个测试文件的测试" > gittest.md
git add .
git commit -m "添加测试文件"
git rm gittest.md
ls -al
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-14-41-43-image.png)

### 例子：删除暂存区或分支上的文件, 不删除本地

```shell
git rm --cached README
ls -al
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-14-50-08-image.png)

## 移动/重命名 ( git mv )

### 描述

git mv 命令用于移动或重命名一个文件、目录、软连接。

### 语法

```shell
git mv 原文件名 新文件名
```

### 例子

```shell
git add README
git mv README  README.md
ls -al
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-15-28-12-image.png)

# 远程仓库

## 添加远程仓库

我这边使用的是自建的gitea

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-15-36-18-image.png)

创建仓库后出现下面的页面

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-15-37-24-image.png)

现在,这个仓库还是空的, gitea告诉我们，可以从这个仓库克隆出新的仓库，也可以把一个已有的本地仓库与之关联，然后，把本地仓库的内容推送到 gitea仓库。

我们将本地已有仓库与之关联:

```shell
git remote add origin https://gitea.huangge1199.cn/huangge1199/gitlearn.git
```

然后,我们把本地库的所有内容推送到远程库上:

```shell
git push -u origin master
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-15-41-28-image.png)

由于远程库是空的，我们第一次推送`master`分支时，加上了`-u`参数

另外红框的地方需要输入gitea的用户名和密码

推送成功后, 就可以在 gitea页面看到内容了:

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-15-44-06-image.png)

## 克隆操作 ( git clone )

使用 **git clone** 拷贝一个 Git 仓库到本地，让自己能够查看该项目，或者进行修改。

如果你需要与他人合作一个项目，或者想要复制一个项目，看看代码，你就可以克隆那个项目。 执行命令：

```shell
 git clone [url]
```

[url] 为你想要复制的项目地址。

例如,我们在 gitea 创建一个新的 gitClone

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-15-49-08-image.png)

填上仓库名称，勾选上”初始化仓库(添加. gitignore、许可证和自述文件)“

创建完毕后可以看到仓库中有一个 README.md 文件:

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-15-50-28-image.png)

现在,将以上项目克隆到本地：

```shell
git clone https://gitea.huangge1199.cn/huangge1199/gitClone.git
cd gitClone
ls -al
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-22-15-52-52-image.png)

> 默认情况下，Git 会按照你提供的 URL 所指示的项目的名称创建你的本地项目目录。 通常就是该 URL 最后一个 / 之后的项目名称。如果你想要一个不一样的名字， 你可以在该命令后加上你想要的名称。

> 例如: git clone https://gitea.huangge1199.cn/huangge1199/gitClone.git app

## 更新数据

### 更新数据 ( git fetch )

**git fetch**：从远程获取最新版本到本地，不会自动 merge

```shell
git checkout issue12
git fetch origin issue12
git log -p issue12..origin/issue12
git merge origin/issue12
```

> 解析:
> 
> (1).切换到issue12分支  
> 
> (2).从远程的origin的issue12主分支下载最新的版本到origin/issue12分支上  
> 
> (3).比较本地的issue12分支和origin/issue12分支的差别  ( git log 常用 -p 选项展开显示每次提交的内容差异 )
> 
> (4).将origin/issue12分支合并到issue12

### 更新数据 ( git pull  )

**git pull**：相当于是从远程获取最新版本并merge到本地

```shell
git checkout issue13
git pull origin issue13
```

> 上述 git pull 命令,  相当于 git fetch 和 git merge

# Git分支管理

## Git 分支原理

Git 每次提交的版本, Git 都将其串成一条时间线, 这条时间线就是一个分支, 当你执行 **git init** 的时候，缺省情况下 Git 就会为你创建 "master" 分支。`HEAD`严格来说不是指向提交，而是指向`master`，`master`才是指向提交的，所以，`HEAD`指向的就是当前分支。

如图所示:

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-09-00-41-image.png)

每次提交，`master`分支都会向前移动一步，这样，随着你不断提交，`master`分支的线也越来越长.

当我们创建新的分支，如`dev`时，Git 新建了一个指针叫`dev`，指向与`master`相同的提交，再把`HEAD`指向`dev`，现在表示当前分支在`dev`上  

如图所示:

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-09-02-17-image.png)

从现在开始, 对工作区的修改和提交就是针对`dev`分支了，比如新提交一次后，`dev`指针往前移动一步，而`master`指针不变.

如图所示:

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-09-04-07-image.png)

我们在`dev`上完成相应的开发后, 我们将其合并到 master 分支上, 切换回 master 分支.  

如图所示:

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-09-05-48-image.png)

合并完成后, 也可以删除 dev 分支, 原理是将 dev 指针删除

如图所示:

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-09-06-25-image.png)

## 分支基础命令

几乎每一种版本控制系统都以某种形式支持分支。使用分支意味着你可以从开发主线上分离开来，然后在不影响主线的同时继续工作。

有人把 **Git** 的分支模型称为"必杀技特性"，而正是因为它，将 Git 从版本控制系统家族里区分出来。

创建分支命令：

```shell
git branch 分支名
```

切换分支命令:

```shell
git checkout 分支名
```

当你切换分支的时候，Git 会用该分支的最后提交的快照替换你的工作目录的内容， 所以多个分支不需要多个目录。

合并分支命令:

```shell
git merge 
```

你可以多次合并到统一分支， 也可以选择在合并之后直接删除被并入的分支。

## 查看、创建及切换分支

### 语法

```shell
# 列出分支
git branch
# 创建分支
git branch 分支名
# 切换分支
git checkout 分支名
# 创建新分支并立即切换到该分支
git checkout -b 分支名
```

### 例子一

```shell
# 列出分支
git branch
# 创建分支dev
git branch dev
# 列出分支
git branch
# 列出当前目录的所有文件
ls -al
# 切换到dev分支
git checkout dev
# 创建新文件test.md
echo '# Git分支学习测试' > test.md
# 添加到暂存区
git add .
# 提交到dev分支
git commit -m "新增test.md文件"
# 列出当前目录的所有文件
ls -al
# 切换回master分支
git checkout master
# 列出当前目录的所有文件
ls -al
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-09-21-12-image.png)

### 例子二

```shell
# 创建新分支newtest并切换到新分支
git checkout -b newtest
# 查看所有分支
git branch
# 删除hello.php文件
git rm hello.php
# 列出目录下所有文件
ls -al
# 提交变更到newtest分支
git commit -am "removed hello.php"
# 切换回master分支
git checkout master
# 列出目录下所有文件
ls -al
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-09-31-46-image.png)

## 分支合并

### 描述

一旦某分支有了独立内容，你终究会希望将它合并回到你的主分支。

### 语法

```shell
git merge 分支名
```

### 例子

```shell
# 创建新分支dev2并切换到新分支
git checkout -b dev2
# 创建空文件dev2.md
touch dev2.md
# 添加到暂存区
git add .
# 提交到dev2分支
git commit -m "新增dev2.md"
# 切回master分支
git checkout master
# 列出目录下所有文件
ls -al
# 将dev2分支合并到当前master分支
git merge dev2
# 列出目录下所有文件
ls -al
```

## 删除分支

### 语法

```shell
git branch -d <分支名>
```

### 例子

```shell
# 查看所有分支
git branch
# 删除分支dev2
git branch -d dev2
# 查看所有分支
git branch
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-10-17-52-image.png)

## 解决冲突

我们先创造一个冲突出来, 比如, 在两个分支中修改了同一个文件的同一行代码,在合并的时候就会发生冲突，出现冲突后我们再解决冲突。下面就是创建冲突、解决冲突的全过程。

```shell
# 查看所有分支
git branch
# 查看当前目录
ls -al
# 查看gittest.md文件内容
cat gittest.md
# 在gittest.md文件结尾添加“冲突测试”
echo "冲突测试" >> gittest.md
# 查看gittest.md文件内容
cat gittest.md
# 查看git状态
git status -s
# 提交变化到master分支
git commit -am "冲突测试"
# 创建并切换到dev1分支
git checkout -b dev1
# 查看当前目录
ls -al
# 查看gittest.md文件内容
cat gittest.md
# 将gittest.md文件最后一行替换成“冲突测试dev1”
sed -i '$s/.*/冲突测试dev1/' gittest.md
# 查看gittest.md文件内容
cat gittest.md
# 提交变化到dev1分支
git commit -am "冲突测试dev1"
# 切换回master分支
git checkout master
# 将gittest.md文件最后一行替换成“冲突测试master”
sed -i '$s/.*/冲突测试master/' gittest.md
# 查看gittest.md文件内容
cat gittest.md
# 提交变化到master分支
git commit -am "冲突测试master"
# 合并dev1分支到master
git merge dev1
# 查看git状态
git status
# 查看gittest.md文件内容
cat gittest.md
# 将gittest.md文件中冲突部分替换成“冲突测试master 和 冲突测试dev1”
sed -i '/^<<<<<<< HEAD$/,/^>>>>>>> dev1$/c\冲突测试master 和 冲突测试dev1' gittest.md
# 查看gittest.md文件内容
cat gittest.md
# 提交冲突修复内容到master分支
git commit -am "修复冲突"
# 查看分支历史
git log --graph --pretty=oneline --abbrev-commit
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-11-01-46-image.png)

## 分支管理策略

通常 Git 在合并分支的时候会用 Fast forward 模式, 这样删除分支后, 也会丢掉分支信息.

我们在合并分支时可以使用 --no-ff 参数,强制禁用 Fastforward 模式, 这样 Git 在合并时会生成一个新的 commit(提交), 然后我们就可以在历史分支上看出分支信息.

我们来操作下看看效果, 我们创建一个 dev2 的分支

```shell
git checkout -b dev2
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-11-18-23-image.png)

修改 gittest.md 文件, 然后提交修改:

```shell
ls -al
cat gittest.md
echo "分支策略。。。测试" >> gittest.md
cat gittest.md
git commit -am "分支策略"
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-11-22-32-image.png)

切回 master 分支, 然后使用 git merge --no-ff 合并分支:

```shell
git checkout master
git merge --no-ff -m "merge with no-ff" dev2
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-11-24-12-image.png)

因为我们禁用 Fast forward 模式, 所以本次合并会创建一个新的 commit(提交), 我们用 -m 给这次 commit 加上描述

然后我们用 git log 查看下分支历史

```shell
git log --graph --pretty=oneline --abbrev-commit
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-11-25-13-image.png)

## 多人协作

### 查看远程库信息

当我们从远程仓库克隆时，实际上 Git 自动把本地的`master`分支和远程的`master`分支对应起来了(远程仓库默认名字是 origin)  

可以用 git remote 查看远程库的信息

```shell
git remote
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-11-28-41-image.png)

加参数 -v 可以显示更详细的信息：

```shell
git remote -v
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-11-29-25-image.png)

> 上面显示了可以抓取和推送的`origin`的地址。如果没有推送权限，就看不到push的地址。

### 推送分支

我们想将本地分支推送到远程库,可以使用 git push 命令,在推送时,要指定本地分支, 这样，Git 就会把该分支推送到远程库对应的远程分支上：

```shell
git push origin master
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-11-53-32-image.png)

如果要推送其他分支, 比如 dev2 :

```shell
git push origin dev2
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-11-54-27-image.png)

# 回退与撤销

## 撤销修改 ( git checkout -- file)

### 描述

把 该文件 在工作区的修改全部撤销

### 语法

```shell
git checkout -- <file>
```

如果 文件 修改后还没有被放到暂存区，现在，撤销修改就是用版本库的版本覆盖当前的文件。

如果 文件 已经添加到暂存区后，又作了修改，现在，撤销修改就是将暂存区中的文件版本覆盖当前的文件。

> 总之，就是让这个文件回到最近一次`git commit`或`git add`时的状态。

### 例子

```shell
# 查看git状态
git status
# 查看gittest.md文件内容
cat gittest.md
# 修改gittest.md文件
echo "撤销修改。。。测试" >> gittest.md
# 查看gittest.md文件内容
cat gittest.md
# 查看本地与暂存区的不同
git diff
# 撤销本地修改
git checkout -- gittest.md
# 查看gittest.md文件内容
cat gittest.md
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-13-27-33-image.png)

## 历史记录 ( git log )

在实际工作中，我们脑子里怎么可能记得一个几千行的文件每次都改了什么内容，不然要版本控制系统干什么。

Git 可以使用 **git log** 命令告诉我们历史记录：

```shell
git log
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-13-37-09-image.png)

`git log`命令显示从最近到最远的提交日志

如果嫌 git log 输出信息太多，看得眼花缭乱，可以加上`--pretty=oneline`参数:

```shell
git log --pretty=oneline
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-13-38-36-image.png)

## 版本回退 ( git reset )

### 描述

要把当前版本回退到上一个版本，可以使用`git reset`命令.  

### 语法

回退到上一个版本：

```shell
git reset --hard HEAD^
```

> 在 Git 中，用 HEAD 表示当前版本，上一个版本就是 HEAD^，上上一个版本就是 HEAD^^，当然往上100个版本写100个^比较容易数不过来，所以写成HEAD~100

回退到指定 commit id 版本：

```shell
git reset --hard <commit id>
```

### 例子

```shell
# 查看当前历史记录
git log --pretty=oneline
# 回退到上一个版本
git reset --hard HEAD^
# 查看当前历史记录
git log --pretty=oneline
# 显示整个本地仓储的 commit
git reflog
# 回退失误,通过回退到指定 commit id 版本，改回原来的版本
git reset --hard cd531a8
# 查看当前历史记录
git log --pretty=oneline
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-13-54-38-image.png)

# 标签管理

## 创建标签

### 语法

```shell
# 创建一个新标签，默认打在最新提交的 commit id 上的。
git tag <标签名>
# 在指定commit id上打标签
git tag <标签名> <commit id>
# 创建带有说明的标签
git tag -a <标签名> -m <说明> <commit id>
```

### 例子

```shell
git log --pretty=oneline --abbrev-commit
git tag v1.0
git log --pretty=oneline --abbrev-commit
git tag v0.8 b2db307
git tag -a v0.9 -m "标签说明" 0d5375b
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-14-06-23-image.png)

## 查看标签

### 语法

```shell
# 查看所有标签
git tag
# 查看标签信息
git show <标签名>
```

### 例子

```shell
git tag
git show v0.9
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-14-12-35-image.png)

## 删除和推送标签

可以使用 git tag -d 标签名 删除打错的标签：

```shell
git tag -d v0.8
git tag
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-14-15-54-image.png)

到目前为止,我们打的标签都只是存储在本地

如果要推送某个标签到远程，使用命令 git push origin 标签名

```shell
git push origin v1.0
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-14-31-13-image.png)

也可以，一次性推送全部尚未推送到远程的本地标签：

```shell
git push origin --tags
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-14-32-13-image.png)

如果标签已经推送到远程，要删除远程标签就麻烦一点，先从本地删除，然后，从远程删除。删除命令也是push

```shell
git tag -d v0.9
git push origin :refs/tags/v0.9
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-14-33-46-image.png)

# 自定义Git

## Git 配置

Git 提供了一个叫做 git config 的工具，专门用来配置或读取相应的工作环境变量。

这些环境变量，决定了 Git 在各个环节的具体工作方式和行为。这些变量可以存放在以下三个不同的地方：

- /etc/gitconfig 文件：系统中对所有用户都普遍适用的配置。若使用 git config 时用 --system 选项，读写的就是这个文件。
- ~/.gitconfig 文件：用户目录下的配置文件只适用于该用户。若使用 git config 时用 --global 选项，读写的就是这个文件。
- 当前项目的 Git 目录中的配置文件（也就是工作目录中的 .git/config 文件）：这里的配置仅仅针对当前项目有效。每一个级别的配置都会覆盖上层的相同配置，所以 .git/config 里的配置会覆盖 /etc/gitconfig 中的同名变量。

在 Windows 系统上，Git 会找寻用户主目录下的 .gitconfig 文件。主目录即 $HOME 变量指定的目录，一般都是 C:\Documents and Settings\$USER。

此外，Git 还会尝试找寻 /etc/gitconfig 文件，只不过看当初 Git 装在什么目录，就以此作为根目录来定位。

### 配置用户信息

配置个人的用户名称和电子邮件地址：

```shell
git config --global user.name "huangge1199"
git config --global user.email huangge1199@hotmail.com
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-14-38-54-image.png)

### 查看配置信息

要检查已有的配置信息，可以使用 **git config --list** 命令：

```shell
git config --list
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-14-39-44-image.png)

有时候会看到重复的变量名，那就说明它们来自不同的配置文件（比如 /etc/gitconfig 和 ~/.gitconfig），不过最终 Git 实际采用的是最后一个。

这些配置我们也可以在 ~/.gitconfig 或 /etc/gitconfig 看到，如下所示：

```shell
cat ~/.gitconfig
```

![](https://img.huangge1199.cn/blog/gitStudy/2024-07-23-14-41-21-image.png)

## 忽略特殊文件

有时你必须把某些文件放入 Git 工作目录中, 又不能将其提交, 比如:存储了数据库密码的配置文件.

我们只需在 Git 工作区的根目录下创建一个名为 .gitignore 的文件, 写入过滤规则就行了.

忽略文件的原则是：

1. 忽略操作系统自动生成的文件，比如缩略图等；
2. 忽略编译生成的中间文件、可执行文件等，也就是如果一个文件是通过另一个文件自动生成的，那自动生成的文件就没必要放进版本库，比如 Java 编译产生的 .class 文件；
3. 忽略你自己的带有敏感信息的配置文件，比如存放口令的配置文件。

例如, 这是 java 项目的 .gitignore 文件

```gitignore
# Compiled class file
*.class

# Log file
*.log

# BlueJ files
*.ctxt

# Mobile Tools for Java (J2ME)
.mtj.tmp/

# Package Files #
*.jar
*.war
*.ear
*.zip
*.tar.gz
*.rar

# virtual machine crash logs, see http://www.java.com/en/download/help/error_hotspot.xml
hs_err_pid*
```
