#!/usr/bin/env bash


work_dir=$(pwd)

echo "Expanding coreboot.rom file to my winbond W25Q128.V chip size"
truncate -s 16777216 $work_dir/coreboot.rom

cd $work_dir  # return to start directory
echo ""
