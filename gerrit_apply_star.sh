#!/bin/bash -e

user=ftang1
srv=ctegerrit.sh.intel.com
port=29418

patches=(`ssh -p $port $srv gerrit query starredby:$user | grep -E "number:|branch:|subject:" | while read p1 p2; do
        if [ "$p1" = "number:" ]; then
                patch_num=$p2
        fi
        if [ "$p1" = "branch:" ]; then
                patch_branch=$p2
        fi
        if [ "$p1" = "subject:" ]; then
                patch_subject=$p2
		echo "$patch_num"
        fi
done`)

echo "correct patch dependence..."

patch_list=
patch_num=${#patches[@]}
for ((i=0; i<$patch_num; i++)); do
        dep_array[$i]=`ssh -p $port $srv gerrit query --format=TEXT --dependencies --current-patch-set=${patches[$i]} | grep "dependsOn:" -A2 | grep "number:" | cut -d':' -f 2 | tr -d " "`
        if [ -z ${dep_array[$i]} ]; then
                dep_array[$i]="nodep"
        fi
        echo "${patches[$i]} dep on ${dep_array[$i]}"
done

for ((i=0; i<$patch_num; i++)); do
        if ! echo "${patches[@]}" | grep -w -q ${dep_array[$i]}; then
                patch_list+="${patches[$i]} "
                patches[$i]="none"
                dep_array[$i]="none"
        fi
done

for ((j=0; j<$patch_num; j++)); do
        for ((k=0; k<$patch_num; k++)); do
                if [ "${patches[$k]}" != "none" ]; then
                        if echo $patch_list | grep -w -q ${dep_array[$k]}; then
                                patch_list+="${patches[$k]} "
                                patches[$k]="none"
                                dep_array[$k]="none"
                        fi
                fi
        done
done
echo "patch_list: $patch_list"

for p in $patch_list; do
	prj=`ssh -p $port $srv gerrit query --format=TEXT --current-patch-set=$p | grep 'project:' | cut -d':' -f 2`
	pset=`ssh -p $port $srv gerrit query --format=TEXT --current-patch-set=$p | grep -A1  "currentPatchSet:" | grep number | cut -d':' -f 2 | tr -d " "`
	echo "apply patch $p/$pset to $prj"
	if ! repo download -c $prj $p/$pset > /dev/null; then
		echo "apply patch fail"
		exit 1
	fi
done

echo "apply all patches successfully"

