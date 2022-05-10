---
title: 力扣2266. 统计打字方案数
date: 2022-05-10 09:32:53
tags: [力扣]
categories: [算法,力扣]
---

力扣周赛292--第三题

[2266. 统计打字方案数](https://leetcode.cn/problems/count-number-of-texts/)

# 题目

<p>Alice 在给 Bob 用手机打字。数字到字母的 <strong>对应</strong> 如下图所示。</p>

<p><img alt="" src="https://assets.leetcode.com/uploads/2022/03/15/1200px-telephone-keypad2svg.png" style="width: 200px; height: 162px;"></p>

<p>为了 <strong>打出</strong> 一个字母，Alice 需要 <strong>按</strong> 对应字母 <code>i</code> 次，<code>i</code> 是该字母在这个按键上所处的位置。</p>

<ul>  
   <li>比方说，为了按出字母 <code>'s'</code> ，Alice 需要按 <code>'7'</code> 四次。类似的， Alice 需要按 <code>'5'</code> 两次得到字母  <code>'k'</code> 。</li>  
   <li>注意，数字 <code>'0'</code> 和 <code>'1'</code> 不映射到任何字母，所以 Alice <strong>不</strong> 使用它们。</li>  
</ul>

<p>但是，由于传输的错误，Bob 没有收到 Alice 打字的字母信息，反而收到了 <strong>按键的字符串信息</strong> 。</p>

<ul>  
   <li>比方说，Alice 发出的信息为 <code>"bob"</code> ，Bob 将收到字符串 <code>"2266622"</code> 。</li>  
</ul>

<p>给你一个字符串 <code>pressedKeys</code> ，表示 Bob 收到的字符串，请你返回 Alice <strong>总共可能发出多少种文字信息</strong> 。</p>

<p>由于答案可能很大，将它对 <code>10<sup>9</sup> + 7</code> <strong>取余</strong> 后返回。</p>

<p> </p>

<p><strong>示例 1：</strong></p>

<pre><b>输入：</b>pressedKeys = "22233"  
<b>输出：</b>8  
<strong>解释：</strong>  
Alice 可能发出的文字信息包括：  
"aaadd", "abdd", "badd", "cdd", "aaae", "abe", "bae" 和 "ce" 。  
由于总共有 8 种可能的信息，所以我们返回 8 。  
</pre>

<p><strong>示例 2：</strong></p>

<pre><b>输入：</b>pressedKeys = "222222222222222222222222222222222222"  
<b>输出：</b>82876089  
<strong>解释：</strong>  
总共有 2082876103 种 Alice 可能发出的文字信息。  
由于我们需要将答案对 10<sup>9</sup> + 7 取余，所以我们返回 2082876103 % (10<sup>9</sup> + 7) = 82876089 。  
</pre>

<p> </p>

<p><strong>提示：</strong></p>

<ul>  
   <li><code>1 <= pressedKeys.length <= 10<sup>5</sup></code></li>  
   <li><code>pressedKeys</code> 只包含数字 <code>'2'</code> 到 <code>'9'</code> 。</li>  
</ul>

# 思路

这题标的是中等题，个人觉得解题方法有点取巧，怎么取巧尼，因为重复的数最多4个，我完全可以嵌套3层if来处理，当然我也是这么干的。只要遍历一遍就可以了。

在遍历到索引`i`时，有如下情况：

1. 当前数字不和前面的组合，自己单独成一个新的
   
   索引`i`的种数 = 索引`i-1`的种数

2. 当前数字与前一个相等，那么该数字的组合就有两种情况
   
   - 直接和前一个数字凑一起
     
     索引`i`的种数=索引`i-2`的种数
   
   - 索引`i`的数字和索引`i-2`的数字也相等，这也有2种情况
     
     - 把索引`i`,`i-1`,`i-2`都凑一起
       
       索引`i`的种数=索引`i-3`的种数
     
     - 索引`i`是7或者9，最多可以连续4个，把索引`i`,`i-1`,`i-2`,`i-3`都凑一起
       
       索引`i`的种数=索引`i-4`的种数

同时，为了保证数据没有超过int的最大值，这里对于每一次的结果都对<span>10<sup>9</sup>+7</span>取余

# 代码

Java：

```java
class Solution {
    public int countTexts(String pressedKeys) {
        int[] cnts = new int[pressedKeys.length() + 1];
        cnts[0] = 1;
        cnts[1] = 1;
        int mod = 1000000007;
        for (int i = 1; i < pressedKeys.length(); i++) {
            cnts[i + 1] = cnts[i];
            if (pressdKeys.charAt(i) == pressedKeys.charAt(i - 1)) {
                cnts[i + 1] += cnts[i - 1];
                cnts[i + 1] %= mod;
                if (i > 1 && pressedKeys.charAt(i) == pressedKeys.charAt(i - 2)) {
                    cnts[i + 1] += cnts[i - 2];
                    cnts[i + 1] %= mod;
                    if (i > 2 && pressedKeys.charAt(i) == pressedKeys.charAt(i - 3) && (pressedKeys.charAt(i) == '7' || pressedKeys.charAt(i) == '
                        cnts[i + 1] += cnts[i - 3];
                        cnts[i + 1] %= mod;
                    }
                }
            }
        }
        return cnts[pressedKeys.length()];
    }
}
```
