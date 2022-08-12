---
title: windows server下安装zookeeper和kafka集群
date: 2022-07-08 10:42:20
tags: [安装部署]
categories: [安装部署]
---

# 安装说明

单机部署zookeeper和kafka集群，kafka使用2.8.0版本的，该版本已经将zookeeper集成在内了，因此只需要下载kafka的包即可。

安装目录：C:/kafka/

三个节点都在目录下，依次为kafka1、kafka2、kafka3

# 下载

从kafka官网下载：[kafka_2.13-2.8.0.tgz 下载地址](https://archive.apache.org/dist/kafka/2.8.0/kafka_2.13-2.8.0.tgz)

下载好后，将内容解压后，依次拷贝到kafka1、kafka2、kafka3的目录下，作为集群的3个节点

# zookeeper

## 1、配置文件

修改zookeeper的配置文件，conf/zookeeper.properties，以节点1为例，确保有以下内容：

```properties
dataDir=C:/kafka/kafka1/zkData
dataLogDir=C:/kafka/kafka1/zkLog
clientPort=2187

tickTime=2000
initLimit=10
syncLimit=5

server.1=192.168.0.116:2887:3887
server.2=192.168.0.116:2888:3888
server.3=192.168.0.116:2889:3889
```

三个节点的clientPort依次设置成2187、2188、2189

> 注意：
> 
> - 三个节点的dataDir和dataLogDir的目录不同
> 
> - dataDir和dataLogDir必须保证目录存在，不会根据配置文件自动生成
> 
> - 余下内容全部相同

## 2、创建myid文件

依次在三个节点的dataDir目录下创建myid文件，内容依次填入1、2、3。

## 3、创建启动脚本

依次在三个节点kafka的目录下添加启动脚本zkStart.bat

```batch
.\bin\windows\zookeeper-server-start.bat .\config\zookeeper.properties
```

# kafka

## 1、修改配置文件

修改kafka的配置文件，server.properties，以节点1为例，修改内容如下：

```properties
broker.id=0
listeners=PLAINTEXT://192.168.0.116:9097
advertised.listeners=PLAINTEXT://192.168.0.116:9097
host.name= 192.168.0.116
port=9097
log.dirs=C:/kafka/kafka1/log
zookeeper.connect=192.168.0.116:2187,192.168.0.116:2188,192.168.0.116:2189
```

> 注意：
> 
> - broker.id：依次为0、1、2
> 
> - port：依次为9097、9098、9099
> 
> - log.dirs必须保证目录存在，不会根据配置文件自动生成

## 2、创建启动、停止脚本

依次在三个节点kafka的目录下添加

启动脚本start.bat：

```batch
./bin/kafka-server-start.sh config/server.properties
```

停止脚本stop.bat：

```batch
./bin/kafka-server-stop.sh config/server.properties
```

# 测试：发送消息

## 1、创建主题

在kafka目录下执行下面的命令

```batch
kafka-topics.bat --create --zookeeper IP:2181 --replication-factor 3 --partitions 1 --topic test7
```

## 2、创建生产者

在kafka的bin\windows目录下执行下面的命令

```batch
kafka-console-producer.bat --broker-list 192.168.0.116:9097,192.168.0.116:9098,192.168.0.116:9099 --topic test7
```

![](2022-07-08-15-14-23-image.png)

## 3、创建消费者

在kafka的bin\windows目录下执行下面的命令

```batch
kafka-console-consumer.bat --bootstrap-server 192.168.0.116:9097 --topic test7 --from-beginning
```

![](2022-07-08-15-14-57-image.png)

## 4、生产者发送消息，消费者接收消息

生产者随意输入内容，消费者显示内容

生产者：

![](2022-07-08-15-15-55-image.png)

消费者：

![](2022-07-08-15-16-48-image.png)
