#!/bin/bash
ConnectChoice=$(whiptail --title "Menu example" --menu "Choose an option" 25 78 16 \
"1" "Connect to VPN." \
"2" "Connect to VPN (UK)." \
"3" "Disconnect VPN." 3>&1 1>&2 2>&3)

if [ $ConnectChoice = 1 ]; then
    sudo nordvpn connect            
elif [ $ConnectChoice = 2 ]; then
    sudo nordvpn connect uk
elif [ $ConnectChoice = 3 ]; then
    sudo nordvpn disconnect
else
    exit
fi