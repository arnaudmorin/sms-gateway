#!/bin/bash

while true ; do
    # Purge
    echo "$(date) - purging"
    curl -s -q -X DELETE http://127.0.0.1:5000/purge
    # Sleep 10 minutes before next purge
    sleep 600
done
