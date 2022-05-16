---

title: 用docker-compose安装nginx
date: 2022-04-24 15:36:52
tags: [docker]
categories: [docker]

---

docker中安装nginx

# 1、查找nginx镜像

通过[Docker Hub网站查询nginx镜像](https://hub.docker.com/)，选择下面的官方镜像

![](2022-04-21-00-46-47-image.png)

# 2、下载镜像

3.1页面点进去后在右上方有docker拉取命令

![](2022-04-21-00-47-51-image.png)

```shell
docker pull nginx
```

![](2022-04-21-01-03-03-image.png)

# 3、编写docker-compose.yml

docker-compose.yml内容如下：

```shell
version: '3'
services:
    nginx: 
        container_name: nginx  #生成的容器名
        image: nginx:latest #镜像
        environment:
            - TZ=Asia/Shanghai #时间
        volumes: 
            - ./html:/usr/share/nginx/html              #nginx静态页位置
            - ./conf/nginx.conf:/etc/nginx/nginx.conf   #配置文件
            - ./conf.d:/etc/nginx/conf.d                #配置文件
            - ./logs:/var/log/nginx                     #日志
        ports: 
            - 80:80
            - 443:443
        restart: always
```

# 4、创建目录以及nginx配置文件

根据docker-compose.yml建立文件目录，并编写相关文件

目录：

![](2022-04-21-20-43-55-image.png)

conf/nginx.conf：

```
user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log notice;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    include /etc/nginx/conf.d/*.conf;
}
```

conf.d/default.conf

```
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;

    #access_log  /var/log/nginx/host.access.log  main;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    #location ~ \.php$ {
    #    root           html;
    #    fastcgi_pass   127.0.0.1:9000;
    #    fastcgi_index  index.php;
    #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
    #    include        fastcgi_params;
    #}

    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    #location ~ /\.ht {
    #    deny  all;
    #}
}
```

html/50x.html

```html
<!DOCTYPE html>
<html>
<head>
<title>Error</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>An error occurred.</h1>
<p>Sorry, the page you are looking for is currently unavailable.<br/>
Please try again later.</p>
<p>If you are the system administrator of this resource then you should check
the error log for details.</p>
<p><em>Faithfully yours, nginx.</em></p>
</body>
</html>
```

html/index.html

```html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

# 5、docker-compose启动nginx

```shell
cd nginx/
ll
docker-compose up -d
```

![](2022-04-21-19-59-02-image.png)

# 6、验证nginx正常启动

执行命令：

```shell
docker ps -a
```

![](2022-04-21-20-12-55-image.png)

然后在浏览器中输入IP，出现欢迎界面，安装完成

![](2022-04-24-15-34-45-image.png)

## 
