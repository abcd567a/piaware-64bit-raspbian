#!/bin/bash
INSTALL_DIRECTORY=${PWD}

echo -e "\e[32mUpdating\e[39m"
sudo apt update

echo -e "\e[32mInstalling build tools\e[39m"
sudo apt install -y git dh-systemd devscripts

echo -e "\e[32mInstalling dependencies \e[39m"
sudo apt install -y libboost-system-dev libboost-program-options-dev
sudo apt install -y libboost-regex-dev libboost-filesystem-dev
sudo apt install -y libsoapysdr-dev lighttpd

echo -e "\e[32mCloning dump978-fa source code\e[39m"
cd ${INSTALL_DIRECTORY}
git clone https://github.com/flightaware/dump978.git

echo -e "\e[32mBuilding dump978-fa package\e[39m"
cd ${INSTALL_DIRECTORY}/dump978
sudo dpkg-buildpackage -b

cd ../
echo -e "\e[32mInstalling dump978-fa \e[39m"
sudo dpkg -i dump978-fa_*.deb

echo -e "\e[32mInstalling skyaware978 \e[39m"
sudo dpkg -i skyaware978_*.deb


echo -e "\e[32mEnabling piaware to use dump978-fa \e[39m"
sudo piaware-config uat-receiver-type sdr

echo -e "\e[32mConfiguring dump1090-fa and dump978-fa to use serialized dongles \e[39m"
sudo sed -i 's/--device-index 0/--device-index 00001090/' /etc/default/dump1090-fa
sudo sed -i 's/driver=rtlsdr/driver=rtlsdr,serial=00000978/' /etc/default/dump978-fa

echo -e "\e[32mRestarting piaware, dump1090-fa & dump978-fa to implement config changes \e[39m"
sudo systemctl restart piaware
sudo systemctl stop dump1090-fa
sudo systemctl stop dump978-fa
sudo systemctl start dump1090-fa
sudo systemctl start dump978-fa

echo -e "\e[32mDUMP978-FA INSTALLATION COMPLETED \e[39m"

echo -e "\e[32mdump1090-fa and dump978-fa have been configured as follows \e[39m"
echo -e "\e[31mdump1090-fa will use dongle serial 00001090 \e[39m"
echo -e "\e[31mdump978-fa will use dongle serial 00000978 \e[39m"
echo -e "\e[31mPlease serialize dongles as given in page linked below: \e[39m"
