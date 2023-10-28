# 创建一个无限循环，允许用户多次执行操作
$videoURL=''
while ($true) {
    if ($videoURL -eq ''){
    # 提示用户输入视频 URL
    $videoURL = Read-Host "请输入要下载的视频 URL"
    }

    # 提示用户选择要下载的内容类型
    $choice = Read-Host "请选择要下载的内容ID:`n1. 视频`n2. 字幕`n3. 退出"

    # 如果用户选择退出，跳出循环
    if ($choice -eq '3') {
        break
    }

    # 提示用户选择视频保存的位置
    $videoSaveLocation = Read-Host "请输入视频保存位置 (直接回车使用默认位置: 'D:/Files/Youtube/%(title)s/%(title)s.%(ext)s')"
    if ([string]::IsNullOrWhiteSpace($videoSaveLocation)) {
        $videoSaveLocation = 'D:/Files/Youtube/%(title)s/%(title)s.%(ext)s'
    }

    if ($choice -eq '1') {
        # 提示用户选择视频质量
        $formatChoice = Read-Host "请选择视频质量:`n1. 默认配置（最高画质+缩略图+视频描述）`n2.最高质量`n3. 指定质量"
        if ($formatChoice -eq '1') {
            yt-dlp -N 8 -f 'bv[ext=mp4]+ba[ext=m4a]' $videoURL --write-thumbnail --write-description  --embed-metadata --merge-output-format mp4 -o $videoSaveLocation --restrict-filenames
        } elseif ($formatChoice -eq '2') {
            yt-dlp -N 8 -f 'bv[ext=mp4]+ba[ext=m4a]' $videoURL --embed-metadata --merge-output-format mp4 -o $videoSaveLocation --restrict-filenames
        } elseif ($formatChoice -eq '3') {
            # 列出视频的可下载内容
            Write-Host "以下是视频的可下载内容："
            yt-dlp -F $videoURL
            $itemNum = Read-Host "请输入所需的视频内容序号,如 76"
            yt-dlp -N 8 -f $itemNum $videoURL --write-thumbnail --embed-metadata -o $videoSaveLocation --restrict-filenames
        }
    } elseif ($choice -eq '2') {
        $subLangChoice = Read-Host "请选择字幕语言:`n1. 中文`n2. 英文`n3. 其他"
        if ($subLangChoice -eq '1') {
            yt-dlp --sub-langs zh-Hans --write-auto-subs --convert-subs srt $videoURL -o $videoSaveLocation --restrict-filenames
        } elseif ($subLangChoice -eq '2') {
            yt-dlp --sub-langs en --write-auto-subs --convert-subs srt $videoURL -o $videoSaveLocation --restrict-filenames
        } elseif ($subLangChoice -eq '3') {
            Write-Host "以下是视频的可下载字幕："
            yt-dlp --list-subs $videoURL
            $subChoice = Read-Host "请选择要下载的字幕的 Language 名称，如 zh "
            yt-dlp --sub-langs $subChoice --write-auto-subs --convert-subs srt $videoURL -o $videoSaveLocation --restrict-filenames
        }
    }

    # 提示用户是否要继续或退出
    $continueChoice = Read-Host "是否继续下载或退出:`n1. 同url继续`n2. 更改url继续`n3. 退出"
    if ($continueChoice -eq '2') {
        $videoURL=''
    }
    if ($continueChoice -eq '3') {
        break
    }
}
