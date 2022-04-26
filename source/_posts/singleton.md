---
title: 单例模式
date: 2022-04-26 14:44:05
tags: [学习笔记,设计模式]
categories: [设计模式]
---
# 定义

确保一个类在任何情况下都绝对只有一个实例，并提供一个全局访问点

# 饿汉式单例

优点：执行效率高、性能高、没有融合的锁

缺点：某些情况下，可能会造成内存浪费

## 常规写法

```java
public class HungrySingleton {

    private static final HungrySingleton hungrySingleton = new HungrySingleton();

    private HungrySingleton() {
    }

    public static HungrySingleton getInstance() {
        return hungrySingleton;
    }
}
```

## 利用静态代码块的写法

```java
public class HungryStaticSingleton {
    private static final HungryStaticSingleton hungrySingleton;

    static {
        hungrySingleton = new HungryStaticSingleton();
    }

    private HungryStaticSingleton() {
    }

    public static HungryStaticSingleton getInstance() {
        return hungrySingleton;
    }
}
```

# 懒汉式单例

## 常规写法

优点：节省了内存，线程安全

缺点：性能低

```java
public class LazySimpleSingletion {
    private static LazySimpleSingletion instance;
    private LazySimpleSingletion(){}

    public synchronized static LazySimpleSingletion getInstance(){
        if(instance == null){
            instance = new LazySimpleSingletion();
        }
        return instance;
    }
}
```

## 双重检查

优点：性能高了，线程安全了  
缺点：可读性难度加大，不够优雅

```java
public class LazyDoubleCheckSingleton {
    private volatile static LazyDoubleCheckSingleton instance;

    private LazyDoubleCheckSingleton() {
    }

    public static LazyDoubleCheckSingleton getInstance() {
        //检查是否要阻塞
        if (instance == null) {
            synchronized (LazyDoubleCheckSingleton.class) {
                //检查是否要重新创建实例
                if (instance == null) {
                    instance = new LazyDoubleCheckSingleton();
                    //指令重排序的问题
                }
            }
        }
        return instance;
    }
}
```

## 静态内部类单例

优点：写法优雅，利用了Java本身语法特点，性能高，避免了内存浪费,不能被反射破坏

```java
public class LazyStaticInnerClassSingleton {

    private LazyStaticInnerClassSingleton() {
        if (LazyHolder.INSTANCE != null) {
            throw new RuntimeException("不允许非法访问");
        }
    }

    private static LazyStaticInnerClassSingleton getInstance() {
        return LazyHolder.INSTANCE;
    }

    private static class LazyHolder {
        private static final LazyStaticInnerClassSingleton INSTANCE = new LazyStaticInnerClassSingleton();
    }

}
```

# 注册式单例

## 枚举单例

```java
public enum EnumSingleton {
    INSTANCE;

    private Object data;

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public static EnumSingleton getInstance() {
        return INSTANCE;
    }
}
```

## 容器化单例

```java
public class ContainerSingleton {

    private ContainerSingleton() {
    }

    private static Map<String, Object> ioc = new ConcurrentHashMap<String, Object>();

    public static Object getInstance(String className) {
        Object instance = null;
        if (!ioc.containsKey(className)) {
            try {
                instance = Class.forName(className).newInstance();
                ioc.put(className, instance);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return instance;
        } else {
            return ioc.get(className);
        }
    }

}
```

# 序列化单例

```java
public class SeriableSingleton implements Serializable {
    
    public final static SeriableSingleton INSTANCE = new SeriableSingleton();

    private SeriableSingleton() {
    }

    public static SeriableSingleton getInstance() {
        return INSTANCE;
    }

    private Object readResolve() {
        return INSTANCE;
    }

}
```

# 线程

```java
public class ThreadLocalSingleton {
    private static final ThreadLocal<ThreadLocalSingleton> threadLocaLInstance =
            new ThreadLocal<ThreadLocalSingleton>() {
                @Override
                protected ThreadLocalSingleton initialValue() {
                    return new ThreadLocalSingleton();
                }
            };

    private ThreadLocalSingleton() {
    }

    public static ThreadLocalSingleton getInstance() {
        return threadLocaLInstance.get();
    }
}CE;
    }

}
```

# 破坏单例模式的场景和解决方案

## 1、指令重排使懒汉式模式失效

解决办法：加`volatile`关键字

## 2、反射

解决办法：弄一个全局变量标记是否实例化过，如果实例化过，抛异常

## 3、克隆

解决办法：重新克隆方法，调用时直接返回已经实例化的对象

## 4、序列化

解决办法：在反序列化时的回调方法 readResolve()中返回单例对象
