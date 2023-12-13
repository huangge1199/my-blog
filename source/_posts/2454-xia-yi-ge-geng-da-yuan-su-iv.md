---
title: 2454. 下一个更大元素 IV（2023-12-12）
tags: [力扣]
categories: [算法,力扣,每日一题]
date: 2023-12-13 08:55:55
---
力扣每日一题
题目：[2454. 下一个更大元素 IV](https://leetcode.cn/problems/next-greater-element-iv/description/)
![2023-12-12.png](https://img.huangge1199.cn/halo/2023-12-12.png)
日期：2023-12-12
用时：35 m 09 s
时间：614ms
内存：57.18MB
代码：
```java
class Solution {
    public int[] secondGreaterElement(int[] nums) {
        int[] res = new int[nums.length];
        Arrays.fill(res, -1);
        List<Integer> list1 = new ArrayList<>();
        List<Integer> list2 = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            while (!list2.isEmpty() && nums[list2.get(list2.size() - 1)] < nums[i]) {
                res[list2.get(list2.size() - 1)] = nums[i];
                list2.remove(list2.size() - 1);
            }
            int j = list1.size();
            for(;j>0;j--){
                if(nums[list1.get(j - 1)] >= nums[i]){
                    break;
                }
            }
            while (j<list1.size()) {
                list2.add(list1.get(j));
                list1.remove(j);
            }
            list1.add(i);
        }
        return res;
    }
}
```