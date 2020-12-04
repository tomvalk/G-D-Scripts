#!/bin/sh
#
# Auto_Switching.sh
#
# Author: Tom Valk
# Guntermann & Drunck GmbH
#
# Version: v1

#############################################
# Important Settings
#############################################

# Set the port where your device is connected to e.g. ttyUSB0 or ttyS0
SERIAL_PORT="/dev/ttyUSB0"

# The Baudrate must fit to the MUX setting, mostly it's 115200!
BAUDRATE="115200" 

# Set the delay between the commands
DELAY="1s"

# With old devices that do not have their own RS232 port, it is necessary to switch from setup mode to switch mode
SWITCHMODE="\x21"		# Setup-Mode = ! 
SETUPMODE="\x23\x21"	# Switch-Mode = #!

# Commands with HEX Values
PORT_1="\x31\x21"	# = 1!
PORT_2="\x32\x21"	# = 2!
PORT_3="\x33\x21"	# = 3!
PORT_4="\x34\x21"	# = 4!
PORT_5="\x35\x21"	# = 5!
PORT_6="\x36\x21"	# = 6!
PORT_7="\x37\x21"	# = 7!
PORT_8="\x38\x21"	# = 8!

NEXT="\x3c\x21"		# = <!
PREV="\x3e\x21"		# = >!

#############################################
# Autostart
#############################################
# Add the following code to crontab -e
# @reboot export DISPLAY=:0.0 && sleep 10 && sudo sh /path/to/the/script/Auto_Switching.sh

#############################################
# Script
#############################################
echo
echo "Starting script..."
echo
echo "Using port "${SERIAL_PORT}
echo "Delay was set to "${DELAY}
echo "Set Baudrate to "${BAUDRATE} "..."
stty -F ${SERIAL_PORT} ${BAUDRATE} > /dev/null 2>&1
if [ $? = 1 ]
        then
		echo "Could not connect to "${SERIAL_PORT} " please check the port"
		echo "[Script Failed]"
		echo
		echo
		exit
fi
echo "[Done]"
echo
echo "Starting loop (exit with CTRL + C) ..."
echo -e ${SWITCHMODE} > ${SERIAL_PORT}
echo
echo
  		while :
  		do
			echo -e ${PORT_1} > ${SERIAL_PORT}
    		echo "Command send ( $(date) )"
			sleep ${DELAY}
			echo -e ${PORT_2} > ${SERIAL_PORT}
			echo "Command send ( $(date) )"
			sleep ${DELAY}  		
		done
echo "[Closed]"
