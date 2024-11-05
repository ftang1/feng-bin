

out_dir="/home/feng/ws2/projects/NDG/true_atp/out/"

cd $out_dir

rm flash.log

i=0;
sudo dmesg -c > /dev/null;
while true;
	do ((i++));
	echo "flash start $i"
	echo "========================" >> flash.log
	echo "flash start $i" >> flash.log;
	sleep 1;
	echo 'system reset 0' > /dev/ttyUSB1;
	cflasher --device-detection-timeout 30000 -f firmware/flash.json -c usb_full --log-level 5 >>flash.log 2>&1;
#	make flash
	
	echo >> flash.log
	echo >> flash.log
	echo "-------------------------\n kernel log\n --------------------------\n" >> flash.log
	sudo dmesg -c >> flash.log;
	echo >> flash.log
	echo >> flash.log
	sleep 20;
done 
