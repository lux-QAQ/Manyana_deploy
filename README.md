# Manyana_deploy（带有UI界面）
Manyana机器人一键部署脚本，适用于带有apt和yum的系统（建议使用ubuntu会少很多奇怪的问题） :yum: 

使用方法

（不建议在root下运行）


`wget https://gitee.com/laixi_lingdun/Manyana_deploy/raw/main/install.sh`

`chmod 777 install.sh`

`./install.sh`

 **_脚本有严格混淆，运行时要多等一会。_** 


B站视频演示：https://www.bilibili.com/video/BV1Km421K7gP/

机器人本体地址：https://github.com/avilliai/Manyana

## Windows部署教程
前往https://github.com/avilliai/Manyana/releases
下载howToUse.mp4查看

## 旧版本脚本更新
使用方法

（不建议在root下运行）


`wget https://gitee.com/laixi_lingdun/Manyana_deploy/raw/main/fix_patch.sh`

`chmod 777 fix_patch.sh`

`./fix_patch.sh`

## Linux下出现过的问题
1. overflow日志出现 红字connection refused ,或者 Manyana 启动后无任何反应，请确保你机器人初始化完毕后（也就是修改好各种配置文件后），启动了脚本1_*****.sh，然后cat 1_****.txt，并且扫码登录了。(**_已经实现了GUI界面了，这个问题基本不可能出现了_**)
2. pip install 时，报错空间不足，要么就是你的磁盘真的满了，要么有可能是/tmp满了，第二种情况请手动切换到qqbot环境中并且更换tmp文件夹的环境变量，然后在重新执行脚本。
3. unrar解压是报错UTF16E啥的，说明你的系统不支持这种编码。不同的系统解决方法应该不一样请带着报错信息自行百度。
4. unzip或者unrar:command not found，红字安装依赖失败。手动执行sudo apt install unrar unzip后再运行脚本。（最新版脚本已修改该问题，再出现问题就有鬼了）
5. 签到无法正常发送图像，图像无法生成，检查你自己的头像是不是GIF或者别的离谱东西，正常图片机器人才能制作签到图像。

无法解决问题时可以加群**理智**询问：628763673


