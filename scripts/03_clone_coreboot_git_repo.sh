#!/usr/bin/env bash


work_dir=$(pwd)

coreboot_repo="https://review.coreboot.org/coreboot"

coreboot_version_tag="4.19"  # set the latest numbered version here

if [ ! -d "$work_dir/coreboot" ]; then
	echo "Downloading the coreboot git repo"
	git clone $coreboot_repo $work_dir/coreboot
else
	echo "Detected coreboot directory; skipping git clone"
fi

echo ""

echo "Checking out coreboot release $coreboot_version_tag"
cd $work_dir/coreboot
git fetch --all --tags
git checkout tags/$coreboot_version_tag -b v$coreboot_version_tag-branch

cd $work_dir  # return to start directory
echo ""
