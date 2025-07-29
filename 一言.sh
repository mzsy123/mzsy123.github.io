#!/bin/bash
clear
# 定义要获取数据的网络地址（示例：获取公开测试接口的IP信息）
NETWORK_URL="https://v1.jinrishici.com/all.txt"

# 从网络获取数据（使用curl，-s静默模式，-f失败时不输出错误）
# 将结果存入变量 NETWORK_DATA
NETWORK_DATA=$(curl -s -f "$NETWORK_URL")

# 判断是否获取成功（若变量为空，说明失败）
if [ -z "$NETWORK_DATA" ]; then
  echo "- 网络无法连接"
  exit 1  # 退出并返回错误码
fi

# 输出获取到的变量内容
echo "- 一言："
echo "- $NETWORK_DATA"
