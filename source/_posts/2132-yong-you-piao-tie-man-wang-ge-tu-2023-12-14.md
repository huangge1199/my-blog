---
title: 2132. 用邮票贴满网格图（2023-12-14）
tags: [力扣]
categories: [算法,力扣,每日一题]
date: 2023-12-14 09:39:13
---
力扣每日一题
题目：[2132. 用邮票贴满网格图](https://leetcode.cn/problems/stamping-the-grid/description/)
![2023-12-14.png](https://img.huangge1199.cn/halo/2023-12-14.png)
日期：2023-12-14
用时：38 m 32 s
思路：使用前缀和＋差分，只是往常是一维，现在变二维了，原理差不多
时间：22ms
内存：98.24MB
代码：
```java
class Solution {
    public boolean possibleToStamp(int[][] grid, int stampHeight, int stampWidth) {
        int xl = grid.length;
        int yl = grid[0].length;

        // 前缀和
        int[][] sum = new int[xl+1][yl+1];
        for(int i=1;i<=xl;i++){
            for(int j=1;j<=yl;j++){
                sum[i][j] = sum[i-1][j]+sum[i][j-1]-sum[i-1][j-1]+grid[i-1][j-1];
            }
        }

        // 差分
        int[][] cnt = new int[xl+2][yl+2];
        for(int xStart=stampHeight;xStart<=xl;xStart++){
            for(int yStart=stampWidth;yStart<=yl;yStart++){
                int xEnd = xStart-stampHeight+1;
                int yEnd = yStart-stampWidth+1;
                if(sum[xStart][yStart]+sum[xEnd-1][yEnd-1]-sum[xStart][yEnd-1]-sum[xEnd-1][yStart]==0){
                    cnt[xEnd][yEnd]++;
                    cnt[xStart+1][yStart+1]++;
                    cnt[xEnd][yStart+1]--;
                    cnt[xStart+1][yEnd]--;
                }
            }
        }

        // 判断单元格是否能放邮戳
        for(int i=1;i<=xl;i++){
            for(int j=1;j<=yl;j++){
                cnt[i][j] += cnt[i][j-1]+cnt[i-1][j]-cnt[i-1][j-1];
                if(grid[i-1][j-1]==0&&cnt[i][j]==0){
                    return false;
                }
            }
        }

        return true;
    }
}
```