set -x
cd /home/feng/
adb root
sleep 2
adb remount
adb push chktop /data/chktop
adb push chkmem /data/chkmem
adb push memeat32 /data/memeat32
adb push show_cs /data/show_cs
adb push save_ftrace /data/save_ftrace
adb push chkion /data/chkion
adb push chkion1 /data/chkion1
adb push find /data/find
adb push page-types /data/page-types
adb push stop_s3 /data/
adb push sw_csc.ion /data/
adb push sw_csc.malloc /data/
adb push pss /data/
adb push enable_64m_zram /data/
adb push enable_ksm /data/
adb push pyr /data/
adb push msg /data/
adb push ion_on /data/
adb push msg1 /data/
adb push get_info.sh /data/
adb push iondbg /data/
adb push chksm /data/
adb push byt_pwr /data/
adb push show_wl /data/
adb push apower /data/

adb push 1280x720.rgba /sdcard/input_720p.rgba

adb shell chmod 777 /data/*
adb install file_exp.apk
#adb install ESFileExplorer.apk
adb install com.halfbrick.fruitninjamini-1.apk
#adb install antutu-benchmark-v520.apk

#push_video 52_24fps_5s291ms_MP4_h264_1280x720_Main@L4.0_Bitrate_397Kbps_NoAudio.mp4 89_25fps_24s160ms_MP4_h264_1280x720_Main@L3.1_Bitrate_2787Kbps_NoAudio.mp4 H264_BP_1080x720_30fps_12Mbps_AACLC_44.1khz_64kbps_s_1_17.mp4 VID_20141104_101226.3gp  /home/feng/test_AFD.mp4

adb push /home/feng/sdv_backup/ftest/Now_35 /storage/sdcard0/Music/

#adb install AnTuTu-4.0.3.apk
#adb install JIO_V1.6.apk
#adb install jifeng.apk
