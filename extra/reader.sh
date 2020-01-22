#!/bin/bash

while true ; do
    # Get a message
    data=$(curl -s -q http://127.0.0.1:5000/read)
    FROM=$(echo $data | jq '.from' | sed -r 's/\+/%2B/; s/"//g')
    MESSAGE=$(echo $data | jq '.message' | sed -r 's/"//g')
    DATE=$(date -R)
    #echo "DEBUG $FROM / $MESSAGE"
    if [ "Z$FROM" != "Znull" -a "Z$MESSAGE" != "Znull" ] ; then
        echo "$DATE | $FROM | $MESSAGE"
        echo "$DATE | $FROM | $MESSAGE" >> /var/log/sms.log
        if [ "$MESSAGE" = "ping" ] ; then
            ~/.local/bin/sendsms.sh 0${FROM#%2B33} pong
        fi
    fi
    sleep 1
done
