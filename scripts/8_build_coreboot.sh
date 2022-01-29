#!/usr/bin/env bash


work_dir=$(pwd)

if [ ! -f "$work_dir/coreboot/.config" ]; then
    echo "$work_dir/coreboot/.config not found; aborting"
    exit 1
fi

cd $work_dir/coreboot/

echo "Detecting system architecture to optimize crossgcc compilation"
num_of_cpus_on_system=$(grep -c ^processor /proc/cpuinfo)
num_of_cpus_to_use=$(( $num_of_system_cpus / 2 ))
system_arch=$(uname -m)
arch="x64"

if [ system_arch -eq "x86_64" ]; then
    arch="x64"
fi

if [ system_arch -eq "ix86" ]; then
    arch="i386"
fi

if [ system_arch -eq "arm" ]; then
    arch="arm"
fi

echo "Detected $system_arch system architecture"
echo "Detected $num_of_cpus_on_system CPU cores on system"
echo "$arch arch & $num_of_cpus_to_use CPU cores will be used"

echo "Running make crossgcc-$arch CPUS=$num_of_cpus_to_use"
make crossgcc-$arch CPUS=$num_of_cpus_to_use || {
    echo "Error detected; aborting"
    exit 1
}

echo "Running make iasl"
make iasl || {
    echo "Error detected; aborting"
    exit 1
}

echo "Running make"
make || {
    echo "Error detected; aborting"
    exit 1
}

echo "Build complete!"

echo "Copying coreboot.rom file to $work_dir"
cp $work_dir/coreboot/build/coreboot.rom $work_dir/coreboot.rom

cd $work_dir
