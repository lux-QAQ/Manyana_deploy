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
clear
cd $CURRENT_DIR/Manyana/
source $HOME/miniconda/bin/activate qqbot
python setUp.py | tee $CURRENT_DIR/start/update_log.txt