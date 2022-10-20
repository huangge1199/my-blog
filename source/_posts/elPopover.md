---
title: vue下el-popover组件实现滚轴跟随功能
date: 2022-10-19 14:13:52
tags: [前端,vue]
categories: [前端,vue]
---
# 描述
使用的是点击触发弹出内容，目标是在弹出内容的情况下，上下来回滚动鼠标，弹出内容和点击按钮不分离

通过监听页面滚动来实现功能，当监听到页面有滚动时，通过组件的updatePopper()方法来更新组件的位置

# 代码

```vue
<el-popover 
    ref="popover"
    placement="right"
    width="400"
    trigger="click"
    style="position: relative">
    <el-table :data="gridData">
      <el-table-column width="150" property="date" label="日期"></el-table-column>
      <el-table-column width="100" property="name" label="姓名"></el-table-column>
      <el-table-column width="300" property="address" label="地址"></el-table-column>
    </el-table>
    <el-button slot="reference">click 激活</el-button>
</el-popover>

<script>
export default {
  data() {
    return {
      gridData: [{
        date: '2016-05-02',
        name: '王小虎',
        address: '上海市普陀区金沙江路 1518 弄'
      }, {
        date: '2016-05-04',
        name: '王小虎',
        address: '上海市普陀区金沙江路 1518 弄'
      }, {
        date: '2016-05-01',
        name: '王小虎',
        address: '上海市普陀区金沙江路 1518 弄'
      }, {
        date: '2016-05-03',
        name: '王小虎',
        address: '上海市普陀区金沙江路 1518 弄'
      }]
    };
  },
  mounted() {
    window.addEventListener('scroll', this.handleScroll, true)
  },
  methods: {
    handleScroll() {
      this.$refs.popover.updatePopper()
    }
  }
};
</script>
```
