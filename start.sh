#!/bin/bash
source ~/apps/sms-gateway/bin/activate
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

tmux -L robots ls -F "#{session_name}" | grep sms || {
    tmux -L robots new -d -s sms -napi $DIR/start.py
    tmux -L robots new-window -t sms -nreader 'bash extra/reader.sh'
    tmux -L robots new-window -t sms -npurger 'bash extra/purger.sh'
}
