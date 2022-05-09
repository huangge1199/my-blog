---
title: 力扣6057. 统计值等于子树平均值的节点数
date: 2022-05-09 15:57:48
tags: [力扣]
categories: [算法,力扣]
---

力扣周赛292--第二题

[6057. 统计值等于子树平均值的节点数](https://leetcode.cn/problems/count-nodes-equal-to-average-of-subtree/)

# 题目

<p>给你一棵二叉树的根节点 <code>root</code> ，找出并返回满足要求的节点数，要求节点的值等于其 <strong>子树</strong> 中值的 <strong>平均值</strong> 。</p>

<p><strong>注意：</strong></p>

<ul>  
   <li><code>n</code> 个元素的平均值可以由 <code>n</code> 个元素 <strong>求和</strong> 然后再除以 <code>n</code> ，并 <strong>向下舍入</strong> 到最近的整数。</li>  
   <li><code>root</code> 的 <strong>子树</strong> 由 <code>root</code> 和它的所有后代组成。</li>  
</ul>

<p> </p>

<p><strong>示例 1：</strong></p>  
<img src="https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/blog/count-nodes-equal-to-average-of-subtree/20220426172421.png" style="width: 300px; height: 212px;">  
<pre><strong>输入：</strong>root = [4,8,5,0,1,null,6]  
<strong>输出：</strong>5  
<strong>解释：</strong>  
对值为 4 的节点：子树的平均值 (4 + 8 + 5 + 0 + 1 + 6) / 6 = 24 / 6 = 4 。  
对值为 5 的节点：子树的平均值 (5 + 6) / 2 = 11 / 2 = 5 。  
对值为 0 的节点：子树的平均值 0 / 1 = 0 。  
对值为 1 的节点：子树的平均值 1 / 1 = 1 。  
对值为 6 的节点：子树的平均值 6 / 1 = 6 。  
</pre>

<p><strong>示例 2：</strong></p>  
<img src="https://huangge1199-1303833695.cos.ap-beijing.myqcloud.com/blog/count-nodes-equal-to-average-of-subtree/image-20220326133920.png" style="width: 80px; height: 76px;">  
<pre><strong>输入：</strong>root = [1]  
<strong>输出：</strong>1  
<strong>解释：</strong>对值为 1 的节点：子树的平均值 1 / 1 = 1。  
</pre>

<p> </p>

<p><strong>提示：</strong></p>

<ul>  
   <li>树中节点数目在范围 <code>[1, 1000]</code> 内</li>  
   <li><code>0 <= Node.val <= 1000</code></li>  
</ul>

# 思路

这题的思路：

- 先深度遍历树，统计出每个节点包含的节点数，并将其放入队列中

- 再深度遍历一次树，这次计算出每个节点的元素和，并从队列中取到该节点的节点数，然后求平均值做判断

# 代码

Java：

```java
class Solution {
    public int averageOfSubtree(TreeNode root) {
        counts(root);
        sums(root);
        return count;
    }
    Queue<Integer> queue = new LinkedList<>();
    int count = 0;
    private int counts(TreeNode root) {
        if (root == null) {
            return 0;
        }
        int cnt = counts(root.left) + counts(root.right) + 1;
        queue.add(cnt);
        return cnt;
    }
    private int sums(TreeNode root) {
        if (root == null) {
            return 0;
        }
        int sum = root.val;
        sum += sums(root.left);
        sum += sums(root.right);
        if (sum / queue.poll() == root.val) {
            count++;
        }
        return sum;
    }
}
```
