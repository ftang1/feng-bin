#cd /dev/shm/
#adb pull /data/logs/"$1"
trm_log MODEM $1
trm_log __is_battery_full $1
trm_log pse_get_next_cc_cv $1
trm_log RPC $1
trm_log IPC $1
trm_log Keyguard $1
trm_log AUD $1
trm_log wpa_supp $1
trm_log dalvik $1
trm_log SimWidget $1
trm_log Thermal $1
trm_log leoyang $1
trm_log __is_battery_full $1
trm_log Wifi $1
trm_log wpa_s $1

