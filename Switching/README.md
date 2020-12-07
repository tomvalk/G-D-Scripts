# Pi-Switching Script
Shell script for switching MUX/TradeSwitch via the Serial Port

## Prerequisite:
- None

## Usage:
```
sudo sh ./Auto_Switching.sh
```

## Autostart
- Add the following code to ``crontab -e``
- Important to change the ``*PATH*``
```
@reboot export DISPLAY=:0.0 && sleep 10 && sudo sh *PATH*/Auto_Switching.sh
```
- ``export DISPLAY=:0.0`` to start a real terminal from crontab 
- ``sleep 10`` needed in some installations for initialise all USB ports 

## Info:
HEX values:
```
# Commands with HEX Values
PORT_1='"\x31\x21"'     # = 1!
PORT_2='"\x32\x21"'     # = 2!
PORT_3='"\x33\x21"'     # = 3!
PORT_4='"\x34\x21"'     # = 4!
PORT_5='"\x35\x21"'     # = 5!
PORT_6='"\x36\x21"'     # = 6!
PORT_7='"\x37\x21"'     # = 7!
PORT_8='"\x38\x21"'     # = 8!

NEXT='"\x3e\x21"'         # = <!
PREV='"\x3c\x21"'         # = >!

# With old devices that do not have their own RS232 port,
# it is necessary to switch from setup mode to switch mode
SETUPMODE='"\x21"'        # Setup-Mode = !
SWITCHMODE='"\x23\x21"'   # Switch-Mode = #!
```

Change Baudrate:
```
Command:  stty -F /dev/ttyUSB0 115200
Script:   stty -F ${SERIAL_PORT} ${BAUDRATE} > /dev/null 2>&1
```

Send Command:
```
Command: echo -e "\x31\x21" > /dev/ttyUSB0
Script: echo "echo -e ${PORT_1} > ${SERIAL_PORT}" | bash
```

WSL
- This script can be executet via the WSL Terminal
- Windows ```COM3``` can be accessed in the WSL via ```/dev/ttyS3```