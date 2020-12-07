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
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, false); //IMPORTANT, must be FALSE!!!
 curl_setopt($ch, CURLOPT_HTTP09_ALLOWED, 1); //IMPORTANT, must be 1!!!
 curl_setopt($ch, CURLOPT_TIMEOUT, 1);
 curl_setopt($ch, CURLOPT_POST, true);
 curl_setopt($ch, CURLOPT_POSTFIELDS, $xml);
 curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
 curl_setopt($ch, CURLOPT_VERBOSE, true);
 $data = curl_exec($ch);
 
 error_log(print_r($data, TRUE));
 
 echo $data;
    
 ?>
