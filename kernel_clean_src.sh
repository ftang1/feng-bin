if [ "$1" == "" ]
then
	cwd=.
else	
	cwd=$1
fi

echo $cwd

cd "$cwd"
pwd

# Clean some dev stuff
rm -rf *.patch
rm -rf cscope*
rm -rf tags
#------------------


mv arch/x86 .

rm -rf arch

mkdir tmp-fs/

cp fs/*.c tmp-fs/

# cut fs/
cd fs
	mv devpts debugfs ecryptfs proc pstore ramfs sysfs ext4 ../tmp-fs/
cd ..

rm -rf fs
mv tmp-fs fs/
# cut fs/ done


# cut drivers/
cd drivers
	rm -rf accessibility amba atm auxdisplay bcma cdrom connector dca 
	rm -rf edac eisa extcon firewire fmc gator hv hwspinlock infiniband 
	rm -rf ipack isdn leds macintosh memstick nubus parisc parport pcmcia
	rm -rf powercap pps ps3 ptp rapidio s390 sh sn uwb uio w1 zorro

	## net
	cd net
		rm -rf appletalk arcnet can cris dsa irda hamradio vmxnet3 wan
		rm -rf wimax plip hippi ieee802154

		mv ethernet/intel eth-intel
		mv ethernet/realtek eth-rtlk
		rm -rf ethernet

		mv wireless/iwlwifi wlan-iwl
		mv wireless/ti	wlan-ti
		rm -rf wireless
	cd ..

	## staging
	mv staging/android stg-android
	cd staging
	cd ..
	rm -rf staging

	## gpu
	cd gpu 
		cd drm
			rm -rf armada ast bochs cirrus nouveau omapdrm qxl
			rm -rf r128 radeon rcar-du savage shmobile sis tdfx tegra
			rm -rf tilcdc ttm udl via vmwgfx mgag200 mga
		cd ..
	cd ..

	## media
	cd media 
		rm -rf pci parport dvb-frontends

		cd platform
			rm -rf s3c* omap* exynos* ti-vpa vspl blackfin
		cd ..
	cd ..

	## video
	cd video
		rm -rf back* omap* logo kyro riva savage via sis 
	cd ..

cd ..
# cut drivers done


# cut net protocl
cd net
	rm -rf appletalk atm ax25 caif can ceph dcb dccp decnet dns_resolver
	rm -rf dsa hsr ipx irda iucv key lapb llc mpls netfilter netlable sctp
	rm -rf tipc wimax xfrm vmw_vsock
cd ..

# cut net done


# cut sound <<< 
cd sound

	mv pci/hda pci-hda
	rm -rf pci
	
	cd soc
		rm -rf adi atmel au1x bcm blackfin cirrus
		rm -rf davinci fsl jz4740 kirkwood mxs nuc900
		rm -rf omap pxa s6000 samsung sh spear tegra txx9 ux500
	cd ..
cd ..
# cut sound/ >>> 

# Remove the EXPORT_SYMBOL EXPORT_GPL_SYMBOL
find . -name *.[ch] | xargs sed -i -e '/EXPORT_SYMBOL/d'

