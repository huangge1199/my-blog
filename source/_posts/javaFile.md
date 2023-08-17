---
title: Java代码中对文件的操作
tags: [java]
categories: [java]
date: 2023-08-15 13:56:51
---

# 引言

这几天的项目涉及到了文件的操作，我这边做一下整理



# 环境说明

jdk版本：1.8.0_311

# 对文件的操作

## 1、保存文件

```java
/**
 * 保存文件
 *
 * @param file 文件
 * @param path 文件保存目录
 * @param name 保存后的文件名字
 */
public void saveFile(MultipartFile file, String path, String name) throws Exception {
    if (file == null) {
        throw new Exception("请上传有效文件!");
    }
    // 若目录不存在则创建目录
    File folder = new File(path);
    if (!folder.exists()) {
        folder.mkdirs();
    }

    // 生成文件，folder为文件目录，newName为文件名
    file.transferTo(new File(folder, name));
}
```

## 2、删除文件

```java
/**
 * 删除指定目录下的指定文件
 *
 * @param path 文件路径(路径结尾不带“/”)
 * @param name 文件名称
 */
public void delFile(String path, String name) {
    File file = new File(path + "/" + name);
    file.delete();
}
```

## 3、删除指定的空目

```java
/**
 * 删除指定的空目录，如果往上2层的目录也是空的，则一起删除
 *
 * @param path 目录路径(路径结尾不带“/”)
 */
public void delBlankDir(String path) {
    for (int i = 0; i < 3; i++) {
        File dirFile = new File(path);
        if (dirFile.length() == 0) {
            dirFile.delete();
            path = path.substring(0, path.lastIndexOf("/"));
        } else {
            break;
        }
    }
}
```

## 4、验证文件是否是MP3格式

```java
/**
 * 验证是否是MP3格式的文件
 *
 * @param multipartFile 验证的文件
 * @return true：是MP3、false：不是MP3
 */
public boolean isMP3File(MultipartFile multipartFile) {
    try {
        byte[] headerBytes = new byte[4];
        multipartFile.getInputStream().read(headerBytes);
        if (headerBytes[0] == (byte) 0x49 && headerBytes[1] == (byte) 0x44 &&
                headerBytes[2] == (byte) 0x33) {
            return true;
        }
    } catch (IOException e) {
        e.printStackTrace();
        return false;
    }
    return false;
}
```

## 5、音频格式转换

```java
/**
 * 音频文件格式转换
 *
 * @param fpath  需要转换的音频文件路径
 * @param target 转换后的音频文件路径
 */
public void transferAudioPcm(String fpath, String target) {
    List<String> commend = new ArrayList<>();
    String path = "";
    if (SystemUtils.isLinux()) {
        path = "修改成Ffmpeg文件的路径";
    } else if (SystemUtils.isWindows()) {
        path = "修改成Ffmpeg文件的路径";
    }
    commend.add(path);
    commend.add("-y");
    commend.add("-i");
    commend.add(fpath);
    commend.add("-f");
    commend.add("s16le");
    commend.add("-ar");
    commend.add("4000");
    commend.add("-ac");
    commend.add("-1");
    commend.add(target);
    try {
        ProcessBuilder builder = new ProcessBuilder();
        builder.command(commend);
        Process p = builder.start();
        p.waitFor();
        p.destroy();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
```

## 6、改变linux系统下的文件权限

```java
/**
 * 改变linux系统下的文件权限
 *
 * @param mod  修改后的权限
 * @param path 文件路径
 */
public void changePermission(String mod, String path) throws Exception {
    // ProcessBuilder processBuilder = new ProcessBuilder("chmod", "775", "/data/a.txt");
    ProcessBuilder processBuilder = new ProcessBuilder("chmod", mod, path);
    Process process = processBuilder.start();
    int exitCode = process.waitFor();
    if (exitCode == 0) {
        System.out.println("File permission changed successfully!");
    } else {
        System.out.println("Failed to change file permission.");
    }
}
```

## 7、查询服务器磁盘空间

```java
/**
 * 查询服务器磁盘空间
 *
 * @return map
 */
public Map<String, String> getDiskInfo() {
    // 总空间
    long totalSpace = 0;
    // 已用空间
    long usableSpace = 0;
    // 可用空间
    long unallocatedSpace = 0;
    for (FileStore fileStore : FileSystems.getDefault().getFileStores()) {
        try {
            totalSpace += fileStore.getTotalSpace();
            usableSpace += fileStore.getUsableSpace();
            unallocatedSpace += fileStore.getUnallocatedSpace();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
    DecimalFormat decimalFormat = new DecimalFormat("#.00");
    Map<String, String> map = new HashMap<>(3);
    map.put("totalSpace", decimalFormat.format(totalSpace / (1024.0 * 1024 * 1024)));
    map.put("usableSpace", decimalFormat.format(usableSpace / (1024.0 * 1024 * 1024)));
    map.put("unallocatedSpace", decimalFormat.format(unallocatedSpace / (1024.0 * 1024 * 1024)));
    return map;
}
```
