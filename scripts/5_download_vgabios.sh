#!/usr/bin/env bash


work_dir=$(pwd)
vgabin="vga-8086-0126.bin"

if [ ! -f "$work_dir/$vgabin" ]; then
    echo "Downloading pre-extracted vgabios firmware"  # needed for booting windows
    wget https://github.com/thetarkus/x220-coreboot-guide/raw/master/vga-8086-0126.bin
else
    echo "Detected vgabios firmware at $work_dir/$vgabin"
fi

echo ""
