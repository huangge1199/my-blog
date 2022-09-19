---
title: 力扣2414:最长的字母序连续子字符串的长度
date: 2022-09-19 22:47:57
tags: [力扣]
categories: [算法,力扣]
---

311周赛第二题

原题链接：[2414. 最长的字母序连续子字符串的长度](https://leetcode.cn/problems/length-of-the-longest-alphabetical-continuous-substring/)

# 题目

<p><strong>字母序连续字符串</strong> 是由字母表中连续字母组成的字符串。换句话说，字符串 <code>"abcdefghijklmnopqrstuvwxyz"</code> 的任意子字符串都是 <strong>字母序连续字符串</strong> 。</p>

<ul> 
 <li>例如，<code>"abc"</code> 是一个字母序连续字符串，而 <code>"acb"</code> 和 <code>"za"</code> 不是。</li> 
</ul>

<p>给你一个仅由小写英文字母组成的字符串 <code>s</code> ，返回其 <strong>最长</strong> 的 字母序连续子字符串 的长度。</p>

<p>&nbsp;</p>

<p><strong>示例 1：</strong></p>

<pre><strong>输入：</strong>s = "abacaba"
<strong>输出：</strong>2
<strong>解释：</strong>共有 4 个不同的字母序连续子字符串 "a"、"b"、"c" 和 "ab" 。
"ab" 是最长的字母序连续子字符串。
</pre>

<p><strong>示例 2：</strong></p>

<pre><strong>输入：</strong>s = "abcde"
<strong>输出：</strong>5
<strong>解释：</strong>"abcde" 是最长的字母序连续子字符串。
</pre>

<p>&nbsp;</p>

<p><strong>提示：</strong></p>

<ul> 
 <li><code>1 &lt;= s.length &lt;= 10<sup>5</sup></code></li> 
 <li><code>s</code> 由小写英文字母组成</li> 
</ul>

# 个人解法

遍历一次，判断相邻字符是否连续，找到最长的连续子字符串的长度

{% tabs categories%}

<!-- tab Java -->

```java
class Solution {
    public int longestContinuousSubstring(String s) {
        int cnt = 0;
        int bf = 0;
        for (int i = 1; i < s.length(); i++) {
            if (s.charAt(i) - s.charAt(i - 1) != 1) {
                cnt = Math.max(cnt, i - bf);
                bf = i;
            }
        }
        return Math.max(cnt, s.length() - bf);
    }
}
```

<!-- endtab -->

<!-- tab Python3 -->

```python
class Solution:
    def longestContinuousSubstring(self, s: str) -> int:
        cnt = bf = 0
        for i in range(1, len(s)):
            if ord(s[i]) - ord(s[i - 1]) != 1:
                cnt = max(cnt, i - bf)
                bf = i
        return max(cnt, len(s) - bf)
```

<!-- endtab -->

{% endtabs %}