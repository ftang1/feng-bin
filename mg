#!/bin/sh
if [ ! -e "$2" ]
then
	echo '$2 is NULL'
	fdir=.
else
	echo "\$2 is $2"
	fdir=$2
fi
grep --binary-files=without-match $1 $fdir -r > ~/tmp_123456.txt

#grep $1 ./* -r > ~/tmp_123456.txt
sed -i -e "/\.map/d" -e "/Binary/d" -e "/cscope/d" -e "/tags/d" ~/tmp_123456.txt
cat ~/tmp_123456.txt | grep --color $1
rm ~/tmp_123456.txt
