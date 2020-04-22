#!/bin/sh
#
# Syslog.sh
#
# Logging G&D devices
#
# Prerequisite:
# Connect the G&D device with the USB to mini USB service cable before starting the script
# sudo apt-get install minicom
# 
# To start the syslog use:
# sudo sh ./Syslog.sh 
#
# You can edit the Crontab to make the script executeable on startup and every 24 hours 
#
# crontab -e
#
# @reboot export DISPLAY=:0.0 XAUTHORITY=/home/*USER*/.Xauthority && sleep 10 && sudo sh *PATH*/Syslog.sh
# @daily export DISPLAY=:0.0 XAUTHORITY=/home/*USER*/.Xauthority  && sleep 10 && sudo sh *PATH*/Syslog.sh
#
# Author: Tom Valk
# Guntermann & Drunck GmbH
#
# Version: v5

# Please check the path of the variables below:
BACKUP_SOURCE="./Syslog/Logs/"
BACKUP_DEST="./Syslog/Backup/"

# Filename for the Backup
FILENAME="Backup_$(date '+%F_%H.%M.%S').tgz"

echo
echo "Starting script..."
echo

#Kill minicom
sudo pkill -9 minicom

#Check if the folders are created:
 if [ ! -d ${BACKUP_SOURCE} ]
        then
		echo "Creating BACKUP_SOURCE and BACKUP_DEST..."
		sudo mkdir -p -m=777 ${BACKUP_SOURCE}
		sudo mkdir -p -m=777 ${BACKUP_DEST}
		echo "[Done]"
		echo
fi

#If there are already log files in the folder, start backup...
ls -1 ${BACKUP_SOURCE}/* > /dev/null 2>&1
  if [ "$?" = "0" ]
  		then
                echo "Backing up old log files..."
                        tar cvPzf ${BACKUP_DEST}/${FILENAME} ${BACKUP_SOURCE}
                        rm  ${BACKUP_SOURCE}/*.txt
                echo ${FILENAME}
                echo "[Done]"
		echo
  fi
  
#determine all ttyUSB connections
echo "Searching for ttyUSB..."

ls -A1B /dev/ttyUSB* > /tmp/found_tty.txt 2> /dev/null
if [ -s /tmp/found_tty.txt ]
	then
		ls -A1B /dev/ttyUSB*
		echo "[Done]"
		echo
		echo "Start logging via minicom..."

		#Start minicom for each ttyUSB
  		while read LINE
  		do
    			TTYUSB="$(echo ${LINE}|cut -d'/' -f3)"
    			x-terminal-emulator -t "${TTYUSB}" -e sudo minicom -D ${LINE} -C ${BACKUP_SOURCE}${TTYUSB}.txt &
    			sleep 5s
  		done < /tmp/found_tty.txt
		echo "[Done]"
		echo
		echo "Script complete, cleaning up..."
		rm /tmp/found_tty.txt
		echo "[Done]"
else
		echo "[Fail]"
		echo
		ls -A1B /dev/ttyUSB*	
		echo 
		echo "Connect the G&D device with the USB to mini USB service cable before starting the script"
		echo
		echo "Script failed, cleaning up..."
		rm /tmp/found_tty.txt
fi
echo
echo "Tom Valk"
echo "Guntermann & Drunck GmbH"
echo
