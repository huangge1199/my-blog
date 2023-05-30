---
title: 如何使用Python操作Excel文件？看这篇博客就够了！
tags: [python]
categories: [python]
date: 2023-05-30 14:09:15
---

# 前言

如何使用Python操作Excel文件？看这篇博客就够了！

在工作中，我们经常需要处理和分析数据。而Excel作为一种广泛使用的数据分析工具，被很多人所熟知。但是，对于一些非技术背景的用户来说，如何操作Excel却可能有些困难。这时候，Python就成为了一种非常有用的工具。

本文将介绍如何使用Python对Excel文件进行读写操作。首先，我们将介绍Python中可以使用的第三方库`xlrd`、`xlwt`和`xlutils`,并通过示例来展示“如何使用``xlwt``库来将数据写入到Excel文件中”、“如何使用`xlrd`库来读取一个Excel文件的数据”和“如何使用三个库的配合来进行一边读取一边写入的操作”。

通过本文的介绍，你将会了解到：

* 如何获取单元格的值；
* 如何遍历整个工作表；
* 如何创建新的工作表和单元格，并将数据写入到单元格中；
* 如何使用`save()`方法保存Excel文件到磁盘上。

如果你想学习如何使用Python操作Excel文件，那么这篇文章就是为你准备的。希望它能帮助你更好地理解和应用这个工具。

# 1、写入Excel文件

首先来学习下，随机生成数据，写入一个Excel文件并保存，所使用到的库，是xlwt，安装命令`pip install xlwt` ，安装简单方便，无依赖，很快。

## 1.1、新建一个WorkBook对象

```python
import xlwt
wb = xlwt.Workbook()
```

## 1.2、新建sheet

```python
sheet = wb.add_sheet('第一个sheet')
```

## 1.3、写数据

```python
head_data = ['姓名','地址','手机号','城市']
for head in head_data:
    sheet.write(0,head_data.index(head),head)
```

`write`函数写入，分别是x行 x列 数据，头部数据永远是第一行，所以第0行。数据的列，则是当前数据所在列表的索引，直接使用index函数即可。

## 1.4、创建虚假数据

有了头部数据，现在就开始写入内容了，分别是随机姓名 随机地址 随机号码 随机城市，数据的来源都是faker库，一个专门创建虚假数据用来测试的库，安装命令：`pip install faker`。

因为头部信息已经写好，所以接下来是从第1行开始写数据，每行四个数据，准备写99个用户数据，所以用循环，循环99次，代码如下：

```python
import faker
fake = faker.Faker()
for i in range(1,100):
    sheet.write(i,0,fake.first_name() + ' ' + fake.last_name())
    sheet.write(i,1,fake.address())
    sheet.write(i,2,fake.phone_number())
    sheet.write(i,3,fake.city())
```

## 1.5、保存成xls文件

```python
wb.save('虚假用户数据.xls')
```

然后找到文件，使用office或者wps打开这个xls文件：

![](https://img.huangge1199.cn/blog/pyExcel/2023-05-30-14-15-53-image.png)

# 2、读取Excel文件

写文件已经搞定，接下来就要学习下Excel的读操作，读取Excel的库是xlrd，对应read；xlrd的安装命令：`pip install xlrd`

## 2.1、打开Excel文件

```python
import xlrd
wb = xlrd.open_workbook('虚假用户数据.xls')
```

## 2.2、读取Excel数据

```python
# 获取文件中全部的sheet，返回结构是list。
sheets = wb.sheets()
# 通过索引顺序获取。
sheet = sheets[0]
# 直接通过索引顺序获取。
sheet = wb.sheet_by_index(0)
# 通过名称获取。
sheet = wb.sheet_by_name('第一个sheet')
```

## 2.3、打印数据

```python
# 获取行数
rows = sheet.nrows
# 获取列数
cols = sheet.ncols
for row in range(rows):
    for col in range(cols):
        print(sheet.cell(row,col).value,end=' , ')
    print('\n')
```

打印效果（只截取部分）：

![](https://img.huangge1199.cn/blog/pyExcel/2023-05-30-14-14-29-image.png)

# 3、在现有的Excel文件中追加内容

需求：往“虚假用户数据.xls”里面，追加额外的50条用户数据，就是标题+数据，达到150条。

## 3.1、导入库

```python
import xlrd
from xlutils.copy import copy
```

## 3.2、使用xlrd打开文件，然后xlutils赋值打开后的workbook

```python
wb = xlrd.open_workbook('虚假用户数据.xls',formatting_info=True)
xwb = copy(wb)
```

## 3.3、有了workbook之后，就开始指定sheet，并获取这个sheet的总行数

```python
sheet = xwb.get_sheet('第一个sheet')
rows = sheet.get_rows()
```

指定名称为“第一个sheet”的sheet，然后获取全部的行

## 3.4、有了具体的行数，然后保证原有数据不变动的情况下，从第101行写数据

```python
import faker
fake = faker.Faker()
for i in range(len(rows),150):
    sheet.write(i,0,fake.first_name() + ' ' + fake.last_name())
    sheet.write(i,1,fake.address())
    sheet.write(i,2,fake.phone_number())
    sheet.write(i,3,fake.city())
```

range函数，从len(rows)开始，到150-1结束，共50条。 faker库是制造虚假数据的，这个在前面写数据有用过，循环写入了50条。

## 3.5、最后保存就可以了

```python
xwb.save('虚假用户数据.xls')
```

使用xwb，也就是操作之后的workbook对象，直接保存原来的文件名就可以了。

# 4、总结

本文介绍了Python中常用的三个库：xlrd、xlwt和xlutils,分别用于读取Excel文件、写入Excel文件和处理Excel文件。这些库都有各自的优点和缺点，在实际使用时需要根据具体需求进行选择。

同时，本文还提供了一些示例代码来演示如何使用这些库。通过这些示例代码，读者可以更好地了解这些库的使用方法和操作步骤。

最后，提醒读者注意在使用这些库时要仔细阅读其文档和API,以避免出现不必要的错误。

# 5、参考资料

* [W3Cschool微课（Python 自动化办公课程）](https://www.w3cschool.cn/minicourse/play/pythonwork)
* [Python官方文档--xlrd](https://docs.python.org/zh-cn/3/library/xlrd.html)
* [Python官方文档--xlwt](https://docs.python.org/zh-cn/3/library/xlwt.html)
* [Python官方文档--xlutils](https://docs.python.org/zh-cn/3/library/xlutils.html)
