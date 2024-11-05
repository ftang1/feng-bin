# adb push exe
adb remount
adb push $1 /system/bin/
adb shell chmod 777 /system/bin/$1

