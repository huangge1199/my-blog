---
title: 2697. 字典序最小回文串（2023-12-13）
tags: [力扣]
categories: [算法,力扣,每日一题]
date: 2023-12-13 09:01:34
---
力扣每日一题
题目：[2697. 字典序最小回文串](https://leetcode.cn/problems/lexicographically-smallest-palindrome/description/)
![2023-12-13.png](https://img.huangge1199.cn/halo/2023-12-13.png)
日期：2023-12-13
用时：4 m 53 s
时间：7ms
内存：43.61MB
代码：
```java
class Solution {
    public String makeSmallestPalindrome(String s) {
        char[] chs = s.toCharArray();
        int size = s.length();
        for(int i=0;i<size/2;i++){
            if(chs[i]>chs[size-1-i]){
                chs[i] = chs[size-1-i];
            }else{
                chs[size-1-i] = chs[i];
            }
        }
        return new String(chs);
    }
}
```