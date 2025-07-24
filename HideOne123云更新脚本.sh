if [ `whoami` = "root" ]; then
    echo "- 开始下载"
    echo "- Ps:因为用的github所以下载过程可能需要使用魔法"
    # busybox wget "https://mzsy123.github.io/core.sh" -O /data/local/tmp/core.sh 2>/dev/null
    busybox wget "https://mzsy123.github.io/sr.sh" -O "/data/local/tmp/sr.sh" 2>&1 | busybox awk '
    /%/ {
      for (i=1; i<=NF; i++) {
        if ($i ~ /^[^[:space:]]+\.[a-z0-9]{1,4}$/) f=$i
        if ($i ~ /%$/) p=$i
      }
      if (f && p) print f, p
      fflush()
    }'
    busybox wget "https://mzsy123.github.io/HideOne123.zip" -O "/data/local/tmp/HideOne123.zip" 2>&1 | busybox awk '
    /%/ {
      for (i=1; i<=NF; i++) {
        if ($i ~ /^[^[:space:]]+\.[a-z0-9]{1,4}$/) f=$i
        if ($i ~ /%$/) p=$i
      }
      if (f && p) print f, p
      fflush()
    }'
    sleep 1
    echo "- 核心文件下载完成"
    echo "- 正在执行核心程序"
    sh /data/local/tmp/sr.sh
    sleep 1
    echo "- 执行结束"
    sleep 0.5
    echo "- 正在清理缓存"
    rm -rf /data/local/tmp/sr.sh
    rm -rf /data/local/tmp/HideOne123.zip
    sleep 1
    echo "- 清理完成"
else
    echo "- 请以root权限执行！"
    exit
fi
