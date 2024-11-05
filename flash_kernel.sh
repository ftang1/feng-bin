#!/bin/bash
set -x
adb reboot bootloader
sleep 15 
fastboot devices 
fastboot flash boot boot.img
fastboot reboot
