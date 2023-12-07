---
title: 2661. 找出叠涂元素（2023-12-01）
tags: [力扣]
categories: [算法,力扣,每日一题]
date: 2023-12-01 09:44:29
---
力扣每日一题
题目：[2661. 找出叠涂元素](https://leetcode.cn/problems/first-completely-painted-row-or-column/description/)

![2023-12-01.png](https://img.huangge1199.cn/halo/2023-12-01.png)
日期：2023-12-01
用时：7 m 4 s
时间：26ms
内存：67.45MB
代码：
```java
class Solution {
    public int firstCompleteIndex(int[] arr, int[][] mat) {
        Map<Integer,int[]> map = new HashMap<>();
        for(int i=0;i<mat.length;i++){
            for(int j=0;j<mat[0].length;j++){
                map.put(mat[i][j],new int[]{i,j});
            }
        }
        int[] xc = new int[mat.length];
        int[] yc = new int[mat[0].length];
        for(int i=0;i<arr.length;i++){
            int[] tmp = map.get(arr[i]);
            xc[tmp[0]]++;
            yc[tmp[1]]++;
            if(xc[tmp[0]]==mat[0].length||yc[tmp[1]]==mat.length){
                return i;
            }
        }
        return 0;
    }
}
```