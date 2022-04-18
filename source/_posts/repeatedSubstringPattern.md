---
title: 力扣459:重复的子字符串
date: 2022-04-18 15:53:15
tags: [力扣]
categories: [算法,力扣]
---

今天刷力扣发现一道有趣的题，这道题目很普通，但是解法确可以偷懒

原题链接：[力扣459:重复的子字符串](https://leetcode-cn.com/problems/repeated-substring-pattern/)

# 题目

<p>给定一个非空的字符串<meta charset="UTF-8" />&nbsp;<code>s</code>&nbsp;，检查是否可以通过由它的一个子串重复多次构成。</p>

<p>&nbsp;</p>

<p><strong>示例 1:</strong></p>

<pre>
<strong>输入:</strong> s = "abab"
<strong>输出:</strong> true
<strong>解释:</strong> 可由子串 "ab" 重复两次构成。
</pre>

<p><strong>示例 2:</strong></p>

<pre>
<strong>输入:</strong> s = "aba"
<strong>输出:</strong> false
</pre>

<p><strong>示例 3:</strong></p>

<pre>
<strong>输入:</strong> s = "abcabcabcabc"
<strong>输出:</strong> true
<strong>解释:</strong> 可由子串 "abc" 重复四次构成。 (或子串 "abcabc" 重复两次构成。)
</pre>

<p>&nbsp;</p>

<p><b>提示：</b></p>

<p><meta charset="UTF-8" /></p>

<ul>
	<li><code>1 &lt;= s.length &lt;= 10<sup>4</sup></code></li>
	<li><code>s</code>&nbsp;由小写英文字母组成</li>
</ul>
<div><div>Related Topics</div><div><li>字符串</li><li>字符串匹配</li></div></div><br>

# 个人解法

想法：既然要判断字符串是否由一个子串重复多次构成，那么如果结果是肯定的，这个字符串的长
度一定能够整除子串的长度。

所以我首先做一个循环，找到可能作为子串重复的字符串，在其基础上判断是否满足，循环结束
后都没有找到满足的，那么结果肯定就是false了。

接下来我们考虑循环内部的逻辑，如果一个子串可以满足子串重复多次组成当前的字符串，那么按
照子串的长度分割，每一部分都是相同的。接下来就是重点了！！！重点！！！怎么判断这些部分
都相同？？

<div style="color: red">
假设满足条件：<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s = "abdfs"<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;parent = s1+s2+s3+s4+....sn（s1...sn都是s）<br/>
根据上面的字符串以及子串作说明<br/>
可以分为两步判断：
<ol style="color: green">
<li>s1和sn相同</li>
<li>s2s3s4...sn和s1s2s3....s(n-1)相同</li>
</ol>
2中s2=s1，s3=s2.....sn=s(n-1)，这样一来s1,s2,s3....sn就都相同了
</div>

{% tabs categories%}

<!-- tab Java -->

```java
class Solution {
    public boolean repeatedSubstringPattern(String s) {
        int lens = s.length();
        for (int i = 1; i < lens; i++) {
            if (lens % i == 0) {
                if (s.substring(0, i).equals(s.substring(lens - i))
                        && s.substring(i).equals(s.substring(0, lens - i))) {
                    return true;
                }
            }
        }
        return false;
    }
}
```

<!-- endtab -->

<!-- tab Python3 -->

```python
class Solution:
    def repeatedSubstringPattern(self, s: str) -> bool:
        for i in range(1, len(s)):
            if len(s) % i == 0:
                if s[0:i] == s[len(s)-i:len(s)] and s[0:len(s)-i] == s[i:len(s)]:
                    return True
        return False
```

<!-- endtab -->

{% endtabs %}
