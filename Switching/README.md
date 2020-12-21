# Switching Script
Shell script for switching G&D MUX/TradeSwitch via the Serial Port 

## General Switching:

### Change/Set Baudrate:
```
stty -F /dev/ttyUSB0 115200 cs8 -cstopb -parenb -ixon
```

### Access the device via WSL
Windows ```COM3``` can be accessed in the WSL via ```/dev/ttyS3```

### Send a command:
```
echo -e -n "\x31\x21" > /dev/ttyUSB0
```

### Send a command via a Shell script:
```
echo "echo -e -n '"\x31\x21"' > /dev/ttyUSB0" | bash
```

### HEX values:
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
SWITCHMODE='"\x21"'        # Switch-Mode = !
SETUPMODE='"\x23\x21"'     # Setup-Mode = #!
```

-------------

## Script for Automatic Switching (Testing):

### Prerequisite:
- None

### Usage
```
sudo bash ./Auto_Switching.sh
```

### Autostart
- Add the following code to ``crontab -e``
- Important to change the ``*PATH*``
```
@reboot export DISPLAY=:0.0 && sleep 10 && sudo bash *PATH*/Auto_Switching.sh
```
- ``export DISPLAY=:0.0`` to start a real terminal from crontab 
- ``sleep 10`` needed in some installations for initialise all USB ports 

