#!/bin/bash

KLIPPERSCREEN_DISPLAY=127.0.0.1:0

case "$1" in
    stop)
        echo -n "Stopping Klipper Screen Xclient Deamon .... "
        PID=`ps -ef|grep KlipperScreen-env/bin/python|awk '{print $2}'`
        kill -9 $PID >/dev/null 2>&1 < /dev/null
        echo "stopping"
        ;;
    *)
        ret=1
        timeout=0
        echo -n "Waiting for x-server to be ready "
        while [ $ret -gt 0 ] && [ $timeout -lt 60 ]
        do
            xset -display $KLIPPERSCREEN_DISPLAY -q > /dev/null 2>&1
            ret=$?
            timeout=$( expr $timeout + 1 )
            echo -n "."
            sleep 1
        done
        echo ""

        if [ $timeout -lt 60 ]
        then
            echo -n "Starting Klipper Screen Xclient Deamon .... "
            DISPLAY=$KLIPPERSCREEN_DISPLAY /root/.KlipperScreen-env/bin/python /root/KlipperScreen/screen.py -c /root/printer_data/config/KlipperScreen.conf -l /root/printer_data/logs/KlipperScreen.log >/dev/null 2>&1 < /dev/null &
            echo "running"
            exit 0
        else
            exit 1
        fi
        ;;
esac
exit 0
