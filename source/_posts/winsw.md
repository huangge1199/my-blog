---
title: Windows系统下设置程序开机自启（WinSW）
tags: [工具]
categories: [工具]
date: 2023-10-13 08:45:13
---

# 介绍

WinSW可以将Windows上的任何程序作为系统服务进行管理，已达到开机自启的效果。

# 支持的平台

WinSW需要运行在拥有.NET Framework 4.6.1或者更新版本的Windows平台下

# 下载

- github： [下载地址](https://github.com/winsw/winsw/releases)

- 百度网盘（v2.12.0）：[WinSW-x86](https://pan.baidu.com/s/1mCdn2cLyKkA6BSuYtvA-1A?pwd=ktt7)  [WinSW-x64](https://pan.baidu.com/s/1suXVU4I7v3mHApy5UQSO9g?pwd=f3i1)

# 使用说明

## 全局应用

1. 获取`WinSW.exe`文件
2. 编写*myapp.xml*文件（详细内容看[XML配置文件](# XML配置文件)）
3. 运行`winsw install myapp.xml [options]`安装服务，使其写入系统服务中
4. 运行`winsw start myapp.xml` 开启服务
5. 运行`winsw status myapp.xml` 查看服务的运行状态

## 单一应用

1. 获取`WinSW.exe`文件并将其更名为你的服务名(例如*myapp.exe*).
2. 编写*myapp.xml*文件
3. 请确保前面两个文件在同一目录
4. 运行`myapp.exe install [options]`安装服务，使其写入系统服务中
5. 运行`myapp.exe start`开启服务
6. 运行`myapp status myapp.xml` 查看服务的运行状态

# 命令

除了使用说明中的`install`、`start`、`status`三个命令外，WinSW还提供了其他的命令，具体命令及说明如下：

- install：安装服务

- uninstall：卸载服务

- start：启动服务

- stop：停止服务

- restart：重启服务

- status：检查服务状态

- refresh：刷新服务属性

- customize：自定义包装器可执行文件

- dev：扩展命令（具体看下方）

扩展命令：

- dev ps：绘制与服务相关的进程树

- dev kill：如果服务停止响应，则终止该服务

- dev list：列出当前可执行文件管理的服务

# XML配置文件

## 文件结构

xml文件的根元素必须是 `<service>`, 并支持以下的子元素

例子：

```xml
<service>
  <id>jenkins</id>
  <name>Jenkins</name>
  <description>This service runs Jenkins continuous integration system.</description>
  <env name="JENKINS_HOME" value="%BASE%"/>
  <executable>java</executable>
  <arguments>-Xrs -Xmx256m -jar "%BASE%\jenkins.war" --httpPort=8080</arguments>
  <log mode="roll"></log>
</service>
```

## 环境变量扩展

配置 XML 文件可以包含 %Name% 形式的环境变量扩展。如果发现这种情况，将自动用变量的实际值替换。如果引用了未定义的环境变量，则不会进行替换。

此外，服务包装器还会自行设置环境变量 BASE，该变量指向包含重命名后的 WinSW.exe 的目录。这对引用同一目录中的其他文件非常有用。由于这本身就是一个环境变量，因此也可以从服务包装器启动的子进程中访问该值。

## 配置条目

### id

必填 指定 Windows 内部用于标识服务的 ID。在系统中安装的所有服务中，该 ID 必须是唯一的，且应完全由字母数字字符组成。

```xml
<id>jenkins</id>
```

### executable

必填 该元素指定要启动的可执行文件。它可以是绝对路径，也可以直接指定可执行文件的名称，然后从 PATH 中搜索（但要注意的是，服务通常以不同的用户账户运行，因此它的 PATH 可能与 shell 不同）。

```xml
<executable>java</executable>
```

### name

可选项 服务的简短显示名称，可以包含空格和其他字符。该名称不能太长，如 <id>，而且在给定系统的所有服务中也必须是唯一的。

```xml
<name>Jenkins</name>
```

### description

可选 对服务的长篇可读描述。当服务被选中时，它会显示在 Windows 服务管理器中。

```xml
<description>This service runs Jenkins continuous integration system.</description>
```

### startmode

可选 此元素指定 Windows 服务的启动模式。可以是以下值之一：自动或手动。有关详细信息，请参阅 [ChangeStartMode]([Win32_Service 类的 ChangeStartMode 方法 (CIMWin32 WMI 提供程序) - Win32 apps | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/win32/cimwin32prov/changestartmode-method-in-class-win32-service)) 方法。默认值为自动`Automatic`。

### delayedAutoStart

可选 如果定义了`Automatic`模式，此布尔选项将启用延迟启动模式。更多信息，请参阅[Startup Processes and Delayed Automatic Start](https://techcommunity.microsoft.com/t5/ask-the-performance-team/ws2008-startup-processes-and-delayed-automatic-start/ba-p/372692)。

请注意，该启动模式不适用于 Windows 7 和 Windows Server 2008 以上的旧版本。在这种情况下，Windows 服务安装可能会失败。

```xml
<delayedAutoStart>true</delayedAutoStart>
```

### depend

可选 指定此服务依赖的其他服务的 ID。当服务 X 依赖于服务 Y 时，X 只能在 Y 运行时运行。

可使用多个元素指定多个依赖关系。

```xml
<depend>Eventlog</depend>
<depend>W32Time</depend>
```

### log

可选 用 <logpath> 和启动模式设置不同的日志目录：append（默认）、reset（清除日志）、ignore（忽略）、roll（移动到 \*.old）。

更多信息，请参阅[Logging and error reporting](https://github.com/winsw/winsw/blob/v3/docs/logging-and-error-reporting.md)。

```xml
<log mode="roll"></log>
```

### arguments

可选 <arguments> 元素指定要传递给可执行文件的参数。

```xml
<arguments>arg1 arg2 arg3</arguments>
```

或者

```xml
<arguments>
  arg1
  arg2
  arg3
</arguments>
```

### stopargument/stopexecutable

可选 当服务被请求停止时，winsw 会简单地调用 [TerminateProcess function](https://docs.microsoft.com/windows/win32/api/processthreadsapi/nf-processthreadsapi-terminateprocess)立即杀死服务。但是，如果存在 <stoparguments> 元素，winsw 将使用指定的参数启动另一个 <executable> 进程（或 <stopopexecutable>，如果已指定），并期望该进程启动服务进程的优雅关闭。      

然后，Winsw 将等待这两个进程自行退出，然后向 Windows 报告服务已终止。  

使用 <stoparguments> 时，必须使用 <startarguments> 而不是 <arguments>。

```xml
<executable>catalina.sh</executable>
<startarguments>jpda run</startarguments>

<stopexecutable>catalina.sh</stopexecutable>
<stoparguments>stop</stoparguments>
```

### Additional commands

扩展命令包括`prestart`,`poststart`,`prestop`,`poststop`四个，以`prestart`为例写法如下：

```xml
<prestart>
  <executable></executable>
  <arguments></arguments>
  <stdoutPath></stdoutPath>
  <stderrPath></stderrPath>
</prestart>
```

- prestart：在服务启动时、主进程启动前执行

- poststart：在服务启动时和主程序启动后执行

- prestop：在服务停止时、主进程停止前执行

- poststop：在服务停止时和主进程停止后执行

共用的命令如下：

- stdoutPath：指定将标准输出重定向到的路径

- stderrPath：指定将标准错误输出重定向到的路径

在 stdoutPath 或 stderrPath 中指定 NUL 可处理相应的数据流

### preshutdown

当系统关闭时，让服务有更多时间停止。

系统默认的预关机超时时间为三分钟。

```xml
<preshutdown>false</preshutdown>
<preshutdownTimeout>3 min</preshutdown>
```

### stoptimeout

当服务被请求停止时，winsw 会首先尝试向控制台应用程序发送 Ctrl+C 信号，或向 Windows 应用程序发布关闭消息，然后等待长达 15 秒的时间，让进程自己优雅地退出。如果超时或无法发送信号或消息，winsw 就会立即终止服务。  

通过这个可选元素，您可以更改 "15 秒 "的值，这样就可以控制 winsw 让服务自行关闭的时间。

```xml
<stoptimeout>10sec</stoptimeout>
```

### Environment

如有必要，可多次指定该可选元素，以指定要为子进程设置的环境变量。

```xml
<env name="HOME" value="c:\abc" />
```

### interactive

如果指定了此可选元素，则允许服务与桌面交互，如显示新窗口和对话框。

```xml
<interactive>true</interactive>
```

请注意，自引入 UAC（Windows Vista 及以后版本）以来，服务已不再真正允许与桌面交互。在这些操作系统中，这样做的目的只是让用户切换到一个单独的窗口站来与服务交互。

### beeponshutdown

该可选元素用于在服务关闭时发出[simple tones](https://docs.microsoft.com/windows/win32/api/utilapiset/nf-utilapiset-beep)。此功能只能用于调试，因为某些操作系统和硬件不支持此功能。

```xml
<beeponshutdown>true</beeponshutdown>
```

### download

可以多次指定这个可选元素，以便让服务包装器从 URL 获取资源并将其作为文件放到本地。此操作在服务启动时，即 `<executable>` 指定的应用程序启动前运行。

对于需要身份验证的服务器，必须根据身份验证类型指定一些参数。只有基本身份验证需要额外的子参数。支持的身份验证类型有

- none（无）：默认值，不得指定

- sspi：Windows [Security Support Provider Interface](https://docs.microsoft.com/windows/win32/secauthn/sspi)，包括 Kerberos、NTLM 等。

- basic：基本身份验证，子参数：
  
  - user="UserName" 用户名
  
  - password="Passw0rd"
  
  - unsecureAuth="true": 默认值="false"

参数 unsecureAuth 仅在传输协议为 HTTP（未加密数据传输）时有效。这是一个安全漏洞，因为凭据是以明文发送的！对于 SSPI 身份验证来说，这并不重要，因为身份验证令牌是加密的。

对于使用 HTTPS 传输协议的目标服务器来说，颁发服务器证书的 CA 必须得到客户端的信任。当服务器位于互联网上时，通常会出现这种情况。当一个组织在内部网中使用自行签发的 CA 时，情况可能并非如此。在这种情况下，有必要将 CA 导入 Windows 客户端的证书 MMC。请参阅 "[Manage Trusted Root Certificates](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754841(v=ws.11))"中的说明。必须将自行签发的 CA 导入计算机的可信根证书颁发机构。

默认情况下，如果操作失败（如从不可用），下载命令不会导致服务启动失败。为了在这种情况下强制下载失败，可以指定 failOnError 布尔属性。

要指定自定义代理，请使用参数 proxy，格式如下：

- 有凭据：http://USERNAME:PASSWORD@HOST:PORT/。

- 无凭据： http://HOST:PORT/。

```xml
<download from="http://example.com/some.dat" to="%BASE%\some.dat" />

<download from="http://example.com/some.dat" to="%BASE%\some.dat" failOnError="true"/>

<download from="http://example.com/some.dat" to="%BASE%\some.dat" proxy="http://192.168.1.5:80/"/>

<download from="https://example.com/some.dat" to="%BASE%\some.dat" auth="sspi" />

<download from="https://example.com/some.dat" to="%BASE%\some.dat" failOnError="true"
          auth="basic" user="aUser" password="aPassw0rd" />

<download from="http://example.com/some.dat" to="%BASE%\some.dat"
          proxy="http://aUser:aPassw0rd@192.168.1.5:80/"
          auth="basic" unsecureAuth="true"
          user="aUser" password="aPassw0rd" />
```

这是开发自我更新服务的另一个有用的组成部分。

自 2.7 版起，如果目标文件存在，WinSW 将在 If-Modified-Since 标头中发送其最后写入时间，如果收到 304 Not Modified，则跳过下载。

### onfailure

当 winsw 启动的进程失败（即以非零退出代码退出）时，这个可选的可重复元素将控制其行为。

```xml
<onfailure action="restart" delay="10 sec"/>
<onfailure action="restart" delay="20 sec"/>
<onfailure action="reboot" />
```

例如，上述配置会导致服务在第一次故障后 10 秒内重新启动，在第二次故障后 20 秒内重新启动，然后如果服务再次发生故障，Windows 将重新启动。

每个元素都包含一个强制的 action 属性和可选的 delay 属性，前者用于控制 Windows SCM 将采取的行动，后者用于控制采取该行动前的延迟时间。action 的合法值为

- restart：重新启动服务

- reboot：重新启动 Windows。将显示带有 [CRITICAL_PROCESS_DIED](https://docs.microsoft.com/windows-hardware/drivers/debugger/bug-check-0xef--critical-process-died) 错误检查代码的蓝色屏幕

- none：不执行任何操作，让服务停止延迟属性的可能后缀为秒/秒/分钟/分钟/小时/小时/天/天。如果缺少，延迟属性默认为 0。

延迟属性的后缀可能是秒/秒/分/分/小时/小时/天/天。如果缺少，延迟属性默认为 0。

如果服务不断发生故障，并且超过了配置的 `<onfailure> `次数，则会重复上次的操作。因此，如果只想始终自动重启服务，只需像这样指定一个 `<onfailure>` 元素即可：

```xml
<onfailure action="restart" />
```

### resetfailure

此可选元素控制 Windows SCM 重置故障计数的时间。例如，如果您指定 <resetfailure>1 小时</resetfailure>，而服务持续运行的时间超过一小时，那么故障计数将重置为零。

换句话说，这是您认为服务成功运行的持续时间。默认为 1 天。

```xml
<resetfailure>1 hour</resetfailure>
```

### Security descriptor

SDDL 格式的服务安全描述符字符串。

有关详细信息，请参阅[安全描述符定义语言](https://learn.microsoft.com/zh-cn/windows/win32/secauthz/security-descriptor-definition-language)。

```xml
<securityDescriptor></securityDescriptor>
```

### Service account

服务默认安装为 [LocalSystem 账户](https://docs.microsoft.com/windows/win32/services/localsystem-account)。如果您的服务不需要很高的权限级别，可以考虑使用 [LocalService 账户](https://docs.microsoft.com/windows/win32/services/localservice-account)、[NetworkService 帐户](https://docs.microsoft.com/windows/win32/services/networkservice-account)或用户账户。

要使用用户账户，请像这样指定 `<serviceaccount>` 元素：

```xml
<serviceaccount>
  <username>DomainName\UserName</username>
  <password>Pa55w0rd</password>
  <allowservicelogon>true</allowservicelogon>
</serviceaccount>
```

`<username> `的格式为 DomainName\UserName 或 UserName@DomainName。如果账户属于内置域，则可以指定 .\UserName。

`<allowservicelogon>` 是可选项。如果设置为 true，将自动为列出的账户设置 "允许以服务身份登录 "的权限。

要使用[Group Managed Service Accounts Overview](https://docs.microsoft.com/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview)，请在账户名后追加 $ 并删除 `<password>` 元素：

```xml
<serviceaccount>
  <username>DomainName\GmsaUserName$</username>
  <allowservicelogon>true</allowservicelogon>
</serviceaccount>
```

#### LocalSystem account

要明确使用[LocalSystem 帐户](https://docs.microsoft.com/windows/win32/services/localsystem-account) ，请指定以下内容：

```xml
<serviceaccount>
  <username>LocalSystem</username>
</serviceaccount>
```

请注意，该账户没有密码，因此提供的任何密码都将被忽略。

#### LocalService account

要使用 [LocalService 帐户](https://docs.microsoft.com/windows/win32/services/localservice-account)，请指定以下内容：

```xml
<serviceaccount>
  <username>NT AUTHORITY\LocalService</username>
</serviceaccount>
```

请注意，该账户没有密码，因此提供的任何密码都将被忽略。

#### NetworkService account

要使用 [NetworkService 帐户](https://docs.microsoft.com/windows/win32/services/networkservice-account)，请指定以下内容：

```xml
<serviceaccount>
  <username>NT AUTHORITY\NetworkService</username>
</serviceaccount>
```

请注意，该账户没有密码，因此提供的任何密码都将被忽略。

#### prompt

可选。提示输入用户名和密码。

```xml
<serviceaccount>
  <prompt>dialog|console</prompt>
</serviceaccount>
```

- 话框：使用对话框进行提示。

- 控制台：在控制台进行提示。

### Working directory

某些服务在运行时需要指定工作目录。为此，请像这样指定` <workingdirectory> `元素：

```xml
<workingdirectory>C:\application</workingdirectory>
```

### Priority

可选择指定服务进程的调度优先级（相当于 Unix nice），可选值包括`idle`, `belownormal`, `normal`, `abovenormal`, `high`, `realtime`（不区分大小写）。

```xml
<priority>idle</priority>
```

指定高于正常值的优先级会产生意想不到的后果。有关详细信息，请参阅 .NET 文档中的 [ProcessPriorityClass 枚举](https://docs.microsoft.com/dotnet/api/system.diagnostics.processpriorityclass)。此功能的主要目的是以较低的优先级启动进程，以免干扰计算机的交互式使用。

### Auto refresh

```xml
<autoRefresh>true</autoRefresh>
```

当服务启动或执行以下命令时，自动刷新服务属性：

- start
- stop
- restart

默认值为 true。

### sharedDirectoryMapping

默认情况下，即使在 Windows 服务配置文件中进行了配置，Windows 也不会为服务建立共享驱动器映射。由于域策略的原因，有时无法解决这个问题。

这样就可以在启动可执行文件之前映射外部共享目录。

```xml
<sharedDirectoryMapping>
  <map label="N:" uncpath="\\UNC" />
  <map label="M:" uncpath="\\UNC2" />
</sharedDirectoryMapping>
```