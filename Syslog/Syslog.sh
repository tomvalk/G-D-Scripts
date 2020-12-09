#!/bin/sh
#
# Syslog.sh
#
# Author: Tom Valk
# Guntermann & Drunck GmbH
#
# Version: v1

# Terminal Application, use 'grabserial' or 'minicom'
APP="grabserial"

# Global path
MY_PATH="`dirname \"$0\"`"
BACKUP_SOURCE="$MY_PATH/Syslog/Logs/"
BACKUP_DEST="$MY_PATH/Syslog/Backup/"

# Filename for the Backup
FILENAME="Backup_$(date '+%F_%H.%M.%S').tgz"

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
#determine all ttyUSB connections
echo "Searching for ttyUSB..."
ls -A1B /dev/ttyUSB* > /tmp/found_tty.txt 2> /dev/null
if [ -s /tmp/found_tty.txt ]
	then
		ls -A1B /dev/ttyUSB*
		echo "[Done]"
		echo
		echo "Start logging via $APP..."
		#Start grabserial for each ttyUSB
  		while read LINE
  		do
    			TTYUSB="$(echo ${LINE}|cut -d'/' -f3)"
				if [ $APP = "grabserial" ]; then
					x-terminal-emulator -t "${TTYUSB}" -e sudo grabserial -T -d ${LINE} -o ${BACKUP_SOURCE}${TTYUSB}.txt &
				elif [ $APP = "minicom" ]; then
					x-terminal-emulator -t "${TTYUSB}" -e sudo minicom -D ${LINE} -C ${BACKUP_SOURCE}${TTYUSB}.txt &
				fi
    			sleep 5s
  		done < /tmp/found_tty.txt
		echo "[Done]"
		echo
		echo "File location:"
		echo "Logs: 	$BACKUP_SOURCE"
		echo "Backup: 	$BACKUP_DEST"
		echo
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
chmod -R 0777 $BACKUP_SOURCE $BACKUP_DEST	
rm /tmp/found_tty.txt
echo "[Closed]"
echo
echo "Tom Valk"
echo "Guntermann & Drunck GmbH"
echo
echo
