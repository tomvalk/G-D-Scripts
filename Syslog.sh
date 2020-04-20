    #!/bin/sh
    #
    # Syslog_v4.sh
    #
    # Logging G&D devices
    #
    # Prerequisite:
    # Connect the G&D device with the USB to mini USB service cable before starting the script
    # sudo apt-get install minicom
    # 
	# To start the syslog use:
	# sudo sh /home/pi/Desktop/Syslog/Syslog_v4.sh 
	#
	# You can edit the Crontab to make the script executeable on startup and every 24 hours 
	# to make keep the log short
	#
    # crontab -e
	#
    # @reboot export DISPLAY=:0.0 && sleep 10 && sudo sh /home/pi/Desktop/Syslog/Syslog_v4.sh
    # @daily export DISPLAY=:0.0 && sleep 10 && sudo sh /home/pi/Desktop/Syslog/Syslog_v4.sh
    #
    # Author: Martin Reiche (PM) & Tom Valk (Service)
    # Guntermann & Drunck GmbH
    #
    # Version: v4.01

# Please check the path of the variables below:
BACKUP_SOURCE="/home/pi/Desktop/Syslog/Logs/"
BACKUP_DEST="/home/pi/Desktop/Syslog/Backup/"

# Filename for the Backup
FILENAME="Backup_$(date '+%F_%H.%M.%S').tgz"

echo
echo "Starting script..."
echo

#Kill minicom
sudo pkill -9 minicom

echo "Creating BACKUP_SOURCE and BACKUP_DEST..."

#Check if the folders are created:
sudo mkdir ${BACKUP_SOURCE} 2> /dev/null
sudo mkdir ${BACKUP_DEST} 2> /dev/null

echo "[Done]"
echo


#If there are already log files in the folder, start backup...
  if [ -d ${BACKUP_SOURCE} ]
	then
		echo "Backing up old log files"
			cd ${BACKUP_SOURCE} && \
			tar cvPzf ${BACKUP_DEST}/${FILENAME} `ls -1 ${BACKUP_SOURCE}` 2> /dev/null  && \
			rm  ${BACKUP_SOURCE}/*.txt
			cd ~
		echo ${FILENAME}	
		echo "[Done]"
  fi
echo
echo "Searching for ttyUSB..."

#determine all ttyUSB connections
ls -A1B /dev/ttyUSB* > /tmp/found_tty.txt
ls -A1B /dev/ttyUSB*
echo "[Done]"
echo
echo "Start logging via minicom..."

#Start minicom for each ttyUSB
  while read LINE
  do
    TTYUSB="$(echo ${LINE}|cut -d'/' -f3)"
    lxterminal -T "${TTYUSB}" -e sudo minicom -D ${LINE} -C ${BACKUP_SOURCE}${TTYUSB}.txt &
	sleep 5s
  done < /tmp/found_tty.txt

echo "[Done]"
echo
echo "Script complete, cleaning up..."
     rm /tmp/found_tty.txt
echo "[Done]"
echo
echo "Martin Reiche (PM) & Tom Valk (Service)"
echo "Guntermann & Drunck GmbH"
echo
