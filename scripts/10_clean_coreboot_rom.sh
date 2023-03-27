#!/usr/bin/env bash


work_dir=$(pwd)

original_coreboot_rom_file="coreboot.rom"
cleaned_coreboot_rom_file="cleaned_coreboot.rom"


if [ ! -f "$work_dir/$original_coreboot_rom_file" ]; then
	echo "$work_dir/$original_coreboot_rom_file file not found; aborting $0"
	exit 1
fi

if [ ! -f "$work_dir/$cleaned_coreboot_rom_file" ]; then
	echo "Creating $cleaned_coreboot_rom_file with me_cleaner.py"

	$work_dir/me_cleaner/me_cleaner.py \
		-S -r -t -d \
		-D ifd_shrinked.bin \
		-M me_shrinked.bin \
		-O $work_dir/$cleaned_coreboot_rom_file \
		$work_dir/$original_coreboot_rom_file

	# -S => soft-disable; set the MeAltDisable bit or the HAP bit to ask Intel ME/TXE to disable itself after the hardware initialization.
	# -r => relocate; relocate the FTPR partition to the top of the ME region to save even more space.
	# -t => truncate; truncate the empty part of the firmware (requires a separated ME/TXE image or `--extract-me`).
	# -d => descriptor; remove the ME/TXE Read/Write permissions to the other regions on the flash from the Intel Flash Descriptor (requires a full dump).
	# -D => extract-descriptor; extract the flash descriptor from a full dump; when used with `--truncate` save a descriptor with adjusted regions start and end.
	# -M => extract-me; extract the ME firmware from a full dump; when used with `--truncate` save a truncated ME/TXE image.
	# -O => output; save the modified image in a separate file, instead of modifying the original file.

else
	echo "Detected $cleaned_coreboot_rom_file at $work_dir/$cleaned_coreboot_rom_file"
fi


echo ""
