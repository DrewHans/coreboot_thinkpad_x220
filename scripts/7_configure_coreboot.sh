#!/usr/bin/env bash


work_dir=$(pwd)

if [ -f "$work_dir/coreboot.config" ]; then
    echo "$work_dir/coreboot.config found"
    echo "Copying coreboot.config file to $work_dir/coreboot/.config"
    cp $work_dir/coreboot.config $work_dir/coreboot/.config
else
    echo "$work_dir/coreboot.config not found"
    cd $work_dir/coreboot/
    make nconfig
fi

if [ ! -f "$work_dir/coreboot/.config" ]; then
    echo "$work_dir/coreboot/.config not found; aborting"
    exit 1
fi

cd $work_dir