---
title: python3学习笔记--pairwise
date: 2022-09-05 20:52:18
tags: [学习笔记,python]
categories: python
---
# 说明
pairwise(iterable)是itertools下的一个方法
该方法是会返回传入列表所有相邻元素，如果传入的数据少于两个，会返回空

# 官方文档
Return successive overlapping pairs taken from the input iterable.

The number of 2-tuples in the output iterator will be one fewer than the number of inputs. It will be empty if the input iterable has fewer than two values.

Roughly equivalent to:
```python
def pairwise(iterable):
    # pairwise('ABCDEFG') --> AB BC CD DE EF FG
    a, b = tee(iterable)
    next(b, None)
    return zip(a, b)
```

# 源码
在`itertools.py`文件中
```python
class pairwise(object):
    """
    Return an iterator of overlapping pairs taken from the input iterator.
    
        s -> (s0,s1), (s1,s2), (s2, s3), ...
    """
    def __getattribute__(self, *args, **kwargs): # real signature unknown
        """ Return getattr(self, name). """
        pass

    def __init__(self, *args, **kwargs): # real signature unknown
        pass

    def __iter__(self, *args, **kwargs): # real signature unknown
        """ Implement iter(self). """
        pass

    @staticmethod # known case of __new__
    def __new__(*args, **kwargs): # real signature unknown
        """ Create and return a new object.  See help(type) for accurate signature. """
        pass

    def __next__(self, *args, **kwargs): # real signature unknown
        """ Implement next(self). """
        pass
```

# 参考代码

代码：
```python
#!/usr/bin/env python3
# @Time : 2022/9/5 20:23
# @Author : 轩辕龙儿
# @File : pyPairwise.py 
# @Software: PyCharm
from itertools import pairwise

if __name__ == "__main__":
    arrs = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    print("传入数据：0, 1, 2, 3, 4, 5, 6, 7, 8, 9")
    for arr in pairwise(arrs):
        print(str(arr[0]) + "," + str(arr[1]))
    print("------------------------------------")
    print("传入数据：1")
    for arr in pairwise([1]):
        print(str(arr[0]) + "," + str(arr[1]))
```
控制台输出：
```
"D:\Program Files\Python310\python.exe" D:/project/leet-code-python/study/pyPairwise.py 
传入数据：0, 1, 2, 3, 4, 5, 6, 7, 8, 9
0,1
1,2
2,3
3,4
4,5
5,6
6,7
7,8
8,9
------------------------------------
传入数据：1

Process finished with exit code 0
```