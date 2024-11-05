set -x
kcpuid -h

sleep 5

kcpuid 
sleep 5

kcpuid -d
sleep 5
kcpuid -b

kcpuid -l 0x80000000
sleep 5
kcpuid -l 4
sleep 5
kcpuid -l 4 -s 2
sleep 5
