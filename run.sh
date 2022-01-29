#!/usr/bin/env bash

work_dir=$(pwd)
stock_bios_rom="stock_bios.rom"

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Error: You must run this script as root"
    exit 1
fi

if [ ! -f "$work_dir/$stock_bios_rom" ]; then
    echo "$work_dir/$stock_bios_rom file not found"
    echo "You need to BYOB (bring your own bios)"
    echo "Aborting $0"
    exit 1
fi

# TODO: consider refactoring these scripts into one...
# - I had trouble keeping all these steps organized in one single file
#   so I decided to split them apart into several little scripts

sudo bash $work_dir/scripts/0_install_prerequisites.sh

bash $work_dir/scripts/1_clone_git_repos.sh

sudo bash $work_dir/scripts/2_build_ifdtool.sh

bash $work_dir/scripts/3_create_cleaned_rom.sh

bash $work_dir/scripts/4_extract_blobs_from_cleaned_rom.sh

bash $work_dir/scripts/5_download_vgabios.sh

bash $work_dir/scripts/6_move_3rdparty_blobs.sh

bash $work_dir/scripts/7_configure_coreboot.sh

bash $work_dir/scripts/8_build_coreboot.sh

bash $work_dir/scripts/9_flash_coreboot_rom.sh
