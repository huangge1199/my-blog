---
title: 1466. 重新规划路线（2023-12-07）
tags: [力扣]
categories: [算法,力扣,每日一题]
date: 2023-12-13 08:48:55
---
力扣每日一题
题目：[1466. 重新规划路线](https://leetcode.cn/problems/reorder-routes-to-make-all-paths-lead-to-the-city-zero/description/)
![2023-12-07.png](https://img.huangge1199.cn/halo/2023-12-07.png)
日期：2023-12-07
用时：45 m 36 s
时间：37ms
内存：69.64MB
代码：
```java
class Solution {
    public int minReorder(int n, int[][] connections) {
        list = new List[n];
        Arrays.setAll(list, k -> new ArrayList<>());
        for (int[] connection : connections) {
            int start = connection[0];
            int end = connection[1];
            list[start].add(new int[] {end, 1});
            list[end].add(new int[] {start, 0});
        }
        return dfs(0, -1);
    }
    
    List<int[]>[] list;

    private int dfs(int index, int target) {
        int ans = 0;
        for (int[] num : list[index]) {
            if (num[0] != target) {
                ans += num[1] + dfs(num[0], index);
            }
        }
        return ans;
    }
}
```