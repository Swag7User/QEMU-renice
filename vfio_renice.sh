#!/bin/bash

sleep 2m
QEMUPID=$(pidof --single-shot qemu-system-x86_64)
QEMUGROUPID=$(/bin/ps -Lo pgid --no-heading --pid $QEMUPID | sort --unique)
if [[ ! $1 =~ ^-?[0-9]+$ ]] ; then
    echo "Bad input, only numbers allowed"
    exit
fi
if [[ $1 == 0 ]]; then
    renice -n 0 -g $QEMUGROUPID
    echo reniced QEMUGROUP to 0
else
    renice -n $(($1-2)) -g $QEMUGROUPID
    renice -n $1 -p $QEMUPID
    taskset --cpu-list --all-tasks --pid 1,5,2,6,3,7 $QEMUPID
    echo reniced QEMUPID to $1
    echo reniced QEMUGROUP to $(($1-2))
fi
echo finished renicing
