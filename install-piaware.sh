#!/bin/bash

echo -e "\e[32mCreating folder piaware-pkg to hold packages \e[39m"
sudo mkdir ${PWD}/piaware-pkg-4.0

echo "Downloading piaware packages from Github"
sudo wget -O ${PWD}/piaware-pkg-4.0/tcl-tls_1.7.16-1+fa1_arm64.deb "https://github.com/abcd567a/piaware-64bit-raspbian/releases/download/4.0/tcl-tls_1.7.16-1+fa1_arm64.deb"
sudo wget -O ${PWD}/piaware-pkg-4.0/piaware_4.0_arm64.deb "https://github.com/abcd567a/piaware-64bit-raspbian/releases/download/4.0/piaware_4.0_arm64.deb"

echo -e "\e[32mInstalling tcl-tls dependencies \e[39m"
sudo apt install -y libssl-dev tcl-dev chrpath

echo -e "\e[32mInstalling piaware dependencies \e[39m"
sudo apt install -y libboost-system-dev libboost-program-options-dev   
sudo apt install -y libboost-regex-dev libboost-filesystem-dev    
sudo apt install -y tclx8.4 tcllib itcl3     

echo -e "\e[32mEntering pre-built packages folder \e[39m"
cd ${PWD}/piaware-pkg-4.0

echo -e "\e[32mInstalling tcl-tls pre-built package \e[39m"
sudo dpkg -i tcl-tls_1.7.16-1+fa1_arm64.deb
echo -e "\e[32mBlocking auto-upgrade of tcl-tls \e[39m"
sudo apt-mark hold tcl-tls

echo -e "\e[32mInstalling piaware pre-built package\e[39m"
sudo dpkg -i piaware_4.0_arm64.deb

echo -e "\e[32mPIAWARE INSTALLATION COMPLETED \e[39m"
echo -e "\e[33mPre-built packages are available in folder " ${PWD} " \e[39m"

echo -e "\e[39mIf you already have  feeder-id, please configure piaware with it \e[39m"
echo -e "\e[39m    sudo piaware-config feeder-id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx \e[39m"
echo -e "\e[39m    sudo piaware-config allow-manual-updates yes  \e[39m"
echo -e "\e[39m    sudo piaware-config allow-auto-updates yes \e[39m"
echo -e "\e[39m    sudo systemctl restart piaware \e[39m"
echo -e "\e[39mIf you dont already have a feeder-id, please go to Flightaware Claim page  \e[39m"
