# PHP-cURL-Scripts
PHP-cURL script for sending XML code/files via the IP-Control-API 

## Prerequisite:
```
cURL: sudo apt-get install curl 
PHP:  sudo apt-get install php php-curl nghttp2 
```

## Usage cURL:
```
curl -X POST -d @./curl_test.xml 192.168.0.1:27994
```

## Usage PHP:
```
php -f curl_api_test.php
```

- Important Settings:
```
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, false); //Must be FALSE to receive a response!
 curl_setopt($ch, CURLOPT_HTTP09_ALLOWED, 1); //Must be set to 1 to avoid HTTP/0.9 issues!
 ```
