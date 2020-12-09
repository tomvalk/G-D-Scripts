# PHP-CURL-Scripts
PHP and CURL script for sending XML code/files via the IP-Control-API to a G&D device 

- Requires the G&D firmware expansion IP-Control-API togehther with an activated Remote-Control-Port:
```
Webinterface -> Matrix/Mux -> Information -> Activated Features
Webinterface -> Matrix/Mux -> Configuration -> Network -> Remote-Control -> TCP:xxxxx -> Enabled
```

## CURL-Script
### Prerequisite:
```
sudo apt-get install curl 
```

### Usage CURL with file:
```
curl 192.168.0.1:27994 --data @./xml_test.xml --http0.9 --max-time 1
```

### Usage CURL with direct commands:
```
curl 192.168.0.1:27994 --data "<root><list><MatrixConnectionList /></list></root>" --http0.9 --max-time 1
```

### Command settings:
```
--data <data>         HTTP POST data; Use @./file.xml or text "<root>XML-Command</root>"
--http0.9             Allow HTTP 0.9 responses  
--max-time <sec>      Maximum time allowed for the transfer; To avoid infinite waiting for response!
```


## PHP-Script
### Prerequisite:
```
sudo apt-get install php-curl 
```

### Usage PHP:
```
php -f curl_api_test.php
```

### Command settings:
```
-f <file>        Parse and execute <file>.
```

### Important .php file settings:
```
 curl_setopt($ch, CURLOPT_TIMEOUT, 1);            //Must be set to 1 to avoid infinite waiting for response!
 curl_setopt($ch, CURLOPT_HTTP09_ALLOWED, 1);     //Must be set to 1 to avoid HTTP/0.9 issues!
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, false); //Must be set to FALSE to receive a response!
 curl_setopt($ch, CURLOPT_VERBOSE, false);        //Optional, set to true to provide additional details!
 ```
