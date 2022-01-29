#!/usr/bin/env bash


work_dir=$(pwd)
stock_bios_rom="stock_bios.rom"
cleaned_bios_rom="cleaned_bios.rom"

echo "Creating $cleaned_bios_rom with me_cleaner.py"

if [ ! -f "$work_dir/$stock_bios_rom" ]; then
    echo "$work_dir/$stock_bios_rom file not found; aborting"
    exit 1
fi

$work_dir/me_cleaner/me_cleaner.py --soft-disable $work_dir/$stock_bios_rom --output $work_dir/$cleaned_bios_rom
