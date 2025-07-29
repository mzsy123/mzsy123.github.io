#!/system/bin/sh

print_hideone() {
cat << "EOF"
  _    _ _     _       ____             
 | |  | (_)   | |     / __ \            
 | |__| |_  __| | ___| |  | |_ __   ___ 
 |  __  | |/ _` |/ _ \ |  | | '_ \ / _ \
 | |  | | | (_| |  __/ |__| | | | |  __/
 |_|  |_|_|\__,_|\___|\____/|_| |_|\___|
                                        
                                        
EOF
}

# 设置仓库变量
USER="mzsy123"
REPO="HideOne123"
ASSET_EXT=".zip"

# 定义链接数组
echo "- 正在获取最新发行版地址"

# 自动选择 curl/wget/busybox wget 获取 release JSON
if command -v curl >/dev/null 2>&1; then
    JSON=$(curl -s "https://api.github.com/repos/$USER/$REPO/releases/latest")
elif command -v wget >/dev/null 2>&1; then
    JSON=$(wget -qO- "https://api.github.com/repos/$USER/$REPO/releases/latest")
elif command -v busybox >/dev/null 2>&1 && busybox wget --help >/dev/null 2>&1; then
    JSON=$(busybox wget -qO- "https://api.github.com/repos/$USER/$REPO/releases/latest")
else
    echo "- 喵呜~无法获取 JSON，curl/wget 都不可用！"
    exit 1
fi

# 解析下载链接
NEW_URL=$(echo "$JSON" | grep "browser_download_url" | cut -d '"' -f 4 | grep "$ASSET_EXT")

echo "- 获取完成惹~"
sleep 0.3

# 定义统一保存目录
outdir="/data/local/tmp"

# 提取文件名（共用下载和清理）
files=""
for url in $NEW_URL; do
  files="$files $(basename "$url")"
done

# 执行下载
echo "- 开始下载最新HideOne模块"
for url in $NEW_URL; do
  fname=$(basename "$url")
  busybox wget "$url" -O "$outdir/$fname" 2>&1 | busybox awk -v f="- $fname" '
  /%/ {
    for (i=1; i<=NF; i++)
      if ($i ~ /%$/) p=$i
    if (p) print f, p
    fflush()
  }'
done
echo "- $fname模块下载结束惹 喵~"
sleep 1
clear

while true
do
    # echo ""
    echo "- 请选择$fname刷入模式:"
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
                clear
                print_hideone
                echo "- 即将执行Magisk刷入模式 喵~"
                sleep 1
                magisk --install-module "$outdir/$fname"
                for fname in $files; do
                  rm -f "$outdir/$fname"
                  sleep 1
                done
                exit
            }
            ;;
        2)
            {
                clear
                print_hideone
                echo "- 即将执行KSU刷入模式 喵~"
                sleep 1
                ksud module install "$outdir/$fname"
                for fname in $files; do
                  rm -f "$outdir/$fname"
                  sleep 1
                done
                exit
            }
            ;;
        3)
            {
                clear
                print_hideone
                echo "- 即将执行APatch刷入模式 喵~"
                sleep 1
                apd module install "$outdir/$fname"
                for fname in $files; do
                  rm -f "$outdir/$fname"
                  sleep 1
                done
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