#!/bin/bash
CURRENT_DIR=$(pwd)/..
# 检查是否存在config.json文件
CONFIG_FILE="$CURRENT_DIR/Manyana/config.json"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "config.json 文件不存在！"
    exit 1
fi
# 获取当前目录
# 提示用户输入机器人的名字
BOT_NAME=$(dialog --no-lines --inputbox "请输入机器人的名字：" 10 50 3>&1 1>&2 2>&3)
# 提示用户输入机器人的QQ号码
BOT_QQ=$(dialog --no-lines --inputbox "请输入机器人的QQ号码：" 10 50 3>&1 1>&2 2>&3)
# 提示用户输入机器人主人的QQ号码
MASTER_QQ=$(dialog --no-lines --inputbox "请输入机器人主人的QQ号码：" 10 50 3>&1 1>&2 2>&3)
# 提示用户输入主要的QQ群
MAIN_GROUP=$(dialog --no-lines --inputbox "请输入主要的QQ群：" 10 50 3>&1 1>&2 2>&3)
# 更新config.json文件
sudo rm $CURRENT_DIR/Manyana/config.json
cat > $CONFIG_FILE <<EOL
{"botName": "$BOT_NAME", "botQQ": "$BOT_QQ", "master": "$MASTER_QQ","mainGroup": "$MAIN_GROUP", "vertify_key": "1234567890", "port": "23456"}
EOL
chmod 777 $CONFIG_FILE
# 复制napcat.json和onebot11.json到对应的文件名
cp "$CURRENT_DIR/NapCat/config/napcat.json" "$CURRENT_DIR/NapCat/config/napcat_$BOT_QQ.json"
cp "$CURRENT_DIR/NapCat/config/onebot11.json" "$CURRENT_DIR/NapCat/config/onebot11_$BOT_QQ.json"
# 显示完成消息
dialog --no-lines --msgbox "\n配置已更新并复制配置文件" 10 50
clear
