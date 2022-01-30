#!/usr/bin/env bash


work_dir=$(pwd)
blobs_dir="$work_dir/coreboot/3rdparty/blobs/mainboard/lenovo/x220/"

if [ ! -f "$work_dir/flashregion_0_flashdescriptor.bin" ]; then
    echo "$work_dir/flashregion_0_flashdescriptor.bin file not found; aborting $0"
    exit 1
fi

if [ ! -f "$work_dir/flashregion_2_intel_me.bin" ]; then
    echo "$work_dir/flashregion_2_intel_me.bin file not found; aborting $0"
    exit 1
fi

if [ ! -f "$work_dir/flashregion_3_gbe.bin" ]; then
    echo "$work_dir/flashregion_3_gbe.bin file not found; aborting $0"
    exit 1
fi

if [ ! -f "$work_dir/vga-8086-0126.bin" ]; then
    echo "$work_dir/vga-8086-0126.bin file not found; aborting $0"
    exit 1
fi

echo "Creating $blobs_dir directory to store blob files"
mkdir -p $blobs_dir

echo "Copying blobs extracted from cleaned_bios.rom to $blobs_dir"
cp $work_dir/flashregion_0_flashdescriptor.bin $blobs_dir/descriptor.bin
cp $work_dir/flashregion_2_intel_me.bin $blobs_dir/me.bin
cp $work_dir/flashregion_3_gbe.bin $blobs_dir/gbe.bin

echo "Copying vgabios to $blobs_dir"
cp $work_dir/vga-8086-0126.bin $blobs_dir/vgabios.bin

echo ""
