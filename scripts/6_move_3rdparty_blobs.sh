#!/usr/bin/env bash


work_dir=$(pwd)
blobs_dir="$work_dir/blobs/"

mkdir -p $blobs_dir

# handle descriptor.bin
if [ -f "$blobs_dir/descriptor.bin" ]; then
    echo "Detected $blobs_dir/descriptor.bin file"
elif [ ! -f "$work_dir/flashregion_0_flashdescriptor.bin" ]; then
    echo "$work_dir/flashregion_0_flashdescriptor.bin file not found; aborting $0"
    exit 1
else
    echo "Copying flashregion_0_flashdescriptor.bin to $blobs_dir/descriptor.bin"
    cp $work_dir/flashregion_0_flashdescriptor.bin $blobs_dir/descriptor.bin
fi

# handle me.bin
if [ -f "$blobs_dir/me.bin" ]; then
    echo "Detected $blobs_dir/me.bin file"
elif [ ! -f "$work_dir/flashregion_2_intel_me.bin" ]; then
    echo "$work_dir/flashregion_2_intel_me.bin file not found; aborting $0"
    exit 1
else
    echo "Copying flashregion_2_intel_me.bin to $blobs_dir/me.bin"
    cp $work_dir/flashregion_2_intel_me.bin $blobs_dir/me.bin
fi

# handle gbe.bin
if [ -f "$blobs_dir/gbe.bin" ]; then
    echo "Detected $blobs_dir/gbe.bin file"
elif [ ! -f "$work_dir/flashregion_3_gbe.bin" ]; then
    echo "$work_dir/flashregion_3_gbe.bin file not found; aborting $0"
    exit 1
else
    echo "Copying flashregion_3_gbe.bin to $blobs_dir/gbe.bin"
    cp $work_dir/flashregion_3_gbe.bin $blobs_dir/gbe.bin
fi

# handle vgabios.bin
if [ -f "$blobs_dir/vgabios.bin" ]; then
    echo "Detected $blobs_dir/vgabios.bin file"
elif [ ! -f "$work_dir/vga-8086-0126.bin" ]; then
    echo "$work_dir/vga-8086-0126.bin file not found; aborting $0"
    exit 1
else
    echo "Copying vga-8086-0126.bin to $blobs_dir/vgabios.bin"
    cp $work_dir/vga-8086-0126.bin $blobs_dir/vgabios.bin
fi

echo ""
