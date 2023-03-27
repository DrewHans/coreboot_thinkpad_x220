#!/usr/bin/env bash


work_dir=$(pwd)

cleaned_coreboot_rom_file="cleaned_coreboot.rom"

if [ ! -f "$work_dir/$cleaned_coreboot_rom_file" ]; then
	echo "$cleaned_coreboot_rom_file not found; something went horribly wrong"
	echo "Aborting $0"
	exit 1
fi

echo "Now you are ready to flash coreboot!"

programmer="ch341a_spi"
eeprom_16mb_chip="W25Q128.V"
eeprom_8mb_chip="MX25L6406E/MX25L6408E"
eeprom_chip=$eeprom_16mb_chip

echo "Try running:"
echo "sudo flashrom -p $programmer -c '$eeprom_chip'"
echo ""

echo "You should see that the programmer and eeprom chip are detected by flashrom"
echo "If not, then you probably need to fix your clip"
echo ""

echo "When you are ready, flash the cleaned coreboot rom by running:"
echo "sudo flashrom -p $programmer -c '$eeprom_chip' -w $work_dir/$cleaned_coreboot_rom_file"
# note to self, don't forget that passing -r instead of -w will read the chip

echo ""
