---
title: JPA复合主键使用
date: 2022-01-05 15:14:53
tags: [java,jpa]
categories: [java,jpa]
cover: https://blog.huangge1199.cn/post/jpaCompositePK/bg.jpg
---

# 1、建立带有复合主键的表User

该表使用 `username`+`phone` 做为复合组件

```sql
create table user
(
    username varchar(50) not null,
    phone     varchar(11) not null,
    email     varchar(20) default '',
    address   varchar(50) default '',
    primary key (username, phone)
) default charset = utf8
```

# 2、java中建立复合主键的实体类

```java
import lombok.Data;
import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
public class UserKey implements Serializable {
    private String username;
    private String phone;
}
```

# 3、建立表的实体类

在实体类上面使用 @IdClass 注解指定复合主键。同时，需要在 name 和 phone 字段上面使用 @Id 注解标记为主键

```java
import lombok.Data;
import javax.persistence.*;

@Data
@Entity
@Table(name = "user")
@IdClass(value = UserKey.class)
public class User {
    @Id
    @Column(nullable = false)
    private String username;

    @Id
    @Column(nullable = false)
    private String phone;

    @Column
    private String email;

    @Column
    private String address;
}
```
