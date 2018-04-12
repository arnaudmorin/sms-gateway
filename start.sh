#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
screen -t sms -S sms -dm $DIR/start.py
