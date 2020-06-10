# Pi-Syslog-Script
Shell script for logging G&D devices

## Prerequisite:
```
sudo apt-get install minicom
```

## Usage:
```
sudo sh ./Syslog.sh 
```

## Autostart / 24h Restart
```
crontab -e
@reboot export DISPLAY=:0.0 XAUTHORITY=/home/*USER*/.Xauthority && sleep 10 && cd *PATH* && sudo sh ./Syslog.sh
@daily export DISPLAY=:0.0 XAUTHORITY=/home/*USER*/.Xauthority  && sleep 10 && cd *PATH* && sudo sh ./Syslog.sh
```

> "export DISPLAY=:0.0" to start a real terminal with minicom from crontab </br>
> "XAUTHORITY=/home/*USER*/.Xauthority" needed in some installations for minicom to run properly </br>
> "sleep 10" needed in some installations for initialise all USB ports </br>


## Contributing
For changes or issues, please open an issue first to discuss what you would like to change. <br/>


## Author
Tom Valk   <br/>
Int. Area Sales Manager  <br/>
State-certified technical engineer and business economist <br/>
Certified specialist trainer (BDVT)

