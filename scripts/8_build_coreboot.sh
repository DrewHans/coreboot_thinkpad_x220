#!/usr/bin/env bash


work_dir=$(pwd)

if [ ! -f "$work_dir/coreboot/.config" ]; then
    echo "$work_dir/coreboot/.config not found; aborting $0"
    exit 1
fi

cd $work_dir/coreboot/

num_of_cpus_on_system=$(grep -c ^processor /proc/cpuinfo)
num_of_cpus_to_use=$(( $num_of_cpus_on_system / 2 ))
echo "Detected $num_of_cpus_on_system CPU cores available: $num_of_cpus_to_use CPU cores will be used"
echo ""

echo "Running make crossgcc-i386 CPUS=$num_of_cpus_to_use"
make crossgcc-i386 CPUS=$num_of_cpus_to_use || {
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
