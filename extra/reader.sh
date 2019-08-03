#!/bin/bash

while true ; do
    # Get a message
    data=$(curl -s -q http://127.0.0.1:5000/read)
    FROM=$(echo $data | jq '.from' | sed -r 's/\+/%2B/; s/"//g')
    MESSAGE=$(echo $data | jq '.message' | sed -r 's/"//g')
    #echo "DEBUG $FROM / $MESSAGE"
    if [ "Z$FROM" != "Znull" -a "Z$MESSAGE" != "Znull" ] ; then
        echo "Message received: $FROM / $MESSAGE"
        echo "Message received: $FROM / $MESSAGE" >> /var/log/sms.log
    fi
    sleep 1
done
