---
title: 使用xlsxwriter和openplxl库操作Excel文件
tags: [python]
categories: [python]
date: 2023-05-31 11:13:46
---

Excel文件是一种广泛使用的电子表格格式，用于存储和处理各种数据。在Python中，有多个库可以用于处理Excel文件，其中包括xlsxwriter和openplxl两个库。本文将介绍这两个库的使用方法以及如何使用它们来操作Excel文件。

# 1、xlsxwriter生成Excel文件

xlsxwriter是一个用于生成Excel文件的Python库，支持多种格式的Excel文件(如.xlsx、.xlsm、.xltx、.xltm等),并且支持自定义样式和格式。下面将以一个简单的示例，来逐步介绍如何使用xlsxwriter库创建一个Excel文件并写入数据

## 1.1、导入库并创建Excel文件

Excel文件名为：xlsxwriter插入数据和折线图.xlsx

```python
import xlsxwriter, random

wb = xlsxwriter.Workbook('xlsxwriter插入数据和折线图.xlsx')
```

## 1.2、创建一个sheet页

sheet标签页名字为：sheet1

```python
worksheet1 = wb.add_worksheet('sheet1')
```

## 1.3、按行写入数据

这里以写入Excel的头部数据为例：

```python
headings = ['日期','数据1','数据2']
worksheet1.write_row('A1',headings)
```

## 1.4、按列写入数据

有了头部数据后，该写入下面的实际数据了

```python
# 创造数据
data = [
    ['2019-1','2019-2','2019-3','2019-4','2019-5','2019-6','2019-7','2019-8','2019-9','2019-10','2019-11','2019-12',],
    [random.randint(1,100) for i in range(12)],
    [random.randint(1,100) for i in range(12)],
] 
# 按列写入数据
worksheet1.write_column('A2',data[0])
worksheet1.write_column('B2',data[1])
worksheet1.write_column('C2',data[2])
```

## 1.5、新建图表对象

折线图表的定义：

```python
chart_col = wb.add_chart({'type':'line'})
```

## 1.6、图表数据配置

这里的数据有两条，一个是数据1，一个是数据2，所以图表添加数据的代码如下：

```python
chart_col.add_series(
    {
        'name':'=sheet1!$B$1',
        'categoies':'=sheet1!$A$2:$A$7',
        'values':   '=sheet1!$B$2:$B$7',
        'line': {'color': 'blue'},
    }
)
chart_col.add_series(
    {
        'name':'=sheet1!$C$1',
        'categories':'=sheet1!$A$2:$A$7',
        'values':   '=sheet1!$C$2:$C$7',
        'line': {'color': 'green'},
    }
)

```

有两条数据，所以添加了两次。

数据有四项，数据名、具体值对应的横坐标categories、具体值对应的纵坐标values、折线颜色，其中取值方式，直接是使用sheet的坐标形式，例如name是B1和B2，categories都是A2-A7，值分别是B2-B7和C2-C7。

## 1.7、完成图表

数据添加之后，在设置下坐标的相关信息，就是标题、x轴、y轴的名字，以及图表位置和大小，代码如下：

```python
chart_col.set_title({'name':'虚假数据折线图'})
chart_col.set_x_axis({'name':"横坐标"})
chart_col.set_y_axis({'name':'纵坐标'})

worksheet1.insert_chart('D2',chart_col,{'x_offset':25,'y_offset':10})

wb.close()
```

图表的位置和大小，是根据左上角的起始表格和x和y的偏移计算的。

代码中是从D2做左上角起始，然后x和y分别便宜25和10个单位，得到了图片的最终大小。最后关闭wb。

![](https://img.huangge1199.cn/blog/pyHighExcel/2023-05-31-13-51-38-image.png)

# 2、openpyxl追加Excel数据

openplxl是一个用于读取现有的Excel文件的Python库，支持多种格式的Excel文件(如.xlsx、.xlsm、.xltx、.xltm等),并且支持读取单元格的数据。

## 2.1、打开文件

```python
import openpyxl
filename = 'xlsxwriter插入数据和折线图.xlsx'
wb = openpyxl.load_workbook(filename)
```

## 2.2、拷贝sheet

```python
sheet1 = wb['sheet1']
# 拷贝sheet1
sheet2 = wb.copy_worksheet(sheet1)
# 设置拷贝后的名称为sheet2
sheet2.title = "sheet2"
```

## 2.3、追加数据内容

在sheet2中，数据1和数据2追加一年的数据，代码如下：

```python
# 读取最后一行
rows = sheet2.max_row
# 取出时间的字符串
prev_date_str = sheet2.cell(row=rows,column=1).value
# 时间字符串转时间对象
prev_date = datetime.datetime.strptime(prev_date_str, "%Y-%m")
for i in range(1,13):
    # 月份的计算，每次增加一个月，就得到了第二年的12个月
    tmp_date = prev_date + relativedelta(months=i)
    tmp_num1 = random.randint(1,100)
    tmp_num2 = random.randint(1,100)
    sheet2.append([tmp_date.strftime("%Y-%m"), tmp_num1, tmp_num2])
```

实现思路：

- 读取出最后一行
- 取出时间字符串，然后转换成时间对象
- 一年12个月，循环12次，每次增加一个月，数值可以随机的生成，用random即可
- 数据的追加，是按每行，所以将【时间， 数据1， 数据2】通过append直接追加到数据最后即可

## 2.4、使用openpyxl画图表

在sheet2中对全部数据画折线图

```python
from openpyxl.chart import Series,LineChart, Reference
# 图表对象
chart = LineChart()
rows = sheet2.max_row

# 创建series对象
data1 = Reference(sheet2, min_col=2, min_row=1, max_col=2, max_row=rows) #涉及数据
title1 = sheet2.cell(row=1,column=2).value
seriesObj1 = Series(data1, title=title1)

# 创建series对象
data2 = Reference(sheet2, min_col=3, min_row=1, max_col=3, max_row=rows) #涉及数据
title2 = sheet2.cell(row=1,column=3).value
seriesObj2 = Series(data2, title=title2)

# 添加到chart中
chart.append(seriesObj1)
chart.append(seriesObj2)

# 将图表添加到 sheet中
sheet2.add_chart(chart, "E3")

# 保存Excel
wb.save('poenpyxl插入数据和折线图[copy xlsxwriter].xlsx')
```

导入所需的画图工具，图表初始化，然后生成数据对象：

- data1的生成，因为索引从1开始，所以标题是第一行第二列，数据是第二行第二列，一直到最后一行第二列
- data2的生成，因为索引从1开始，所以标题是第一行第三列，数据是第二行第三列，一直到第二行最后三列
- 将两个数据都放到图表内
- 然后图表的开始位置，设置成E3，数据在ABC，E是空的，3距离顶部有两格的位置

最后文件保存，大功告成。 

![](https://img.huangge1199.cn/blog/pyHighExcel/2023-05-31-14-04-47-image.png)

![](https://img.huangge1199.cn/blog/pyHighExcel/2023-05-31-14-05-20-image.png)

# 3、总结

本文介绍了如何使用xlsxwriter和openplxl两个库来操作Excel文件。xlsxwriter库可以用于创建新的Excel文件并写入数据，而openplxl库则可以用于读取现有的Excel文件并读取单元格的数据。这些库都是Python中处理Excel文件的好工具，可以帮助我们更加高效地处理各种数据。
