<?php
 $url = "192.168.0.1:27994";
 $xml = '<root><list><MatrixConnectionList/></list></root>';
 
 $headers = array(
     "Content-type: text/xml",
     "Content-length: " . strlen($xml),
     "Connection: close",
 );
 
 $ch = curl_init();
 curl_setopt($ch, CURLOPT_URL, $url);
 curl_setopt($ch, CURLOPT_POST, true);
 curl_setopt($ch, CURLOPT_POSTFIELDS, $xml);
 curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
 curl_setopt($ch, CURLOPT_TIMEOUT, 1); //Must be set to 1 to avoid infinite waiting for response!
 curl_setopt($ch, CURLOPT_HTTP09_ALLOWED, 1); //Must be set to 1 to avoid HTTP/0.9 issues!
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, false); //Must be FALSE to receive a response!
 curl_setopt($ch, CURLOPT_VERBOSE, false); //Optional, set to treu to provide additional details!

 $data = curl_exec($ch);
 error_log(print_r($data, TRUE));
 echo $data;
    
 ?>
