---
title: 力扣2415. 反转二叉树的奇数层
date: 2022-09-20 00:28:22
tags: [力扣]
categories: [算法,力扣]
---

311周赛第三题

原题链接：[2415. 反转二叉树的奇数层](https://leetcode.cn/problems/reverse-odd-levels-of-binary-tree/)

# 题目

<p>给你一棵 <strong>完美</strong> 二叉树的根节点 <code>root</code> ，请你反转这棵树中每个 <strong>奇数</strong> 层的节点值。</p>

<ul> 
 <li>例如，假设第 3 层的节点值是 <code>[2,1,3,4,7,11,29,18]</code> ，那么反转后它应该变成 <code>[18,29,11,7,4,3,1,2]</code> 。</li> 
</ul>

<p>反转后，返回树的根节点。</p>

<p><strong>完美</strong> 二叉树需满足：二叉树的所有父节点都有两个子节点，且所有叶子节点都在同一层。</p>

<p>节点的 <strong>层数</strong> 等于该节点到根节点之间的边数。</p>

<p>&nbsp;</p>

<p><strong>示例 1：</strong></p> 
<img alt="" src="https://assets.leetcode.com/uploads/2022/07/28/first_case1.png" style="width: 626px; height: 191px;" /> 
<pre>
<strong>输入：</strong>root = [2,3,5,8,13,21,34]
<strong>输出：</strong>[2,5,3,8,13,21,34]
<strong>解释：</strong>
这棵树只有一个奇数层。
在第 1 层的节点分别是 3、5 ，反转后为 5、3 。
</pre>

<p><strong>示例 2：</strong></p> 
<img alt="" src="https://assets.leetcode.com/uploads/2022/07/28/second_case3.png" style="width: 591px; height: 111px;" /> 
<pre>
<strong>输入：</strong>root = [7,13,11]
<strong>输出：</strong>[7,11,13]
<strong>解释：</strong> 
在第 1 层的节点分别是 13、11 ，反转后为 11、13 。 
</pre>

<p><strong>示例 3：</strong></p>

<pre>
<strong>输入：</strong>root = [0,1,2,0,0,0,0,1,1,1,1,2,2,2,2]
<strong>输出：</strong>[0,2,1,0,0,0,0,2,2,2,2,1,1,1,1]
<strong>解释：</strong>奇数层由非零值组成。
在第 1 层的节点分别是 1、2 ，反转后为 2、1 。
在第 3 层的节点分别是 1、1、1、1、2、2、2、2 ，反转后为 2、2、2、2、1、1、1、1 。
</pre>

<p>&nbsp;</p>

<p><strong>提示：</strong></p>

<ul> 
 <li>树中的节点数目在范围 <code>[1, 2<sup>14</sup>]</code> 内</li> 
 <li><code>0 &lt;= Node.val &lt;= 10<sup>5</sup></code></li> 
 <li><code>root</code> 是一棵 <strong>完美</strong> 二叉树</li> 
</ul>

# 思路：

> 看了灵神的周赛视频讲解，或多或少有影响

这题有两种方法，都可以做交换值：
- BFS
- DFS

# BFS代码

{% tabs categories%}

<!-- tab Java -->

```java
import java.util.*;

class Solution {
    public TreeNode reverseOddLevels(TreeNode root) {
        /*
        如果是空节点直接返回
         */
        if (root == null) {
            return null;
        }
        // 队列存入每层的节点
        Queue<TreeNode> queue = new LinkedList<>();
        queue.add(root);
        int level = 0;
        while (!queue.isEmpty()) {
            /*
            拿出每层的节点放入列表中，并将下一层的节点放入队列中
             */
            int size = queue.size();
            List<TreeNode> nodeList = new ArrayList<>();
            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                nodeList.add(node);
                if (node.left != null) {
                    queue.add(node.left);
                    queue.add(node.right);
                }
            }
            /*
            奇数层，在列表中交换收尾节点的值
             */
            if (level == 1) {
                int nodeSize = nodeList.size();
                for (int i = 0; i < nodeSize / 2; i++) {
                    int num = nodeList.get(i).val;
                    nodeList.get(i).val = nodeList.get(nodeSize - i - 1).val;
                    nodeList.get(nodeSize - i - 1).val = num;
                }
            }
            // 改变奇偶层
            level = 1 - level;
        }
        return root;
    }
}
```

<!-- endtab -->

<!-- tab Python3 -->

```python
from typing import Optional


class Solution:
    def reverseOddLevels(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        queue = [root]
        level = 1
        while queue[0].left:
            next = []
            for node in queue:
                next += [node.left, node.right]
            queue = next
            if level:
                for i in range(len(queue) // 2):
                    node1, node2 = queue[i], queue[len(queue) - 1 - i]
                    node1.val, node2.val = node2.val, node1.val
            level = 1 - level
        return root
```

<!-- endtab -->

{% endtabs %}

# DFS代码

{% tabs categories%}

<!-- tab Java -->

```java
import java.util.*;

class Solution {
    public TreeNode reverseOddLevels(TreeNode root) {
        if (root == null) {
            return root;
        }
        dfs(root.left, root.right, 1);
        return root;
    }
    
    private void dfs(TreeNode left, TreeNode right, int level) {
        if (left == null) {
            return;
        }
        if (level == 1) {
            // 如果是奇数层，交换值
            int tmp = left.val;
            left.val = right.val;
            right.val = tmp;
        }
        dfs(left.left, right.right, 1 - level);
        dfs(left.right, right.left, 1 - level);
    }
}
```

<!-- endtab -->

<!-- tab Python3 -->

```python
from typing import Optional


class Solution:
    def reverseOddLevels(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        def dfs(left, right, level: bool) -> None:
            if left is None: return
            if level: left.val, right.val = right.val, left.val
            dfs(left.left, right.right, not level)
            dfs(left.right, right.left, not level)

        dfs(root.left, root.right, True)
        return root
```

<!-- endtab --> 

{% endtabs %}