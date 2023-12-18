---
title: 162. 寻找峰值（2023-12-18）
tags: [力扣]
categories: [算法,力扣,每日一题]
date: 2023-12-18 11:10:01
---
力扣每日一题
题目：[162. 寻找峰值](https://leetcode.cn/problems/find-peak-element/description/)

![2023-12-18.png](https://img.huangge1199.cn/halo/2023-12-18.png)
日期：2023-12-18
用时：10 m 9 s
时间：0 ms
内存：40.54 MB
代码：
```java
class Solution {
    public int findPeakElement(int[] nums) {
        if(nums.length==1){
            return 0;
        }
        if(nums.length==2){
            return nums[0]>nums[1]?0:1;
        }
        if(nums[0]>nums[1]){
            return 0;
        }
        if(nums[nums.length-1]>nums[nums.length-2]){
            return nums.length-1;
        }
        for(int i=1;i<nums.length-1;i++){
            if(nums[i]>nums[i-1]&&nums[i]>nums[i+1]){
                return i;
            }
        }
        return 0;
    }
}
```