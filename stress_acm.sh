for i in `seq 1 90`
do
	sleep 1
	echo $i
	cat /proc/interrupts > /dev/ttyACM1
#	cat /home/feng/acm.txt > /dev/ttyACM1
done
