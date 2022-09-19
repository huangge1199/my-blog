---
title: 力扣2413:最小偶倍数
date: 2022-09-19 21:47:05
tags: [力扣]
categories: [算法,力扣]
---

311周赛第一题

原题链接：[2413. 最小偶倍数](https://leetcode.cn/problems/smallest-even-multiple/)

# 题目

给你一个正整数 <code>n</code> ，返回 <code>2</code><em> </em>和<em> </em><code>n</code> 的最小公倍数（正整数）。


<p><strong>示例 1：</strong></p>

<pre><strong>输入：</strong>n = 5
<strong>输出：</strong>10
<strong>解释：</strong>5 和 2 的最小公倍数是 10 。
</pre>

<p><strong>示例 2：</strong></p>

<pre><strong>输入：</strong>n = 6
<strong>输出：</strong>6
<strong>解释：</strong>6 和 2 的最小公倍数是 6 。注意数字会是它自身的倍数。
</pre>

<p><strong>提示：</strong></p>

<ul> 
 <li><code>1 &lt;= n &lt;= 150</code></li> 
</ul>

# 个人解法

这题比较简单，就直接上代码

{% tabs categories%}

<!-- tab Java -->

```java
class Solution {
    public int smallestEvenMultiple(int n) {
        return n % 2 == 0 ? n : n * 2;
    }
}
```

<!-- endtab -->

<!-- tab Python3 -->

```python
class Solution:
    def smallestEvenMultiple(self, n: int) -> int:
        return n if n % 2 == 0 else n * 2

```

<!-- endtab -->

<!-- tab Python3 使用lcm -->

```python
from math import lcm

    
class Solution:
    def smallestEvenMultiple(self, n: int) -> int:
        return lcm(n, 2)

```

<!-- endtab -->

{% endtabs %}