#!/bin/bash
source ~/apps/sms-gateway/bin/activate
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

screen -ls | grep sms || screen -t sms -S sms -L -dm $DIR/start.py
