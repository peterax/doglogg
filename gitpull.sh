#!/bin/bash

# sätt
git config --global user.email "peter@reducks.se"
git config --global user.name "Peter Axelsson"

# gör
cd /home/pi/doglogg
git pull --no-edit

sudo ./phonehome.sh


