---
title: Java实现RS485串口通信
tags: [java]
categories: [java]
date: 2024-06-24 18:10:11
---

近期，我接到了一个任务，将报警器接入到Java项目中，而接入的方式就是通过RS485接入，本人之前可以说是对此毫无所知。不过要感谢现在的互联网，通过网络我查到了我想要知道的一切，这里记录下本次学习的情况，供大家参考

# 一、RS485简单介绍

RS485是一种常用的串行通信标准，广泛应用于工业自动化和嵌入式系统。它采用差分信号传输，具有抗干扰能力强、传输距离远等优点。以下是关于RS485串口的一些关键点：

## 1、硬件连接

- RS485使用差分信号传输，通常需要使用收发器（如MAX485芯片）将串口的TTL信号转换为RS485信号

- 可以使用USB转RS485转换器实现与计算机的连接

## 2、通信方式

- RS485支持半双工通信，即发送和接收不能同时进行，通常需要软件控制来实现发送和接收的切换

- 通过两个数据线进行通信，数据线为A和B，A为正，B为负

## 3、数据发送和接收

- 在数据发送时，控制器的TX信号经过收发器转换成差分信号传输到总线上

- 接收时，差分信号通过收发器转换为TTL信号，再传输给控制器的RX端口

- 数据传输速率可以根据具体应用需求进行调整，常见的波特率有9600、19200等

# 二、电脑需要做的准备

Windows系统还好，需要一个USB转RS485的转换器就可以了，基本不需要额外安装什么其他的。Linux系统可能就麻烦些，除了一个USB转RS485的转换器外，可能还需要下载相应的驱动（Linux这部分本人未实际操作，全凭网上的资料）。当然，如果你的电脑或者是设备本身就带RS485串口那就方便了，直接接上就好。

接线方面，A接T+，B接T-

# 三、代码方面

本人使用的是Springboot项目，通过网上的查询，可以使用 `jSerialComm` 或 `RXTX` 库来实现串口通信。

## 1、jSerialComm

本人觉得使用这个库相对简单些，直接在pom文件引入依赖就可以了，依赖代码如下：

```xml
<dependency>
    <groupId>com.fazecast</groupId>
    <artifactId>jSerialComm</artifactId>
    <version>2.9.2</version>
</dependency>
```

## 2、RXTX

这个尼，个人觉得相对复杂些，首先，要先去下载RXTX的jar包([rxtx-2.1-7-bins-r2](http://rxtx.qbang.org/pub/rxtx/rxtx-2.1-7-bins-r2.zip))，在使用时，除了在pom文件中引入压缩包内的`RXTXcomm.jar`包外，还需要在系统`%JAVA_HOME%/jre/bin`目录下放入对应的文件，比如说Windows的需要放入`rxtxParallel.dll`和`rxtxSerial.dll`两个文件

压缩包内容：

![](https://img.huangge1199.cn/blog/javashi-xian-rs485chuan-kou-tong-xin/2024-06-24-11-58-06-image.png)

## 3、代码例子

我这边用的`jSerialComm`的方式，引入jar包后，Java的测试代码如下：

```java
import com.fazecast.jSerialComm.SerialPort;

public class RS485Communication {
    public static void main(String[] args) {
        //SerialPort[] commPorts = SerialPort.getCommPorts();
        //if (commPorts.length == 0) {
        //    log.error("设备未插入！");
        //}
		//SerialPort serialPort = null;
        //if(SystemUtils.isLinux()){
        //    for (SerialPort commPort : commPorts) {
        //        log.info(JSON.toJSONString(commPort));
        //        if(commPort.getSystemPortName().equals("ttyS2")){
        //            serialPort = commPort;
        //        }
        //    }
        //} else {
        //    for (SerialPort commPort : commPorts) {
        //        log.info(JSON.toJSONString(commPort));
        //        if(commPort.getSystemPortName().contains("COM")){
        //            serialPort = commPort;
        //        }
        //    }
        //}
	    // 这里取的是第一个，如果你有多个，可以通过注释的代码来确定你使用的是哪一个
        SerialPort serialPort = SerialPort.getCommPorts()[0];
        serialPort.setBaudRate(9600);
        serialPort.setNumDataBits(8);
        serialPort.setNumStopBits(SerialPort.ONE_STOP_BIT);
        serialPort.setParity(SerialPort.NO_PARITY);

        if (serialPort.openPort()) {
            System.out.println("Port opened successfully.");
        } else {
            System.out.println("Failed to open port.");
            return;
        }

        // 发送数据
        byte[] dataToSend = {0x00, 0x10}; // 示例16位数据
        serialPort.writeBytes(dataToSend, dataToSend.length);

        // 接收数据
        byte[] readBuffer = new byte[2];
        serialPort.readBytes(readBuffer, readBuffer.length);
        System.out.println("Received: " + bytesToHex(readBuffer));

        serialPort.closePort();
    }

    private static String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02X ", b));
        }
        return sb.toString().trim();
    }
}


```
