#!/bin/bash
clear
# 定义要获取数据的网络地址（示例：获取公开测试接口的IP信息）
VERSION_URL="https://mzsy123.github.io/vision"
VERSION="v1.0"

# 从网络获取数据（使用curl，-s静默模式，-f失败时不输出错误）
# 将结果存入变量 NETWORK_CLOUD
VERSION_CLOUD=$(curl -s -f "$VERSION_URL")

# 判断是否获取成功（若变量为空，说明失败）
if [ -z "$VERSION_CLOUD" ]; then
  echo "- 本地版本$VERSION"
  exit 1  # 退出并返回错误码
fi

# 输出获取到的变量内容
if [ "$VERSION" != "$VERSION_CLOUD" ]; then
  # 版本不同时，输出云端最新版本
  echo "- 版本检测："
  echo "- 本地版本$VERSION"
  echo "- 云端最新$VERSION_CLOUD 请尽快更新"
else
  # 版本相同时，输出本地版本（提示已为最新）
  echo "- 版本检测："
  echo "- 当前已是最新版本$VERSION"
fi