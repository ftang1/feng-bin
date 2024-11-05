old_size=`cat /sys/kernel/debug/tracing/buffer_size_kb`
echo $old_size
let old_size=$old_size+128
echo $old_size > /sys/kernel/debug/tracing/buffer_size_kb 
