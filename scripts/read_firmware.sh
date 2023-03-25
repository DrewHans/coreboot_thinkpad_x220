#!/usr/bin/env bash


# check prerequisite program installed
command -v flashrom >/dev/null 2>&1 || {
    echo "flashrom not found; aborting $0"
    exit 1
}

echo "Starting script"

echo "Verify that the ch341a programmer is detected, then hit enter"
sudo flashrom --programmer ch341a_spi
read

echo "Connect your soic8 clip to the flash chip, connect the clip wires to the programmer, then hit enter"
read

echo "Verify that the programmer is detecting the flash chip, then hit enter"
sudo flashrom --programmer ch341a_spi
read

echo "Now we're ready to read the flash chip; hit enter to begin the first read"
read

sudo flashrom --programmer ch341a_spi -c "MX25L6406E/MX25L6408E" -r "firmware_read_1.bin"
echo "First read finished; hit enter to begin the second read"
read

sudo flashrom --programmer ch341a_spi -c "MX25L6406E/MX25L6408E" -r "firmware_read_2.bin"
echo "Second read finished; hit enter to begin the third read"
read

sudo flashrom --programmer ch341a_spi -c "MX25L6406E/MX25L6408E" -r "firmware_read_3.bin"
echo "Third read finished; hit enter to begin sha256sum verification"
read

sha256sum ./firmware_read_1.bin
sha256sum ./firmware_read_2.bin
sha256sum ./firmware_read_3.bin

echo "Now verify that all three reads share the same sha256sum value, then hit enter"
read

echo "Now backup the reads on another drive"
echo "Finished"
