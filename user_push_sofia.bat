set -x
cd /home/feng/
adb root
adb remount
adb push chktop /sdcard/bin/chktop
adb push chkmem /sdcard/bin/chkmem
adb push memeat32 /sdcard/bin/memeat32
adb push show_cs /sdcard/bin/show_cs
adb push save_ftrace /sdcard/bin/save_ftrace
adb push chkion /sdcard/bin/chkion
adb push chkion1 /sdcard/bin/chkion1
adb push find /sdcard/bin/find
adb push page-types /sdcard/bin/page-types
adb push stop_s3 /sdcard/bin/
adb push sw_csc.ion /sdcard/bin/
adb push sw_csc.malloc /sdcard/bin/
adb push pss /sdcard/bin/
adb push enable_64m_zram /sdcard/bin/
adb push enable_ksm /sdcard/bin/
adb push pyr /sdcard/bin/
adb push msg /sdcard/bin/
adb push ion_on /sdcard/bin/
adb push msg1 /sdcard/bin/
adb push get_info.sh /sdcard/bin/
adb push iondbg /sdcard/bin/
adb push chksm /sdcard/bin/

adb push 1280x720.rgba /sdcard/input_720p.rgba

adb shell chmod 777 /sdcard/bin/*
adb install ESFileExplorer.apk
adb install com.halfbrick.fruitninjamini-1.apk
#adb install antutu-benchmark-v520.apk

#push_video 52_24fps_5s291ms_MP4_h264_1280x720_Main@L4.0_Bitrate_397Kbps_NoAudio.mp4 89_25fps_24s160ms_MP4_h264_1280x720_Main@L3.1_Bitrate_2787Kbps_NoAudio.mp4 H264_BP_1080x720_30fps_12Mbps_AACLC_44.1khz_64kbps_s_1_17.mp4 VID_20141104_101226.3gp  /home/feng/test_AFD.mp4

adb push /home/feng/sdv_backup/ftest/Now_35 /storage/sdcard0/Music/

#adb install AnTuTu-4.0.3.apk
#adb install JIO_V1.6.apk
#adb install jifeng.apk
