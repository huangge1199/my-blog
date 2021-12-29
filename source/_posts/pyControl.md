---
title: python3学习笔记--条件控制用法整理
date: 2021-12-29 16:04:06
tags: python
categories: 学习笔记
---

# if

```python
if_stmt ::=  "if" assignment_expression ":" suite
             ("elif" assignment_expression ":" suite)*
             ["else" ":" suite]
```

用法：

```python
if EXPRESSION1:
    SUITE1
elif EXPRESSION2:
    SUITE2
else:
    SUITE
```

常用的操作符：

- "<"：小于
- "<="：小于等于
- ">"：大于
- ">="：大于等于
- "=="：等于
- "!="：不等于
- "and"：并且
- "or"：或者

# with

```python
with_stmt          ::=  "with" ( "(" with_stmt_contents ","? ")" | with_stmt_contents ) ":" suite
with_stmt_contents ::=  with_item ("," with_item)*
with_item          ::=  expression ["as" target]
```

用法：

```python
with EXPRESSION as TARGET:
    SUITE
或者
with A() as a, B() as b:
    SUITE
或者
with A() as a:
    with B() as b:
        SUITE
或者
with (
    A() as a,
    B() as b,
):
    SUITE
```

# match（3.10新特性）

```python
match_stmt   ::=  'match' subject_expr ":" NEWLINE INDENT case_block+ DEDENT
subject_expr ::=  star_named_expression "," star_named_expressions?
                  | named_expression
case_block   ::=  'case' patterns [guard] ":" block
```

用法：

```python
match variable: #这里的variable是需要判断的内容
    case ["quit"]: 
        statement_block_1 # 对应案例的执行代码，当variable="quit"时执行statement_block_1
    case ["go", direction]: 
        statement_block_2
    case ["drop", *objects]: 
        statement_block_3
    ... # 其他的case语句
    case _: #如果上面的case语句没有命中，则执行这个代码块，类似于Switch的default
        statement_block_default
```

