<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function checkCertValid($filePath, $include){
    	$fp = @fopen($filePath, 'r');
    	$flag = 0;
    	if ($fp) {
    		while (!feof($fp)) {
    			$buffer = fgets($fp, 4096);
    			if(strstr($buffer,$include)){
    				$flag = 1;
    				break;
    			}
    		}
    	}
    	return  $flag;
    }
    
    function checkSISCertByCA($certpath){
    	$cacert = $certpath.'/ca.crt';
    	$siscert = $certpath.'/server.crt';
    	$cli = new cli();
    	$cmd = '/usr/bin/openssl verify -CAfile '.$cacert.' '.$siscert.' 2>/dev/null';
    	$result = $cli->run($cmd);
    	return $result;
    }
    
    if(isset($_FILES['CAcert']))
    {
    	$uploadPath = '/tmp/cert';
    	$certPath = '/usr/local/webserver/cert';
    	$cli = new cli();
    	$cmd = "mkdir -p $uploadPath $certPath";
    	$cli->run($cmd);    		
    	$cacert = $certPath.'/ca.crt';
    	$siscert = $certPath.'/server.crt';
    	$siskey = $certPath.'/server.key';
    	$fs = new fileUpload($_FILES,$uploadPath);
    	$fs->upload();
    	
    	if($_FILES['CAcert'][name] !== 'ca.crt'){
    		$cmd = "mv $uploadPath/".$_FILES['CAcert'][name]." $uploadPath/ca.crt";
    		$rc = $cli->run($cmd);
    		
    	}
    	if($_FILES['SIScert'][name] !== 'server.crt'){
    		$cmd = "mv $uploadPath/".$_FILES['SIScert'][name]." $uploadPath/server.crt";
    	    $cli->run($cmd);
    	}
    	if($_FILES['SISkey'][name] !== 'server.key'){
    		$cmd = "mv $uploadPath/".$_FILES['SISkey'][name]." $uploadPath/server.key";
    	    $cli->run($cmd);
    	}    	    	
    	$isValidCA = checkCertValid($uploadPath.'/ca.crt','CERTIFICATE');
    	$isValidSIS = checkCertValid($uploadPath.'/server.crt','Certificate');
    	$isValidKey = checkCertValid($uploadPath.'/server.key','PRIVATE KEY');
    	if($isValidCA !== 1){
    		echo json_encode(array('msg' => '导入的CA证书格式不正确.'));    		
    	}
    	else if($isValidSIS !== 1){
    		echo json_encode(array('msg' => '导入的证书格式不正确.'));
    	}
    	else if($isValidKey !== 1){
    		echo json_encode(array('msg' => '导入的密钥格式不正确.'));
    	}
    	else{
    		$isMatch = checkSISCertByCA($uploadPath);
    		if($isMatch[0] == '/tmp/cert/server.crt: OK'){
    			$cmd = "mv $uploadPath/ca.crt $certPath/ca.crt";
    			$cli->run($cmd);
    			$cmd = "mv $uploadPath/server.crt $certPath/server.crt";
    			$cli->run($cmd);
    			$cmd = "mv $uploadPath/server.key $certPath/server.key";
    			$cli->run($cmd);
    			$cmd = "killall -9 nginx";
    			$cli->run($cmd);
    			$cmd = "/usr/local/webserver/nginx/sbin/nginx -c /usr/local/webserver/nginx/conf/nginx.conf";
    			$cli->run($cmd);
    		}
    		else{
    			echo json_encode(array('msg' => '导入证书不是一套有效证书.'));
    		}
    	}
    	
    }    
   
?>
