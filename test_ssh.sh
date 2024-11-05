for i in `seq 1 250`
do
	echo "test 10.239.48.$i"
	ssh feng@10.239.48.$i ls /home/feng/ || continue
	sleep 5
done
