#!/usr/bin/env bash


work_dir=$(pwd)

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Error: You must run this script as root"
    exit 1
fi

if [ ! -f "$work_dir/coreboot.rom" ]; then
    echo "$work_dir/coreboot.rom not found; something went horribly wrong"
    echo "Aborting"
    exit 1
fi

echo "Now you are ready to flash coreboot!"

programmer="ch341a_spi"
eeprom_chip="W25Q128.V"

echo "Try running: sudo flashrom -p $programmer -c '$eeprom_chip'"
echo "You should see that the programmer and eeprom chip are detected by flashrom"
echo "If not, then you need to fix your clip"
echo ""

echo "When you are ready, flash the coreboot rom by running:"
echo "sudo flashrom -p $programmer -c '$eeprom_chip' -w $work_dir/coreboot.rom"
echo ""
# note to self, don't forget that passing -r instead of -w will read the chip
