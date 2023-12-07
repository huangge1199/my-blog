---
title: 2646. 最小化旅行的价格总和（2023-12-06）
tags: [力扣]
categories: [算法,力扣,每日一题]
date: 2023-12-06 22:03:31
---
力扣每日一题
题目：[2646. 最小化旅行的价格总和](https://leetcode.cn/problems/minimize-the-total-price-of-the-trips/description/)
![2023-12-06.png](https://img.huangge1199.cn/halo/2023-12-06.png)
日期：2023-12-06
用时：30 m 14 s
时间：8ms
内存：42.98MB
思路：先统计旅行中每个节点路过的次数（dfs方法），再计算减半后的价格之和的最小值（dp方法），最后比较下减半和未减半的价格。dp方法中，对于相邻的父子节点有两种情况：
- 如果父节点价格不变，那么子节点的价格取减半和不变两种情况的最小值
- 如果父节点价格减半，那么子节点的价格只能不变

代码：每条路上通过的城市数量实际就是图中每个节点的子节点数量。
```java
class Solution {
    public int minimumTotalPrice(int n, int[][] edges, int[] price, int[][] trips) {
      list = new ArrayList[n];
      for(int i=0;i<n;i++){
        list[i] = new ArrayList<>();
      }
      for(int[] edge:edges){
        list[edge[0]].add(edge[1]);
        list[edge[1]].add(edge[0]);
      }
      cnt = new int[n];
      for(int[] trip:trips){
        end = trip[1];
        dfs(trip[0],-1);
      }
      int[] res = dp(0,-1,price);
      return Math.min(res[0],res[1]);
    }
    List<Integer>[] list;
    int end;
    int[] cnt;
    boolean dfs(int x, int fa) {
        if (x == end) {
            cnt[x]++;
            return true;
        }
        for (int y : list[x]) {
            if (y != fa && dfs(y, x)) {
                cnt[x]++;
                return true;
            }
        }
        return false;
    }
    int[] dp(int index,int target,int[] price){
      int prices = price[index]*cnt[index];
      int halfPrices = prices/2;
      for(int num:list[index]){
        if(num!=target){
          int[] res = dp(num,index,price);
          prices += Math.min(res[0],res[1]);
          halfPrices += res[0];
        }
      }
      return new int[]{prices,halfPrices};
    }
}
```