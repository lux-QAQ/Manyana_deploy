#!/bin/bash
detect_package_manager() {
    if command -v apt &> /dev/null; then
        echo "apt"
        elif command -v yum &> /dev/null; then
        echo "yum"
    else
        echo "none"
    fi
}

# 获取当前文件夹路径
CURRENT_DIR=$(pwd)
echo -e "\033[33m当前文件夹路径: $CURRENT_DIR\033[0m"

# 检查 Manyana 文件夹是否存在
MANYANA_DIR="$CURRENT_DIR/Manyana"
if [ ! -d "$MANYANA_DIR" ]; then
    echo -e "\033[31mManyana 文件夹不存在，请检查脚本放置的路径！\033[0m"
    exit 1
fi

# 检查 NapCat 文件夹是否存在
NAPCAT_DIR="$CURRENT_DIR/NapCat"
if [ ! -d "$NAPCAT_DIR" ]; then
    echo -e "\033[31mNapCat 文件夹不存在，请检查脚本放置的路径！\033[0m"
    exit 1
fi

# 继续执行剩余的脚本内容
if [ "$package_manager" = "apt" ];then
    sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt install -qq -y libgbm1 libasound2 libgtk-3-0 libnotify4 libxss1 libxtst6 xdg-utils libatspi2.0-0 libsecret-1-0 wget unrar screen git openjdk-17-jdk unzip ffmpeg dialog
else
    sudo yum install -q -y epel-release wget unrar screen git java-17-openjdk java-17-openjdk-devel unzip xdg-utils mesa-libgbm alsa-lib gtk3 libnotify libXScrnSaver libXtst at-spi2-core libsecret ffmpeg dialog
fi
# 创建start文件夹
START_DIR="$CURRENT_DIR/start"
sudo rm -rf $START_DIR
mkdir -p $START_DIR/direct
echo -e "\033[32m创建start文件夹: $START_DIR\033[0m\n"

# 创建1_napcat.sh脚本
cat > $START_DIR/direct/1_napcat.sh <<EOL
#!/bin/bash
source $HOME/miniconda/bin/activate qqbot
rm $START_DIR/napcat_log.txt
cd $CURRENT_DIR/NapCat/
bash $CURRENT_DIR/NapCat/napcat.sh >> $START_DIR/napcat_log.txt 2>&1
EOL
chmod +x $START_DIR/direct/1_napcat.sh
echo -e "\033[32m创建脚本: $START_DIR/direct/1_napcat.sh\033[0m\n"

# 创建2_overflow.sh脚本
cat > $START_DIR/direct/2_overflow.sh <<EOL
#!/bin/bash
source $HOME/miniconda/bin/activate qqbot
cd $CURRENT_DIR/ManyanaLauncher/overflow/
bash $CURRENT_DIR/ManyanaLauncher/overflow/start.sh >> $START_DIR/overflow_log.txt 2>&1
EOL
chmod +x $START_DIR/direct/2_overflow.sh
echo -e "\033[32m创建脚本: $START_DIR/direct/2_overflow.sh\033[0m\n"

# 创建3_Manyana.sh脚本
cat > $START_DIR/direct/3_Manyana.sh <<EOL
#!/bin/bash
source $HOME/miniconda/bin/activate qqbot
cd $CURRENT_DIR/Manyana/
python $CURRENT_DIR/Manyana/main.py >> $START_DIR/manyana_log.txt 2>&1
EOL
chmod +x $START_DIR/direct/3_Manyana.sh
echo -e "\033[32m创建脚本: $START_DIR/direct/3_Manyana.sh\033[0m\n"

# 创建1_napcat_withoutgui.sh脚本
cat > $START_DIR/1_napcat_withoutgui.sh <<EOL
#!/bin/bash
echo -e "\033[31m请勿试图切换到screen窗口，否则可能导致进程关闭，如果扫码登录机器人，请直接cat overflow_log.txt日志\033[0m"
screen -S napcat -d -m $START_DIR/direct/1_napcat.sh
EOL
chmod +x $START_DIR/1_napcat_withoutgui.sh
echo -e "\033[32m创建脚本: $START_DIR/1_napcat_withoutgui.sh\033[0m\n"

# 创建2_overflow_withoutgui.sh脚本
cat > $START_DIR/2_overflow_withoutgui.sh <<EOL
#!/bin/bash
echo -e "\033[31m请5s左右再启动Manyana，你可以cat overflow_log.txt来检查overflow是否启动成功，不要试图切换到screen窗口，否则可能导致进程关闭，如果要查询进程情况，请直接cat对应日志\033[0m"
screen -S overflow -d -m $START_DIR/direct/2_overflow.sh
EOL
chmod +x $START_DIR/2_overflow_withoutgui.sh
echo -e "\033[32m创建脚本: $START_DIR/2_overflow_withoutgui.sh\033[0m\n"

# 创建3_Manyana_withoutgui.sh脚本
cat > $START_DIR/3_Manyana_withoutgui.sh <<EOL
#!/bin/bash
echo -e "\033[31m请勿试图切换到screen窗口，否则可能导致进程关闭，如果要查询进程情况，请直接cat对应日志\033[0m"
screen -S Manyana -d -m $START_DIR/direct/3_Manyana.sh
EOL
chmod +x $START_DIR/3_Manyana_withoutgui.sh
echo -e "\033[32m创建脚本: $START_DIR/3_Manyana_withoutgui.sh\033[0m\n"

curl -o $START_DIR/gui.sh https://gitee.com/laixi_lingdun/Manyana_deploy/raw/main/gui.sh 
curl -o $START_DIR/init.sh https://gitee.com/laixi_lingdun/Manyana_deploy/raw/main/init.sh
curl -o $START_DIR/update.sh https://gitee.com/laixi_lingdun/Manyana_deploy/raw/main/update.sh

chmod  777 -R $CURRENT_DIR
echo -e "\n\n\n\033[32m修补完毕，请仔细阅读以下内容：\033[0m"
echo -e "\033[31m-------------------------------------------------------------------------------------------------\n\033[0m"
echo -e "\033[33m请执行 bash $START_DIR/init.sh 来初始化机器人（如果你以前已经成功运行过机器人，可以跳过这个步骤）\033[0m"
echo -e "\033[33m请执行 bash $START_DIR/gui.sh 来启动和管理机器人\033[0m"
echo -e "\033[33m机器人其他详细配置请参见$CURRENT_DIR/Manyana/config/中的配置文件所含注释（预计以后会出GUI管理界面）\033[0m"
echo -e "\033[31m-------------------------------------------------------------------------------------------------\n\033[0m"
echo -e "\e[3;4;38;5;46;48;5;95m求求各位给个star\e[0m"
echo -e "\033[32m自动化安装脚本:https://github.com/lux-QAQ/Manyana_deploy\033[0m"
echo "机器人实现：https://github.com/avilliai/Manyana"
echo -e "\033[33m如有疑问欢迎加Q群\033[0m ： \033[42m628763673\033[0m"
echo -e "\033[32m-------------------------------------------------------------------------------------------------\n\033[0m"
echo -e "\033[32m修补执行完毕\n\033[0m"
