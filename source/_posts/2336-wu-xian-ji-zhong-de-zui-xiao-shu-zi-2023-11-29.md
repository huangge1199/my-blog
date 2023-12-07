---
title: 2336. 无限集中的最小数字（2023.11.29）
tags: [力扣]
categories: [算法,力扣,每日一题]
date: 2023-11-29 09:57:56
---
力扣每日一题
题目：[2336. 无限集中的最小数字](https://leetcode.cn/problems/smallest-number-in-infinite-set/description/)
![2023-11-29.png](https://img.huangge1199.cn/halo/2023-11-29.png)
日期：2023-11-29
用时：3 m 50 s
时间：71ms
内存：43.68MB
代码：
```java
class SmallestInfiniteSet {

    List<Integer> list;

    public SmallestInfiniteSet() {
        list = new ArrayList<>();
        for(int i=1;i<1001;i++){
            list.add(i);
        }
        Collections.sort(list);
    }
    
    public int popSmallest() {
        int num = list.get(0);
        list.remove(0);
        return num;
    }
    
    public void addBack(int num) {
        if(!list.contains(num)){
            list.add(num);
            Collections.sort(list);
        }
    }
}

/**
 * Your SmallestInfiniteSet object will be instantiated and called as such:
 * SmallestInfiniteSet obj = new SmallestInfiniteSet();
 * int param_1 = obj.popSmallest();
 * obj.addBack(num);
 */
```