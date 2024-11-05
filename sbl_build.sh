set -x
cd /home/feng/ws2/projects/mini_loader-fsp/
BuildLoader.py clean
python Tools/platforms/APL/build.py && python Tools/platforms/APL/stitch.py
ls -l Outputs/apl/images/DEBUG/
cp -f ~/iot/new.bin ~/iot/old.bin
cp -f Outputs/apl/images/DEBUG/ifwi_gpmrb_b1_sbl.bin ~/iot/new.bin
