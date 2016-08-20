#!/bin/bash

if [-a /sys/bus/w1/devices/28*/w1_slave] THEN
	

	# Get temps form w1
	OutsideTemp=`cat /sys/bus/w1/devices/28*/w1_slave| grep -o 't=.*'|cut -f2- -d'='|awk '{$1=$1 / 1000;printf "%.2f", $1}'`

	# Get sensor id
	SensorId=`ls /sys/bus/w1/devices/28*/w1_slave|cut -f6 -d'/'`


	# wget -q -O/dev/null "http://www.sjobyn.se/savedata.php?id=$SensorId&data=$OutsideTemp"

	echo $SensorId  $OutsideTemp

ELSE
	echo "No data found!"
FI