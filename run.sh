#!/usr/bin/env bash


echo "Starting $0"

# chain script calls to ensure aborts stop the run
$work_dir/scripts/00_check_file_dependencies.sh && \
$work_dir/scripts/01_apt_install_required_tools.sh && \
$work_dir/scripts/02_clone_mecleaner_git_repo.sh && \
$work_dir/scripts/03_clone_coreboot_git_repo.sh && \
$work_dir/scripts/04_build_and_install_coreboots_ifdtool.sh && \
$work_dir/scripts/05_extract_blobs_from_stockbios.sh && \
$work_dir/scripts/06_download_vgabios_blob.sh && \
$work_dir/scripts/07_move_3rdparty_blobs.sh && \
$work_dir/scripts/08_configure_coreboot.sh && \
$work_dir/scripts/09_build_coreboot_rom.sh && \
$work_dir/scripts/10_clean_coreboot_rom.sh

echo "Finished $0"
