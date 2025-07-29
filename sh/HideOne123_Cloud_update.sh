if [ `whoami` = "root" ]; then
    echo "- 开始下载"
    echo "- Ps:因为用的github所以下载过程可能需要使用魔法"
    # 定义链接数组
    urls="https://mzsy123.github.io/sh/sr_gpt.sh"# 默认为GPT优化版本可改为sr.sh为普通版

    # 定义统一保存目录
    outdir="/data/local/tmp"
    
    # 提取文件名（共用下载和清理）
    for url in $urls; do
      files="$files $(basename "$url")"
    done

    # 执行下载
    for url in $urls; do
      fname=$(basename "$url")
      busybox wget "$url" -O "$outdir/$fname" 2>&1 | busybox awk -v f="- $fname" '
      /%/ {
        for (i=1; i<=NF; i++)
          if ($i ~ /%$/) p=$i
        if (p) print f, p
        fflush()
      }'
    done
    sleep 0.3
    echo "- $fname核心文件下载结束"
    if [ -e "!$outdir/$fname" ]; then
        echo "- $fname文件不存在"
    fi
    echo "- 正在执行核心程序"
    sh "$outdir/$fname"
    sleep 1
    echo "- 执行结束"
    sleep 0.5
    echo "- 正在清理缓存"
    for fname in $files; do
      rm -f "$outdir/$fname"
    done
    sleep 1
    echo "- 清理完成"
else
    echo "- 请以root权限执行！"
    exit
fi
