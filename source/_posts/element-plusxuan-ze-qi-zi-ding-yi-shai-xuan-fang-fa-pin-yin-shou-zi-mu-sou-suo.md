---
title: element-plus选择器自定义筛选方法（拼音首字母搜索）
tags: [前端,vue]
categories: [前端,vue]
date: 2024-07-05 14:05:35
---

# 引言

最近，来了个需求，需要在下拉列表中做筛选。下拉列表显示的是中文，但筛选时可能会输入中文的拼音首字母。因此，需要实现一个筛选功能，能够根据拼音首字母筛选出匹配的选项。

# 自定义筛选方法

前端使用的是 [vue3](https://cn.vuejs.org/guide/introduction.html) 和 [element-plus](https://element-plus.org/zh-CN/component/overview.html)。我使用的组件是 [Select 选择器 | Element Plus](https://element-plus.org/zh-CN/component/select.html) 。为 `el-select` 添加 `filterable` 属性即可启用搜索功能。默认情况下，Select 会找出所有 `label` 属性包含输入值的选项。但这里需要匹配拼音首字母进行搜索，因此要通过传入一个 `filter-method` 来实现。`filter-method` 是一个函数，它会在输入值发生变化时调用，参数为当前输入值。

下面是这部分的简短代码：

vue部分：

```vue
<el-select
  v-model="queryParams.word"
  filterable
  placeholder="请输入"
  clearable
  :filter-method="filterMethod"
  >
  <el-option
    v-for="word in words"
    :key="word"
    :label="word"
    :value="word"
  />
</el-select>/el-form-item>
```

JS部分：

```js
const showSearch = ref(true);
// option选项
const words = ref(['你好', '世界', '中国', '中国最棒'])
// 保留原始的option选项
const wordsOld = ref(['你好', '世界', '中国', '中国最棒'])

const data = reactive({
  queryParams: {
    word: null,
  },
});

const { queryParams } = toRefs(data);

// 多选框选中数据
function filterMethod(val){
  // 如果有输入值，根据输入内容进行筛选
  if(val){
    // 先将option中的选项words清空
    words.value = []
    // 从原始的option选项中遍历筛选
    wordsOld.value.forEach(word => {
      // 添加筛选逻辑，满足的word添加到words中显示
      words.value.push(word)
    })
  } else {
    // 如果没有输入值，恢复成原始的option选项
    words.value = wordsOld.value
  }
}
```

# 拼音首字母匹配

可以使用 `pinyin-pro` 来实现拼音匹配，例子如下：

```js
import { pinyin } from 'pinyin-pro';

const word = ref('中国最棒')

const firstLetterPinyin = pinyin(word, { pattern: 'first' }).replace(/\s+/g, '');
if(firstLetterPinyin.includes(queryLower)){
  words.value.push(word)
}
```

`pinyin` 方法使用 `pinyin-pro` 库将汉字转换为指定样式的拼音字符串。这里面'first'样式为获取每一个字的小写拼音首字母，中间用空格分割，而我匹配时不需要空格，因此在`firstLetterPinyin`设值时添加了`replace(/\s+/g, '')`将转换的字符串去除空格。

# 完整的vue代码

```vue
<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="中文拼音匹配选择器">
        <el-select
          v-model="queryParams.word"
          filterable
          placeholder="请输入"
          clearable
          :filter-method="filterMethod"
          >
          <el-option
            v-for="word in words"
            :key="word"
            :label="word"
            :value="word"
          />
        </el-select>
      </el-form-item>
    </el-form>
  </div>
</template>

<script setup name="word">
import { pinyin } from 'pinyin-pro';

const showSearch = ref(true);
const words = ref(['你好', '世界', '中国', '中国最棒'])
const wordsOld = ref(['你好', '世界', '中国', '中国最棒'])

const data = reactive({
  queryParams: {
    word: null,
  },
});

const { queryParams } = toRefs(data);

// 多选框选中数据
function filterMethod(val){
  if(val){
    const queryLower = val.toLowerCase();
    words.value = []

    // 筛选拼音首字母包含输入内容的选项
    wordsOld.value.forEach(word => {
      const firstLetterPinyin = convertToPinyin(word, 'first').replace(/\s+/g, '');
      if(firstLetterPinyin.includes(queryLower)){
        words.value.push(word)
      }
    })
    // 筛选选包含输入内容的选项
    wordsOld.value.forEach(word => {
      if(word.includes(val)){
        words.value.push(word)
      }
    })
  } else {
    words.value = wordsOld.value
  }
}

function convertToPinyin(word, type) {
  return pinyin(word, { pattern: type });
}
</script>
```

代码解析：

1. **模板部分**：
   
   - 使用 `el-select` 组件并启用 `filterable` 属性。
   - 通过 `v-for` 渲染选项列表。

2. **脚本部分**：
   
   - 导入 `ref`, `reactive`, `toRefs` 从 Vue 中管理状态。
   - 导入 `pinyin-pro` 库进行拼音转换。
   - 定义原始选项列表 `wordsOld` 和当前选项列表 `words`。
   - 定义一个响应式对象 `data` 存储查询参数。
   - 实现 `filterMethod` 函数，根据输入值筛选匹配的选项，包括拼音首字母和汉字匹配。

以上代码实现了一个带拼音首字母匹配功能的下拉选择器，能有效地根据用户输入进行筛选。
