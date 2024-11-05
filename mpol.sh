#set -x

echo $@

numactl -H

echo
echo

echo "Testing MPOL_PREFERRED_MANY"
echo "==========================="
echo
echo


echo
echo "-------------"
time tmpol -q  -p 5 -n 0xC  -s 900 $@

echo
echo "-------------"
time tmpol -q  -p 5 -n 0xC  -s 130 $@
echo

echo "-------------"
time tmpol -q  -p 5 -n 8  -s 40 $@


echo
echo "-------------"
time tmpol -q  -p 5 -n 8  -s 60 $@


echo
echo "-------------"
time tmpol -q  -p 5 -n 0xC  -s 60 $@



echo
echo
echo "Testing MPOL_PREFERRED"
echo "==========================="
echo
echo


echo
echo "-------------"
time tmpol -q  -p 1 -n 8  -s 40 $@
echo
echo "-------------"
time tmpol -q  -p 1 -n 8  -s 60 $@


