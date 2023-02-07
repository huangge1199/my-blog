---
title: 免费HTTPS证书部署
date: 2023-02-07 15:15:03
tags: 网站建设
categories: [网站建设]
---

# 前言

由于腾讯云限制了免费证书的使用个数，而我之前因为免费就随意了很多，现在，一个正在使用的证书过期了，没法继续使用，这样就导致了在浏览器中不能一步到位的打开网站

# 网站介绍

使用的是[FreeSSL.cn](https://freessl.cn/)网站，该网站提供免费的HTTPS证书申请，下面是网站首页

![](https://img.huangge1199.cn/blog/useFreeSSL/2023-02-07-15-29-10-image.png)

# 安装acme.sh

我们需要先在服务器上安装acme.sh，建议使用root用户安装

```shell
curl https://get.acme.sh | sh -s email=my@example.com
```

![](https://img.huangge1199.cn/blog/useFreeSSL/2023-02-07-15-49-45-image.png)

# ACME 域名配置

在首页中输入想要申请证书的域名，点击后面的按钮

![](https://img.huangge1199.cn/blog/useFreeSSL/2023-02-07-15-31-54-image.png)

点击下一步

![](https://img.huangge1199.cn/blog/useFreeSSL/2023-02-07-15-32-57-image.png)

根据内容，去你的域名管理处添加信息，添加后回来点击按钮

![](https://img.huangge1199.cn/blog/useFreeSSL/2023-02-07-15-38-46-image.png)

![](https://img.huangge1199.cn/blog/useFreeSSL/2023-02-07-15-40-47-image.png)

出现下面的页面，可以先直接点击完成

![](https://img.huangge1199.cn/blog/useFreeSSL/2023-02-07-16-02-28-image.png)

# 部署证书

acme.sh 部署命令，这个就是上面图中的内容

```shell
acme.sh --issue -d blog.huangge1199.cn  --dns dns_dp --server [专属 ACME 地址]
```

![](https://img.huangge1199.cn/blog/useFreeSSL/2023-02-07-16-07-46-image.png)

生成证书，注意生成证书的路径根据自己的情况修改

```shell
acme.sh --install-cert -d blog.huangge1199.cn \
--key-file       /www/server/panel/vhost/cert/blog.huangge1199.cn/key.pem  \
--fullchain-file /www/server/panel/vhost/cert/blog.huangge1199.cn/cert.pem \
--reloadcmd     "service nginx reload"
```

![](https://img.huangge1199.cn/blog/useFreeSSL/2023-02-07-16-09-45-image.png)

修改nginx配置文件，添加如下的内容，证书文件的路径和名字同生成证书的路径与名字一致

```yml
ssl_certificate    /www/server/panel/vhost/cert/blog.huangge1199.cn/cert.pem;
ssl_certificate_key    /www/server/panel/vhost/cert/blog.huangge1199.cn/key.pem;
ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
ssl_ciphers EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5;
ssl_prefer_server_ciphers on;
```

![](https://img.huangge1199.cn/blog/useFreeSSL/2023-02-07-16-12-23-image.png)

nginx最好再重启一次

```shell
service nginx reload
```

![](https://img.huangge1199.cn/blog/useFreeSSL/2023-02-07-16-13-25-image.png)

# 验证

点击跳转，[龙儿之家]([https://blog.huangge1199.cn/](https://blog.huangge1199.cn/))

![](https://img.huangge1199.cn/blog/useFreeSSL/2023-02-07-16-15-44-image.png)
