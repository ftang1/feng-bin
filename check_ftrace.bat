#!/bin/bash
set -x
adb shell save_ftrace  && adb pull /data/1.log ;
fromdos 1.log
cut -b 22- 1.log > /dev/shm/2.log
#sed -i -e 's/^.........................//g' /dev/shm/1.log
vi /dev/shm/2.log
