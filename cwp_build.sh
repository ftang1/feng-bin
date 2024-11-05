#make bzImage -j 32 && scp arch/x86/boot/bzImage root@10.239.142.$1: && ssh root@10.239.142.$1 sign.sh && ssh root@10.239.142.$1 poweroff
make bzImage -j 32 && scp arch/x86/boot/bzImage root@10.239.154.$1: && ssh root@10.239.154.$1 sign.sh && ssh root@10.239.154.$1 poweroff

#sleep 10 

#ssh root@feng-iot echog
