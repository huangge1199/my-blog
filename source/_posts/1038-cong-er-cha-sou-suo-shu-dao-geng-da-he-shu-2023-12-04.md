---
title: 1038. 从二叉搜索树到更大和树（2023-12-04）
tags: [力扣]
categories: [算法,力扣,每日一题]
date: 2023-12-04 10:27:05
---
力扣每日一题
题目：[1038. 从二叉搜索树到更大和树](https://leetcode.cn/problems/binary-search-tree-to-greater-sum-tree/description/)

![2023-12-04.png](https://img.huangge1199.cn/halo/2023-12-04.png)
日期：2023-12-04
用时：12 m 23 s
时间：0ms
内存：39.39MB
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
    public TreeNode bstToGst(TreeNode root) {
        dfs(root);
        return root;
    }
    int sum = 0;
    private void dfs(TreeNode node) {
        if (node == null) {
            return;
        }
        dfs(node.right);
        sum += node.val;
        node.val = sum;
        dfs(node.left);
    }
}
```