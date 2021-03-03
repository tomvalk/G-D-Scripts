#!/bin/bash
#
# Syslog.sh
#
# Author: Tom Valk
#
# Usage: sudo bash Syslog.sh
#

#############################################
# Important Settings
#############################################

# Select the serial application, use 'grabserial' or 'minicom'
APP="grabserial"

# Select ttyUSB* for all USB ports or ttyS* for all serial connections
PORT="/dev/ttyUSB*"

# Set the Baudrate
BAUDRATE="115200"

# Set the path to Log/Backup folder
MY_PATH="`dirname \"$0\"`"
BACKUP_SOURCE="$MY_PATH/Logs/"
BACKUP_DEST="$MY_PATH/Backup/"

# Set the backup name
FILENAME="Backup_$(date '+%F_%H.%M.%S').tgz"

#############################################
# Script
#############################################

echo
echo "Starting script!"
echo
echo "Check if you're root..."
if [ `whoami` != root ]
	then
	echo "Please run the Syslog.sh script as root or using sudo!"
	exit
fi
echo "[OK]"
echo
echo "Check if $APP is installed..."
command -v $APP >/dev/null 2>&1
if [ $? -ne 0 ]
	then
	echo "$APP is not installed"
	echo "Please run sudo apt-get install $APP"
	exit
fi
echo "[OK]"
echo
echo "Close all open $APP application..."
pkill -9 $APP
echo "[OK]"
echo
echo "Check if LOG and BACKUP folders are created..."
 if [ ! -d ${BACKUP_SOURCE} ]
        then
		echo "> Creating $BACKUP_SOURCE"
		mkdir -p ${BACKUP_SOURCE}
		echo "> Creating $BACKUP_DEST"
		mkdir -p ${BACKUP_DEST}
		echo "[Done]"
		echo
else
echo "[OK]"
fi
echo
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
#determine all tty connections
echo "Searching for $PORT..."
ls -A1B $PORT > /tmp/found_tty.txt 2> /dev/null
if [ -s /tmp/found_tty.txt ]
	then
		ls -A1B $PORT
		echo "[Done]"
		echo
		echo "Start logging via $APP..."
		#Start grabserial for each ttyUSB
  		while read LINE
  		do
    			TTYPORT="$(echo ${LINE}|cut -d'/' -f3)"
				if [ $APP = "grabserial" ]; then
					x-terminal-emulator -e grabserial -T -b ${BAUDRATE} -d ${LINE} -o ${BACKUP_SOURCE}${TTYPORT}.txt &
				elif [ $APP = "minicom" ]; then
					x-terminal-emulator -e minicom -b ${BAUDRATE} -D ${LINE} -C ${BACKUP_SOURCE}${TTYPORT}.txt &
				fi
    			sleep 5s
  		done < /tmp/found_tty.txt
		echo "[Done]"
		echo
		echo "File location:"
		echo "Logs: $BACKUP_SOURCE"
		echo "Backup: $BACKUP_DEST"
else
		echo "[Fail]"
		echo
		ls -A1B $PORT 
		echo "Connect the G&D device with the USB to mini USB service cable before starting the script"
fi
echo
echo
echo "Cleaning up..."
chmod -R 0777 $BACKUP_SOURCE $BACKUP_DEST	
rm /tmp/found_tty.txt
echo "[Script Closed]"
echo
echo "Tom Valk"
echo
echo
