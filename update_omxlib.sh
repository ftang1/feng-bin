set -x
#cd /home/feng/b8/android/$1/android/out/target/product/Sf3g_$2_512m/system/lib/
cd /home/feng/b8/android/$1/android/out/target/product/Sf3g_mrd5_p1_v2_512m/system/lib/
chmod a-x libstagefright*.so
adb remount
for i in `ls libstagefright*.so`
do
	echo "Updating " $i
	adb push $i /system/lib/
done
adb shell stop
adb shell start
