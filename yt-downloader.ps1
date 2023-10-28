# ����һ������ѭ���������û����ִ�в���
$videoURL=''
$defultLocation='D:/Files/Youtube/%(title)s/%(title)s.%(ext)s'
$restrict_filenames = '--restrict-filenames'
$sub_fromat = 'srt'
$download_thread = 8
while ($true) {
    if ($videoURL -eq ''){
        # ��ʾ�û�������Ƶ URL
        $videoURL = Read-Host "������Ҫ���ص���Ƶ URL"
    }

    # ��ʾ�û�ѡ��Ҫ���ص���������
    $choice = Read-Host "��ѡ��Ҫ���ص�����ID:`n0. Ĭ������(��߻���+����ͼ+��Ƶ����)`n1. ��Ƶ`n2. ��Ļ`n3. �˳�`n9. ������һ��"

    # ����û�ѡ���˳�������ѭ��
    if ($choice -eq '3') {
        break
    }

    # ����û�ѡ�񷵻���һ���������Ƶ URL ����������
    if ($choice -eq '9') {
        $videoURL = ''
        continue
    }

    # ��ʾ�û�ѡ����Ƶ�����λ��
    $videoSaveLocation = Read-Host "�������ļ�����λ�� (ֱ�ӻس�ʹ��Ĭ��λ��: $defultLocation)"
    if ([string]::IsNullOrWhiteSpace($videoSaveLocation)) {
        $videoSaveLocation = $defultLocation
    }
    
    if ($choice -eq '0') {
        # Ĭ������
        yt-dlp -N $download_thread -f 'bv[ext=mp4]+ba[ext=m4a]' $videoURL --write-thumbnail --write-description  --embed-metadata --merge-output-format mp4 -o $videoSaveLocation $restrict_filenames
        Write-Host "�������"
    } elseif ($choice -eq '1') {
        # ��ʾ�û�ѡ����Ƶ����
        $formatChoice = Read-Host "��ѡ����Ƶ����:`n1. Ĭ�����ã���߻���+����ͼ+��Ƶ������`n2. �������`n3. ָ������"
        if ($formatChoice -eq '1') {
            yt-dlp -N $download_thread -f 'bv[ext=mp4]+ba[ext=m4a]' $videoURL --write-thumbnail --write-description  --embed-metadata --merge-output-format mp4 -o $videoSaveLocation $restrict_filenames
        } elseif ($formatChoice -eq '2') {
            yt-dlp -N $download_thread -f 'bv[ext=mp4]+ba[ext=m4a]' $videoURL --embed-metadata --merge-output-format mp4 -o $videoSaveLocation $restrict_filenames
        } elseif ($formatChoice -eq '3') {
            # �г���Ƶ�Ŀ���������
            Write-Host "��������Ƶ�Ŀ��������ݣ�"
            yt-dlp -F $videoURL
            $itemNum = Read-Host "�������������Ƶ�������,�� 76"
            yt-dlp -N $download_thread -f $itemNum $videoURL --write-thumbnail --embed-metadata -o $videoSaveLocation $restrict_filenames
        }
    } elseif ($choice -eq '2') {
        $subLangChoice = Read-Host "��ѡ����Ļ����:`n1. ����`n2. Ӣ��`n3. ����"
        if ($subLangChoice -eq '1') {
            yt-dlp --skip-download --sub-langs zh-Hans --write-auto-subs --convert-subs $sub_fromat $videoURL -o $videoSaveLocation $restrict_filenames
        } elseif ($subLangChoice -eq '2') {
            yt-dlp --skip-download --sub-langs en --write-auto-subs --convert-subs $sub_fromat $videoURL -o $videoSaveLocation $restrict_filenames
        } elseif ($subLangChoice -eq '3') {
            Write-Host "��������Ƶ�Ŀ�������Ļ��"
            yt-dlp --list-subs $videoURL
            $subChoice = Read-Host "��ѡ��Ҫ���ص���Ļ�� Language ���ƣ��� zh "
            yt-dlp --skip-download --sub-langs $subChoice --write-auto-subs --convert-subs $sub_fromat $videoURL -o $videoSaveLocation $restrict_filenames
        }
    }

    # ��ʾ�û��Ƿ�Ҫ�������˳�
    $continueChoice = Read-Host "�������ػ��˳�:`n1. ͬurl����`n2. ����url����`n3. �˳�"
    if ($continueChoice -eq '2') {
        $videoURL = ''
    } elseif ($continueChoice -eq '3') {
        break
    }
}
