#make bzImage -j 32 && scp arch/x86/boot/bzImage root@10.239.142.$1: && ssh root@10.239.142.$1 sign.sh && ssh root@10.239.142.$1 poweroff
#make bzImage -j 32 && scp arch/x86/boot/bzImage root@10.239.154.$1: && ssh root@10.239.154.$1 sign_acrn.sh && ssh root@10.239.154.$1 reboot 
#make bzImage -j 32 && scp arch/x86/boot/bzImage root@10.239.154.$1: && ssh root@10.239.154.$1 sign_acrn.sh 

#make bzImage -j 32 && scp arch/x86/boot/bzImage root@10.239.154.$1: && ssh root@10.239.154.$1 new_acrn 

echo "Old bzImage file size" 
file arch/x86/boot/bzImage 

echo "New bzImage file size"

make bzImage -j 32 && file arch/x86/boot/bzImage && scp arch/x86/boot/bzImage root@10.239.154.$1: && ssh root@10.239.154.$1 sign_acrn.sh 

sleep 10 
ssh root@10.239.154.$1 tlog

#sleep 10 
#ssh root@feng-iot echog
