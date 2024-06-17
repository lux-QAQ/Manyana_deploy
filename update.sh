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
# 获取当前脚本所在的目录（绝对路径）
script_dir=$(dirname "$script_path")

# 获取父目录（绝对路径）
parent_dir=$(cd "$script_dir/.."; pwd)
START_DIR=$script_dir
CURRENT_DIR=$parent_dir
clear
cd $CURRENT_DIR/Manyana/
source $HOME/miniconda/bin/activate qqbot
python setUp.py | tee $CURRENT_DIR/start/update_log.txt