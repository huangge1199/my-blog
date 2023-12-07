---
title: 1670. 设计前中后队列（2023.11.28）
tags: [力扣]
categories: [算法,力扣,每日一题]
date: 2023-11-28 15:56:04
---
力扣每日一题
题目：[1670. 设计前中后队列](https://leetcode.cn/problems/design-front-middle-back-queue/description/)
日期：2023-11-28
用时：8 m 23 s
时间：6ms
内存：43.55MB
代码：
```java
class FrontMiddleBackQueue {

    List<Integer> list;

    public FrontMiddleBackQueue() {
        list = new ArrayList<>();
    }
    
    public void pushFront(int val) {
        list.add(0,val);
    }
    
    public void pushMiddle(int val) {
        list.add(list.size()/2,val);
    }
    
    public void pushBack(int val) {
        list.add(val);
    }
    
    public int popFront() {
        if(list.size()==0){
            return -1;
        }
        int res = list.get(0);
        list.remove(0);
        return res;
    }
    
    public int popMiddle() {
        if(list.size()==0){
            return -1;
        }
        int res = list.get((list.size()-1)/2);
        list.remove((list.size()-1)/2);
        return res;
    }
    
    public int popBack() {
        if(list.size()==0){
            return -1;
        }
        int res = list.get(list.size()-1);
        list.remove(list.size()-1);
        return res;
    }
}

/**
 * Your FrontMiddleBackQueue object will be instantiated and called as such:
 * FrontMiddleBackQueue obj = new FrontMiddleBackQueue();
 * obj.pushFront(val);
 * obj.pushMiddle(val);
 * obj.pushBack(val);
 * int param_4 = obj.popFront();
 * int param_5 = obj.popMiddle();
 * int param_6 = obj.popBack();
 */
```