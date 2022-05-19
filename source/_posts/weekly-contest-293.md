---
title: 力扣周赛293题解
date: 2022-05-19 14:52:09
tags: [力扣]
categories: [算法,力扣,周赛]

---

# 第一题

## 力扣原题链接：

[2273. 移除字母异位词后的结果数组](https://site.huangge1199.cn/?golink=aHR0cHM6Ly9sZWV0Y29kZS5jbi9wcm9ibGVtcy9maW5kLXJlc3VsdGFudC1hcnJheS1hZnRlci1yZW1vdmluZy1hbmFncmFtcy8=)

## 单个题解：

[力扣2273. 移除字母异位词后的结果数组](https://site.huangge1199.cn/284.html)

## 题目：

<p>给你一个下标从 <strong>0</strong> 开始的字符串 <code>words</code> ，其中 <code>words[i]</code> 由小写英文字符组成。</p>

<p>在一步操作中，需要选出任一下标 <code>i</code> ，从 <code>words</code> 中 <strong>删除</strong> <code>words[i]</code> 。其中下标 <code>i</code> 需要同时满足下述两个条件：</p>

<ol>    
   <li><code>0 < i < words.length</code></li>    
   <li><code>words[i - 1]</code> 和 <code>words[i]</code> 是 <strong>字母异位词</strong> 。</li>    
</ol>

<p>只要可以选出满足条件的下标，就一直执行这个操作。</p>

<p>在执行所有操作后，返回 <code>words</code> 。可以证明，按任意顺序为每步操作选择下标都会得到相同的结果。</p>

<p><strong>字母异位词</strong> 是由重新排列源单词的字母得到的一个新单词，所有源单词中的字母通常恰好只用一次。例如，<code>"dacb"</code> 是 <code>"abdc"</code> 的一个字母异位词。</p>

<p> </p>

<p><strong>示例 1：</strong></p>

<pre><strong>输入：</strong>words = ["abba","baba","bbaa","cd","cd"]    
<strong>输出：</strong>["abba","cd"]    
<strong>解释：</strong>    
获取结果数组的方法之一是执行下述步骤：  - 由于 words[2] = "bbaa" 和 words[1] = "baba" 是字母异位词，选择下标 2 并删除 words[2] 。    
  现在 words = ["abba","baba","cd","cd"] 。  - 由于 words[1] = "baba" 和 words[0] = "abba" 是字母异位词，选择下标 1 并删除 words[1] 。    
  现在 words = ["abba","cd","cd"] 。  - 由于 words[2] = "cd" 和 words[1] = "cd" 是字母异位词，选择下标 2 并删除 words[2] 。    
  现在 words = ["abba","cd"] 。  无法再执行任何操作，所以 ["abba","cd"] 是最终答案。</pre>

<p><strong>示例 2：</strong></p>

<pre><strong>输入：</strong>words = ["a","b","c","d","e"]    
<strong>输出：</strong>["a","b","c","d","e"]    
<strong>解释：</strong>    
words 中不存在互为字母异位词的两个相邻字符串，所以无需执行任何操作。</pre>

<p> </p>

<p><strong>提示：</strong></p>

<ul>    
   <li><code>1 <= words.length <= 100</code></li>    
   <li><code>1 <= words[i].length <= 10</code></li>    
   <li><code>words[i]</code> 由小写英文字母组成</li>    
</ul>    
<div><div>Related Topics</div><div><li>数组</li><li>哈希表</li><li>字符串</li><li>排序</li></div></div>

## 思路：

遍历字符串数组，分别将每一个字符串装换成字符数组，字符数组排序，如果排序后转成的字符串一样，则说明是字母异位词  

## 代码：

java：  

```java
class Solution {
    public List<String> removeAnagrams(String[] words) {
        char[] strs = words[0].toCharArray();
        Arrays.sort(strs);
        List<String> list = new ArrayList<>();
        int index = 0;
        for (int i = 1; i < words.length; i++) {
            char[] strs1 = words[i].toCharArray();
            Arrays.sort(strs1);
            if (!String.valueOf(strs).equals(String.valueOf(strs1))) {
                list.add(words[index]);
                strs = strs1;
                index = i;
            }
        }
        list.add(words[index]);
        return list;
    }
}
```

# 第二题

## 力扣原题链接：

[2274. 不含特殊楼层的最大连续楼层数](https://leetcode.cn/problems/maximum-consecutive-floors-without-special-floors/)

## 单个题解：

[力扣2274. 不含特殊楼层的最大连续楼层数](https://site.huangge1199.cn/288.html)

## 题目：

<p>Alice 管理着一家公司，并租用大楼的部分楼层作为办公空间。Alice 决定将一些楼层作为 <strong>特殊楼层</strong> ，仅用于放松。</p>

<p>给你两个整数 <code>bottom</code> 和 <code>top</code> ，表示 Alice 租用了从 <code>bottom</code> 到 <code>top</code>（含 <code>bottom</code> 和 <code>top</code> 在内）的所有楼层。另给你一个整数数组 <code>special</code> ，其中 <code>special[i]</code> 表示  Alice 指定用于放松的特殊楼层。</p>

<p>返回不含特殊楼层的 <strong>最大</strong> 连续楼层数。</p>

<p> </p>

<p><strong>示例 1：</strong></p>

<pre>  
<strong>输入：</strong>bottom = 2, top = 9, special = [4,6]  
<strong>输出：</strong>3  
<strong>解释：</strong>下面列出的是不含特殊楼层的连续楼层范围：  
- (2, 3) ，楼层数为 2 。  
- (5, 5) ，楼层数为 1 。  
- (7, 9) ，楼层数为 3 。  
因此，返回最大连续楼层数 3 。  
</pre>

<p><strong>示例 2：</strong></p>

<pre>  
<strong>输入：</strong>bottom = 6, top = 8, special = [7,6,8]  
<strong>输出：</strong>0  
<strong>解释：</strong>每层楼都被规划为特殊楼层，所以返回 0 。  
</pre>

<p> </p>

<p><strong>提示</strong></p>

<ul>  
   <li><code>1 <= special.length <= 10<sup>5</sup></code></li>  
   <li><code>1 <= bottom <= special[i] <= top <= 10<sup>9</sup></code></li>  
   <li><code>special</code> 中的所有值 <strong>互不相同</strong></li>  
</ul>  
<div><div>Related Topics</div><div><li>数组</li><li>排序</li></div></div>

## 思路：

这题相当于在bottom到top的范围内，被special的数分割了，我们需要找到分割后最长的一段

步骤：

1. 为了保证数据的顺序进行，对special进行排序
2. 遍历`special`对`bottom~top`进行分割，当`bottom<=special[i]`时，  
   连续楼层数为`special[i]-bottom`，与之前的最大连续层数对比，得到当前的最大连续层数，  
   同时更新`bottom = special[i] + 1`
3. 遍历完，还有最后一段的连续层数`top - special[special.length - 1]`
4. 至此，不包含特殊层的最大的连续层数就出来了

## 代码：

java：

```java
class Solution {
    public int maxConsecutive(int bottom, int top, int[] special) {
        Arrays.sort(special);
        int max = 0;
        for (int j : special) {
            if (bottom <= j) {
                max = Math.max(max, j - bottom);
                bottom = j + 1;
            }
        }
        max = Math.max(max, top - special[special.length - 1]);
        return max;
    }
}
```

# 第三题

## 力扣原题链接：

[2275. 按位与结果大于零的最长组合](https://leetcode.cn/problems/largest-combination-with-bitwise-and-greater-than-zero/)

## 单个题解：

[力扣2275. 按位与结果大于零的最长组合](https://site.huangge1199.cn/286.html)

## 题目：

<p>对数组 <code>nums</code> 执行 <strong>按位与</strong> 相当于对数组 <code>nums</code> 中的所有整数执行 <strong>按位与</strong> 。</p>

<ul>  
   <li>例如，对 <code>nums = [1, 5, 3]</code> 来说，按位与等于 <code>1 & 5 & 3 = 1</code> 。</li>  
   <li>同样，对 <code>nums = [7]</code> 而言，按位与等于 <code>7</code> 。</li>  
</ul>

<p>给你一个正整数数组 <code>candidates</code> 。计算 <code>candidates</code> 中的数字每种组合下 <strong>按位与</strong> 的结果。 <code>candidates</code> 中的每个数字在每种组合中只能使用 <strong>一次</strong> 。</p>

<p>返回按位与结果大于 <code>0</code> 的 <strong>最长</strong> 组合的长度<em>。</em></p>

<p> </p>

<p><strong>示例 1：</strong></p>

<pre>  
<strong>输入：</strong>candidates = [16,17,71,62,12,24,14]  
<strong>输出：</strong>4  
<strong>解释：</strong>组合 [16,17,62,24] 的按位与结果是 16 & 17 & 62 & 24 = 16 > 0 。  
组合长度是 4 。  
可以证明不存在按位与结果大于 0 且长度大于 4 的组合。  
注意，符合长度最大的组合可能不止一种。  
例如，组合 [62,12,24,14] 的按位与结果是 62 & 12 & 24 & 14 = 8 > 0 。  
</pre>

<p><strong>示例 2：</strong></p>

<pre>  
<strong>输入：</strong>candidates = [8,8]  
<strong>输出：</strong>2  
<strong>解释：</strong>最长组合是 [8,8] ，按位与结果 8 & 8 = 8 > 0 。  
组合长度是 2 ，所以返回 2 。  
</pre>

<p> </p>

<p><strong>提示：</strong></p>

<ul>  
   <li><code>1 <= candidates.length <= 10<sup>5</sup></code></li>  
   <li><code>1 <= candidates[i] <= 10<sup>7</sup></code></li>  
</ul>  
<div><div>Related Topics</div><div><li>位运算</li><li>数组</li><li>哈希表</li><li>计数</li></div></div>

## 思路：

这题需要找出按位与结果大于0的最长组合的长度，按位与结果大于0，  
说明这个数组中的每一个二进制数都有相同的一位是1，根据这题给的数组值的范围，  
可以确定最多有24位，那么我们可以循环24次数组，每一次循环统计出第`i`位位数为1的个数，  
然后将每一次的个数做比较，得出最长组合的长度

## 代码：

java：

```java
class Solution {
    public int largestCombination(int[] candidates) {
        int max = 0;
        for (int i = 0; i < 25; i++) {
            int cnt = 0;
            for (int j = 0; j < candidates.length; j++) {
                if ((candidates[j] & (1 << i)) > 0) {
                    cnt++;
                }
            }
            max = Math.max(max, cnt);
        }
        return max;
    }
}
```

# 第四题

## 力扣原题链接：

[2276. 统计区间中的整数数目](https://leetcode.cn/problems/count-integers-in-intervals/)

## 单个题解：

[力扣2276. 统计区间中的整数数目](https://site.huangge1199.cn/282.html)

## 题目：

<p>给你区间的 <strong>空</strong> 集，请你设计并实现满足要求的数据结构：</p>

<ul>  
   <li><strong>新增：</strong>添加一个区间到这个区间集合中。</li>  
   <li><strong>统计：</strong>计算出现在 <strong>至少一个</strong> 区间中的整数个数。</li>  
</ul>

<p>实现 <code>CountIntervals</code> 类：</p>

<ul>  
   <li><code>CountIntervals()</code> 使用区间的空集初始化对象</li>  
   <li><code>void add(int left, int right)</code> 添加区间 <code>[left, right]</code> 到区间集合之中。</li>  
   <li><code>int count()</code> 返回出现在 <strong>至少一个</strong> 区间中的整数个数。</li>  
</ul>

<p><strong>注意：</strong>区间 <code>[left, right]</code> 表示满足 <code>left <= x <= right</code> 的所有整数 <code>x</code> 。</p>

<p> </p>

<p><strong>示例 1：</strong></p>

<pre>  
<strong>输入</strong>  
["CountIntervals", "add", "add", "count", "add", "count"]  
[[], [2, 3], [7, 10], [], [5, 8], []]  
<strong>输出</strong>  
[null, null, null, 6, null, 8]  

<strong>解释</strong>  
CountIntervals countIntervals = new CountIntervals(); // 用一个区间空集初始化对象  
countIntervals.add(2, 3);  // 将 [2, 3] 添加到区间集合中  
countIntervals.add(7, 10); // 将 [7, 10] 添加到区间集合中  
countIntervals.count();    // 返回 6  
                           // 整数 2 和 3 出现在区间 [2, 3] 中  
                           // 整数 7、8、9、10 出现在区间 [7, 10] 中  
countIntervals.add(5, 8);  // 将 [5, 8] 添加到区间集合中  
countIntervals.count();    // 返回 8  
                           // 整数 2 和 3 出现在区间 [2, 3] 中  
                           // 整数 5 和 6 出现在区间 [5, 8] 中  
                           // 整数 7 和 8 出现在区间 [5, 8] 和区间 [7, 10] 中  
                           // 整数 9 和 10 出现在区间 [7, 10] 中</pre>

<p> </p>

<p><strong>提示：</strong></p>

<ul>  
   <li><code>1 <= left <= right <= 10<sup>9</sup></code></li>  
   <li>最多调用  <code>add</code> 和 <code>count</code> 方法 <strong>总计</strong> <code>10<sup>5</sup></code> 次</li>  
   <li>调用 <code>count</code> 方法至少一次</li>  
</ul>

## 思路：

这题我的思路是添加一次整理一次并同时计数，利用java的TreeSet结构，可以快速的定位数据。  
典型的模板题  

## 代码：

java：  

```java
class CountIntervals {
    TreeSet<Interval> ranges;
    int cnt;
    public CountIntervals() {
        ranges = new TreeSet();
        cnt = 0;
    }
    public void add(int left, int right) {
        Iterator<Interval> itr = ranges.tailSet(new Interval(0, left - 1)).iterator();
        while (itr.hasNext()) {
            Interval iv = itr.next();
            if (right < iv.left) {
                break;
            }
            left = Math.min(left, iv.left);
            right = Math.max(right, iv.right);
            cnt -= iv.right - iv.left + 1;
            itr.remove();
        }
        ranges.add(new Interval(left, right));
        cnt += right - left + 1;
    }
    public int count() {
        return cnt;
    }
}
public class Interval implements Comparable<Interval> {
    int left;
    int right;
    public Interval(int left, int right) {
        this.left = left;
        this.right = right;
    }
    public int compareTo(Interval that) {
        if (this.right == that.right) return this.left - that.left;
        return this.right - that.right;
    }
}
```
