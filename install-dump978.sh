#!/bin/bash

echo -e "\e[32mCreating folder dump978-fa-pkg to hold packages \e[39m"
sudo mkdir ${PWD}/dump978-fa-pkg-4.0

echo -e "\e[32mDownloading dump978-fa_4.0_arm64.deb package from Github \e[39m"
sudo wget -O ${PWD}/dump978-fa-pkg-4.0/dump978-fa_4.0_arm64.deb "https://github.com/abcd567a/piaware-64bit-raspbian/releases/download/4.0/dump978-fa_4.0_arm64.deb" 

echo -e "\e[32mDownloading skyaware978_4.0_arm64.deb package from Github \e[39m"
sudo wget -O ${PWD}/dump978-fa-pkg-4.0/skyaware978_4.0_arm64.deb "https://github.com/abcd567a/piaware-64bit-raspbian/releases/download/4.0/skyaware978_4.0_arm64.deb"   


echo -e "\e[32mInstalling dependencies \e[39m"
sudo apt install -y libboost-system-dev libboost-program-options-dev libboost-regex-dev libboost-filesystem-dev libsoapysdr-dev lighttpd 

echo -e "\e[32mEntering folder holding dump978-fa & skyaware978 packages \e[39m"
cd ${PWD}/dump978-fa-pkg-4.0

echo -e "\e[32mInstalling dump978-fa \e[39m"
sudo dpkg -i dump978-fa_4.0_arm64.deb

echo -e "\e[32mInstalling skyaware978 \e[39m"
sudo dpkg -i skyaware978_4.0_arm64.deb

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
echo -e "\e[33mPre-built packages are available in folder " ${PWD} " \e[39m"

echo -e "\e[32mdump1090-fa and dump978-fa have been configured as follows \e[39m"
echo -e "\e[31mdump1090-fa will use dongle serial 00001090 \e[39m"
echo -e "\e[31mdump978-fa will use dongle serial 00000978 \e[39m"
echo -e "\e[31mPlease serialize dongles as given in page linked below: \e[39m"
echo -e "\e[31mhttps://github.com/abcd567a/piaware-64bit-raspbian/blob/master/README.md \e[39m"
