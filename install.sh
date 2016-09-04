#!/bin/bash

sudo modprobe w1-gpio
sudo modprobe w1-therm

# sudo echo "dtoverlay=w1-gpio">>/boot/config.txt

git config --global user.email "peter@reducks.se"
git config --global user.name "Peter Axelsson"

# Fix a cronjob
sudo crontab -l > mycron
echo "* * * * *           /home/pi/doglogg/get_temp.sh" >> mycron
echo "* * * * *           /home/pi/doglogg/gitpull.sh" >> mycron
sudo crontab mycron


echo "Done! Reboot needed..."
