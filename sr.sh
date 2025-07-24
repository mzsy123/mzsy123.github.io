#!/system/bin/sh

while true
do
    echo ""
    echo "- HideOne123刷入选择:"
    echo "1.Magisk系列刷入模式(支持官方及Alpha版本)"
    echo "2.KSU系列刷入模式(支持官方KSU、KSU Next、SukiSU)"
    echo "3.APatch系列刷入模式(支持官方及AP Next版本)"
    echo ""
    echo "温馨提示:目前不推荐AP用户刷入因为其隐藏模块可能无法做到最佳隐藏效果"
    echo "无需担心选择错误，选错了会执行失败退出的"
    echo ""
    echo "请输入数字 (1/2/3)，输入 q/Q 即可退出喵~"
    read choice

    case "$choice" in
        1)
            {
                echo "即将执行Magisk刷入模式 喵~"
                sleep 1
                # magisk --install-module "/storage/emulated/0/Download/840/testapp_v1.2.zip"
                magisk --install-module "/data/local/tmp/HideOne123.zip"
                exit
            }
            ;;
        2)
            {
                echo "即将执行KSU刷入模式 喵~"
                sleep 1
                # ksud module install "/storage/emulated/0/Download/840/testapp_v1.2.zip"
                ksud module install "/data/local/tmp/HideOne123.zip"
                exit
            }
            ;;
        3)
            {
                echo "即将执行APatch刷入模式 喵~"
                sleep 1
                # ap module install "/storage/emulated/0/Download/840/testapp_v1.2.zip"
                ap module install "/data/local/tmp/HideOne123.zip"
                exit
            }
            ;;
        q|Q)
            echo "喵~脚本结束了喵~ฅ^•ﻌ•^ฅ"
            break
            ;;
        *)
            echo "喵呜~无效输入，请输入 1、2、3或 q/Q 退出哦~"
            ;;
    esac
    echo "" # 空行分隔方便阅读喵~
done