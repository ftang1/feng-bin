set -x
make sbl-hypervisor && scp build/hypervisor-sbl/acrn.32.out root@10.239.154.$1: && ssh root@10.239.154.$1 new_acrn 
