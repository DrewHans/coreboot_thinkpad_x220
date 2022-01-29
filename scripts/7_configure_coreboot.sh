#!/usr/bin/env bash


work_dir=$(pwd)

if [ -f "$work_dir/coreboot.config" ]; then
    echo "Found coreboot.config at $work_dir/coreboot.config"
    echo "Copying coreboot.config file to $work_dir/coreboot/.config"
    cp $work_dir/coreboot.config $work_dir/coreboot/.config
else
    echo "$work_dir/coreboot.config not found"
    echo "Running make nconfig"
    cd $work_dir/coreboot/
    make nconfig
    echo ""

    echo "Backing up $work_dir/coreboot/.config to $work_dir/coreboot.config"
    cp $work_dir/coreboot/.config $work_dir/coreboot.config
fi

if [ ! -f "$work_dir/coreboot/.config" ]; then
    echo "$work_dir/coreboot/.config not found; aborting $0"
    exit 1
fi

cd $work_dir  # return to start directory
echo ""
