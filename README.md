# Youtube下载器，使用PowerShell打开
## 一、简介
本项目基于 [**yt-dlp**](https://github.com/yt-dlp/yt-dlp)，选择了几个常用的命令进行封装，主要功能为**youtube音视频和字幕下载**，其中音视频可以在不登录的情况下，下载最高画质，如4k等，字幕下载可以下载自动翻译的字幕。相比原项目更易使用。
## 二、使用前
### 1.安装yt-dlp与ffmpeg
安装与配置可参考 [yt-dlp安装和使用（以Windows为例）](https://blog.csdn.net/euqlll/article/details/126905973)

确保添加环境变量，可直接在powershell中输入yt-dlp、ffmpeg访问。
```
(base) PS D:\Files\Youtube> yt-dlp

Usage: yt-dlp.exe [OPTIONS] URL [URL...]

yt-dlp.exe: error: You must provide at least one URL.
Type yt-dlp --help to see a list of all options.
````
```
(base) PS D:\Files\Youtube> ffmpeg
ffmpeg version 2023-10-26-git-2b300eb533-full_build-www.gyan.dev Copyright (c) 2000-2023 the FFmpeg developers
  built with gcc 12.2.0 (Rev10, Built by MSYS2 project)
  ······
````
### 2. 启用PowerShell脚本
由于Windows PowerShell的默认执行策略受到限制，因此我们无法运行任何脚本，除非对脚本进行更改。 在PowerShell中使用以下命令将执行策略设置为``Unrestricted``以执行脚本。
```
Set-ExecutionPolicy Unrestricted
````
### 3. 确保可以访问Youtube
本脚本不提供任何VPN服务，请确保你本人可以访问Youtube网站再使用。

## 三、使用
### 1.默认配置
-目前基于本人习惯，将默认下载配置设为了``最高画质+缩略图+视频描述``，其中视频为选择最高质量的视频和音频并使用ffmpeg组合而成，并删除原始视频音频文件仅保留拼接视频

-下载地址默认为``'D:/Files/Youtube/%(title)s/%(title)s.%(ext)s'``,其中，title是youtube视频的标题，ext是下载的文件格式，默认该url下所有下载的文件都放在同一个文件夹中，如果文件夹不存在会自动创建文件夹。

-同时使用了``--restrict-filenames``参数，减少文件名中的空格可能会导致的bug,空格将会被替换为'_'，如``I love you``会被替换为``I_love_you``。文档中描述如下：
>Restrict filenames to only ASCII characters,and avoid "&" and spaces in filenames
>
>将文件名限制为ASCII字符，避免文件名中出现"&"和空格


-字幕格式选择了``srt``，也可自行在代码最上方更改：```$sub_fromat = 'srt'```

-默认将视频元信息嵌入视频，如视频地址，发布时间等。

-默认使用8线程下载``$download_thread = 8``

### 2.使用示例
>所选视频为随机选择仅为示范，不代表本人任何观点

#### 默认下载
<img src=img\默认下载.png  width=80% />

#### 显示可下载内容
<img src=img\显示可下载内容.png  width=80% />

#### 下载结果
<img src=img\下载结果.png  width=80% />



