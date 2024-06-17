#!/bin/bash
START_DIR=$(pwd)
CURRENT_DIR=$(pwd)/..
# 检查是否存在 onebot_xxxx.json 文件
check_init() {
    if ls $CURRENT_DIR/NapCat/config/onebot11_*.json 1> /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# 检查进程是否在运行
check_running() {
    tmux list-sessions | grep -q "$1"
    if [ $? -eq 0 ]; then
        echo "\Zb\Z2运行中\Zn"
    else
        echo "\Zb\Z1未运行\Zn"
    fi
}

# 查看日志
view_log() {
    tail -n 30 "$1"
    sleep 3
}

# 检查初始化
if ! check_init; then
    dialog --no-lines --colors --msgbox "\n\Zb\Z1未执行初始化，请先运行初始化脚本。按Enter开始初始化\Zn" 10 50
    $START_DIR/init.sh
    if ! check_init; then
        dialog --no-lines --colors --msgbox "\n\Zb\Z1初始化失败，请检查配置并重新初始化\Zn" 10 50
        exit 1
    fi
fi

while true; do
    NAPCAT_STATUS=$(check_running "napcat")
    OVERFLOW_STATUS=$(check_running "overflow")
    MANYANA_STATUS=$(check_running "Manyana")

    CHOICE=$(dialog --no-lines --colors --clear --title "⭐ \Zb\Z4机器人启动菜单\Zn ⭐" \
        --menu "\n\Zb\Z6请选择要执行的操作:\Zn" 20 50 10 \
        1 "\Zb\Z3启动 Napcat \Zn (\Zn $NAPCAT_STATUS \Zb\Z3)\Zn" \
        2 "\Zb\Z3启动 Overflow \Zn (\Zn $OVERFLOW_STATUS \Zb\Z3)\Zn" \
        3 "\Zb\Z3启动 Manyana \Zn (\Zn $MANYANA_STATUS \Zb\Z3)\Zn" \
        4 "\Zb\Z3临时查看 Napcat 日志2s\Zn" \
        5 "\Zb\Z3临时查看 Overflow 日志2s\Zn" \
        6 "\Zb\Z3临时查看 Manyana 日志2s\Zn" \
        7 "\Zb\Z1停止所有进程\Zn" \
        8 "\Zb\Z3更新机器人\Zn" \
        9 "\Zb\Z4退出\Zn" \
        3>&1 1>&2 2>&3)

    case $CHOICE in
        1)
            if [ "$NAPCAT_STATUS" == "\Zb\Z1未运行\Zn" ]; then
                $START_DIR/1_napcat_withoutgui.sh
                dialog --no-lines --colors --msgbox "\n\Zb\Z3Napcat 已启动，等待登录二维码...扫码后，请等待\Zn" 10 50
                sleep 2
                tail -n 30 $START_DIR/napcat_log.txt &
                QR_CODE_DECODED=0
                end=$((SECONDS + 60))
                while [ $SECONDS -lt $end ]; do
                    if grep -q "二维码解码URL" $START_DIR/napcat_log.txt; then
                        QR_CODE_DECODED=1
                        break
                    fi
                    sleep 1
                done
                if [ $QR_CODE_DECODED -eq 1 ]; then
                    clear
                    cat $START_DIR/napcat_log.txt
                    LOG_SUCCESS=0
                    while [ $SECONDS -lt $end ]; do
                        if grep -q -e "登录成功" -e "无法重复登录" $START_DIR/napcat_log.txt; then
                            LOG_SUCCESS=1
                            break
                        fi
                        sleep 1
                    done
                    if [ $LOG_SUCCESS -eq 1 ]; then
                        dialog --no-lines --colors --msgbox "\n\Zb\Z2Napcat 登录成功\Zn" 10 50
                        NAPCAT_STATUS="\Zb\Z2运行中\Zn"
                    else
                        tmux kill-session -t napcat
                        dialog --no-lines --colors --msgbox "\n\Zb\Z1超时未登录，请重新启动\Zn" 10 50
                        NAPCAT_STATUS="\Zb\Z1未运行\Zn"
                    fi
                else
                    tmux kill-session -t napcat
                    dialog --no-lines --colors --msgbox "\n\Zb\Z1二维码生成超时，请重新启动\Zn" 10 50
                    NAPCAT_STATUS="\Zb\Z1未运行\Zn"
                fi
            else
                dialog --no-lines --colors --msgbox "\n\Zb\Z2Napcat 已经在运行中\Zn" 10 50
            fi
            ;;
        2)
            if [ "$OVERFLOW_STATUS" == "\Zb\Z1未运行\Zn" ]; then
                $START_DIR/2_overflow_withoutgui.sh
                dialog --no-lines --colors --msgbox "\n\Zb\Z3Overflow 已启动\Zn" 10 50
            else
                dialog --no-lines --colors --msgbox "\n\Zb\Z2Overflow 已经在运行中\Zn" 10 50
            fi
            ;;
        3)
            dialog --no-lines --colors --msgbox "\n\Zb\Z3Manyana 启动中，请耐心等待，你可以退出脚本，重进脚本以检查是否启动成功\Zn" 10 50
            if grep -q "已连接到服务器" "$START_DIR/overflow_log.txt"; then
                if [ "$MANYANA_STATUS" == "\Zb\Z1未运行\Zn" ] || [ "$MANYANA_STATUS" == "\Zb\Z1等待overflow启动后再执行\Zn" ]; then
                    sleep 1
                    $START_DIR/3_Manyana_withoutgui.sh
                else
                    dialog --no-lines --colors --msgbox "\n\Zb\Z2Manyana 已经在运行中\Zn" 10 50
                fi
            else
                MANYANA_STATUS="\Zb\Z1等待overflow启动后再执行\Zn"
                dialog --no-lines --colors --msgbox "\n\Zb\Z1等待overflow启动后再执行\Zn" 10 50
            fi
            ;;
        4)
            # 查看 Napcat 日志
            view_log "$START_DIR/napcat_log.txt"
            ;;
        5)
            # 查看 Overflow 日志
            view_log "$START_DIR/overflow_log.txt"
            ;;
        6)
            # 查看 Manyana 日志
            view_log "$START_DIR/manyana_log.txt"
            ;;
        7)
            tmux kill-session -t napcat
            tmux kill-session -t overflow
            tmux kill-session -t Manyana
            dialog --no-lines --colors --msgbox "\n\Zb\Z1所有进程已停止\Zn" 10 50
            ;;
        8)
            if [ -d "$START_DIR/../Manyana/.git" ]; then
                $START_DIR/update.sh
            else
                dialog --no-lines --colors --msgbox "\n\Zb\Z1未绑定远程仓库，请先执行更新脚本中1.绑定仓库\Zn" 10 50
                $START_DIR/update.sh
            fi
            ;;
        9)
            clear
            exit 0
            ;;
        *)
            dialog --no-lines --colors --msgbox "\n\Zb\Z1无效选择\Zn" 10 50
            ;;
    esac
done