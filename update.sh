#!/bin/bash
cd $CURRENT_DIR/Manyana/
source $HOME/miniconda/bin/activate qqbot
python setUp.py | tee $START_DIR/update_log.txt