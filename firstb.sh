set -x
#cd /home/feng/b8/android/panic/android/out/target/product/Sf3g_mrd7_p1_v2/fls/
sfdl_part boot.fls userdata.fls slb.fls cache.fls &
adb reboot
