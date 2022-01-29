#!/usr/bin/env bash


work_dir=$(pwd)
cleaned_bios_rom="cleaned_bios.rom"

if [ ! -f "$work_dir/$cleaned_bios_rom" ]; then
    echo "$work_dir/$cleaned_bios_rom file not found; aborting"
    exit 1
fi

echo "Extracting blobs from cleaned bios rom"
ifdtool -x "$work_dir/$cleaned_bios_rom"
