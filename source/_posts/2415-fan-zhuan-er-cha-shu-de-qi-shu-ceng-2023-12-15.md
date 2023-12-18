---
title: 2415. 反转二叉树的奇数层（2023-12-15）
tags: [力扣]
categories: [算法,力扣,每日一题]
date: 2023-12-18 11:04:16
---
力扣每日一题
题目：[2415. 反转二叉树的奇数层](https://leetcode.cn/problems/reverse-odd-levels-of-binary-tree/description/)
![2023-12-15.png](https://img.huangge1199.cn/halo/2023-12-15.png)
日期：2023-12-15
用时：6 m 51 s
时间：0 ms
内存：46.97 MB
代码：
```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public TreeNode reverseOddLevels(TreeNode root) {
        dfs(root.left, root.right, 1);
        return root;
    }

    void dfs(TreeNode left,TreeNode right,int odd){
        if(left==null){
            return;
        }
        if(odd==1){
            int temp = left.val;
            left.val = right.val;
            right.val = temp;
        }
        dfs(left.left, right.right, 1-odd);
        dfs(left.right, right.left, 1-odd);
    }
}
```