#!/usr/bin/env bash


work_dir=$(pwd)

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Error: You must run this script as root"
    exit 1
fi

echo "Building coreboot's ifdtool"

cd $work_dir/coreboot/util/ifdtool

make

sudo make install

cd $work_dir  # return to start directory
