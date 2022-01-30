#!/usr/bin/env bash


work_dir=$(pwd)
stock_bios_rom="stock_bios.rom"
cleaned_bios_rom="cleaned_bios.rom"


if [ ! -f "$work_dir/$stock_bios_rom" ]; then
    echo "$work_dir/$stock_bios_rom file not found; aborting $0"
    exit 1
fi

if [ ! -f "$work_dir/$cleaned_bios_rom" ]; then
    echo "Creating $cleaned_bios_rom with me_cleaner.py"
    $work_dir/me_cleaner/me_cleaner.py --soft-disable $work_dir/$stock_bios_rom --output $work_dir/$cleaned_bios_rom
else
    echo "Detected $cleaned_bios_rom at $work_dir/$cleaned_bios_rom"
fi


echo ""
