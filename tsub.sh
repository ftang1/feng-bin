#!/bin/sh

if [ $# -lt 2 ]; then
	echo "tsub Usage: tsub old_exp new_exp [directory] !!!"
	exit 1
fi

old=$1
new=$2

if [ ! -e "$2" ]
then
	cwd=.
else
	cwd=$3
fi

for i in $(ls $cwd)
do
	j=$cwd/$i
	if [ -d $j ]
	then
		tsub $old $new $j	
	fi
done

#ls $cwd/*.[chsS] 2>/dev/null 1>/dev/null && grep $1 $cwd/*.[chsS]
if ls $cwd/*.[chsS] 2>/dev/null 1>/dev/null
then sed -i -e "s/$old/$new/g" $cwd/*.[chsS]
fi

