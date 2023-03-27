#!/usr/bin/env bash


echo "Updating apt repositories"
sudo apt update
echo ""

echo "Installing required tools"
sudo apt install \
	flashrom \
	git \
	build-essential \
	acpica-tools \
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
