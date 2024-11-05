for i in `seq 1 90`
do
	sleep 1
	echo $i
	cat /proc/interrupts > /dev/ttyACM0
done
