set -x
route -n
route del -net 10.0.0.0/8 
route del default
route add default gw 10.239.154.1 
