set -x
cd /home/feng/sshfs/android/xen_ctp/out/target/product/redhookbay/
#adb reboot bootloader
#sleep 5 
fastboot devices 
fastboot flash boot boot.bin
fastboot reboot
