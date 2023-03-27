#!/usr/bin/env bash


work_dir=$(pwd)

me_cleaner_dir="/home/nyancat/Code/coreboot_thinkpad_x220/me_cleaner"

if [[ $# -ne 1 ]]
then
	 echo "Error: you must provide the name of a rom file"
	 echo "Usage: $0 coreboot-4.16-i5-8MB.rom"
	 exit 3
fi

original_rom_file="$1"
cleaned_rom_file="cleaned-${1}"


if [ ! -f "$work_dir/$original_rom_file" ]
then
	echo "$work_dir/$original_rom_file file not found; aborting $0"
	exit 1
fi

if [ ! -f "$work_dir/$cleaned_rom_file" ]
then
	echo "Creating $cleaned_rom_file with me_cleaner.py"

	$me_cleaner_dir/me_cleaner.py \
		-S -r -t -d \
		-D ifd_shrinked.bin \
		-M me_shrinked.bin \
		-O $work_dir/$cleaned_rom_file \
		$work_dir/$original_rom_file

	# -S => soft-disable; set the MeAltDisable bit or the HAP bit to ask Intel ME/TXE to disable itself after the hardware initialization.
	# -r => relocate; relocate the FTPR partition to the top of the ME region to save even more space.
	# -t => truncate; truncate the empty part of the firmware (requires a separated ME/TXE image or `--extract-me`).
	# -d => descriptor; remove the ME/TXE Read/Write permissions to the other regions on the flash from the Intel Flash Descriptor (requires a full dump).
	# -D => extract-descriptor; extract the flash descriptor from a full dump; when used with `--truncate` save a descriptor with adjusted regions start and end.
	# -M => extract-me; extract the ME firmware from a full dump; when used with `--truncate` save a truncated ME/TXE image.
	# -O => output; save the modified image in a separate file, instead of modifying the original file.

else
	echo "Detected $cleaned_rom_file at $work_dir/$cleaned_rom_file"
	echo "Checking whether the provided rom file has a valid structure and signature..."
	echo ""

	$me_cleaner_dir/me_cleaner.py -c $work_dir/$original_rom_file

	echo ""
	echo "Finished checking rom file"
fi

echo ""
