#!/bin/bash
# Script to create rrd-file 

# 24h with 2,5 min resolution
# 7d with 5 min resolution
# 1y with 10 min resolution
# 20y with 1h resolution

directory="/home/pi/rrddata/"
filename="outside_temp.rrd"

# Check i file already exists
if [ ! -f "$directory$filename" ]
then
	# File doesn't exist, create new rrd-file
	echo "Creating RRDtool DB for outside temp sensor"
	rrdtool create $directory$filename \
		 --step 150 \
		 DS:outsidetemp:GAUGE:300:-50:60 \
		 RRA:AVERAGE:0.5:1:576 \
		 RRA:AVERAGE:0.5:2:2016 \
		 RRA:AVERAGE:0.5:4:52560 \
		 RRA:AVERAGE:0.5:24:175200 \
		 RRA:MAX:0.5:1:5760 \
		 RRA:MAX:0.5:2:2016 \
		 RRA:MAX:0.5:4:52560 \
		 RRA:MAX:0.5:24:175200 \
		 RRA:MIN:0.5:1:5760 \
		 RRA:MIN:0.5:2:2016 \
		 RRA:MIN:0.5:4:52560 \
		 RRA:MIN:0.5:24:175200
	echo "Done!"
else
	echo $directory$filename" already exists, delete it first."
fi
