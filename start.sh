#!/bin/bash
source ~/apps/sms-gateway/bin/activate
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

tmux -L robots ls -F "#{session_name}" | grep sms || {
    tmux -L robots new -d -s sms $DIR/start.py
}


#screen -ls | grep sms || screen -t sms -S sms -L -dm $DIR/start.py
