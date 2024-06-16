#!/bin/bash
CURRENT_DIR=$(pwd)/..
clear
cd $CURRENT_DIR/Manyana/
source $HOME/miniconda/bin/activate qqbot
python setUp.py | tee $CURRENT_DIR/start/update_log.txt