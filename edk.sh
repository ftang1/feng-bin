set -x
adb reboot bootloader
fastboot oem fastboot2adb
sleep 5
adb root
sleep 3
adb push $1 /tmp/
adb shell /system/bin/fpttools/FPT -y -f /tmp/$1 && adb reboot

#adb push FFD8_IFWI_IA32_R_2013_52_3_01_SecEnabled.bin /tmp
#adb shell /system/bin/fpttools/FPT -y -f /tmp/FFD8_IFWI_IA32_R_2013_52_3_01_SecEnabled.bin
