#!/bin/sh
#
# Syslog_TS.sh
#
# Installation: README.md 
#
# Author: Tom Valk
# Guntermann & Drunck GmbH
#
# Version: v5

# Global path
BACKUP_SOURCE="./Syslog/Logs/"
BACKUP_DEST="./Syslog/Backup/"

# Filename for the Backup
FILENAME="Backup_$(date '+%F_%H.%M.%S').tgz"

echo
echo "Starting script..."
echo

# Check if you're root
if [ `whoami` != root ]
	then 
	echo "Please run the Syslog_TS.sh script as root or using sudo!"
	exit
fi

# Check grabserial is installed
command -v grabserial >/dev/null 2>&1
if [ $? -ne 0 ]
	then
	echo "Grabserial is not installed" 
	exit
fi

#Kill grabserial
pkill -9 grabserial

#Check if the folders are created:
 if [ ! -d ${BACKUP_SOURCE} ]
        then
		echo "Creating BACKUP_SOURCE and BACKUP_DEST..."
		mkdir -p ${BACKUP_SOURCE}
		mkdir -p ${BACKUP_DEST}			
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
		echo "Start logging via grabserial..."

		#Start grabserial for each ttyUSB
  		while read LINE
  		do
    			TTYUSB="$(echo ${LINE}|cut -d'/' -f3)"
    			x-terminal-emulator -t "${TTYUSB}" -e sudo grabserial -T -d ${LINE} -o ${BACKUP_SOURCE}${TTYUSB}.txt &
    			sleep 5s
  		done < /tmp/found_tty.txt
		echo "[Done]"
		echo
		echo "Script complete, cleaning up..."

else
		echo "[Fail]"
		echo
		ls -A1B /dev/ttyUSB*	
		echo 
		echo "Connect the G&D device with the USB to mini USB service cable before starting the script"
		echo
		echo "Script failed, cleaning up..."
		
fi

chmod -R 0777 ./Syslog/	
rm /tmp/found_tty.txt
echo "[Done]"
echo
echo "Tom Valk"
echo "Guntermann & Drunck GmbH"
echo
echo