---
title: python3学习笔记--两种排序方法
date: 2021-12-29 10:20:17
tags: python
categories: 学习笔记
cover: https://blog.huangge1199.cn/post/pyListSort/bg.jpeg
---
# 列表排序方法

- sort()：仅对list对象进行排序，会改变list自身的顺序，没有返回值，即**原地排序**
- sorted()：对所有可迭代对象进行排序，返回排序后的新对象，原对象保持不变；

# sort()

list.sort(key=None, reverse=False)

- **key**：设置排序方法，或指定list中用于排序的元素；
- **reverse**：升降序排列，默认为升序排列；

例子：

```python
nums = [2, 3, 5, 1, 6]
nums.sort()
print(nums)  # [1, 2, 3, 5, 6]
nums.sort(key=None, reverse=True)
print(nums)  # [6, 5, 3, 2, 1]
    
students = [('john', 'C', 15), ('jane', 'A', 12), ('dave', 'B', 10)]
students.sort(key=lambda x: x[2])  # 按照列表中第三个元素排序
print(students)  # [('dave', 'B', 10), ('jane', 'A', 12), ('john', 'C', 15)]
```

# sorted()

sorted(iterable [, key[, reverse]])

- **key** ：设置排序方法，或指定迭代对象中，用于排序的元素；
- **reverse** ：升降序排列，默认为升序排列；

例子：

```python
nums = [2, 3, 5, 1, 6]
newNums = sorted(nums)
print(nums)  # [2, 3, 5, 1, 6]
print(newNums)  # [1, 2, 3, 5, 6]
students = [('john', 'C', 15), ('jane', 'A', 12), ('dave', 'B', 10)]
newStudents = sorted(students, key=lambda x: x[1])
print(students)  # [('john', 'C', 15), ('jane', 'A', 12), ('dave', 'B', 10)]
print(newStudents)  # [('jane', 'A', 12), ('dave', 'B', 10), ('john', 'C', 15)]
```

