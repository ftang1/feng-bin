set -x
cd /home/feng/ws2/projects/NDG/main_atp/wearable_device_sw/packages/intel/iq/tests/
sudo python raw_sensor_single.py $1 -p -freq 50 -d 5 --csv
