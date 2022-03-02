---
title: python3学习笔记--常用的函数
date: 2022-03-01 09:02:19
tags: [学习笔记,python]
categories: python
---

{% note info no-icon %}
本篇博客内容为学习整理笔记，学习地址为：
https://www.w3cschool.cn/minicourse/play/python3course?cp=427&gid=0
{% endnote %}

# 字符串函数

## 1、join

以另一个字符串作为分隔符连接字符串列表。

例如：

```python
print(", ".join(["spam", "eggs", "ham"]))
# 打印 "spam, eggs, ham"
```

## 2、replace

用另一个替换字符串中的一个子字符串。

例如：

```python
print("Hello ME".replace("ME", "world"))
# 打印 "Hello world"
```

## 3、startswith

确定是否在字符串的开始处有一个子字符串。

例如：

```python
print("This is a sentence.".startswith("This"))
# 打印 "True"
```

## 4、endswith

确定是否在字符串的结尾处有一个子字符串。

例如：

```python
print("This is a sentence.".endswith("sentence."))
# 打印 "True"
```

## 5、lower

将字符串全部转为小写。

例如：

```python
print("AN ALL CAPS SENTENCE".lower())
# 打印  "an all caps sentence"
```

## 6、upper

将字符串全部转为大写。

例如：

```python
print("This is a sentence.".upper())
# 打印 "THIS IS A SENTENCE."
```

## 7、split

把一个字符串转换成一个列表。

例如：

```python
print("spam, eggs, ham".split(", "))
# 打印  "['spam', 'eggs', 'ham']"
```

# 数字函数

## 1、max

查找某些数字或列表的最大值。

例如：

```python
print(max([1, 2, 9, 2, 4, 7, 8]))
# 打印 9
```

## 2、min

查找某些数字或列表的最小值。

例如：

```python
print(min(1, 6, 3, 4, 0, 7, 1))
# 打印 0
```

## 3、abs

将数字转成绝对值（该数字与0的距离）。

例如：

```python
print(abs(-93))
print(abs(22))
# 打印 93
```

## 4、round

要将数字四舍五入到一定的小数位数。

## 5、sum

计算一个列表数字的总和。

例如：

```python
print(sum([1, 2, 3, 4, 5, 6]))
# 打印 21
```

# 列表函数

## 1、all

列表中所有值均为 True 时，结果为 True，否则结果为 False。

例如：

```python
nums = [55, 44, 33, 22, 11]

if all([i > 5 for i in nums]):
    print("All larger than 5")

# 打印 All larger than 5
```

## 2、any

列表中只要有一个为 True，结果为 True，反之结果为 False。

例如：

```python
nums = [55, 44, 33, 22, 11]

if any([i % 2 == 0 for i in nums]):
   print("At least one is even")

# 打印 At least one is even5
```

## 3、enumerate

用来同时迭代列表的键和值。

例如：

```python
nums = [55, 44, 33, 22, 11]

for v in enumerate(nums):
   print(v)

# 打印
# (0, 55)
# (1, 44)
# (2, 33)
# (3, 22)
# (4, 11)
```
