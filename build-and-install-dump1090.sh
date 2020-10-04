#!/bin/bash
INSTALL_DIRECTORY=${PWD}

echo -e "\e[32mUpdating\e[39m"
sudo apt update
echo -e "\e[32mInstalling build tools\e[39m"
sudo apt install -y git dh-systemd devscripts

echo -e "\e[32mInstalling dependencies \e[39m"
sudo apt install -y lighttpd librtlsdr-dev libusb-1.0-0-dev libncurses5-dev libbladerf-dev  
sudo apt install -y libhackrf-dev liblimesuite-dev 

echo -e "\e[32mCloning dump1090-fa source code\e[39m"
cd ${INSTALL_DIRECTORY}
git clone https://github.com/flightaware/dump1090

echo -e "\e[32mBuilding dump1090-fa package\e[39m"
cd ${INSTALL_DIRECTORY}/dump1090
sudo dpkg-buildpackage -b --no-sign

echo -e "\e[32mInstalling dump1090-fa \e[39m"
cd ../  
sudo dpkg -i dump1090-fa_*.deb

echo ""
echo -e "\e[32mDUMP1090-FA INSTALLATION COMPLETED \e[39m"
echo -e "\e[31mREBOOT Pi \e[39m"
echo -e "\e[31mREBOOT Pi \e[39m"
echo -e "\e[31mREBOOT Pi \e[39m"
echo -e "\e[32mAfter REBOOT, check status by following command \e[39m"
echo -e "\e[33msudo systemctl status dump1090-fa  \e[39m"
echo ""
