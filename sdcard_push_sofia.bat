set -x
cd /home/feng/
adb root
sleep 2
adb remount
adb push chktop /sdcard/chktop
adb push chkmem /sdcard/chkmem
adb push memeat32 /sdcard/memeat32
adb push show_cs /sdcard/show_cs
adb push save_ftrace /sdcard/save_ftrace
adb push chkion /sdcard/chkion
adb push chkion1 /sdcard/chkion1
adb push find /sdcard/find
adb push page-types /sdcard/page-types
adb push stop_s3 /sdcard/
adb push sw_csc.ion /sdcard/
adb push sw_csc.malloc /sdcard/
adb push pss /sdcard/
adb push enable_64m_zram /sdcard/
adb push enable_ksm /sdcard/
adb push pyr /sdcard/
adb push msg /sdcard/
adb push ion_on /sdcard/
adb push msg1 /sdcard/
adb push get_info.sh /sdcard/
adb push iondbg /sdcard/
adb push chksm /sdcard/
adb push byt_pwr /sdcard/
adb push show_wl /sdcard/
adb push apower /sdcard/

adb push 1280x720.rgba /sdcard/input_720p.rgba

adb shell chmod 777 /sdcard/*
adb install file_exp.apk
#adb install ESFileExplorer.apk
adb install com.halfbrick.fruitninjamini-1.apk
#adb install antutu-benchmark-v520.apk

#push_video 52_24fps_5s291ms_MP4_h264_1280x720_Main@L4.0_Bitrate_397Kbps_NoAudio.mp4 89_25fps_24s160ms_MP4_h264_1280x720_Main@L3.1_Bitrate_2787Kbps_NoAudio.mp4 H264_BP_1080x720_30fps_12Mbps_AACLC_44.1khz_64kbps_s_1_17.mp4 VID_20141104_101226.3gp  /home/feng/test_AFD.mp4

adb push /home/feng/sdv_backup/ftest/Now_35 /storage/sdcard0/Music/

#adb install AnTuTu-4.0.3.apk
#adb install JIO_V1.6.apk
#adb install jifeng.apk
