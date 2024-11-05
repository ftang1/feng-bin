#set -x

date > /home/feng/ifconfig.log
ifconfig >> /home/feng/ifconfig.log
mount | grep b8 || sshfs shbuild888: /home/feng/b8/
mount | grep b9 || sshfs shbuild999: /home/feng/b9/
cp ifconfig.log /home/feng/b8/
cp ifconfig.log /home/feng/b9/
#ssh shbuild888 sshfs feng-snb: /home/feng/sshfs/
#ssh shbuild999 sshfs feng-snb: /home/feng/sshfs/

