#!/usr/bin/env bash


work_dir=$(pwd)

if [ ! -f "$work_dir/coreboot/.config" ]; then
    echo "$work_dir/coreboot/.config not found; aborting $0"
    exit 1
fi

cd $work_dir/coreboot/

echo "Detecting system architecture to optimize crossgcc compilation"
num_of_cpus_on_system=$(grep -c ^processor /proc/cpuinfo)
num_of_cpus_to_use=$(( $num_of_cpus_on_system / 2 ))
system_arch=$(uname -m)
arch="x64"
if [ $system_arch == "x86_64" ]; then
    arch="x64"
fi
if [ $system_arch == "ix86" ]; then
    arch="i386"
fi
if [ $system_arch == "arm" ]; then
    arch="arm"
fi
echo "Detected $system_arch system architecture: $arch arch option will be used"
echo "Detected $num_of_cpus_on_system CPU cores available: $num_of_cpus_to_use CPU cores will be used"
echo ""

# TODO: figure out if this build works or if we can only use i386 for the x220
echo "Running make crossgcc-$arch CPUS=$num_of_cpus_to_use"
make crossgcc-$arch CPUS=$num_of_cpus_to_use || {
    echo "Error detected; aborting $0"
    exit 1
}
echo ""

echo "Running make iasl"
make iasl || {
    echo "Error detected; aborting $0"
    exit 1
}
echo ""

echo "Making coreboot rom"
make || {
    echo "Error detected; aborting $0"
    exit 1
}
echo ""

echo "Build complete!"

echo "Copying coreboot.rom file to $work_dir"
cp $work_dir/coreboot/build/coreboot.rom $work_dir/coreboot.rom

cd $work_dir  # return to start directory
echo ""
