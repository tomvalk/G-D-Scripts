# PHP-CURL-Scripts
PHP and CURL script for sending XML code/files via the IP-Control-API to a G&D device 

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

### Important Settings:
```
--data <data> HTTP POST data; Use @./file.xml or text "<root>XML-Command</root>"
--http0.9 Allow HTTP 0.9 responses  
--max-time <seconds> Maximum time allowed for the transfer
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

### Important Settings:
```
 curl_setopt($ch, CURLOPT_TIMEOUT, 1); //Must be set to 1 to avoid infinite loop!
 curl_setopt($ch, CURLOPT_VERBOSE, false); //Optional, set to treu to provide additional details!
 curl_setopt($ch, CURLOPT_HTTP09_ALLOWED, 1); //Must be set to 1 to avoid HTTP/0.9 issues!
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, false); //Must be FALSE to receive a response!
 ```
