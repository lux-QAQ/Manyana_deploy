#!/bin/bash
START_DIR=$(pwd)
# 检查进程是否在运行
check_running() {
    screen -ls | grep -q "$1"
    if [ $? -eq 0 ]; then
        echo "\Zb\Z2运行中\\Zn"
    else
        echo "\Zb\Z1未运行\Zn"
    fi
}
# 查看日志
view_log() {
    tail -n 30  "$1"
    sleep 3
}
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
        8 "\Zb\Z4退出\Zn" \
        3>&1 1>&2 2>&3)

    case $CHOICE in
        1)
            if [ "$NAPCAT_STATUS" == "\Zb\Z1未运行\Zn" ]; then
                $START_DIR/1_napcat_withoutgui.sh
                dialog --no-lines --colors --msgbox "\n\Zb\Z3Napcat 已启动，等待登录二维码...，请2s后按Enter键\Zn" 10 50
                sleep 2
                tail -n 30  $START_DIR/napcat_log.txt &
                LOG_SUCCESS=0
                end=$((SECONDS+60))
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
                    screen -S napcat -X quit
                    dialog --no-lines --colors --msgbox "\n\Zb\Z1超时未登录，请重新启动\Zn" 10 50
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
            if [ "$MANYANA_STATUS" == "\Zb\Z1未运行\Zn" ]; then
                sleep 10
                $START_DIR/3_Manyana_withoutgui.sh
                dialog --no-lines --colors --msgbox "\n\Zb\Z3Manyana 启动中，请耐心等待，你可以退出脚本，重进脚本以检查是否启动成功\Zn" 10 50
            else
                dialog --no-lines --colors --msgbox "\n\Zb\Z2Manyana 已经在运行中\Zn" 10 50
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
            screen -S napcat -X quit
            screen -S overflow -X quit
            screen -S Manyana -X quit
            dialog --no-lines --colors --msgbox "\n\Zb\Z1所有进程已停止\Zn" 10 50
            ;;
        8)
            clear
            exit 0
            ;;
        *)
            dialog --no-lines --colors --msgbox "\n\Zb\Z1无效选择\Zn" 10 50
            ;;
    esac
done