# Syslog-Script
Shell script for logging G&D devices

## Prerequisite:
### Syslog.sh (w/time stamp)
```
sudo apt-get install grabserial
```
### Real-Time-Clock (RTC)
It's recommend to use a real-time clock (RTC) like the DS3231 or similar if the script is used on a device without network connection.

## Usage:
```
sudo bash ./Syslog.sh 
```

## Autostart / 24h Restart
- Recommend to restart every 24h to reduce file size
- Add the following code to ``crontab -e``
- Important to change ``*USER*`` and ``*PATH*`` 
```
@reboot export DISPLAY=:0.0 XAUTHORITY=/home/*USER*/.Xauthority && sleep 10 && sudo bash *PATH*/Syslog.sh
@daily export DISPLAY=:0.0 XAUTHORITY=/home/*USER*/.Xauthority  && sleep 10 && sudo bash *PATH*/Syslog.sh
```

- ``export DISPLAY=:0.0`` to start a real terminal from crontab for interaction with the device
- ``XAUTHORITY=/home/*USER*/.Xauthority`` needed in some applications to run properly 
- ``sleep 10`` needed in some installations for initialise all USB ports 

#### Alternativ with Minicom
```
sudo apt-get install minicom
```
Change the following variable in Syslog.sh to ``APP="minicom" ``
