#!/usr/bin/env bash


work_dir=$(pwd)

echo "Downloading pre-extracted vgabios firmware"  # needed for booting windows
wget https://github.com/thetarkus/x220-coreboot-guide/raw/master/vga-8086-0126.bin
