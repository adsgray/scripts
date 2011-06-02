#!/bin/sh

#
# Incomplete.
# The plan is to add this to crontab and have
# it run repair.sh every night, when a recording
# is not taking place.
#

recording_active() {
    space_1=`df 2>/dev/null | grep sda6 | awk '{print $4}'`
    sleep 1
    space_2=`df 2>/dev/null | grep sda6 | awk '{print $4}'`

    #echo $space_2
    #echo $space_1
    diff=$(($space_1 - $space_2))

    if [ $diff -gt 0 ]; then
        echo 1
    else
        echo 0
    fi
}

if [ `recording_active` -eq 0 ]; then
    echo "not active"
	exit 0
else
    echo "active"
	exit 1
fi
