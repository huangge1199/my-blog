---
title: 2477. 到达首都的最少油耗（2023-12-05）
tags: [力扣]
categories: [算法,力扣,每日一题]
date: 2023-12-05 10:03:09
---
力扣每日一题
题目：[2477. 到达首都的最少油耗](https://leetcode.cn/problems/minimum-fuel-cost-to-report-to-the-capital/description/)
![2023-12-05.png](https://img.huangge1199.cn/halo/2023-12-05.png)
日期：2023-12-05
用时：34 m 15 s
时间：37ms
内存：84.8MB
思路：分别计算每条路上通过的城市数量（数量/座位数，向上取整），然后求和，这里每条路上通过的城市数量实际就是图中每个节点的子节点数量。
代码：每条路上通过的城市数量实际就是图中每个节点的子节点数量。
```java
class Solution {
    public long minimumFuelCost(int[][] roads, int seats) {
        int size = roads.length+1;
        List<Integer>[] list = new ArrayList[size];
        for(int i=0;i<size;i++){
            list[i] = new ArrayList<>();
        }
        for(int[] road:roads){
            int num1 = road[0];
            int num2 = road[1];
            list[num1].add(num2);
            list[num2].add(num1);
        };
        dfs(0,-1,list,seats);
        return sum;
    }
    long sum = 0;
    private int dfs(int start,int end,List<Integer>[] list,int seats){
        int cnt =1;
        for(int num: list[start]){
            if(num!=end){
                cnt+=dfs(num,start,list,seats);
            }
        }
        if(start>0){
            sum+=(cnt-1)/seats+1;
        }
        return cnt;
    }
}
```