set -x
echo "Start copy:"
sudo mount /dev/sdb /mnt
scp shbuild888:/home/feng/ws2/projects/byt-clv/arch/x86/boot/bzImage .
sudo cp bzImage /mnt/
#sudo cp ~/ws2/mid/clv_acpi_efi/elilo/elilo-3.14-src/elilo.efi /mnt/
sudo umount /mnt/
echo "Copy done!"
