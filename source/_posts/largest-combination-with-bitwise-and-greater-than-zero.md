---
title: 力扣2275. 按位与结果大于零的最长组合
date: 2022-05-19 13:41:13
tags: [力扣]
categories: [算法,力扣]
---

力扣周赛293--第三题

[2275. 按位与结果大于零的最长组合](https://leetcode.cn/problems/largest-combination-with-bitwise-and-greater-than-zero/)

# 题目

<p>对数组&nbsp;<code>nums</code> 执行 <strong>按位与</strong> 相当于对数组&nbsp;<code>nums</code> 中的所有整数执行 <strong>按位与</strong> 。</p>

<ul>
	<li>例如，对 <code>nums = [1, 5, 3]</code> 来说，按位与等于 <code>1 &amp; 5 &amp; 3 = 1</code> 。</li>
	<li>同样，对 <code>nums = [7]</code> 而言，按位与等于 <code>7</code> 。</li>
</ul>

<p>给你一个正整数数组 <code>candidates</code> 。计算 <code>candidates</code> 中的数字每种组合下 <strong>按位与</strong> 的结果。 <code>candidates</code> 中的每个数字在每种组合中只能使用 <strong>一次</strong> 。</p>

<p>返回按位与结果大于 <code>0</code> 的 <strong>最长</strong> 组合的长度<em>。</em></p>

<p>&nbsp;</p>

<p><strong>示例 1：</strong></p>

<pre>
<strong>输入：</strong>candidates = [16,17,71,62,12,24,14]
<strong>输出：</strong>4
<strong>解释：</strong>组合 [16,17,62,24] 的按位与结果是 16 &amp; 17 &amp; 62 &amp; 24 = 16 &gt; 0 。
组合长度是 4 。
可以证明不存在按位与结果大于 0 且长度大于 4 的组合。
注意，符合长度最大的组合可能不止一种。
例如，组合 [62,12,24,14] 的按位与结果是 62 &amp; 12 &amp; 24 &amp; 14 = 8 &gt; 0 。
</pre>

<p><strong>示例 2：</strong></p>

<pre>
<strong>输入：</strong>candidates = [8,8]
<strong>输出：</strong>2
<strong>解释：</strong>最长组合是 [8,8] ，按位与结果 8 &amp; 8 = 8 &gt; 0 。
组合长度是 2 ，所以返回 2 。
</pre>

<p>&nbsp;</p>

<p><strong>提示：</strong></p>

<ul>
	<li><code>1 &lt;= candidates.length &lt;= 10<sup>5</sup></code></li>
	<li><code>1 &lt;= candidates[i] &lt;= 10<sup>7</sup></code></li>
</ul>
<div><div>Related Topics</div><div><li>位运算</li><li>数组</li><li>哈希表</li><li>计数</li></div></div>

# 思路

这题需要找出按位与结果大于0的最长组合的长度，按位与结果大于0，
说明这个数组中的每一个二进制数都有相同的一位是1，根据这题给的数组值的范围，
可以确定最多有24位，那么我们可以循环24次数组，每一次循环统计出第`i`位位数为1的个数，
然后将每一次的个数做比较，得出最长组合的长度

# 代码

java：
```java
class Solution {
    public int largestCombination(int[] candidates) {
        int max = 0;
        for (int i = 0; i < 25; i++) {
            int cnt = 0;
            for (int j = 0; j < candidates.length; j++) {
                if ((candidates[j] & (1 << i)) > 0) {
                    cnt++;
                }
            }
            max = Math.max(max, cnt);
        }
        return max;
    }
}
```
