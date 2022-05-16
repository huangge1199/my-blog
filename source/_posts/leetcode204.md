---
title: 力扣204:计数质数
date: 2022-04-12 11:04:35
tags: [力扣]
categories: [算法,力扣]
mathjax: true
---

今天遇到一个有趣的题目，求小于给定非负整数的质数的数量

原题链接：[力扣204. 计数质数](https://leetcode-cn.com/problems/count-primes/)

# 题目

<p>给定整数 <code>n</code> ，返回 <em>所有小于非负整数 <code>n</code> 的质数的数量</em> 。</p>

<p> </p>

<p><strong>示例 1：</strong></p>

<pre>
<strong>输入：</strong>n = 10
<strong>输出：</strong>4
<strong>解释：</strong>小于 10 的质数一共有 4 个, 它们是 2, 3, 5, 7 。
</pre>

<p><strong>示例 2：</strong></p>

<pre>
<strong>输入：</strong>n = 0
<strong>输出：</strong>0
</pre>

<p><strong>示例 3：</strong></p>

<pre>
<strong>输入：</strong>n = 1
<strong>输出</strong>：0
</pre>

<p> </p>

<p><strong>提示：</strong></p>

<ul>
    <li><code>0 <= n <= 5 * 10<sup>6</sup></code></li>
</ul>
<div><div>Related Topics</div><div><li>数组</li><li>数学</li><li>枚举</li><li>数论</li></div></div>

# 个人解法

思路：

这题我最开始想的比较简单，直接从0开始遍历到给定数字，遍历过程中判断是否是质数

java代码如下：

```java
class Solution {
    public int countPrimes(int n) {
        if (n <= 2) {
            return 0;
        }
        int count = 1;
        for (int i = 3; i < n; i++) {
            if (isPrime(i)) {
                count++;
            }
        }
        return count;
    }
    /**
     * 判断是否是质数
     *
     * @param num 数字
     * @return true：质数、false：不是质数
     */
    private boolean isPrime(int num) {
        if (num < 2) {
            return false;
        }
        if (num == 2) {
            return true;
        }
        for (int i = 2; i * i <= num; i++) {
            if (num % i == 0) {
                return false;
            }
        }
        return true;
    }
}
```

这种办法虽然例子过了，但是最后提交时却是超时了

接下来，我又仔细的想了想，之后想到了一种办法，通过了，然后看了看题解，发现这完全就是埃拉托斯特
尼筛法，简称埃氏筛，也称素数筛，是一种简单且历史悠久的筛法，用来找出一定范围内所有的素数。

这种算法就是给出要筛数值的范围n，从2开始遍历直到  $\sqrt{2}$ 。从2开始把小于n并且是其倍数的标记上，
然后，按顺序是3，和2一样的步骤，不过要判断下是否被标记过，因为，被标记的不是质数

我在维基百科上看到了这个小动画，就是这个算法的整体步骤了

<iframe frameborder=0 border=0 height=369 width=445 src="Sieve_of_Eratosthenes_animation.gif"></iframe>

下面是我的java代码：

```java
class Solution {
    public int countPrimes(int n) {
        if (n <= 2) {
            return 0;
        }
        boolean[] nums = new boolean[n + 1];
        Arrays.fill(nums, true);
        nums[0] = false;
        nums[1] = false;
        int count = 0;
        int max = (int) Math.sqrt(n);
        for (int i = 2; i < n; i++) {
            if (nums[i]) {
                count++;
                if (i > max) {
                    continue;
                }
                for (int j = i; j * i < n; j++) {
                    nums[j * i] = false;
                }
            }
        }
        return count;
    }
}
```
