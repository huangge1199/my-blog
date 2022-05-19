---
title: 力扣2273. 移除字母异位词后的结果数组
date: 2022-05-19 09:27:33
tags: [力扣]
categories: [算法,力扣]
---

力扣周赛293--第一题

[2273. 移除字母异位词后的结果数组](https://leetcode.cn/problems/find-resultant-array-after-removing-anagrams/)

# 题目

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
获取结果数组的方法之一是执行下述步骤：  
- 由于 words[2] = "bbaa" 和 words[1] = "baba" 是字母异位词，选择下标 2 并删除 words[2] 。  
  现在 words = ["abba","baba","cd","cd"] 。  
- 由于 words[1] = "baba" 和 words[0] = "abba" 是字母异位词，选择下标 1 并删除 words[1] 。  
  现在 words = ["abba","cd","cd"] 。  
- 由于 words[2] = "cd" 和 words[1] = "cd" 是字母异位词，选择下标 2 并删除 words[2] 。  
  现在 words = ["abba","cd"] 。  
无法再执行任何操作，所以 ["abba","cd"] 是最终答案。</pre>

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

# 思路

遍历字符串数组，分别将每一个字符串装换成字符数组，字符数组排序，如果排序后转成的字符串一样，则说明是字母异位词

# 代码

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
