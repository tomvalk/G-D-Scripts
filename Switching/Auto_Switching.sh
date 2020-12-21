#!/bin/sh
#
# Auto_Switching.sh
#
# Author: Tom Valk
# Guntermann & Drunck GmbH
#

#############################################
# Important Settings
#############################################

# Set the port where your device is connected to e.g. ttyUSB0 or ttyS0
# on WSL the Windows COM3 port is the WSL ttyS3 port etc.
SERIAL_PORT="/dev/ttyUSB0"

# The Baudrate must fit to the MUX setting, mostly it's 115200!
BAUDRATE="115200"

# Set the delay between the commands; Possible with seconds (s) or miliseconds (0.1s) etc.
DELAY="1s"

# Commands with HEX values:
PORT_1='"\x31\x21"'     # = 1!
PORT_2='"\x32\x21"'     # = 2!
PORT_3='"\x33\x21"'     # = 3!
PORT_4='"\x34\x21"'     # = 4!
PORT_5='"\x35\x21"'     # = 5!
PORT_6='"\x36\x21"'     # = 6!
PORT_7='"\x37\x21"'     # = 7!
PORT_8='"\x38\x21"'     # = 8!

# Switching to the NEXT or PREV channel (last channel -> first channel and vice versa)
NEXT='"\x3e\x21"'       # = <!
PREV='"\x3c\x21"'       # = >!

# With old devices that do not have their own RS232 port,
# it is necessary to switch from setup mode to switch mode
SWITCHMODE='"\x21"'        # Switch-Mode = !
SETUPMODE='"\x23\x21"'     # Setup-Mode = #!

#############################################
# Script
#############################################
echo
echo "Starting script..."
echo
echo "Using port "${SERIAL_PORT}
echo "Delay was set to "${DELAY}
echo "Set Baudrate to "${BAUDRATE} "..."
stty -F ${SERIAL_PORT} ${BAUDRATE} cs8 -cstopb -parenb -ixon > /dev/null 2>&1
if [ $? = 1 ]
        then
                echo "Could not connect to "${SERIAL_PORT} " please check the port!"
                echo "[Script Failed]"
                exit
fi
echo "[Done]"
echo
# Show response from the serial interface
pkill -9 cat
cat ${SERIAL_PORT} &
# Switch from setup mode to switch mode (optional)
echo "echo -e -n ${SWITCHMODE} > ${SERIAL_PORT}" | bash
echo
echo "Starting loop (exit with CTRL + C) ..."
echo
                while : # Loop until you exit the Script
                do
                        # Switch to the next channel
			echo "echo -e -n ${NEXT} > ${SERIAL_PORT}" | bash
                        echo -n "Command send ($(date)) response: "
                        sleep ${DELAY}
			# Add more commands to the loop if needed
                done
echo
pkill -9 cat
echo "[Closed]"
