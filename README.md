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
```

## Autostart / 24h Restart
- Recommend to restart every 24h to reduce file size
- Add the following code to ``crontab -e``
- Important to set ``*USER*``, ``*PATH*`` and specify ``Syslog.sh`` or ``Syslog_TS.sh``
```
@reboot export DISPLAY=:0.0 XAUTHORITY=/home/*USER*/.Xauthority && sleep 10 && cd *PATH* && sudo sh ./Syslog.sh
@daily export DISPLAY=:0.0 XAUTHORITY=/home/*USER*/.Xauthority  && sleep 10 && cd *PATH* && sudo sh ./Syslog.sh
```

### Info
- ``export DISPLAY=:0.0`` to start a real terminal from crontab 
- ``XAUTHORITY=/home/*USER*/.Xauthority`` needed in some installations to run properly 
- ``sleep 10`` needed in some installations for initialise all USB ports 


## Contributing
For changes or issues, please open an issue first to discuss what you would like to change. <br/>


## Author
Tom Valk   <br/>
Int. Area Sales Manager  <br/>
State-certified technical engineer and business economist <br/>
Certified specialist trainer (BDVT)
