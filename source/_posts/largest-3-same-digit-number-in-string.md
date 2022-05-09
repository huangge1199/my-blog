---
title: 力扣2264. 字符串中最大的 3 位相同数字
date: 2022-05-09 15:24:16
tags: [力扣]
categories: [算法,力扣]
---

力扣周赛292--第一题

[2264. 字符串中最大的 3 位相同数字](https://leetcode.cn/problems/largest-3-same-digit-number-in-string/)

# 题目

<p>给你一个字符串 <code>num</code> ，表示一个大整数。如果一个整数满足下述所有条件，则认为该整数是一个 <strong>优质整数</strong> ：</p>

<ul>  
   <li>该整数是 <code>num</code> 的一个长度为 <code>3</code> 的 <strong>子字符串</strong> 。</li>  
   <li>该整数由唯一一个数字重复 <code>3</code> 次组成。</li>  
</ul>

<p>以字符串形式返回 <strong>最大的优质整数</strong> 。如果不存在满足要求的整数，则返回一个空字符串 <code>""</code> 。</p>

<p><strong>注意：</strong></p>

<ul>  
   <li><strong>子字符串</strong> 是字符串中的一个连续字符序列。</li>  
   <li><code>num</code> 或优质整数中可能存在 <strong>前导零</strong> 。</li>  
</ul>

<p><strong>示例 1：</strong></p>

<pre>  
<strong>输入：</strong>num = "6<em><strong>777</strong></em>133339"  
<strong>输出：</strong>"777"  
<strong>解释：</strong>num 中存在两个优质整数："777" 和 "333" 。  
"777" 是最大的那个，所以返回 "777" 。  
</pre>

<p><strong>示例 2：</strong></p>

<pre>  
<strong>输入：</strong>num = "23<em><strong>000</strong></em>19"  
<strong>输出：</strong>"000"  
<strong>解释：</strong>"000" 是唯一一个优质整数。  
</pre>

<p><strong>示例 3：</strong></p>

<pre>  
<strong>输入：</strong>num = "42352338"  
<strong>输出：</strong>""  
<strong>解释：</strong>不存在长度为 3 且仅由一个唯一数字组成的整数。因此，不存在优质整数。  
</pre>

<p> </p>

<p><strong>提示：</strong></p>

<ul>  
   <li><code>3 <= num.length <= 1000</code></li>  
   <li><code>num</code> 仅由数字（<code>0</code> - <code>9</code>）组成</li>  
</ul>

# 思路

这题是要找最大的3个相同数并且3个数是相连的，因为数字的话只有0~9这10个数字，找最大的，那我就从999开始，然后依次888、777。。。000，只要字符串中存在，那就是它了。

# 代码

java：

```java
public String largestGoodInteger(String num) {
    String str;
    for (int i = 9; i >= 0; i--) {
        str = "" + i + i + i;
        if (num.contains(str)) {
            return str;
        }
    }
    return "";
}
```
