#!/usr/bin/env bash

work_dir=$(pwd)

stock_bios_rom="stock_bios.rom"
bootsplash="bootsplash.jpg"

if [ ! -f "$work_dir/$stock_bios_rom" ]; then
	echo "$work_dir/$stock_bios_rom file not found"
	echo "You need to bring your own bios"
	echo "Aborting $0"
	exit 1
fi

if [ ! -f "$work_dir/$bootsplash" ]; then
	echo "$work_dir/$bootsplash file not found"
	echo "You should bring your own bootsplash image"
	echo "Aborting $0"
	exit 1
fi
