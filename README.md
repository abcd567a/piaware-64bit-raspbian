# piaware-64bit-raspbian
### OS image used: 2020-08-20-raspios-buster-arm64.img
**Download page :** 
[https://downloads.raspberrypi.org/raspios_arm64/images/](https://downloads.raspberrypi.org/raspios_arm64/images/)

**Direct Download Link:**
[https://downloads.raspberrypi.org/raspios_arm64/images/raspios_arm64-2020-08-24/2020-08-20-raspios-buster-arm64.zip](https://downloads.raspberrypi.org/raspios_arm64/images/raspios_arm64-2020-08-24/2020-08-20-raspios-buster-arm64.zip)

### (A) Scripts below are for Automated Installation of ver 4.0 of piaware, dump1090-fa, and dump978-fa on 64bit Raspbian / Pi4 (using the packages built and uploaded to Github by the author abcd567a)
### (B) For instructions how to manually build the packages from source code, please scroll down. </br></br>

## (1) Install DUMP1090-FA
Copy-paste following command in SSH console and press Enter key. The script will install dump1090-fa. </br></br>
`sudo bash -c "$(wget -O - https://raw.githubusercontent.com/abcd567a/piaware-64bit-raspbian/main/install-dump1090.sh)" `</br></br>

**IMPORTANT: Please reboot Pi after installing the dump1090-fa.** </br></br>


## (2) Install PIAWARE 

Copy-paste following command in SSH console and press Enter key. The script will install piaware. </br></br>
`sudo bash -c "$(wget -O - https://raw.githubusercontent.com/abcd567a/piaware-64bit-raspbian/main/install-piaware.sh)" `</br></br>


## (3) Install DUMP978-FA (For USA ONLY - Not required for other countries)
### (3.1) Serialize dongles as follows </br>
(3.1.1) Issue following command to install serialization software: </br>
`sudo apt install rtl-sdr` </br></br>
**(3.1.2) Unplug ALL DVB-T dongles from RPi** </br></br>
(3.1.3) Plugin only that DVB-T dongle which you want to use for dump1090-fa. All other dongles should be unplugged. </br></br>
(3.1.4) Issue following command. Say yes when asked for confirmation to chang serial number. </br>
`rtl_eeprom -s 00001090` </br></br>
**(3.1.5) Unplug 1090 dongle** </br></br>
(3.1.6) Plugin only that DVB-T dongle which you want to use for dump978-fa. All other dongles should be unplugged. </br></br>
(3.1.7) Issue following command. Say yes when asked for confirmation to chang serial number. </br>
`rtl_eeprom -s 00000978` </br></br>
**(3.1.8) Unplug 978 dongle** </br></br>
**IMPORTANT:** After completing above commands, unplug and then replug both dongles. </br>

### (3.2) Copy-paste following command in SSH console and press Enter key. The script will install dump978-fa and skyaware978: </br>
`sudo bash -c "$(wget -O - https://raw.githubusercontent.com/abcd567a/piaware-64bit-raspbian/main/install-dump978.sh)" `</br></br>



**==========================================================================**
## MANUAL INSTALLATION BY BUILDING PACKAGES FROM SOURCE CODE
**==========================================================================**



### Raspberry Pi OS (64bit) details (installed on RPi 4)
```
$ uname -a 
Linux raspberrypi 5.4.51-v8+ #1333 SMP PREEMPT Mon Aug 10 16:58:35 BST 2020 aarch64 GNU/Linux
```

```
$ lsb_release -sc 
buster
```


## 1 - Install tools needed to build dump1090-fa and piaware packages from source code.

```
$ sudo apt install debhelper dh-systemd   
```
</br></br>
## 2 - DUMP1090-FA: Build & Install package from source code
### 2.1 - Install dump1090-fa dependencies:
```
$ sudo apt install lighttpd librtlsdr-dev libusb-1.0-0-dev   
$ sudo apt install libncurses5-dev libbladerf-dev   
$ sudo apt install libhackrf-dev liblimesuite-dev 
```

### 2.2 - Clone source code, build and install dump1090-fa package
```
$ cd ~/
$ git clone https://github.com/flightaware/dump1090  
$ cd dump1090  
$ sudo dpkg-buildpackage -b --no-sign  

$ cd ../  
$ sudo dpkg -i dump1090-fa_*.deb  

## REBOOT
$ sudo reboot  
```
</br></br>
## 3 - PIAWARE: Build & Install package from source code

### 3.1 - Install dependencies 
```
$ sudo apt install libboost-system-dev libboost-program-options-dev   
$ sudo apt install libboost-regex-dev libboost-filesystem-dev    
$ sudo apt install tclx8.4 tcllib itcl3     
```

### 3.2 - Build & Install dependency `tcl-tls` from source code.

```
## Install dependencies
$ sudo apt install libssl-dev tcl-dev chrpath   


## Clone source code, build & Install tcl-tls  
cd ~/  
$ git clone http://github.com/flightaware/tcltls-rebuild.git   
$ cd tcltls-rebuild   
$ ./prepare-build.sh buster     
$ cd package-buster   
$ sudo dpkg-buildpackage -b --no-sign   
$ cd ../   
$ sudo dpkg -i tcl-tls_*.deb   

## During auto-upgrades, the version of tcl-tls we have built (1.7.16-1+fa1) may
## be replaced by the version in repository (1.7.16-1). To prevent this, 
## mark tcl-tls on hold by following command

$ sudo apt-mark hold tcl-tls  
tcl-tls set on hold.

```

### 3.3 - Clone piaware source code, build  and install Piaware package.

```
$ cd ~/  
$ git clone http://github.com/flightaware/piaware_builder    
$ cd piaware_builder   
$ sudo ./sensible-build.sh buster   
$ cd package-buster   

$ sudo dpkg-buildpackage -b --no-sign   
$ cd ../   
$ sudo dpkg -i piaware_*.deb   

cd ~/
```

### 3.4 - Configure Piaware
```
$ sudo piaware-config feeder-id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  

$ sudo piaware-config allow-auto-updates yes  
$ sudo piaware-config allow-manual-updates yes  

$ sudo systemctl restart piaware   

```
</br></br>
## 4 - DUMP978-FA (For USA Only): Build & Install package from source code
### 4.1 - Install dump978-fa dependencies:
```
$ sudo apt install libboost-system-dev libboost-program-options-dev 
$ sudo apt install libboost-regex-dev libboost-filesystem-dev 
$ sudo apt install libsoapysdr-dev lighttpd 

```
### 4.2 - Clone source code, build and install dump978-fa and skyaware978 packages
```
$ cd ~/
$ git clone https://github.com/flightaware/dump978.git  
$ cd dump978  
$ sudo dpkg-buildpackage -b  

$ cd ../  
$ sudo dpkg -i dump978-fa_*.deb  

$ sudo dpkg -i skyaware978_*.deb  

```
</br>

### 4.3 - Configure </br>
**4.3.1 - Serialize dongles** </br>
(a) Issue following command to install serialization software: </br>
`sudo apt install rtl-sdr` </br></br>
**(b) Unplug ALL DVB-T dongles from RPi** </br></br>
(c) Plugin only that DVB-T dongle which you want to use for dump1090-fa. All other dongles should be unplugged. </br>
Issue following command. Say yes when asked for confirmation to chang serial number. </br>
`rtl_eeprom -s 00001090` </br>
(d) Unplug 1090 dongle </br></br>
(e) Plugin only that DVB-T dongle which you want to use for dump978-fa. All other dongles should be unplugged. </br>
(f) Issue following command. Say yes when asked for confirmation to chang serial number. </br>
`rtl_eeprom -d 1 -s 00000978` </br>
(g) Unplug 978 dongle </br></br>
**IMPORTANT:** After completing above commands, unplug and then replug both dongles. </br>
</br>
**4.3.2 - configure dump1090 and dump978**

```
$ sudo piaware-config uat-receiver-type sdr 
$ sudo sed -i 's/--device-index 0/--device-index 00001090/' /etc/default/dump1090-fa 
$ sudo sed -i 's/driver=rtlsdr/driver=rtlsdr,serial=00000978/' /etc/default/dump978-fa 

# Reboot Pi to implement configuration settings
sudo reboot
``` 

</br>

&nbsp;
# To Upgrade from previous version </br>
If you are using 64-bit Respbian and have build & installed ver 3.8.1 packages from source-code, then: </br>

1. You already have all the build tool and dependencies (except two new one) already installed. </br>
2. You already have source-code on your Pi in following folders: </br>

    dump1090 </br>
    piaware_builder </br>

To build packages for version 4.0, do this: </br>
## DUMP1090-FA Upgrade

```
sudo apt install libhackrf-dev liblimesuite-dev 

cd dump1090  
git fetch --all  
git reset --hard origin/master

sudo dpkg-buildpackage -b --no-sign 

cd ../
sudo dpkg -i dump1090-fa_4.0_arm64.deb 
```

 </br>
 
## PIAWARE Upgrade

```
cd piaware_builder 
git fetch --all 
git reset --hard origin/master 

sudo ./sensible-build.sh buster  
cd package-buster   
sudo dpkg-buildpackage -b --no-sign   

cd ../   
sudo dpkg -i piaware_4.0_arm64.deb 
```

&nbsp;

&nbsp;
