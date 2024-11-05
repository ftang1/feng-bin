rm ldb.log

for i in 128 64 32 16 8 4
#for i in 128
do

	sudo tonline $i

#	nr_cpu

	echo "-----------------" >> ldb.log
	echo " $i CPUs:"	 >> ldb.log
	echo "-----------------" >> ldb.log

	./db_bench --benchmarks=readrandom --num=500000 --threads=$i | grep micros >> ldb.log

	echo >> ldb.log
done

