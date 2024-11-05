
echo "Start copy:"
sudo mount /dev/sdb /mnt
scp shbuild888:/home/feng/ws2/projects/linux-2.6/arch/x86/boot/bzImage .
sudo cp bzImage /mnt/
sudo cp ~/ws2/mid/clv_acpi_efi/elilo/elilo-3.14-src/elilo.efi /mnt/efi/
sudo umount /mnt/
echo "Copy done!"
