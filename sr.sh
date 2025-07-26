#!/system/bin/sh
# 定义链接数组
urls="
https://mzsy123.github.io/HideOne_v2.6b.zip
"

# 定义统一保存目录
outdir="/data/local/tmp"

# 提取文件名（共用下载和清理）
for url in $urls; do
  files="$files $(basename "$url")"
done

# 执行下载
echo "- 开始下载最新HideOne模块"
for url in $urls; do
  fname=$(basename "$url")
  busybox wget "$url" -O "$outdir/$fname" 2>&1 | busybox awk -v f="$fname" '
  /%/ {
    for (i=1; i<=NF; i++)
      if ($i ~ /%$/) p=$i
    if (p) print f, p
    fflush()
  }'
done
echo "- $fname模块下载结束"
sleep 1

while true
do
    echo ""
    echo "- 请选择HideOne123刷入模式:"
    echo "1.Magisk系列刷入模式(支持官方及Alpha版本)"
    echo "2.KSU系列刷入模式(支持官方KSU、KSU Next、SukiSU)"
    echo "3.APatch系列刷入模式(支持官方及AP Next版本)"
    echo ""
    echo "- 温馨提示:目前不推荐AP用户刷入因为其隐藏模块可能无法做到最佳隐藏效果"
    echo "- 无需担心选择错误，选错了会执行失败退出的"
    echo ""
    echo "- 请输入数字 (1/2/3)，输入 q/Q 即可退出喵~"
    read choice

    case "$choice" in
        1)
            {
                echo "- 即将执行Magisk刷入模式 喵~"
                sleep 1
                magisk --install-module "$outdir/$fname"
                exit
            }
            ;;
        2)
            {
                echo "- 即将执行KSU刷入模式 喵~"
                sleep 1
                ksud module install "$outdir/$fname"
                exit
            }
            ;;
        3)
            {
                echo "- 即将执行APatch刷入模式 喵~"
                sleep 1
                apd module install "$outdir/$fname"
                exit
            }
            ;;
        q|Q)
            echo "- 喵~脚本结束了喵~ฅ^•ﻌ•^ฅ"
                for fname in $files; do
                  rm -f "$outdir/$fname"
                sleep 1
                done
            break
            ;;
        *)
            echo "- 喵呜~无效输入，请输入 1、2、3或 q/Q 退出哦~"
            ;;
    esac
    echo "" # 空行分隔方便阅读喵~
done