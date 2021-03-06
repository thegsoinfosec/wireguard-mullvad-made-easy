#!/bin/bash

# How to Install Mullvad with WireGuard on Debian 10 
# First install the Debian dependency pkgs for WireGuard 
 git clone https://salsa.debian.org/debian/wireguard-linux-compat.git

# https://wiki.debian.org/Wireguard
echo "deb http://deb.debian.org/debian/ unstable main" | sudo tee /etc/apt/sources.list.d/unstable-wireguard.list
printf 'Package: *\nPin: release a=unstable\nPin-Priority: 90\n' | sudo tee /etc/apt/preferences.d/limit-unstable
apt update
apt install wireguard
   
#Then download and install Mullvad   
wget https://mullvad.net/media/app/MullvadVPN-2020.5_amd64.deb
sudo apt-get -y install gdebi-core && sudo gdebi MullvadVPN-2020.5_amd64.deb

# Install WireGuard Network interface device
ip link add dev wg0 type wireguard
echo "Example: 192.168.2.1/24"
echo "assingn an IP including the range for wg0 : "
read  IP
ip address add dev wg0 $IP

#Start Mullvad
mullvad


# You can now open the Mullvad desktop app
# Set wireguard as preferred tunnel protocol
# & generate keys for Wireguard
