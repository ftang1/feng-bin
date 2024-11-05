rm binaries/*
rm ~/pulse*.rpm
#sleep 50 
#osc getbinaries standard i586  --debug

#cd git-pulseaudio-0.9.22
#gd HEAD^^ > ../a.patch
#cd ..

osc commit -m "change `date`"

i=1
max_loop=20

sleep 30
while [ $i -lt $max_loop ]
do
	echo "loop $i"
	osc results > /tmp/1.log
	grep succeeded /tmp/1.log || sleep 10 
	#grep succeeded /tmp/1.log && osc getbinaries --debug standard i586 && break
	grep succeeded /tmp/1.log && osc getbinaries standard i586 && break

	let i=i+1
done

rm /tmp/1.log

cp binaries/*.rpm /home/feng

#osc getbinaries home:feng:branches:Trunk kernel-adaptation-intel-automotive standard i586
