#!/bin/bash

# Set path
thePath="/sys/bus/w1/devices/28*/w1_slave"

# Get pi cpu serno
cpuSerialNo=`cat /proc/cpuinfo | grep Serial | cut -d ':' -f 2 | cut -d ' ' -f 2`
# Get pi hw revision
hwRevision=`cat /proc/cpuinfo | grep Revision | cut -d ':' -f 2 | cut -d ' ' -f 2`

# Get external ip address
ipaddress=`curl 'https://api.ipify.org'`

# No, get internal ip address
ipaddress= `hostname -I | tr -d [:space:]`

# Any files?
if ls $thePath &>/dev/null; then
      
# Loop them
for filename in $thePath; do

	# Get temps form w1
	OutsideTemp=`cat $filename| grep -o 't=.*'|cut -f2- -d'='|awk '{$1=$1 / 1000;printf "%.2f", $1}'`

	# Get sensors id
	SensorId=`ls $filename|cut -f6 -d'/'`

	# Save data
	wget -q -O/dev/null "http://www.doglogg.se/doglogg_save.php?id=$SensorId&data=$OutsideTemp&user=$cpuSerialNo-$hwRevision&ip=$ipaddress"

	# Thingspeak, just for test
    # wget -q -O/dev/null  "http://api.thingspeak.com/update?api_key=RKDFIP1P1VM72FE7&field1=$OutsideTemp&field2=$SensorId"

	# Just for the cause
	echo $SensorId  $OutsideTemp
done

else
	echo "No data found!"
fi
