---
title: 1657. 确定两个字符串是否接近（2023-11-30）
tags: [力扣]
categories: [算法,力扣,每日一题]
date: 2023-11-30 10:33:56
---
力扣每日一题
题目：[1657. 确定两个字符串是否接近](https://leetcode.cn/problems/determine-if-two-strings-are-close/description/)

![2023-11-30.png](https://img.huangge1199.cn/halo/2023-11-30.png)
日期：2023-11-30
用时：21 m 07 s
时间：11ms
内存：43.70MB
代码：
```java
class Solution {
    public boolean closeStrings(String word1, String word2) {
        if(word1.length()!=word2.length()){
            return false;
        }
        int[] arr1 = new int[26];
        int[] arr2 = new int[26];
        int mask1=0;
        int mask2=0;
        for(int i=0;i<word1.length();i++){
            arr1[word1.charAt(i)-'a']++;
            arr2[word2.charAt(i)-'a']++;
            mask1 |= 1<<(word1.charAt(i)-'a');
            mask2 |= 1<<(word2.charAt(i)-'a');
        }
        Arrays.sort(arr1);
        Arrays.sort(arr2);
        return Arrays.equals(arr1,arr2)&&mask1==mask2;
    }
}
```