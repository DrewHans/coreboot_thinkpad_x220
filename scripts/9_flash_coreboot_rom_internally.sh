#!/usr/bin/env bash


work_dir=$(pwd)

if [ ! -f "$work_dir/coreboot.rom" ]; then
    echo "coreboot.rom not found; something went horribly wrong"
    echo "Aborting $0"
    exit 1
fi

echo "Now you are ready to flash coreboot!"

programmer="internal:laptop=force_I_want_a_brick"
eeprom_chip="W25Q128.V"

echo "Try running: sudo flashrom -p $programmer -c '$eeprom_chip'"
echo "You should see that the programmer and eeprom chip are detected by flashrom"
echo "If not, then you need to fix your clip"
echo ""

echo "When you are ready, flash the coreboot rom by running:"
echo "sudo flashrom -p $programmer -c '$eeprom_chip' -w $work_dir/coreboot.rom --ifd --image bios --no-verify"
# note to self, don't forget that passing -r instead of -w will read the chip

echo ""
