#!/usr/bin/env bash


work_dir=$(pwd)

if [ ! -f "$work_dir/coreboot.rom" ]; then
    echo "coreboot.rom not found; something went horribly wrong"
    echo "Aborting $0"
    exit 1
fi

echo "Now you are ready to flash coreboot!"

programmer="ch341a_spi"
eeprom_16mb_chip="W25Q128.V"
eeprom_8mb_chip="MX25L6406E/MX25L6408E"

echo "Try running:"
echo "sudo flashrom -p $programmer -c '$eeprom_16mb_chip'"
echo ""

echo "You should see that the programmer and eeprom chip are detected by flashrom"
echo "If not, then you probably need to fix your clip"
echo ""

echo "When you are ready, flash the coreboot rom by running:"
echo "sudo flashrom -p $programmer -c '$eeprom_16mb_chip' -w $work_dir/coreboot.rom"
# note to self, don't forget that passing -r instead of -w will read the chip

echo ""
