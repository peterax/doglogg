#!/bin/bash
createTunnel() {
  # is there a key?
  if ! ls /home/pi/.ssh/id_rsa &>/dev/null; then
	echo -e "\n\n\n" | ssh-keygen
	ssh-copy-id -i /home/pi/.ssh/id_rsa.pub -p 22001 pi@peterax.sjobyn.se
  fi
  /usr/bin/ssh -i /home/pi/.ssh/id_rsa -N -R $idno:localhost:22 pi@peterax.sjobyn.se -p 22001 &

  if [[ $? -eq 0 ]]; then
    echo Tunnel to jumpbox created successfully
  else
    echo An error occurred creating a tunnel to jumpbox. RC was $?
  fi
}



# Get pi cpu serno
cpuSerialNo=`cat /proc/cpuinfo | grep Serial | cut -d ':' -f 2 | cut -d ' ' -f 2`
# Get pi hw revision
hwRevision=`cat /proc/cpuinfo | grep Revision | cut -d ':' -f 2 | cut -d ' ' -f 2`


idno="`wget -qO- http://www.doglogg.se/getdogloggid.php?id=$cpuSerialNo`"
echo $idno


/bin/pidof ssh
if [[ $? -ne 0 ]]; then
  echo Creating new tunnel connection
  createTunnel
fi
