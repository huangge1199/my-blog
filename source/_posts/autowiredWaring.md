---
title: Autowired注解警告的解决办法
date: 2022-03-28 11:20:43
tags: [java]
categories: [java]
---

# @AutoWired 在idea报警告

近期，发现@AutoWired注解在idea中总是报警告

## java代码

如下：

```java
@Controller
public class UserController {

    @Autowired
    private UserService userService;

}
```

## 警告内容

如下：

![](https://blog.huangge1199.cn/post/autowiredWaring/2022-03-28-11-30-49-1648438205(1).png)

## 解决办法

于是乎，关联性的在网上找了找资料，用以下的写法不会报警告，同时这种写法也是spring官方推荐的写法，代码如下：

```java
@Controller
public class UserController {

    private final UserService userService;

    public UserController(UserService userService){
        this.userService = userService;
    }

}
```

## Lombok优雅写法

```java
@Controller
@RequiredArgsConstructor(onConstructor = @__(@Autowired))
public clas UserController {
    //这里必须是final,若不使用final,用@NotNull注解也是可以的
    private final UserService userService;

}
```

# 拓展学习

由此，我这边拓展到了spring的三种依赖注入方式：

- Field Injection

- Constructor Injection

- Setter Injection

## Field Injection

`@Autowired`注解的一大使用场景就是`Field Injection`。

具体形式如下：

```java
@Controller
public class UserController {

    @Autowired
    private UserService userService;

}
```

这种注入方式通过Java的反射机制实现，所以private的成员也可以被注入具体的对象。

## Constructor Injection

`Constructor Injection`是构造器注入，是我们日常最为推荐的一种使用方式。

具体形式如下：

```java
@Controller
public class UserController {

    private final UserService userService;

    public UserController(UserService userService){
        this.userService = userService;
    }

}
```

这种注入方式很直接，通过对象构建的时候建立关系，所以这种方式对对象创建的顺序会有要求，当然Spring会为你搞定这样的先后顺序，除非你出现循环依赖，然后就会抛出异常。

## Setter Injection

`Setter Injection`也会用到`@Autowired`注解，但使用方式与`Field Injection`有所不同，`Field Injection`是用在成员变量上，而`Setter Injection`的时候，是用在成员变量的Setter函数上。

具体形式如下：

```java
@Controller
public class UserController {

    private UserService userService;

    @Autowired
    public void setUserService(UserService userService){
        this.userService = userService;
    }
}
```

这种注入方式也很好理解，就是通过调用成员变量的set方法来注入想要使用的依赖对象。

## 三种依赖注入方式比较

| 注入方式        | 可靠性 | 可维护性 | 可测试性 | 灵活性 | 循环关系的检测 | 性能影响 |
| ----------- | --- | ---- | ---- | --- | ------- | ---- |
| Field       | 不可靠 | 低    | 差    | 很灵活 | 不检测     | 启动快  |
| Constructor | 可靠  | 高    | 好    | 不灵活 | 自动检测    | 启动慢  |
| Setter      | 不可靠 | 低    | 好    | 很灵活 | 不检测     | 启动快  |

# 参考：

1. https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#beans-constructor-injection

2. https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#beans-setter-injection

3. [利用Lombok编写优雅的spring依赖注入代码,去掉繁人的@Autowired_路遥知码农的博客-CSDN博客_lombok 依赖注入](https://blog.csdn.net/weixin_43203497/article/details/104193350)

4. https://segmentfault.com/a/1190000040914633
