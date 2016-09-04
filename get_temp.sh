#!/bin/bash

if ls /sys/bus/w1/devices/28*/w1_slave &>/dev/null; then

	# Get temps form w1
	OutsideTemp=`cat /sys/bus/w1/devices/28*/w1_slave| grep -o 't=.*'|cut -f2- -d'='|awk '{$1=$1 / 1000;printf "%.2f", $1}'`

	# Get sensors id
	SensorId=`ls /sys/bus/w1/devices/28*/w1_slave|cut -f6 -d'/'`

	# Save data
	wget -q -O/dev/null "http://www.doglogg.se/savedata.php?id=$SensorId&data=$OutsideTemp"

        wget -q -O/dev/null  "http://api.thingspeak.com/update?api_key=RKDFIP1P1VM72FE7&field1=$OutsideTemp&field2=$SensorId"

	echo $SensorId  $OutsideTemp
else
	echo "No data found!"
fi
