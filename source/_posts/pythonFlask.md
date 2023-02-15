---
title: 详细的Python Flask的操作
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

![](https://img.huangge1199.cn/blog/pythonFlask/2023-02-14-17-10-32-image.png)

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

## 处理多值

```pythoon
from flask import Flask, request

app = Flask(__name__)


@app.route('/')
def hello_world():  # put application's code here
    r = request.args.getlist('app')  # 返回一个list
    return r


if __name__ == '__main__':
    app.run()
```

在浏览器中访问`http://127.0.0.1:5000/?name=Loen&age&app=ios&app=android`，将显示：

```
[
  "ios",
  "android"
]
```

# 获取POST方法传送的数据

作为一种HTTP请求方法，POST用于向指定的资源提交要被处理的数据。

我们在某些时候不适合将数据放到URL参数中，密或者数据太多，浏览器不一定支持太长长度的URL。这时，一般使用POST方法。

本文章使用python的requests库模拟浏览器。

安装命令：

```batch
pip install requests
```

## 看POST数据内容

app.py代码如下：

```python
from flask import Flask, request

app = Flask(__name__)


@app.route('/register', methods=['POST'])
def register():
    print(request.headers)
    print(request.stream.read())
    return 'welcome'


if __name__ == '__main__':
    app.run()
```

register.py代码如下：

```python
import requests

if __name__ == '__main__':
    user_info = {'name': 'Loen', 'password': 'loveyou'}
    r = requests.post("http://127.0.0.1:5000/register", data=user_info)
    print(r.text)
```

运行`app.py`，然后运行`register.py`。

`register.py`将输出：

```
welcome
```

`app.py`将输出：

```
Host: 127.0.0.1:5000
User-Agent: python-requests/2.28.2
Accept-Encoding: gzip, deflate
Accept: */*
Connection: keep-alive
Content-Length: 26
Content-Type: application/x-www-form-urlencoded


b'name=Loen&password=loveyou'
127.0.0.1 - - [14/Feb/2023 21:12:17] "POST /register HTTP/1.1" 200 -
```

## 解析POST数据

app.py代码如下：

```python
from flask import Flask, request

app = Flask(__name__)


@app.route('/register', methods=['POST'])
def register():
    # print(request.stream.read()) # 不要用，否则下面的form取不到数据
    print(request.form)
    print(request.form['name'])
    print(request.form.get('name'))
    print(request.form.getlist('name'))
    print(request.form.get('nickname', default='little apple'))
    return 'welcome'


if __name__ == '__main__':
    app.run(port=5000, debug=True)
```

register.py代码不变，运行`app.py`，然后运行`register.py`。

`register.py`将输出：

```
welcome
```

`app.py`将输出：

```
ImmutableMultiDict([('name', 'Loen'), ('password', 'loveyou')])
Loen
Loen
['Loen']
little apple
```

request.form会自动解析数据。

request.form['name']和request.form.get('name')都可以获取name对应的值。

request.form.get()可以为参数default指定值以作为默认值。

## 获取POST中的列表数据

app.py代码如下：

```python
from flask import Flask, request

app = Flask(__name__)


@app.route('/register', methods=['POST'])
def register():
    # print(request.stream.read()) # 不要用，否则下面的form取不到数据
    print(request.form.getlist('name'))
    return 'welcome'


if __name__ == '__main__':
    app.run(port=5000, debug=True)
```

register.py代码如下：

```python
import requests

if __name__ == '__main__':
    user_info = {'name': ['Loen', 'Alan'], 'password': 'loveyou'}
    r = requests.post("http://127.0.0.1:5000/register", data=user_info)
    print(r.text)
```

运行`app.py`，然后运行`register.py`。

`register.py`将输出：

```
welcome
```

`app.py`将输出：

```
['Loen', 'Alan']
```

# 处理和响应JSON数据

## 处理JSON数据

如果POST的数据是JSON格式，request.json会自动将json数据转换成Python类型（字典或者列表）。

app.py代码如下：

```python
from flask import Flask, request

app = Flask(__name__)


@app.route('/add', methods=['POST'])
def add():
    print(type(request.json))
    print(request.json)
    result = request.json['n1'] + request.json['n2']
    return str(result)


if __name__ == '__main__':
    app.run(port=5000, debug=True)
```

register.py代码如下：

```python
import requests

if __name__ == '__main__':
    json_data = {'n1': 5, 'n2': 3}
    r = requests.post("http://127.0.0.1:5000/add", json=json_data)
    print(r.text)
```

运行`app.py`，然后运行`register.py`。

`register.py`将输出：

```
8
```

`app.py`将输出：

```
<class 'dict'>
{'n1': 5, 'n2': 3}
```

## 响应JSON数据（Response）

app.py代码如下：

```python
import json

from flask import Flask, request, Response

app = Flask(__name__)


@app.route('/add', methods=['POST'])
def add():
    result = {'sum': request.json['n1'] + request.json['n2']}
    return Response(json.dumps(result), mimetype='application/json')


if __name__ == '__main__':
    app.run(port=5000, debug=True)
```

register.py代码如下：

```python
import requests

if __name__ == '__main__':
    json_data = {'n1': 5, 'n2': 3}
    r = requests.post("http://127.0.0.1:5000/add", json=json_data)
    print(r.headers)
    print(r.text)
```

运行`app.py`，然后运行`register.py`。

`register.py`将输出：

```
/home/huangge1199/PycharmProjects/flaskProject/venv/bin/python /home/huangge1199/PycharmProjects/flaskProject/register.py 
{'Server': 'Werkzeug/2.2.2 Python/3.7.3', 'Date': 'Tue, 14 Feb 2023 13:37:49 GMT', 'Content-Type': 'application/json', 'Content-Length': '10', 'Connection': 'close'}
{"sum": 8}
```

## 响应JSON数据（jsonify）

app.py中app()返回时使用下面的内容，效果同之前一样

```python
return jsonify(result)
```

# 上传表单

用 Flask 处理文件上传很简单，只要确保你没忘记在 HTML 表单中设置 enctype="multipart/form-data" 属性，不然你的浏览器根本不会发送文件。

安装响应的库`werkzeug`

```batch
pip install werkzeug
```

目录结构：

![](https://img.huangge1199.cn/blog/pythonFlask/2023-02-15-15-10-19-image.png)

app.py代码如下：

```python
from flask import Flask, request
from werkzeug.utils import secure_filename
import os

app = Flask(__name__)

# 文件上传目录
app.config['UPLOAD_FOLDER'] = 'static/uploads/'
# 支持的文件格式
app.config['ALLOWED_EXTENSIONS'] = {'png', 'jpg', 'jpeg', 'gif'}  # 集合类型


# 判断文件名是否是我们支持的格式
def allowed_file(filename):
    return '.' in filename and \
        filename.rsplit('.', 1)[1] in app.config['ALLOWED_EXTENSIONS']


@app.route('/upload', methods=['POST'])
def upload():
    upload_file = request.files['image']
    if upload_file and allowed_file(upload_file.filename):  # 上传前文件在客户端的文件名
        filename = secure_filename(upload_file.filename)
        # 将文件保存到 static/uploads 目录，文件名同上传时使用的文件名
        upload_file.save(os.path.join(app.root_path, app.config['UPLOAD_FOLDER'], filename))
        return 'info is ' + request.form.get('info', '') + '. success'
    else:
        return 'failed'


if __name__ == '__main__':
    app.run()
```

register.py代码如下：

```python
import requests

if __name__ == "__main__":
    file_data = {'image': open('flask.png', 'rb')}
    user_info = {'info': 'flask'}
    r = requests.post("http://127.0.0.1:5000/upload", data=user_info, files=file_data)
    print(r.text)
```

运行`app.py`，然后运行`register.py`，这时候文件已经上传到了指定目录中

![](https://img.huangge1199.cn/blog/pythonFlask/2023-02-15-15-11-43-image.png)

要控制上产文件的大小，可以设置请求实体的大小，代码如下：

```python
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024 #16MB
```

获取上传文件的内容，代码如下：

```python
file_content = request.files['image'].stream.read()
```

# Restful URL

Restful URL可以看做是对 URL 参数的替代

## 变量规则

写法如下：

```python
@app.route('/user/<username>/friends')
```

## 转换类型

使用 Restful URL 得到的变量默认为str对象。我们可以用flask内置的转换机制，即在route中指定转换类型，写法如下：

```python
@app.route('/page/<int:num>')
```

有3个默认的转换器：

- int：接受整数

- float：同 int ，但是接受浮点数

- path：和默认的相似，但也接受斜线

## 自定义转换器

自定义的转换器是一个继承werkzeug.routing.BaseConverter的类，修改to_python和to_url方法即可。

to_python方法用于将url中的变量转换后供被`@app.route`包装的函数使用，to_url方法用于flask.url_for中的参数转换。

下面是一个示例：

```python
from flask import Flask, url_for
from werkzeug.routing import BaseConverter


class MyIntConverter(BaseConverter):

    def __init__(self, url_map):
        super(MyIntConverter, self).__init__(url_map)

    def to_python(self, value):
        return int(value)

    def to_url(self, value):
        return value * 2


app = Flask(__name__)
app.url_map.converters['my_int'] = MyIntConverter


@app.route('/page/<my_int:num>')
def page(num):
    print(num)
    print(url_for('page', num='145'))  # page 对应的是 page函数 ，num 对应对应`/page/<my_int:num>`中的num，必须是str
    return 'hello world'


if __name__ == '__main__':
    app.run()
```

运行`app.py`，浏览器访问`http://127.0.0.1:5000/page/28`后，`app.py`的输出信息是：

```
28
/page/145145
```

# 使用url_for生成链接

工具函数`url_for`可以让你以软编码的形式生成url，提供开发效率。

例子`app.py`代码如下：

```python
from flask import Flask, url_for

app = Flask(__name__)


@app.route('/')
def hello_world():
    pass


@app.route('/user/<name>')
def user(name):
    pass


@app.route('/page/<int:num>')
def page(num):
    pass


@app.route('/test')
def test():
    print(url_for('test'))
    print(url_for('user', name='loen'))
    print(url_for('page', num=1, q='welcome to w3c 15%2'))
    print(url_for('static', filename='uploads/flask.png'))
    return 'Hello'


if __name__ == '__main__':
    app.run()
```

运行`app.py`。然后在浏览器中访问`http://127.0.0.1:5000/test`，`server.py`控制台将输出以下信息：

```
/test
/user/loen
/page/1?q=welcome+to+w3c+15%252
/static/uploads/flask.jpg
```

# 使用redirect重定向网址

在浏览器中访问`http://127.0.0.1:5000/old`，浏览器的url会变成`http://127.0.0.1:5000/new`，并显示，`app.py`代码如下：

```python
from flask import Flask, url_for, redirect

app = Flask(__name__)


@app.route('/old')
def old():
    print('this is old')
    return redirect(url_for('new'))


@app.route('/new')
def new():
    print('this is new')
    return 'this is new'


if __name__ == '__main__':
    app.run()
```

运行`app.py`，然后在浏览器中访问`http://127.0.0.1:5000/old`

浏览器显示：

```
this is new
```

控制台显示：

```
this is old
this is new
```

# 自定义404

## 处理HTTP错误

要处理HTTP错误，可以使用`flask.abort`函数。

`app.py`代码如下：

```python
from flask import Flask, abort

app = Flask(__name__)


@app.route('/user')
def user():
    abort(401)  # Unauthorized 未授权
    print('Unauthorized, 请先登录')


if __name__ == '__main__':
    app.run()
```

运行`app.py`，然后在浏览器中访问`http://127.0.0.1:5000/user`

浏览器显示：

![](https://img.huangge1199.cn/blog/pythonFlask/2023-02-15-17-26-19-image.png)

## 自定义错误页面

page_unauthorized 函数返回的是一个元组，401 代表HTTP 响应状态码。

如果省略401，则响应状态码会变成默认的 200。

`app.py`代码如下：

```python
from flask import Flask, abort, render_template_string

app = Flask(__name__)


@app.route('/user')
def user():
    abort(401)  # Unauthorized


@app.errorhandler(401)
def page_unauthorized(error):
    return render_template_string('<h1> Unauthorized </h1><h2>{{ error_info }}</h2>', error_info=error), 401


if __name__ == '__main__':
    app.run()
```

运行`app.py`，然后在浏览器中访问`http://127.0.0.1:5000/user`

浏览器显示：

![](https://img.huangge1199.cn/blog/pythonFlask/2023-02-15-17-29-44-image.png)

# 用户会话

session 用来记录用户的登录状态，一般基于cookie实现。

`app.py`代码如下：

```python
from flask import Flask, render_template_string, request, session, redirect, url_for

app = Flask(__name__)

app.secret_key = 'LoenDSdtj\9bX#%@!!*(0&^%)'


@app.route('/login')
def login():
    page = '''
    <form action="{{ url_for('do_login') }}" method="post">
        <p>name: <input type="text" name="user_name" /></p>
        <input type="submit" value="Submit" />
    </form>
    '''
    return render_template_string(page)


@app.route('/do_login', methods=['POST'])
def do_login():
    name = request.form.get('user_name')
    session['user_name'] = name
    return 'success'


@app.route('/show')
def show():
    return session['user_name']


@app.route('/logout')
def logout():
    session.pop('user_name', None)
    return redirect(url_for('login'))


if __name__ == '__main__':
    app.run()
```

**代码的含义**

app.secret_key用于给session加密。

在/login中将向用户展示一个表单，要求输入一个名字，submit后将数据以post的方式传递给/do_login，/do_login将名字存放在session中。

如果用户成功登录，访问/show时会显示用户的名字。此时，打开调试工具，选择session面板，会看到有一个cookie的名称为session。

/logout用于登出，通过将session中的user_name字段pop即可。Flask中的session基于字典类型实现，调用pop方法时会返回pop的键对应的值；如果要pop的键并不存在，那么返回值是pop()的第二个参数。

另外，使用redirect()重定向时，一定要在前面加上return。

# 设置session的有效时间

设置session的有效时间设置为5分钟。

代码如下：

```python
from datetime import timedelta
from flask import session, app

session.permanent = True
app.permanent_session_lifetime = timedelta(minutes=5)
```

# 使用Cookie

Cookie是存储在客户端的记录访问者状态的数据。

常用的用于记录用户登录状态的session大多是基于cookie实现的。

cookie可以借助flask.Response来实现。

使用`Response.set_cookie`添加和删除cookie。

`expires`参数用来设置cookie有效时间，值可以是`datetime`对象或者unix时间戳。  

```python
res.set_cookie(key='name', value='loen', expires=time.time()+6*60)
```

上面的expire参数的值表示cookie在从现在开始的6分钟内都是有效的。

要删除cookie，将expire参数的值设为0即可：

```python
res.set_cookie('name', '', expires=0)
```

详细的`app.py`代码如下：

```python
import time

from flask import Flask, request, Response

app = Flask(__name__)


@app.route('/add')
def login():
    res = Response('add cookies')
    res.set_cookie(key='name', value='loen', expires=time.time() + 6 * 60)
    return res


@app.route('/show')
def show():
    return request.cookies.__str__()


@app.route('/del')
def del_cookie():
    res = Response('delete cookies')
    res.set_cookie('name', '', expires=0)
    return res


if __name__ == '__main__':
    app.run()

```

# 闪存系统 flashing system

Flask 的闪存系统（flashing system）用于向用户提供反馈信息，这些反馈信息一般是对用户上一次操作的反馈。

反馈信息是存储在服务器端的，当服务器向客户端返回反馈信息后，**这些反馈信息会被服务器端删除。**

详细的`app.py`代码如下：

```python
import time

from flask import Flask, get_flashed_messages, flash

app = Flask(__name__)
app.secret_key = 'some_secret'


@app.route('/')
def index():
    return 'Hello index'


@app.route('/gen')
def gen():
    info = 'access at ' + time.time().__str__()
    flash(info)
    return info


@app.route('/show1')
def show1():
    return get_flashed_messages().__str__()


@app.route('/show2')
def show2():
    return get_flashed_messages().__str__()


if __name__ == '__main__':
    app.run()

```
