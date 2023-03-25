#!/usr/bin/env bash


work_dir=$(pwd)

if [ ! -f "$work_dir/coreboot.rom" ]; then
    echo "coreboot.rom not found; something went horribly wrong"
    echo "Aborting $0"
    exit 1
fi

echo "Now you are ready to flash coreboot!"
echo "If the device is already running coreboot, any subsequent flashes can be done internally"
echo "However, we will have to force flashrom to do it (and to ONLY flash the BIOS region)"
echo ""

programmer="internal:laptop=force_I_want_a_brick"
eeprom_chip="W25Q128.V"

echo "Try running this command on the device:"
echo "sudo flashrom -p $programmer -c '$eeprom_chip'"
echo ""

echo "You should see that the programmer and eeprom chip are detected by flashrom"
echo "If not, then there may be something wrong with the device"
echo ""

echo "When you are ready, flash the coreboot rom by running this command on the device:"
echo "sudo flashrom -p $programmer -c '$eeprom_chip' -w $work_dir/coreboot.rom --ifd --image bios --no-verify"
# note to self, don't forget that passing -r instead of -w will read the chip

echo ""
