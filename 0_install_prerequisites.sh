#!/usr/bin/env bash


# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Error: You must run this script as root"
    exit 1
fi

echo "Updating apt repositories"
sudo apt update

echo "Installing flashrom"
sudo apt install flashrom --yes

echo "Installing build-essential & other required tools"
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
