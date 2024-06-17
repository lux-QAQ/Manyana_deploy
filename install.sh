#!/bin/bash

# 安装 tmux
sudo apt-get update
sudo apt-get install -y tmux wget
echo -e "\033[32m将使用tmux运行安装过程，防止ssh断开或者意外原因导致安装中断\033[0m"
echo -e "\033[32m安装过程的日志保存到了install_log.txt\033[0m"
sleep 1
# 确保安装脚本具有执行权限
wget https://gitee.com/laixi_lingdun/Manyana_deploy/raw/main/install_payload.sh -O install_program.sh
chmod +x install_program.sh

# 使用 tmux 运行安装脚本并重定向输出到日志文件
tmux new-session  -s install 'bash install_program.sh | tee install_log.txt'


