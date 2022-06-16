#!/usr/bin/env bash


work_dir=$(pwd)
me_cleaner_repo="https://github.com/corna/me_cleaner"
coreboot_repo="https://review.coreboot.org/coreboot"

coreboot_version_tag="4.17"  # set the latest numbered version here

# check prerequisite programs installed
command -v git >/dev/null 2>&1 || {
    echo "git not found; aborting $0"
    exit 1
}

if [ ! -d "$work_dir/me_cleaner" ]; then
    echo "Downloading the me_cleaner git repo"
    git clone $me_cleaner_repo $work_dir/me_cleaner
else
    echo "Detected me_cleaner directory; skipping git clone"
fi

echo ""

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
