#!/usr/bin/env bash

work_dir=$(pwd)

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Error: You must run this script as root"
    exit 1
fi


# TODO: consider refactoring these scripts into one...
# - I had trouble keeping all these steps organized in one single file
#   so I decided to split them apart into several little scripts

sudo bash $work_dir/0_install_prerequisites.sh

bash $work_dir/1_clone_git_repos.sh

sudo bash $work_dir/2_build_ifdtool.sh

bash $work_dir/3_create_cleaned_rom.sh

bash $work_dir/4_extract_blobs_from_cleaned_rom.sh

bash $work_dir/5_download_vgabios.sh

bash $work_dir/6_move_3rdparty_blobs.sh

bash $work_dir/7_configure_coreboot.sh

bash $work_dir/8_build_coreboot.sh

bash $work_dir/9_flash_coreboot_rom.sh

# Online references:
# https://michaelmob.com/post/coreboot-thinkpad-x220/
# https://www.coreboot.org/Board:lenovo/x220
# https://www.youtube.com/watch?v=ExQKOtZhLBM
# https://tylercipriani.com/blog/2016/11/13/coreboot-on-the-thinkpad-x220-with-a-raspberry-pi/


## Common Issues
# - *I'm getting "No EEPROM/flash device found" when trying to read the BIOS rom.*
# Make sure that you've enabled SPI and run `ls /dev | grep spi` to confirm that your SPI devices are detected properly. If they do not appear it may have to do with your kernel. Download and flash latest Raspbian Lite and follow the tutorial from the start.


# - *One of the `make` command fails with the follow output:*
#   ```
#   Microcode error: 3rdparty/blobs/cpu/intel/model_206ax/microcode.bin does not exist Microcode error: 3rdparty/blobs/cpu/intel/model_306ax/microcode.bin does not exist src/cpu/Makefile.inc:40: error execution recepie for target «build/cpu_microcode_blob.bin» make: ** [build/cpu_microcode_blob.bin] Error 1
#   ```
#   Clone coreboot's [3rd party blobs](https://github.com/coreboot/blobs) repository.
#   ```
#   cd ~/coreboot/3rdparty
#   git clone http://review.coreboot.org/blobs.git

#   # more details:
#   # https://www.reddit.com/r/coreboot/comments/7y6nqo/missing_microcode/
#   ```
