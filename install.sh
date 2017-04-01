#!/bin/bash

sudo modprobe w1-gpio
sudo modprobe w1-therm

cp /boot/config.txt ./
echo "dtoverlay=w1-gpio">>config.txt
sudo cp config.txt /boot/config.txt
rm config.txt
# sudo echo "dtoverlay=w1-gpio">>/boot/config.txt


# Open WLANs
cp /etc/wpa_supplicant/wpa_supplicant.conf ./
echo "network={" >> wpa_supplicant.conf
echo "        key_mgmt=NONE" >> wpa_supplicant.conf
echo "       priority=-999" >> wpa_supplicant.conf
echo "}" >> wpa_supplicant.conf
sudo cp wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
#rm wpa_supplicant.conf


git config --global user.email "peter@reducks.se"
git config --global user.name "Peter Axelsson"

# Fix a cronjob
sudo crontab -l > mycron
echo "* * * * *           /home/pi/doglogg/get_temp.sh" >> mycron
echo "* * * * *           /home/pi/doglogg/gitpull.sh" >> mycron
sudo crontab mycron


echo "Done! Reboot needed..."

