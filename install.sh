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

# 红色中文提示
echo -e "\033[31m本脚本固定了安装版本，如果你发现这个安装脚本太老了已经不能使用了请参照Manyana、Overflow、Napcatqq官方教程手动安装\033[0m"
echo -e "\033[31m本脚本仅适配了带有apt和yum的系统，其他系统请根据官方教程手动安装或者根据本脚本的逻辑自行安装\033[0m"
echo -e "\033[31m安装过程中如果提示需要输入yes或y 或者选择1 2 3，请输入合适的选项。\033[0m"
echo -e "\033[33m安装过程可能会持续20-60分钟，这取决于你的网速和处理器性能\033[0m"
echo -e "\033[33mlinux上部署肯定没有windows那么方便，但既然你选择了linux，那相信你有勇气和能力解决各种问题\033[0m"


# 等待用户确认
read -p "按回车键继续..."


# 克隆GitHub仓库
# 定义颜色
RED='\033[0;31m'
NC='\033[0m' # No Color

# 提示用户选择下载地址
echo -e "\n\033[32m选择Manyana下载地址\033[0m\n"
echo -e "${RED}提示：如果可以直连GitHub，网速较快，建议直接使用以下地址：${NC}"
echo "https://github.com/avilliai/Manyana.git"

echo "请选择下载地址："
echo -e "\033[33m1. 使用镜像地址 https://mirror.ghproxy.com/https://github.com/avilliai/Manyana.git\033[0m"
echo -e "\033[33m2. 使用备用地址 https://ghproxy.net/https://github.com/avilliai/Manyana.git\033[0m"
echo -e "\033[33m3. \033[0m\033[31m直接使用\033[0m\033[33mGitHub地址 https://github.com/avilliai/Manyana.git\033[0m"
echo -e "\033[33m4. 使用默认地址\033[0m(\033[32mgithub难以连接时推荐选这个\033[0m) \033[33mhttps://github.moeyy.xyz/https://github.com/avilliai/Manyana.git\033[0m"

read -t 10 -p "请输入选项 (1/2/3/4): " choice
if [ $? -ne 0 ]; then
    echo -e "\n${RED}倒计时结束，使用默认地址。${NC}"
    choice="4"
fi

# 根据用户选择设置下载地址
if [ "$choice" == "1" ]; then
    repo_url="https://mirror.ghproxy.com/https://github.com/avilliai/Manyana.git"
elif [ "$choice" == "2" ]; then
    repo_url="https://ghproxy.net/https://github.com/avilliai/Manyana.git"
elif [ "$choice" == "3" ]; then
    repo_url="https://github.com/avilliai/Manyana.git"
elif [ "$choice" == "4" ]; then
    repo_url="https://github.moeyy.xyz/https://github.com/avilliai/Manyana.git"
    use_wget=true
else
    echo -e "\033[31m无效的选项，使用默认地址。\033[0m"
    repo_url="https://github.moeyy.xyz/https://github.com/avilliai/Manyana.git"
    use_wget=true
fi


# 提示用户选择下载地址
echo -e "\n\033[32m选择Manyana启动器下载地址\033[0m\n"
echo -e "${RED}提示：如果可以直连GitHub，网速较快，建议直接使用以下地址：${NC}"
echo "wget https://github.com/avilliai/Manyana/releases/download/Manyana/ManyanaLauncher_V2.rar -O ManyanaLauncher_V2.rar"

echo "请选择下载地址："
echo -e "\033[33m1. 使用\033[0m(\033[32mgithub难以连接时推荐选这个\033[0m)\033[33m默认地址 https://mirror.ghproxy.com/https://github.com/avilliai/Manyana/releases/download/Manyana/ManyanaLauncher_V2.rar\033[0m"
echo -e "\033[33m2. 使用备用地址 https://ghproxy.net/https://github.com/avilliai/Manyana/releases/download/Manyana/ManyanaLauncher_V2.rar\033[0m"
echo -e "\033[33m3.\033[0m \033[31m直接使用GitHub地址\033[0m \033[32mhttps://github.com/avilliai/Manyana/releases/download/Manyana/ManyanaLauncher_V2.rar\033[0m"

read -t 10 -p "请输入选项 (1/2/3): " choice
if [ $? -ne 0 ]; then
    echo -e "\n${RED}倒计时结束，使用默认地址。${NC}"
    choice="1"
fi

# 根据用户选择设置下载地址
if [ "$choice" == "1" ]; then
    file_url="https://mirror.ghproxy.com/https://github.com/avilliai/Manyana/releases/download/Manyana/ManyanaLauncher_V2.rar"
elif [ "$choice" == "2" ]; then
    file_url="https://ghproxy.net/https://github.com/avilliai/Manyana/releases/download/Manyana/ManyanaLauncher_V2.rar"
elif [ "$choice" == "3" ]; then
    file_url="https://github.com/avilliai/Manyana/releases/download/Manyana/ManyanaLauncher_V2.rar"
else
    echo "\033[33m无效的选项，使用默认地址。\033[0m"
    file_url="https://mirror.ghproxy.com/https://github.com/avilliai/Manyana/releases/download/Manyana/ManyanaLauncher_V2.rar"
fi



package_manager=$(detect_package_manager)
echo -e "\033[32m正在检查并安装 wget 、git 、 unrar 和 openjdk-17-jdk ...\033[0m"
# 开始安装依赖
if [ "$package_manager" = "apt" ];then
    sudo apt install -qq -y libgbm1 libasound2 libgtk-3-0 libnotify4 libxss1 libxtst6 xdg-utils libatspi2.0-0 libsecret-1-0 wget unrar screen git openjdk-17-jdk
else
    sudo yum install -q -y libgbm1 libasound2 libgtk-3-0 libnotify4 libxss1 libxtst6 xdg-utils libatspi2.0-0 libsecret-1-0 wget unrar screen git openjdk-17-jdk
fi


# 检查是否已经安装了conda
if command -v conda &> /dev/null; then
    echo -e "\033[32mConda已经安装。\033[0m"
else
    # 获取CPU架构
    ARCH=$(uname -m)

    # 根据CPU架构设置Miniconda安装脚本的URL
    if [ "$ARCH" == "x86_64" ]; then
        MINICONDA_URL="https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh"
    elif [ "$ARCH" == "aarch64" ]; then
        MINICONDA_URL="https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-aarch64.sh"
    elif [ "$ARCH" == "ppc64le" ]; then
        MINICONDA_URL="https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-ppc64le.sh"
    elif [ "$ARCH" == "s390x" ]; then
        MINICONDA_URL="https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-s390x.sh"
    else
        echo -e "\033[31m不支持的架构: $ARCH\033[0m"
        exit 1
    fi

    # 下载Miniconda安装脚本
    echo -e "\033[31m正在下载适用于 $ARCH 架构的Miniconda安装脚本...\033[0m"
    wget $MINICONDA_URL -O Miniconda3-latest-Linux-$ARCH.sh

    # 检查下载是否成功
    if [ $? -ne 0 ]; then
        echo -e "\033[31m下载Miniconda安装脚本失败。\033[0m"
        exit 1
    fi

    # 设置脚本的权限为777
    echo -e "\033[32m正在设置Miniconda安装脚本的权限...\033[0m"
    chmod 777 Miniconda3-latest-Linux-$ARCH.sh

    # 执行安装脚本
    echo -e "\033[32m正在执行Miniconda安装脚本...\033[0m"
    ./Miniconda3-latest-Linux-$ARCH.sh -b -p $HOME/miniconda
    export PATH="$HOME/miniconda/bin:$PATH"
    eval "$($HOME/miniconda/bin/conda shell.bash hook)"
    conda init

    # 检查安装是否成功
    if [ $? -eq 0 ]; then
        echo -e "\033[32mMiniconda安装成功。\033[0m"
    else
        echo -e "\033[31mMiniconda安装失败。\033[0m"
        exit 1
    fi
fi

# 修改conda的软件源配置文件
echo -e "\033[32m正在配置conda的软件源...\033[0m"
cat > ~/.condarc <<EOL
channels:
  - defaults
show_channel_urls: true
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch-lts: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  deepmodeling: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/
EOL

echo -e "\033[32mconda软件源配置完成。\033[0m"

# 清除conda缓存
echo -e "\033[32m正在清除conda缓存...\033[0m"
conda clean -i -y

# 创建Python 3.9虚拟环境
echo -e "\033[32m正在创建Python 3.9虚拟环境...\033[0m"
conda create -y -n qqbot python=3.9

if [ $? -eq 0 ]; then
    echo -e "\033[32m虚拟环境创建成功。正在进入虚拟环境...\033[0m"
    # 激活虚拟环境
    source $HOME/miniconda/bin/activate qqbot
    echo -e "\033[32m已进入虚拟环境qqbot。\033[0m"
else
    echo -e "\033[31m虚拟环境创建失败。\033[0m"
    exit 1
fi



# 克隆GitHub仓库
echo -e "\033[32m正在克隆GitHub仓库...\033[0m"

if [ "$use_wget" == true ]; then
    wget https://github.moeyy.xyz/https://github.com/avilliai/Manyana/archive/refs/heads/main.zip -O Manyana.zip
    if [ $? -eq 0 ]; then
        unzip Manyana.zip -d .
        mv Manyana-main Manyana
        rm Manyana.zip
        echo -e "\033[32m使用wget下载并解压仓库成功。\033[0m"
    else
        echo -e "\033[31m使用wget下载仓库失败。\033[0m"
        exit 1
    fi
else
    git clone "$repo_url"
    if [ $? -ne 0 ]; then
        echo -e "\033[31m克隆仓库失败，正在使用备用地址重试...\033[0m"
        git clone "https://mirror.ghproxy.com/https://github.com/avilliai/Manyana.git"
        if [ $? -eq 0 ]; then
            echo -e "\033[32m使用备用地址克隆仓库成功。\033[0m"
        else
            echo -e "\033[31m使用备用地址克隆仓库失败。尝试直接使用GitHub仓库\033[0m"
            git clone "https://github.com/avilliai/Manyana.git"
            if [ $? -eq 0 ]; then
                echo -e "\033[32m使用GitHub仓库克隆成功。\033[0m"
            else
                echo -e "\033[31m使用所有仓库下载均失败。请检查网络后重试\033[0m"
                exit 1
            fi
        fi
    else
        echo -e "\033[32m克隆Manyana仓库成功。\033[0m"
    fi
fi

# 修改文件权限和内容
chmod 777 -R Manyana
sed -i 's/python.exe/python/g' Manyana/main.py


# 升级pip并修改pip源为清华源
echo -e "\033[32m正在升级pip并修改pip源为清华源...\033[0m"
python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# 安装依赖
echo -e "\033[32m正在安装依赖...\033[0m"
pip  install  hypercorn
pip  install  -r Manyana/requirements.txt

if [ $? -eq 0 ]; then
    echo -e "\033[32m依赖安装成功。\033[0m"
else
    echo -e "\033[31m依赖安装失败。\033[0m"
    exit 1
fi


# 下载ManyanaLauncher_V2.rar
echo -e "\033[32m正在下载ManyanaLauncher_V2.rar...\033[0m"
wget "$file_url" -O ManyanaLauncher_V2.rar

# 检查下载是否成功
if [ $? -ne 0 ]; then
    echo -e "\033[31m下载失败，正在使用备用地址重试...\033[0m"
    wget "https://ghproxy.net/https://github.com/avilliai/Manyana/releases/download/Manyana/ManyanaLauncher_V2.rar" -O ManyanaLauncher_V2.rar
    if [ $? -ne 0 ]; then
        echo -e "\033[31m备用地址下载也失败了。\033[0m"
        exit 1
    else
        echo -e "\033[32m使用备用地址下载成功。\033[0m"
    fi
else
    echo -e "\033[32m下载成功。\033[0m"
fi

# 解压ManyanaLauncher_V2.rar
echo -e "\033[33m正在解压ManyanaLauncher_V2.rar...\033[0m"
mkdir ManyanaLauncher
mv ManyanaLauncher_V2.rar ManyanaLauncher
unrar x ManyanaLauncher/ManyanaLauncher_V2.rar ManyanaLauncher

if [ $? -eq 0 ]; then
    echo -e "\033[32m解压成功。\033[0m"
    chmod 777 -R ManyanaLauncher
else
    echo -e "\033[31m解压失败。\033[0m"
    exit 1
fi

# 删除指定文件和文件夹
echo -e "\033[33m正在删除临时产生且无用的文件和文件夹...\033[0m"
rm -f ManyanaLauncher/launcher_v1.1.4.exe
rm -f Manyana/启动脚本.bat
rm -f Manyana/一键部署脚本.bat
rm -f ManyanaLauncher/llob_install.exe
rm -f ManyanaLauncher/QQ_9.9.9_240403_x64_01.exe
rm -f ManyanaLauncher/ManyanaLauncher_V2.rar
rm -f Miniconda3-latest-Linux-x86_64.sh
rm -rf ManyanaLauncher/environments

# 移动文件
echo -e "\033[33m正在移动文件...\033[0m"
mv ManyanaLauncher/1374_epochsm.pth Manyana/vits/voiceModel/nene

if [ $? -eq 0 ]; then
    echo -e "\033[32m文件移动成功。\033[0m"
else
    echo -e "\033[31m文件移动失败。\033[0m"
    exit 1
fi





while [[ $# -ge 1 ]]; do
    case $1 in
        --docker)
            shift
            use_docker="$1"
            shift
        ;;
        --qq)
            shift
            qq="$1"
            shift
        ;;
        --mode)
            shift
            mode="$1"
            shift
        ;;
        --confirm)
            shift
            confirm="y"
        ;;
        *)
            echo -ne " Usage: bash $0 --docker [y|n] --qq \"114514\" --mode [ws|reverse_ws|reverse_http] --confirm\n"
            exit 1;
        ;;
    esac
done

# 函数：检查当前系统是amd64还是x86_64 读取失败返回none
get_system_arch() {
    echo $(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/)
}

# 函数：根据参数生成docker命令
generate_docker_command() {
    local qq=$1
    local mode=$2
    docker_ws="docker run -d -e ACCOUNT=$qq -e WS_ENABLE=true -p 3001:3001 -p 6099:6099 --name napcat --restart=always mlikiowa/napcat-docker:latest"
    docker_reverse_ws="docker run -d -e ACCOUNT=$qq -e WSR_ENABLE=true -e WS_URLS='[]' --name napcat --restart=always mlikiowa/napcat-docker:latest"
    docker_reverse_http="docker run -d -e ACCOUNT=$qq -e HTTP_ENABLE=true -e HTTP_POST_ENABLE=true -e HTTP_URLS='[]' -p 3000:3000 -p 6099:6099 --name napcat --restart=always mlikiowa/napcat-docker:latest"
    if [ "$mode" = "ws" ]; then
        echo $docker_ws
        elif [ "$mode" = "reverse_ws" ]; then
        echo $docker_reverse_ws
        elif [ "$mode" = "reverse_http" ]; then
        echo $docker_reverse_http
    else
        exit 1
    fi
}



# 函数：检查并返回可用的命令
detect_package_installer() {
    if command -v dpkg &> /dev/null; then
        echo "dpkg"
        elif command -v rpm &> /dev/null; then
        echo "rpm"
    else
        echo "none"
    fi
}

# 函数：检查用户是否安装docker
check_docker() {
    if command -v docker &> /dev/null; then
        echo "true"
    else
        echo "false"
    fi
}

# 保证 curl/wget apt/rpm 基础环境

use_docker=n
if [ "$use_docker" = "y" ]; then
    if [ "$(check_docker)" = "false" ]; then
        sudo curl -fsSL https://get.docker.com -o get-docker.sh
        sudo chmod +x get-docker.sh
        sudo sh get-docker.sh
    fi
    
    if [ "$(check_docker)" = "true" ]; then
        echo "Docker已安装"
    else
        echo "Docker安装失败"
        exit 1
    fi
    
    while true; do
        if [[ -z $qq ]]; then
            echo "请输入QQ号："
            read -r qq
        fi
        if [[ -z $mode ]]; then
            echo "请选择模式（ws/reverse_ws/reverse_http）"
            read -r mode
        fi
        docker_command=$(generate_docker_command "$qq" "$mode")
        if [[ -z $docker_command ]]; then
            echo "模式错误, 无法生成命令"
            confirm="n"
        else
            echo "即将执行以下命令：$docker_command"
        fi
        if [[ -z $confirm ]]; then
            read -p "是否继续？(y/n) " confirm
        fi
        case $confirm in
            y|Y ) break;;
            * )
                # 如果取消了则说明需要重新初始化以上信息
                confirm=""
                mode=""
                qq=""
            ;;
        esac
    done
    eval "$docker_command"
    echo "安装成功"
    exit 0
    elif [ "$use_docker" = "n" ]; then
    echo -e "\033[33m不使用Docker安装\033[0m"
else
    echo "输入错误，请重新安装"
    exit 1
fi

system_arch=$(get_system_arch)
if [ "$system_arch" = "none" ]; then
    echo -e "\033[31m无法识别的系统架构，请检查错误。\033[0m"
    exit 1
fi

echo -e "\033[31m当前系统架构：$system_arch\033[0m"

qq_download_url=""
package_installer=$(detect_package_installer)
#https://dldir1.qq.com/qqfile/qq/QQNT/Linux/QQ_3.2.8_240520_amd64_01.deb
if [ "$system_arch" = "amd64" ]; then
    if [ "$package_installer" = "rpm" ]; then
        qq_download_url=$(curl -s https://cdn-go.cn/qq-web/im.qq.com_new/latest/rainbow/linuxQQDownload.js | grep -o -E 'https://dldir1\.qq\.com/qqfile/qq/QQNT/Linux/QQ_[0-9]+\.[0-9]+\.[0-9]+_[0-9]{6}_86_64_[0-9]{2}\.rpm')
        elif [ "$package_installer" = "dpkg" ]; then
        qq_download_url=$(curl -s https://cdn-go.cn/qq-web/im.qq.com_new/latest/rainbow/linuxQQDownload.js | grep -o -E 'https://dldir1\.qq\.com/qqfile/qq/QQNT/Linux/QQ_[0-9]+\.[0-9]+\.[0-9]+_[0-9]{6}_amd64_[0-9]{2}\.deb')
    fi
    elif [ "$system_arch" = "arm64" ]; then
    if [ "$package_installer" = "rpm" ]; then
        qq_download_url=$(curl -s https://cdn-go.cn/qq-web/im.qq.com_new/latest/rainbow/linuxQQDownload.js | grep -o -E 'https://dldir1\.qq\.com/qqfile/qq/QQNT/Linux/QQ_[0-9]+\.[0-9]+\.[0-9]+_[0-9]{6}_aarch64_[0-9]{2}\.rpm')
        elif [ "$package_installer" = "dpkg" ]; then
        qq_download_url=$(curl -s https://cdn-go.cn/qq-web/im.qq.com_new/latest/rainbow/linuxQQDownload.js | grep -o -E 'https://dldir1\.qq\.com/qqfile/qq/QQNT/Linux/QQ_[0-9]+\.[0-9]+\.[0-9]+_[0-9]{6}_arm64_[0-9]{2}\.deb')
    fi
fi

if [ "$qq_download_url" = "" ]; then
    echo -e "\033[31m无法下载QQ，请检查错误。\033[0m"
    exit 1
fi
echo -e "\033[33mQQ下载链接：$qq_download_url\033[0m"

# 没有完成强制安装
if [ "$package_installer" = "rpm" ]; then
    curl -L "$qq_download_url" -o QQ.rpm
    sudo rpm -Uvh./QQ.rpm --nodeps --force
    rm QQ.rpm
    elif [ "$package_installer" = "dpkg" ]; then
    curl -L "$qq_download_url" -o QQ.deb
    sudo dpkg -i --force-depends QQ.deb
    rm QQ.deb
fi





napcat_download_url=""
#https://github.com/NapNeko/NapCatQQ/releases/download/v1.4.0/NapCat.linux.arm64.zip
#https://github.com/NapNeko/NapCatQQ/releases/download/v1.4.0/NapCat.linux.x64.zip
if [ "$system_arch" = "amd64" ]; then
    napcat_download_url="https://mirror.ghproxy.com/https://github.com/NapNeko/NapCatQQ/releases/download/v1.4.7/NapCat.linux.x64.zip"
    elif [ "$system_arch" = "arm64" ]; then
    napcat_download_url="https://mirror.ghproxy.com/https://github.com/NapNeko/NapCatQQ/releases/download/v1.4.7/NapCat.linux.arm64.zip"
else
    echo -e "\033[31m无法下载NapCatQQ，请检查错误。\033[0m"
    exit 1
fi
echo -e "\033[33mNapCatQQ下载链接：$napcat_download_url\033[0m"
curl -L "$napcat_download_url" -o "NapCat.linux.zip"

# 解压与清理
mkdir ./NapCat/
mkdir ./tmp/
unzip -q -d ./tmp NapCat.linux.zip

rm -rf ./NapCat.linux.zip
if [ "$system_arch" = "amd64" ]; then
    mv ./tmp/NapCat.linux.x64/* ./NapCat/
    elif [ "$system_arch" = "arm64" ]; then
    mv ./tmp/NapCat.linux.arm64/* ./NapCat/
fi
rm -rf ./tmp/
chmod +x ./NapCat/napcat.sh

echo -e "\033[32mNapCatQQ安装完成\033[0m"


# 获取当前文件夹路径
CURRENT_DIR=$(pwd)
echo -e "\033[33m当前文件夹路径: $CURRENT_DIR\033[0m"

# 创建start文件夹
START_DIR="$CURRENT_DIR/start"
mkdir -p $START_DIR/direct
echo -e "\033[32m创建start文件夹: $START_DIR\033[0m\n"

# 创建1_napcat.sh脚本
cat > $START_DIR/direct/1_napcat.sh <<EOL
#!/bin/bash
source $HOME/miniconda/bin/activate qqbot
rm $START_DIR/1_napcat_log.txt
cd $CURRENT_DIR/NapCat/
bash $CURRENT_DIR/NapCat/napcat.sh >> $START_DIR/1_napcat_log.txt 2>&1
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
python $CURRENT_DIR/Manyana/main.py >> $START_DIR/Manyana_log.txt 2>&1
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

chmod  777 -R $CURRENT_DIR

clear
bash

echo -e "\n\n\n\033[32m所有组件已经安装完毕，请仔细阅读以下内容：\033[0m"
echo -e "\033[31m-------------------------------------------------------------------------------------------------\n\033[0m"
echo -e "\033[31m1.\033[0m 本脚本固定了安装版本，如果你发现这个安装脚本太老了已经不能使用了请参照Manyana、Overflow、Napcatqq官方教程手动安装"
echo -e "\033[31m2.\033[0m 请前往Manyana文件夹中修改config.json"
echo "其内容如下："
echo "{"botName": "机器人名字", "botQQ": "机器人QQ", "master": "你的QQ", "mainGroup": "你自己群的群号","vertify_key": "这里写你http-api的key,尖括号不用带", "port": "httpapi的运行端口"}"
echo -e "下面是一个填写示例实例，如使用整合包，\033[31m如果你不知道后两项参数对应什么，不要修改后两项\033[0m"
echo "{"botName": "Manyana", "botQQ": "1283992481", "master": "1840094972","mainGroup": "628763673", "vertify_key": "1234567890", "port": "23456"}"
echo -e "\033[31m3.\033[0m 请手动输入 $CURRENT_DIR/NapCat/napcat.sh 初始化NapCatQQ，并扫码登录，\033[33m然后修改 $CURRENT_DIR/NapCat/config 目录下创建的对应账户的onebot11_xxxxx.json文件\033[0m，将其中ws设置为启用"
echo -e "\033[33m如同:\n......\n"ws": {
    "enable": \033[0m\033[31mtrue\033[0m\033[33m,
    "host": "",
    "port": 3001
  },\n......\n\033[0m
"
echo -e "\033[33m机器人其他详细配置请参见$CURRENT_DIR/Manyana/config/中的配置文件所含注释\033[0m"
echo -e "\033[31m-------------------------------------------------------------------------------------------------\n\033[0m"
echo -e "\n启动机器人的命令顺序如下：\n"
echo -e "\033[31m1. \033[0m如果你使用的是\033[33m没有图形化桌面的服务器\033[0m，请在完成之前的步骤之后，运行$START_DIR/1_napcat_withoutgui.sh，并且cat 1_napcat_log.txt后，扫描其中的二维码登录机器人，然后再执行$START_DIR/2_overflow_withoutgui.sh和$START_DIR/3_Manyana_withoutgui.sh\n\n"
echo -e "\033[31m2. \033[0m如果你使用的是\033[33m带有图形化桌面的服务器\033[0m，你可以选择直接进入$START_DIR/direct目录，运行$START_DIR/1_napcat.sh登录机器人，\033[31m然后开另外两个终端再执行$START_DIR/2_overflow.sh和$START_DIR/3_Manyana.sh（注意如果在登录机器人之前开启这俩shell可能会导致报错）\033[0m\n\n"
echo -e "\033[32m-------------------------------------------------------------------------------------------------\n\033[0m"
echo -e "\e[3;4;38;5;46;48;5;95m求求各位给个star\e[0m"
echo -e "\033[32m自动化安装脚本:https://github.com/lux-QAQ/Manyana_deploy\033[0m"
echo "机器人实现：https://github.com/avilliai/Manyana"
echo "Overflow都懂的请自己搜索"
echo "NapCatQQ都懂的请自己搜"
echo -e "\033[33m如有疑问欢迎加Q群\033[0m ： \033[42m628763673\033[0m"
echo -e "\033[32m-------------------------------------------------------------------------------------------------\n\033[0m"
echo -e "\033[32m脚本执行完毕\n\033[0m"

