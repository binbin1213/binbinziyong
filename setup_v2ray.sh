#!/bin/sh

# =================================================================
# V2Ray 配置脚本 for Alpine Linux
# 功能:
# 1. 使用指定的UUID覆盖V2Ray配置文件。
# 2. 重启V2Ray服务使配置生效。
# 3. 检查V2Ray服务的运行状态。
# =================================================================

# --- 在这里定义你的UUID和端口 ---
UUID="7de5a053-7b39-709d-2a28-947721b30571"
PORT=10086
CONFIG_FILE="/etc/v2ray/config.json"
# ----------------------------------

echo "脚本开始执行..."

# 写入新的配置文件
echo "正在写入新的配置文件到 $CONFIG_FILE ..."
cat > $CONFIG_FILE << EOF
{
  "log": {
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "port": $PORT,
      "listen": "0.0.0.0",
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "$UUID",
            "alterId": 0
          }
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF

echo "✅ 配置文件写入成功！"
echo ""

# 重启V2Ray服务
echo "正在重启 V2Ray 服务以应用新配置..."
rc-service v2ray restart

echo "✅ 重启命令已发送。"
echo ""

# 检查服务状态
echo "正在检查 V2Ray 服务状态..."
rc-service v2ray status

echo ""
echo "🎉 脚本执行完毕！"
echo "请确保你的防火墙已经放行了 TCP 端口: $PORT"
