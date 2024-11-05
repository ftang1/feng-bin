set -x
for i in 0x2 0x4 0x8
do
	sudo wrmsr -a 0x1a4 $i
	sudo rdmsr 0x1a4
	./loop_hackbench.sh hwp-$i.log 
done
