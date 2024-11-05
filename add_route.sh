set -x
route -n
route add -net 10.0.0.0/8 dev eth1
route add -host 172.17.6.9 dev eth1
route del default
route add default gw 192.168.1.253
