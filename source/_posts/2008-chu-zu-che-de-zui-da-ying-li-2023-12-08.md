---
title: 2008. 出租车的最大盈利（2023-12-08）
tags: [力扣]
categories: [算法,力扣,每日一题]
date: 2023-12-13 08:52:23
---
力扣每日一题
# 题目：[2008. 出租车的最大盈利](https://leetcode.cn/problems/maximum-earnings-from-taxi/description/)
![2023-12-08.png](https://img.huangge1199.cn/halo/2023-12-08.png)
# 简短说明
今天的解题有点曲折，完全是一步一步优化来的，看上面的截图，最开始的超时，超时后我加了记忆化搜索，虽然通过了，但是执行时间不太理想，接下来我稍微优化了下，但是执行时间基本没动过，接下来，又尝试着去掉递归，这次效果很显著，执行时间直接从2000多毫秒降低到了18毫秒
# 过程
下面我分别把这四次的代码都展示出来，记录下每次的优化，代码展示顺序是按照上面的截图从下往上的
## 超出时间限制
```java
class Solution {
    public long maxTaxiEarnings(int n, int[][] rides) {
      List<int[]>[] prices = new ArrayList[n+1];
      for(int[] ride:rides){
        if(prices[ride[1]]==null){
          prices[ride[1]] = new ArrayList<>();
        }
        prices[ride[1]].add(new int[]{ride[0],ride[1]-ride[0]+ride[2]});
      }
      return dfs(n,prices);
    }
    long dfs(int index,List<int[]>[] prices){
      if(index==1){
        return 0;
      }
      long res = dfs(index-1,prices);
      if(prices[index]!=null){
        for(int[] price:prices[index]){
          res = Math.max(res,dfs(price[0],prices)+price[1]);
        }
      }
      return res;
    }
}
```
## 2219ms + 84.8MB
```java
class Solution {
    public long maxTaxiEarnings(int n, int[][] rides) {
      List<int[]>[] prices = new ArrayList[n+1];
      for(int[] ride:rides){
        if(prices[ride[1]]==null){
          prices[ride[1]] = new ArrayList<>();
        }
        prices[ride[1]].add(new int[]{ride[0],ride[1]-ride[0]+ride[2]});
      }
      max = new long[n+1];
      return dfs(n,prices);
    } 
    long[] max;
    long dfs(int index,List<int[]>[] prices){
      if(index==1){
        return 0;
      }
      long res = dfs(index-1,prices);
      if(prices[index]!=null){
        for(int[] price:prices[index]){
          if(max[price[0]]>0){
            res = Math.max(res,max[price[0]]+price[1]);
          }else{
            res = Math.max(res,dfs(price[0],prices)+price[1]);
          }
        }
      }
      max[index] = res;
      return res;
    }
}
```
## 2306ms + 84.2MB
```java
class Solution {
    public long maxTaxiEarnings(int n, int[][] rides) {
      List<int[]>[] prices = new ArrayList[n+1];
      for(int[] ride:rides){
        if(prices[ride[1]]==null){
          prices[ride[1]] = new ArrayList<>();
        }
        prices[ride[1]].add(new int[]{ride[0],ride[1]-ride[0]+ride[2]});
      }
      max = new long[n+1];
      return dfs(n,prices);
    } 
    long[] max;
    long dfs(int index,List<int[]>[] prices){
      if(index==1){
        return 0;
      }
      if(max[index]>0){
        return max[index];
      }
      long res = dfs(index-1,prices);
      if(prices[index]!=null){
        for(int[] price:prices[index]){
          res = Math.max(res,dfs(price[0],prices)+price[1]);
        }
      }
      max[index] = res;
      return res;
    }
}
```
## 18ms + 67.3MB
```java
class Solution {
    public long maxTaxiEarnings(int n, int[][] rides) {
      List<int[]>[] prices = new ArrayList[n+1];
      for(int[] ride:rides){
        if(prices[ride[1]]==null){
          prices[ride[1]] = new ArrayList<>();
        }
        prices[ride[1]].add(new int[]{ride[0],ride[1]-ride[0]+ride[2]});
      }
      long[] max = new long[n+1];
      for(int i=2;i<=n;i++){
        max[i] = max[i-1];
        if(prices[i]!=null){
          for(int[] price:prices[i]){
            max[i] = Math.max(max[i],max[price[0]]+price[1]);
          }
        }
      }
      return max[n];
    }
}
```