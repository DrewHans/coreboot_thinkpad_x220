#!/usr/bin/env bash


work_dir=$(pwd)

echo "Building coreboot's ifdtool"

cd $work_dir/coreboot/util/ifdtool

make

sudo make install

cd $work_dir  # return to start directory
echo ""
