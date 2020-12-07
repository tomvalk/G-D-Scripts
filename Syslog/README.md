# Pi-Syslog-Script
Shell script for logging G&D devices

## Prerequisite:
### Syslog.sh
```
sudo apt-get install minicom
```
### Syslog_TS.sh (w/time stamp)
```
sudo apt-get install grabserial
```
### Real-Time-Clock (RTC)
It's recommend to use a real-time clock (RTC) like the DS3231 or similar if the script is used on a device without network connection.


## Usage:
```
sudo sh ./Syslog.sh 
sudo sh ./Syslog_TS.sh 
```

## Autostart / 24h Restart
- Recommend to restart every 24h to reduce file size
- Add the following code to ``crontab -e``
- Important to change ``*USER*``, ``*PATH*`` and specify ``Syslog.sh`` or ``Syslog_TS.sh``
```
@reboot export DISPLAY=:0.0 XAUTHORITY=/home/*USER*/.Xauthority && sleep 10 && cd *PATH* && sudo sh ./Syslog.sh
@daily export DISPLAY=:0.0 XAUTHORITY=/home/*USER*/.Xauthority  && sleep 10 && cd *PATH* && sudo sh ./Syslog.sh
```

- ``export DISPLAY=:0.0`` to start a real terminal from crontab 
- ``XAUTHORITY=/home/*USER*/.Xauthority`` needed in some Minicom installations to run properly 
- ``sleep 10`` needed in some installations for initialise all USB ports 
