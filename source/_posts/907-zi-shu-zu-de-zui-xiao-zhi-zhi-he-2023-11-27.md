---
title: 907. 子数组的最小值之和（2023.11.27）
tags: [力扣]
categories: [算法,力扣,每日一题]
date: 2023-11-27 09:41:39
---
力扣每日一题
题目：[907. 子数组的最小值之和](https://leetcode.cn/problems/sum-of-subarray-minimums/description/)
日期：2023-11-27
用时：14 m 14 s
时间：19ms
内存：47.42MB
代码：
```java
class Solution {
    public int sumSubarrayMins(int[] arr) {
        int n=arr.length;
        int res = 0;
        int mod=1000000007;
        Deque<Integer> deque=new ArrayDeque<>();
        for (int i=0; i <= n; i++) {
            int cur = i<n?arr[i] : 0;
            while (!deque.isEmpty() && arr[deque.peekLast()] >= cur) {
                int index = deque.pollLast();
                int l=deque.isEmpty()?-1:deque.peekLast();
                res += 1L*(index-l)*(i-index)%mod*arr[index]%mod;
                res %= mod;
            }
            deque.addLast(i);
        }
        return res;
    }
}
```