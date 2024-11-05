set -x
cd /home/feng/
adb root
sleep 2
adb remount
adb push chktop /system/bin/chktop
adb push tlog /system/bin/tlog
adb push chkmem /system/bin/chkmem
adb push memeat32 /system/bin/memeat32
adb push show_cs /system/bin/show_cs
adb push save_ftrace /system/bin/save_ftrace
adb push chkion /system/bin/chkion
adb push chkion1 /system/bin/chkion1
adb push find /system/bin/find
adb push page-types /system/bin/page-types
adb push stop_s3 /system/bin/
adb push sw_csc.ion /system/bin/
adb push sw_csc.malloc /system/bin/
adb push pss /system/bin/
adb push enable_64m_zram /system/bin/
adb push enable_ksm /system/bin/
adb push pyr /system/bin/
adb push msg /system/bin/
adb push ion_on /system/bin/
adb push msg1 /system/bin/
adb push get_info.sh /system/bin/
adb push iondbg /system/bin/
adb push chksm /system/bin/
adb push byt_pwr /system/bin/
adb push show_wl /system/bin/
adb push apower /system/bin/
adb push show_freq /system/bin/
adb push chkion2 /system/bin/
adb push tloop /system/bin/
adb push toggle_cpu1 /system/bin/
adb push toggle_cpu2 /system/bin/
adb push toggle_cpu3 /system/bin/

adb push 1280x720.rgba /sdcard/input_720p.rgba

adb shell chmod 777 /system/bin/*
adb install file_exp.apk
#adb install ESFileExplorer.apk
adb install com.halfbrick.fruitninjamini-1.apk
#adb install antutu-benchmark-v520.apk

#push_video 52_24fps_5s291ms_MP4_h264_1280x720_Main@L4.0_Bitrate_397Kbps_NoAudio.mp4 89_25fps_24s160ms_MP4_h264_1280x720_Main@L3.1_Bitrate_2787Kbps_NoAudio.mp4 H264_BP_1080x720_30fps_12Mbps_AACLC_44.1khz_64kbps_s_1_17.mp4 VID_20141104_101226.3gp  /home/feng/test_AFD.mp4

adb push /home/feng/sdv_backup/ftest/Now_35 /storage/sdcard0/Music/

#adb install AnTuTu-4.0.3.apk
#adb install JIO_V1.6.apk
#adb install jifeng.apk
