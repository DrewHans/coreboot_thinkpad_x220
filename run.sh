#!/usr/bin/env bash

# TODO: improve the readability of this script

sudo_user_username=${SUDO_USER:-$USER} # user who ran this script with sudo
work_dir=$(pwd)

# location of the stock bios you read from the eeprom
stock_bios_rom="$work_dir/stock_bios.rom"

# location that the cleaned bios will be saved to
cleaned_bios_rom="$work_dir/cleaned_stock_bios.rom"

# location that the coreboot rom will be saved to
coreboot_rom="$work_dir/coreboot.rom"

# location to copy the proprietary blobs
blobs_dir="$work_dir/coreboot/3rdparty/blobs/mainboard/lenovo/x220"

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Error: You must run this script as root"
    exit 1
fi

# check prerequisite programs installed
command -v git >/dev/null 2>&1 || {
    echo "git not found; aborting"
    exit 1
}

sudo apt update

echo "Installing flashrom"
sudo apt install flashrom --yes

echo "Installing build-essential & other build tools"
sudo apt install \
    build-essential \
    libftdi1 \
    libftdi-dev \
    libusb-dev \
    libpci-dev \
    m4 \
    bison \
    flex \
    libncurses5-dev \
    libncurses5 \
    pciutils \
    usbutils \
    zlib1g-dev \
    gnat \
    --yes

echo "Downloading pre-extracted vgabios firmware"  # needed for booting windows
wget https://github.com/thetarkus/x220-coreboot-guide/raw/master/vga-8086-0126.bin

# me_cleaner work
echo "Downloading the me_cleaner git repo"
git clone https://github.com/corna/me_cleaner $work_dir/me_cleaner

echo "Creating cleaned bios rom"
$work_dir/me_cleaner/me_cleaner.py --soft-disable $stock_bios_rom --output "$cleaned_bios_rom"

# coreboot work
echo "Downloading the coreboot git repo"
git clone --recurse-submodules https://review.coreboot.org/coreboot.git $work_dir/coreboot

echo "Copying coreboot configuration"
cp $work_dir/coreboot.config $work_dir/coreboot/.config

echo "Compiling/installing coreboot's ifdtool"
cd $work_dir/coreboot/util/ifdtool
make && sudo make install
cd $work_dir  # return to start directory
echo "Extracting blobs from cleaned bios rom"
ifdtool -x "$cleaned_bios_rom"
mkdir -p $blobs_dir
cp $work_dir/flashregion_0_flashdescriptor.bin $blobs_dir/descriptor.bin
cp $work_dir/flashregion_2_intel_me.bin $blobs_dir/me.bin
cp $work_dir/flashregion_3_gbe.bin $blobs_dir/gbe.bin

# TODO: sed inplace update the vgabios.bin path in config using variable in this file
# set path to $work_dir/vga-8086-0126.bin

cd $work_dir/coreboot

make crossgcc-i386 CPUS=6
make iasl
make

cp $work_dir/coreboot/build/coreboot.rom $work_dir/coreboot.rom

cd $work_dir

echo "Coreboot rom build complete"

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
