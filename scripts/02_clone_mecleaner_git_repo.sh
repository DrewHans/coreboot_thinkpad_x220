#!/usr/bin/env bash


work_dir=$(pwd)

me_cleaner_repo="https://github.com/corna/me_cleaner"

if [ ! -d "$work_dir/me_cleaner" ]; then
	echo "Downloading the me_cleaner git repo"
	git clone $me_cleaner_repo $work_dir/me_cleaner
else
	echo "Detected me_cleaner directory; skipping git clone"
fi

cd $work_dir  # return to start directory
echo ""
