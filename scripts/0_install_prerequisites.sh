#!/usr/bin/env bash


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

echo ""
