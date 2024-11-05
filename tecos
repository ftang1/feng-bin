cd ~/vredemo/vre_demo1/ecos_info/vre0_48mhz_512K_ondie_build
make clean 
make -j 8 || exit
#make clean && make -j 8
cd ~/vredemo/vre_demo1/
rm -f *.o vre_demo *.bin *.srec && ./build && cp vre_demo.srec ~/1.srec
