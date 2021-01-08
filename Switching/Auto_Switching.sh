#!/bin/bash
#
# Auto_Switching.sh
#
# Author: Tom Valk
#
# Usage: sudo bash Auto_Switching.sh
#

#############################################
# Important Settings
#############################################

# Set the port where your device is connected to e.g. ttyUSB0 or ttyS0
# on WSL the Windows COM3 port is the WSL ttyS3 port etc.
SERIAL_PORT="/dev/ttyUSB0"

# The Baudrate must fit to the MUX setting, mostly it's 115200!
BAUDRATE="115200"

# Set the delay between the commands; Possible with seconds (1) or miliseconds (0.1) etc.
DELAY="1"

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
NEXT_CH='"\x3e\x21"'       # = <!
PREV_CH='"\x3c\x21"'       # = >!

# With old devices that do not have their own RS232 port,
# it is necessary to switch from setup mode to switch mode
SWITCH_MODE='"\x21"'        # Switch-Mode = !
SETUP_MODE='"\x23\x21"'     # Setup-Mode = #!

#############################################
# Script
#############################################
echo
echo "Starting script..."
echo
echo "Using port "${SERIAL_PORT}
echo "Delay was set to "${DELAY}
echo "Set Baudrate to "${BAUDRATE}
stty -F ${SERIAL_PORT} ${BAUDRATE} cs8 -cstopb -parenb -ixon > /dev/null 2>&1
if [ $? = 1 ]
        then
                echo "Could not connect to "${SERIAL_PORT} " please check the port!"
                echo "[Script Failed]"
                exit
fi
# Switch from setup mode to switch mode (optional)
# echo "Enable switch mode"
# echo "echo -e ${SWITCH_MODE} > ${SERIAL_PORT}" | bash
echo
echo "Starting loop (press Q to exit) ..."
COUNTER=0
echo
                # Loop until you exit the Script
                while :
                do
                        # Switch to the next channel
                        COUNTER=$((COUNTER+1))
                        echo "Counter: $COUNTER - press Q to exit"
			
			# Add more commands to the loop if needed
                        echo "echo -e -n ${NEXT_CH} > ${SERIAL_PORT}" | bash
			echo -n "Command send ($(date)) response: "
                        
                        # Break the loop with q or Q
                        read -t 1 -N 1 INPUT
                        if [[ $INPUT = "q" ]] || [[ $INPUT = "Q" ]]; then
                                break
			fi
			
			sleep ${DELAY} 
                done
echo
echo
echo
echo
echo "[Script Closed]"
echo
echo "Tom Valk"
echo
