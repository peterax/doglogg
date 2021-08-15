#!/bin/bash

# sätt
git config --global user.email "peter@reducks.se"
git config --global user.name "Peter Axelsson"

# gör
cd /home/pi/doglogg
git pull --no-edit

sudo chmod 600 id_rsa
./phonehome.sh

sudo apt -y install mosquitto-clients
