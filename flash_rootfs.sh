#!/bin/bash
set -x
adb reboot bootloader
sleep 35
fastboot devices 
fastboot flash system system.img.gz
