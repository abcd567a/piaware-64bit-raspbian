#!/bin/bash

echo -e "\e[32mCreating folder dump1090-fa-pkg to hold packages \e[39m"
sudo mkdir ${PWD}/dump1090-fa-pkg-4.0

echo -e "\e[32mDownloading dump1090-fa_4.0_arm64.deb package from Github \e[39m"
sudo wget -O ${PWD}/dump1090-fa-pkg-4.0/dump1090-fa_4.0_arm64.deb "https://github.com/abcd567a/piaware-64bit-raspbian/releases/download/4.0/dump1090-fa_4.0_arm64.deb"

echo -e "\e[32mInstalling dependencies \e[39m"
sudo apt install -y lighttpd librtlsdr-dev libusb-1.0-0-dev libncurses5-dev libbladerf-dev libhackrf-dev liblimesuite-dev

echo -e "\e[32mInstalling dump1090-fa \e[39m"
cd ${PWD}/dump1090-fa-pkg-4.0
sudo dpkg -i dump1090-fa_4.0_arm64.deb

echo -e "\e[32mDUMP1090-FA INSTALLATION COMPLETED \e[39m"
echo -e "\e[33mPre-built packages are available in folder " ${PWD} " \e[39m"

echo -e "\e[31mREBOOT PI \e[39m"
echo -e "\e[31mREBOOT PI \e[39m"
echo -e "\e[31mREBOOT PI \e[39m"
