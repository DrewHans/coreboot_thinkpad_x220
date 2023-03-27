#!/usr/bin/env bash


work_dir=$(pwd)

cleaned_coreboot_rom_file="cleaned_coreboot.rom"

echo "Expanding $cleaned_coreboot_rom_file file to 16 MB chip size"

truncate -s 16777216 $work_dir/$cleaned_coreboot_rom_file

echo ""
