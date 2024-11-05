#!/bin/bash
# Author: Feng Tang <feng.tang@intel.com>
#
# * New version adding Alek Du's interactive op
# * use bash to use array[]
#
# files=(a b c d e f g h i j k l m n o p q r s t)

# Declare a array


if [ -e "$1" ]
then
	vi $1 
	exit
fi

files=()
files_name=`find . -name "$1" | sed -e "/.*.o$/d"`

i=0

select file in $files_name
do
	break
done

vi $file

