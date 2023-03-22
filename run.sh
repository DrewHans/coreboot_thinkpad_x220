#!/usr/bin/env bash

work_dir=$(pwd)
stock_bios_rom="stock_bios.rom"
bootsplash="bootsplash.jpg"

if [ ! -f "$work_dir/$stock_bios_rom" ]; then
    echo "$work_dir/$stock_bios_rom file not found"
    echo "You need to BYOB (bring your own bios)"
    echo "Aborting $0"
    exit 1
fi

if [ ! -f "$work_dir/$bootsplash" ]; then
    echo "$work_dir/$bootsplash file not found"
    echo "Aborting $0"
    exit 1
fi

# chain script calls to ensure aborts stop the run
$work_dir/scripts/0_install_prerequisites.sh \
&& $work_dir/scripts/1_clone_git_repos.sh \
&& $work_dir/scripts/2_build_ifdtool.sh \
&& $work_dir/scripts/3_create_cleaned_rom.sh \
&& $work_dir/scripts/4_extract_blobs_from_cleaned_rom.sh \
&& $work_dir/scripts/5_download_vgabios.sh \
&& $work_dir/scripts/6_move_3rdparty_blobs.sh \
&& $work_dir/scripts/7_configure_coreboot.sh \
&& $work_dir/scripts/8_build_coreboot.sh

echo "Finished $0"

# next step is to flash internally or externally
