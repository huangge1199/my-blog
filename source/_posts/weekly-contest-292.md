---
title: 力扣周赛292题解
date: 2022-05-10 14:01:37
tags: [力扣]
categories: [算法,力扣,周赛]
---

# 第一题

## 力扣原题链接：

[2264. 字符串中最大的 3 位相同数字](https://leetcode.cn/problems/largest-3-same-digit-number-in-string/)

## 单个题解：

[力扣2264. 字符串中最大的 3 位相同数字](http://192.168.0.198:5080/post/largest-3-same-digit-number-in-string/)

## 题解：

这题是要找最大的3个相同数并且3个数是相连的，因为数字的话只有0~9这10个数字，找最大的，那我就从999开始，然后依次888、777。。。000，只要字符串中存在，那就是它了。

## java代码：

```java
public String largestGoodInteger(String num) {
    String str;
    for (int i = 9; i >= 0; i--) {
        str = "" + i + i + i;
        if (num.contains(str)) {
            return str;
        }
    }
    return "";
}
```

# 第二题

## 力扣原题链接：

[6057. 统计值等于子树平均值的节点数](https://leetcode.cn/problems/count-nodes-equal-to-average-of-subtree/)

## 单个题解：

[力扣6057. 统计值等于子树平均值的节点数](http://192.168.0.198:5080/post/count-nodes-equal-to-average-of-subtree/)

## 题解：

这题的思路：

- 先深度遍历树，统计出每个节点包含的节点数，并将其放入队列中

- 再深度遍历一次树，这次计算出每个节点的元素和，并从队列中取到该节点的节点数，然后求平均值做判断

## java代码：

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

# 第三题

## 力扣原题链接：

[2266. 统计打字方案数](https://leetcode.cn/problems/count-number-of-texts/)

## 单个题解：

[力扣2267. 检查是否有合法括号字符串路径](http://192.168.0.198:5080/post/check-if-there-is-a-valid-parentheses-string-path/)

## 题解：

这题标的是中等题，个人觉得解题方法有点取巧，怎么取巧尼，因为重复的数最多4个，我完全可以嵌套3层if来处理，当然我也是这么干的。只要遍历一遍就可以了。

在遍历到索引`i`时，有如下情况：

1. 当前数字不和前面的组合，自己单独成一个新的
   
   索引`i`的种数 = 索引`i-1`的种数

2. 当前数字与前一个相等，那么该数字的组合就有两种情况
   
   - 直接和前一个数字凑一起
     
     索引`i`的种数=索引`i-2`的种数
   
   - 索引`i`的数字和索引`i-2`的数字也相等，这也有2种情况
     
     - 把索引`i`,`i-1`,`i-2`都凑一起
       
       索引`i`的种数=索引`i-3`的种数
     
     - 索引`i`是7或者9，最多可以连续4个，把索引`i`,`i-1`,`i-2`,`i-3`都凑一起
       
       索引`i`的种数=索引`i-4`的种数

同时，为了保证数据没有超过int的最大值，这里对于每一次的结果都对109+7取余

## java代码：

```java
class Solution {
    public int countTexts(String pressedKeys) {
        int[] cnts = new int[pressedKeys.length() + 1];
        cnts[0] = 1;
        cnts[1] = 1;
        int mod = 1000000007;
        for (int i = 1; i < pressedKeys.length(); i++) {
            cnts[i + 1] = cnts[i];
            if (pressdKeys.charAt(i) == pressedKeys.charAt(i - 1)) {
                cnts[i + 1] += cnts[i - 1];
                cnts[i + 1] %= mod;
                if (i > 1 && pressedKeys.charAt(i) == pressedKeys.charAt(i - 2)) {
                    cnts[i + 1] += cnts[i - 2];
                    cnts[i + 1] %= mod;
                    if (i > 2 && pressedKeys.charAt(i) == pressedKeys.charAt(i - 3) && (pressedKeys.charAt(i) == '7' || pressedKeys.charAt(i) == '
                        cnts[i + 1] += cnts[i - 3];
                        cnts[i + 1] %= mod;
                    }
                }
            }
        }
        return cnts[pressedKeys.length()];
    }
}
```

# 第四题

## 力扣原题链接：

[2267. 检查是否有合法括号字符串路径](https://leetcode.cn/problems/check-if-there-is-a-valid-parentheses-string-path/)

## 单个题解：

[力扣2266. 统计打字方案数](http://192.168.0.198:5080/post/count-number-of-texts/)

## 题解：

从左上角到右下角，依次路过，下一个坐标一定是该坐标的右侧或者下侧的坐标，同时玩吗记录下路过到该坐标时未配对的’`'('`的个数，如果是负数则这条路不对旧不用继续下去了。然后一直到右下角的时候，如果个数为1，则满足条件

## java代码：

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
