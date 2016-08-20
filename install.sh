#!/bin/bash

sudo modprobe w1-gpio
sudo modprobe w1-therm


# Fix a cronjob
sudo crontab -l > mycron
echo "* * * * *           /home/pi/doglogg/get_temp.sh" >> mycron
crontab mycron


echo "Done!"
