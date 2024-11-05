#!/bin/sh

cpu_num=$(cat /proc/cpuinfo | grep processor | wc -l)

echo "Please chose build options"
echo "0) all kinds of configs"
echo "1) i386_def config"
echo "2) allno config"
echo "3) allyes config"
echo "4) allmod config"
echo -n "Enter you choice (default 1):"
read option

#default option is 0
if [ -z $option ]
then
	#echo "got a null option"
	option=1
fi

echo "Kernel build test" > build.log
echo "============================================" >> build.log
echo "\n" >> build.log

# mk_kernel allyes|allno|i386_def
mk_kernel()
{
	echo "\nStart building $1 config:\n"
	make $1;
	echo "---------" >> build.log
	echo "Start building $1 config:" >> build.log
	make bzImage -j $cpu_num 2>> build.log
	ret=$?
	if [ $ret -eq 0 ]
	then
		echo "Build $1 success!" >> build.log
	else
		echo "Build $1 fail!" >> build.log
	fi
	echo "---------\n" >> build.log
}

case $option in
0)
	mk_kernel i386_defconfig &&
	mk_kernel allnoconfig &&
	mk_kernel allmodconfig &&
	mk_kernel allyesconfig
	break
	;;
1)
	mk_kernel i386_defconfig
	break
	;;
2)
	mk_kernel allnoconfig
	break
	;;
3)
	mk_kernel allyesconfig
	break
	;;
4)
	mk_kernel allmodconfig
	break
	;;
esac

echo "Done\n\n" >> build.log


#if [ $option -eq 0 ] || [ $option -eq 3 ] 
#
#if [ $option -eq 0 -o $option -eq 3 ] 
#then
#	make i386_defconfig;
#	echo "Start building i386 defconfig" >> build.log
#	make bzImage -j $cpu_num 2>> build.log
#	ret=$?
#	if [ $ret -eq 0 ]
#	then
#		echo "Build success!\n\n"
#	else
#		echo "Build fail!\n\n"
#	fi
#fi
#
#if [ $option -eq 2 -o $option -eq 3 ] 
#then
#	make allyesconfig;
#	echo "Start building all_yes config" >> build.log
#	make bzImage -j $cpu_num 2>> build.log
#	ret=$?
#	if [ $ret -eq 0 ]
#	then
#		echo "Build success!\n\n"
#	else
#		echo "Build fail!\n\n"
#	fi
#fi
#
#
#if [ $option -eq 1 -o $option -eq 3 ] 
#then
#	make allnoconfig;
#	echo "Start building all_no config" >> build.log
#	make bzImage -j $cpu_num 2>> build.log
#	ret=$?
#	if [ $ret -eq 0 ]
#	then
#		echo "Build success!\n\n"
#	else
#		echo "Build fail!\n\n"
#	fi
#fi
