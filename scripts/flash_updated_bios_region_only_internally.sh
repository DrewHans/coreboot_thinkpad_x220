#!/usr/bin/env bash


work_dir=$(pwd)

cleaned_coreboot_rom_file="cleaned_coreboot.rom"

if [ ! -f "$work_dir/$cleaned_coreboot_rom_file" ]; then
	echo "$cleaned_coreboot_rom_file not found; something went horribly wrong"
	echo "Aborting $0"
	exit 1
fi

echo "Now you are ready to flash coreboot!"
echo "If the device is already running coreboot, any subsequent flashes to BIOS region can be done internally"
echo "However, we will have to force flashrom to do it (and to ONLY flash the BIOS region; other regions are not flashable)"
echo ""

programmer="internal:laptop=force_I_want_a_brick"
eeprom_16mb_chip="W25Q128.V"
eeprom_8mb_chip="MX25L6406E/MX25L6408E"
eeprom_chip=$eeprom_16mb_chip

echo "Try running this command on the device:"
echo "sudo flashrom -p $programmer -c '$eeprom_chip'"
echo ""

echo "You should see that the programmer and eeprom chip are detected by flashrom"
echo "If not, then there may be something wrong with the device"
echo ""

echo "When you are ready, flash the coreboot rom by running this command on the device:"
echo "sudo flashrom -p $programmer -c '$eeprom_chip' -w $work_dir/$cleaned_coreboot_rom_file --ifd --image bios"
# note to self, don't forget that passing -r instead of -w will read the chip
echo ""
