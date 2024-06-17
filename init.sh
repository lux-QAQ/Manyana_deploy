#!/bin/bash
# 尝试解析符号链接获取实际路径
if command -v readlink &> /dev/null; then
    script_path=$(readlink -f "$0")
elif command -v realpath &> /dev/null; then
    script_path=$(realpath "$0")
else
    # 不支持 readlink 或 realpath 的情况
    script_path=$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")
fi

START_DIR=$(dirname "$script_path")
CURRENT_DIR=$(cd "$script_dir/.."; pwd)
# 检查是否存在config.json文件
CONFIG_FILE="$CURRENT_DIR/Manyana/config.json"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "config.json 文件不存在！"
    exit 1
fi
# 提示用户输入机器人的名字
BOT_NAME=$(dialog --no-lines --inputbox "请输入机器人的名字：" 10 50 3>&1 1>&2 2>&3)
if [ $? -ne 0 ] || [ -z "$BOT_NAME" ]; then
    clear
    echo "机器人名字不能为空，或者取消了输入"
    exit 1
fi

# 提示用户输入机器人的QQ号码
BOT_QQ=$(dialog --no-lines --inputbox "请输入机器人的QQ号码：" 10 50 3>&1 1>&2 2>&3)
if [ $? -ne 0 ] || [ -z "$BOT_QQ" ]; then
    clear
    echo "机器人QQ号码不能为空，或者取消了输入"
    exit 1
fi

# 提示用户输入机器人主人的QQ号码
MASTER_QQ=$(dialog --no-lines --inputbox "请输入机器人主人的QQ号码：" 10 50 3>&1 1>&2 2>&3)
if [ $? -ne 0 ] || [ -z "$MASTER_QQ" ]; then
    clear
    echo "机器人主人的QQ号码不能为空，或者取消了输入"
    exit 1
fi

# 提示用户输入主要的QQ群
MAIN_GROUP=$(dialog --no-lines --inputbox "请输入主要的QQ群：" 10 50 3>&1 1>&2 2>&3)
if [ $? -ne 0 ] || [ -z "$MAIN_GROUP" ]; then
    clear
    echo "主要的QQ群不能为空，或者取消了输入"
    exit 1
fi
# 更新config.json文件
sudo rm $CURRENT_DIR/Manyana/config.json
cat > $CONFIG_FILE <<EOL
{"botName": "$BOT_NAME", "botQQ": "$BOT_QQ", "master": "$MASTER_QQ","mainGroup": "$MAIN_GROUP", "vertify_key": "1234567890", "port": "23456"}
EOL
chmod 777 $CONFIG_FILE
# 复制napcat.json和onebot11.json到对应的文件名
cp "$CURRENT_DIR/NapCat/config/napcat.json" "$CURRENT_DIR/NapCat/config/napcat_$BOT_QQ.json"
cat > $CURRENT_DIR/NapCat/config/onebot11_$BOT_QQ.json <<EOL
{
  "http": {
    "enable": false,
    "host": "",
    "port": 3000,
    "secret": "",
    "enableHeart": false,
    "enablePost": false,
    "postUrls": []
  },
  "ws": {
    "enable": true,
    "host": "",
    "port": 3001
  },
  "reverseWs": {
    "enable": false,
    "urls": []
  },
  "debug": false,
  "heartInterval": 30000,
  "messagePostFormat": "array",
  "enableLocalFile2Url": true,
  "musicSignUrl": "",
  "reportSelfMessage": false,
  "token": "",
  "GroupLocalTime": {
    "Record": false,
    "RecordList": []
  }
}
EOL
chmod 777 $CURRENT_DIR/NapCat/config/onebot11_$BOT_QQ.json
# 显示完成消息
dialog --no-lines --msgbox "\n初始化已经完成，如果需要修改机器人QQ号之类的，可以再次运行此脚本" 10 50
clear