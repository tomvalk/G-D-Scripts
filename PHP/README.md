# PHP-CURL-Scripts
PHP and CURL script for sending XML code/files via the IP-Control-API to a G&D device 

## Prerequisite:
```
CURL: sudo apt-get install curl 
PHP:  sudo apt-get install php php-curl 
```

## Usage cURL:
```
curl -X POST -d @./xml_test.xml 192.168.0.1:27994 --http0.9
```

## Usage PHP:
```
php -f curl_api_test.php
```

- Important Settings:
```
 curl_setopt($ch, CURLOPT_TIMEOUT, 1); //Must be set to 1 to avoid infinite loop!
 curl_setopt($ch, CURLOPT_VERBOSE, false); //Optional, set to treu to provide additional details!
 curl_setopt($ch, CURLOPT_HTTP09_ALLOWED, 1); //Must be set to 1 to avoid HTTP/0.9 issues!
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, false); //Must be FALSE to receive a response!
 ```
