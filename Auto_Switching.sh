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
SERIAL_PORT="/dev/ttyUSB0"
DELAY="1s"
BAUDRATE="115200"

# The Baudrate must fit to the MUX setting, mostly it's 115200!

# With old devices that do not have their own RS232 port, the commands can be sent via the service port.
# To do this, it is necessary to switch from setup mode to switch mode once.
# - #! switch to Setup-Mode during runtime
# - !  switch to Switch-Mode during runtime
# or change the setting "Service RS232 Startup Mode" manually

#############################################
# Autostart
#############################################
# Add the following code to crontab -e
# @reboot export DISPLAY=:0.0 && sleep 10 && sudo sh /path/to/the/script/Auto_Switching.sh

#############################################
# HEX Values
#############################################
# To send the commands via Serial you need to use the HEX value of the ASCII code.
# \x31 = 1
# \x32 = 2
# ...
# \x38 = 8
#
# \x3c = <
# \x3e = >
#
# \x3f = ?
# \x21 = !
#
# \x23 = #

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
echo
echo
  		while :
  		do
			echo -e "\x31\x21" > ${SERIAL_PORT}
    		echo "Command send ( $(date) )"
			sleep ${DELAY}
			echo -e "\x32\x21" > ${SERIAL_PORT}
			echo "Command send ( $(date) )"
			sleep ${DELAY}
			# Add other commands if needed, HEX values in the table above!
  		done
echo "[Closed]"
