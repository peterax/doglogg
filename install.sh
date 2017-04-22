#!/bin/bash

sudo modprobe w1-gpio
sudo modprobe w1-therm

# Modify config.txt if needed
if ! sudo cat /boot/config.txt|grep "dtoverlay=w1-gpio" &>/dev/null; then
	cp /boot/config.txt ./
	echo "dtoverlay=w1-gpio">>config.txt
	sudo cp config.txt /boot/config.txt
	rm config.txt
	echo "config.txt fixed"
fi



# Add open WLANs if not there already
if ! sudo cat /etc/wpa_supplicant/wpa_supplicant.conf|grep "key_mgmt=NONE" &>/dev/null; then
	cat /etc/wpa_supplicant/wpa_supplicant.conf >./wpa_supplicant.conf
	echo 'network={' >> wpa_supplicant.conf
	echo '        key_mgmt=NONE' >> wpa_supplicant.conf
	echo '        priority=-999' >> wpa_supplicant.conf
	echo '}' >> wpa_supplicant.conf
	cp wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
	rm wpa_supplicant.conf
	echo "open WLAN fixed"
fi

# Add homo.net if not there already
if ! sudo cat /etc/wpa_supplicant/wpa_supplicant.conf|grep "homo.net" &>/dev/null; then
	cat /etc/wpa_supplicant/wpa_supplicant.conf >./wpa_supplicant.conf
	echo 'network={' >> wpa_supplicant.conf
	echo '        scan_ssid=1' >> wpa_supplicant.conf
	echo '        ssid="homo.net"' >> wpa_supplicant.conf
	echo '        psk="66491Grums"' >> wpa_supplicant.conf
	echo '        key_mgmt=WPA-PSK' >> wpa_supplicant.conf
	echo '}' >> wpa_supplicant.conf
	cp wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
	rm wpa_supplicant.conf
	echo "homo.net fixed"
fi





# Open WLANs and homo.net
# cat /etc/wpa_supplicant/wpa_supplicant.conf >./wpa_supplicant.conf
# echo 'network={' >> wpa_supplicant.conf
# echo '        key_mgmt=NONE' >> wpa_supplicant.conf
# echo '        priority=-999' >> wpa_supplicant.conf
# echo '}' >> wpa_supplicant.conf
# echo 'network={' >> wpa_supplicant.conf
# echo '        scan_ssid=1' >> wpa_supplicant.conf
# echo '        ssid="homo.net"' >> wpa_supplicant.conf
# echo '        psk="66491Grums"' >> wpa_supplicant.conf
# echo '        key_mgmt=WPA-PSK' >> wpa_supplicant.conf
# echo '}' >> wpa_supplicant.conf

# cp wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
# rm wpa_supplicant.conf



git config --global user.email "peter@reducks.se"
git config --global user.name "Peter Axelsson"

# Fix needed cronjobs 
if ! sudo crontab -l|grep "/home/pi/doglogg/get_temp.sh" &>/dev/null; then
	sudo crontab -l > mycron
	echo "* * * * *           /home/pi/doglogg/get_temp.sh" >> mycron
	echo "* * * * *           /home/pi/doglogg/gitpull.sh" >> mycron
	sudo crontab mycron
	sudo rm mycron
	echo "crontab fixed"
fi



# sudo crontab -l > mycron
# echo "* * * * *           /home/pi/doglogg/get_temp.sh" >> mycron
# echo "* * * * *           /home/pi/doglogg/gitpull.sh" >> mycron
# sudo crontab mycron
# sudo rm mycron


echo "Done! Reboot needed..."

