#!/bin/bash

OutsideTempSensor="10.51777C010800"
RRDDataDirectory="/home/pi/rrddata/"
RRDDataFile="outside_temp.rrd"
# Dummy read just to wake up
cat /sys/bus/w1/devices/28*/w1_slave>/dev/null

# Get temps form OWFS
OutsideTemp=`cat /sys/bus/w1/devices/28*/w1_slave| grep -o 't=.*'|cut -f2- -d'='|awk '{$1=$1 / 1000;printf "%.2f", $1}'`

# Get sensor id
SensorId=`ls /sys/bus/w1/devices/28*/w1_slave|cut -f6 -d'/'`

wget -q -O/dev/null "http://www.sjobyn.se/savedata.php?id=$SensorId&data=$OutsideTemp"

#Update RRD database
rrdtool update $RRDDataDirectory$RRDDataFile N:$OutsideTemp
echo $SensorId  $OutsideTemp
