#!/usr/bin/env bash


work_dir=$(pwd)

stockbios="stock_bios.rom"

if [ ! -f "$work_dir/$stockbios" ]; then
	echo "$work_dir/$stockbios file not found; aborting $0"
	exit 1
fi

echo "Extracting blobs from stockbios"
ifdtool -x "$work_dir/$stockbios"

echo ""
