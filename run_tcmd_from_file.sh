#!/bin/bash

cmd_file="$1"
echo "Executing tcmd from file $1"
echo

while read line
do
	echo $line
	
	# Emphasize the comments
	if [[ $line == \#* ]]
	then
		echo "===================="
	else 
		echo $line > /dev/ttyUSB1
	fi	

	sleep 1
done < $cmd_file 

# cat $1 | while read line; do xxxxxx done
