---
title: 力扣2274. 不含特殊楼层的最大连续楼层数
date: 2022-05-19 09:57:58
tags: [力扣]
categories: [算法,力扣]
---

力扣周赛293--第二题

[2274. 不含特殊楼层的最大连续楼层数](https://leetcode.cn/problems/maximum-consecutive-floors-without-special-floors/)

# 题目

<p>Alice 管理着一家公司，并租用大楼的部分楼层作为办公空间。Alice 决定将一些楼层作为 <strong>特殊楼层</strong> ，仅用于放松。</p>

<p>给你两个整数 <code>bottom</code> 和 <code>top</code> ，表示 Alice 租用了从 <code>bottom</code> 到 <code>top</code>（含 <code>bottom</code> 和 <code>top</code> 在内）的所有楼层。另给你一个整数数组 <code>special</code> ，其中 <code>special[i]</code> 表示&nbsp; Alice 指定用于放松的特殊楼层。</p>

<p>返回不含特殊楼层的 <strong>最大</strong> 连续楼层数。</p>

<p>&nbsp;</p>

<p><strong>示例 1：</strong></p>

<pre>
<strong>输入：</strong>bottom = 2, top = 9, special = [4,6]
<strong>输出：</strong>3
<strong>解释：</strong>下面列出的是不含特殊楼层的连续楼层范围：
- (2, 3) ，楼层数为 2 。
- (5, 5) ，楼层数为 1 。
- (7, 9) ，楼层数为 3 。
因此，返回最大连续楼层数 3 。
</pre>

<p><strong>示例 2：</strong></p>

<pre>
<strong>输入：</strong>bottom = 6, top = 8, special = [7,6,8]
<strong>输出：</strong>0
<strong>解释：</strong>每层楼都被规划为特殊楼层，所以返回 0 。
</pre>

<p>&nbsp;</p>

<p><strong>提示</strong></p>

<ul>
	<li><code>1 &lt;= special.length &lt;= 10<sup>5</sup></code></li>
	<li><code>1 &lt;= bottom &lt;= special[i] &lt;= top &lt;= 10<sup>9</sup></code></li>
	<li><code>special</code> 中的所有值 <strong>互不相同</strong></li>
</ul>
<div><div>Related Topics</div><div><li>数组</li><li>排序</li></div></div>

# 思路

这题相当于在bottom到top的范围内，被special的数分割了，我们需要找到分割后最长的一段

步骤：

1. 为了保证数据的顺序进行，对special进行排序
2. 遍历`special`对`bottom~top`进行分割，当`bottom<=special[i]`时，
连续楼层数为`special[i]-bottom`，与之前的最大连续层数对比，得到当前的最大连续层数，
同时更新`bottom = special[i] + 1`
3. 遍历完，还有最后一段的连续层数`top - special[special.length - 1]`
4. 至此，不包含特殊层的最大的连续层数就出来了

# 代码

java：

```java
class Solution {
    public int maxConsecutive(int bottom, int top, int[] special) {
        Arrays.sort(special);
        int max = 0;
        for (int j : special) {
            if (bottom <= j) {
                max = Math.max(max, j - bottom);
                bottom = j + 1;
            }
        }
        max = Math.max(max, top - special[special.length - 1]);
        return max;
    }
}
```
