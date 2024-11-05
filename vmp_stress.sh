count=1
 
while [ $count -le 100000 ]
do
	echo "stress VMP - ${count}"
	echo load > /sys/devices/system/cpu/tdx/reload
	((count++))
done
