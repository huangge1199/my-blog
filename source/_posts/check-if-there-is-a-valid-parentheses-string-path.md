---
title: 力扣2267. 检查是否有合法括号字符串路径
date: 2022-05-10 10:50:21
tags: [力扣]
categories: [算法,力扣]
---

力扣周赛292--第四题

[2267. 检查是否有合法括号字符串路径](https://leetcode.cn/problems/check-if-there-is-a-valid-parentheses-string-path/)

# 题目

<p>一个括号字符串是一个 <strong>非空</strong> 且只包含 <code>'('</code> 和 <code>')'</code> 的字符串。如果下面 <strong>任意</strong> 条件为 <strong>真</strong> ，那么这个括号字符串就是 <strong>合法的</strong> 。</p>

<ul>  
   <li>字符串是 <code>()</code> 。</li>  
   <li>字符串可以表示为 <code>AB</code>（<code>A</code> 连接 <code>B</code>），<code>A</code> 和 <code>B</code> 都是合法括号序列。</li>  
   <li>字符串可以表示为 <code>(A)</code> ，其中 <code>A</code> 是合法括号序列。</li>  
</ul>

<p>给你一个 <code>m x n</code> 的括号网格图矩阵 <code>grid</code> 。网格图中一个 <strong>合法括号路径</strong> 是满足以下所有条件的一条路径：</p>

<ul>  
   <li>路径开始于左上角格子 <code>(0, 0)</code> 。</li>  
   <li>路径结束于右下角格子 <code>(m - 1, n - 1)</code> 。</li>  
   <li>路径每次只会向 <strong>下</strong> 或者向 <strong>右</strong> 移动。</li>  
   <li>路径经过的格子组成的括号字符串是<strong> 合法</strong> 的。</li>  
</ul>

<p>如果网格图中存在一条 <strong>合法括号路径</strong> ，请返回 <code>true</code> ，否则返回 <code>false</code> 。</p>

<p> </p>

<p><strong>示例 1：</strong></p>

<p><img alt="" src="https://assets.leetcode.com/uploads/2022/03/15/example1drawio.png" style="width: 521px; height: 300px;" /></p>

<pre>  
<b>输入：</b>grid = [["(","(","("],[")","(",")"],["(","(",")"],["(","(",")"]]  
<b>输出：</b>true  
<b>解释：</b>上图展示了两条路径，它们都是合法括号字符串路径。  
第一条路径得到的合法字符串是 "()(())" 。  
第二条路径得到的合法字符串是 "((()))" 。  
注意可能有其他的合法括号字符串路径。  
</pre>

<p><strong>示例 2：</strong></p>

<p><img alt="" src="https://assets.leetcode.com/uploads/2022/03/15/example2drawio.png" style="width: 165px; height: 165px;" /></p>

<pre>  
<b>输入：</b>grid = [[")",")"],["(","("]]  
<b>输出：</b>false  
<b>解释：</b>两条可行路径分别得到 "))(" 和 ")((" 。由于它们都不是合法括号字符串，我们返回 false 。  
</pre>

<p> </p>

<p><strong>提示：</strong></p>

<ul>  
   <li><code>m == grid.length</code></li>  
   <li><code>n == grid[i].length</code></li>  
   <li><code>1 <= m, n <= 100</code></li>  
   <li><code>grid[i][j]</code> 要么是 <code>'('</code> ，要么是 <code>')'</code> 。</li>  
</ul>

# 思路

从左上角到右下角，依次路过，下一个坐标一定是该坐标的右侧或者下侧的坐标，同时玩吗记录下路过到该坐标时未配对的’`'('`的个数，如果是负数则这条路不对旧不用继续下去了。然后一直到右下角的时候，如果个数为1，则满足条件

# 代码

Java

```java
class Solution {
    public boolean hasValidPath(char[][] grid) {
        xl = grid.length;
        yl = grid[0].length;
        use = new boolean[xl][yl][xl * yl];
        if ((xl + yl) % 2 == 0 || grid[0][0] == ')' || grid[xl - 1][yl - 
            return false;
        }
        dfs(grid, 0, 0, 0);
        return bl;
    }
    int xl;
    int yl;
    boolean bl = false;
    boolean[][][] use;
    private void dfs(char[][] grid, int x, int y, int cnt) {
        if (x >= xl || y >= yl || cnt > xl - x + yl - y - 1) {
            return;
        }
        if (x == xl - 1 && y == yl - 1) {
            bl = cnt == 1;
        }
        if (use[x][y][cnt]) {
            return;
        }
        use[x][y][cnt] = true;
        cnt += grid[x][y] == '(' ? 1 : -1;
        if (cnt < 0) {
            return;
        }
        if (!bl) {
            dfs(grid, x + 1, y, cnt);
        }
        if (!bl) {
            dfs(grid, x, y + 1, cnt);
        }
    }
}
```
