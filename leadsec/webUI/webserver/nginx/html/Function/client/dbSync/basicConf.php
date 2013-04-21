<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

     //定义四个文件存放路径
    define('CACERTNAME_PATH', '/usr/local/cert/dbscert/lenovo_ng_dbs_ca.crt');
    define('SISCERTNAME_PATH', '/usr/local/cert/dbscert/lenovo_ng_dbs_user.crt');
    define('SISKEYNAME_PATH', '/usr/local/cert/dbscert/lenovo_ng_dbs_user.key');
    define('USERKEYWORDNAME_PATH', '/usr/local/cert/dbscert/lenovo_ng_dbs_user.key.pwd');
    
    function convert_Cert_Type ($init_path, $contents, $dest_path){
    	//文件类型转换
        $pos=strstr($contents,"CERTIFICATE");
    	$pos1=strstr($contents,"Certificate");
		if((pos!=NULL)||(pos1!=NULL)){//是文本文件
			copy($init_path,$dest_path);
			unlink($init_path);	
		} else {//是二进制文件
			$cli = new cli();
			$cmd ="/bin/rm /tmp/upload/test1.pem &>/dev/null"; 
			$cli->run($cmd);
			$cmd ="/usr/bin/openssl x509 -inform DER -in ".$init_path ." -out /tmp/upload/test1.pem";			
			$cli->run($cmd);
			$fp=fopen("/tmp/test1.pem","r");
			if(($fp)!=NULL && fgetc($fp)!= EOF){
				copy("/tmp/upload/test1.pem",$dest_path);
				unlink("/tmp/upload/test1.pem"); 	
			}
		}	
    }
    function CAcertStatus (){
     	// CA中心证书的状态
     	$CAcert['cert'] = "CA中心证书";
        $CAcert['name'] = "-----";
        $CAcert['overtime'] = "-----";
        if(file_exists(CACERTNAME_PATH)){
        	$CAcert['status'] = "已导入";
        	$CAcert['value'] = 1;
        }else{
        	$CAcert['status'] = "未导入";
        	$CAcert['value'] = 0;
        }
        return 	$CAcert;
    }
    
    function SIScertStatus (){
    	// 用户证书的状态
    	$SIScert['cert'] = "用户证书";
   		$SIScert['name'] = "-----";
        $SIScert['overtime'] = "-----";
        if(file_exists(SISCERTNAME_PATH)){        	
        	$fp = fopen(SISCERTNAME_PATH,"r");
        	while ($line = fgets($fp, 1024)) {        		
				$pos = strstr($line, "Not After");			
				if ( $pos ) {
					$pos = substr($pos,12);
					$SIScert['overtime'] = $pos; 
					continue;
				} 				
				$pos = strstr($line, "Subject:");
				if ( $pos ) { 
					$pos = strstr($line, "CN=");
					$tmp = split("/", $pos);
					$pos = split("=", $tmp[0]);
					$SIScert['name'] = $pos[1];										
					break;
				} 
			}
			if($SIScert['name']!=="" && $SIScert['overtime'] !==""){
				$SIScert['status'] = "已导入";
        		$SIScert['value'] = 1;	
			}else{
				$SIScert['status'] = "导入出错";
        		$SIScert['value'] = 1;	
			}
			fclose($fp);				
        }else{
        	$SIScert['status'] = "未导入";
        	$SIScert['value'] = 0;
        }
        return $SIScert;
    }
    
    function SISkeyStatus (){
    	// 用户密钥的状态
    	$SISkey['cert'] = "用户密钥";
   		$SISkey['name'] = "-----";
        $SISkey['overtime'] = "-----";
        if(file_exists(SISKEYNAME_PATH)){
        	$SISkey['status'] = "已导入";
        	$SISkey['value'] = 1;
        }else{
        	$SISkey['status'] = "未导入";
        	$SISkey['value'] = 0;
        }
        return $SISkey;
    }
    function certStatus (){
    	$CAcert = CAcertStatus ();          	   		
   		$status[1]['cert']= $CAcert['cert'];
   		$status[1]['name']= $CAcert['name'];
   		$status[1]['overtime']= $CAcert['overtime'];
   		$status[1]['status']= $CAcert['status'];
   		$status[1]['value']= $CAcert['value'];
   		
   		$SIScert = SIScertStatus ();
   		$status[2]['cert']= $SIScert['cert'];
   		$status[2]['name']= $SIScert['name'];
   		$status[2]['overtime']= $SIScert['overtime'];
   		$status[2]['status']= $SIScert['status'];
   		$status[2]['value']= $SIScert['value'];
   		
   		$SISkey = SISkeyStatus ();
   		$status[3]['cert']= $SISkey['cert'];
   		$status[3]['name']= $SISkey['name'];
   		$status[3]['overtime']= $SISkey['overtime'];
   		$status[3]['status']= $SISkey['status'];
   		$status[3]['value']= $SISkey['value'];
   		 //print_r($status);
   		return $status;
    }
    if ($_FILES['CAcert']['name'] || $_FILES['SIScert']['name'] ||  
    	$_FILES['SISkey']['name'] || $_POST['userKeyWord']) {
    	
		//将读取的文件暂时放到某目录下
        $fs = new fileUpload();
    	$fs->upload();
    	
		//读取CA中心证书，并将正确格式的证书写到"/tmp/upload/lenovo_ng_fs_ca.crt"下
    	$CAcert_name = $_FILES['CAcert']['name'];
    	$CAcert_init ="/tmp/upload"."/".$CAcert_name;
        $CAcert_contents = file_get_contents($CAcert_init);
		convert_Cert_Type ($CAcert_init, $CAcert_contents, CACERTNAME_PATH);
    	//读取用户证书，并将正确格式的证书写到"/tmp/upload/lenovo_ng_fs_user.crt"下
    	$SIScert_name = $_FILES['SIScert']['name'];
    	$SIScert_init ="/tmp/upload"."/".$SIScert_name;
        $SIScert_contents = file_get_contents($SIScert_init);
		convert_Cert_Type ($SIScert_init, $SIScert_contents, SISCERTNAME_PATH);
    	//读取用户密钥，并将正确格式的密钥写到"/tmp/upload/lenovo_ng_fs_user.key"下
    	$SISkey_name = $_FILES['SISkey']['name'];
    	$SISkey_init ="/tmp/upload"."/".$SISkey_name;
        $SISkey_contents = file_get_contents($SISkey_init);
        $key = preg_match("/PRIVATE/",$SISkey_contents);
		if($key !== 0){
			copy($SISkey_init,SISKEYNAME_PATH);
			unlink($SISkey_init);	
		}
		//获取用户密钥口令，并将正确格式写到"/tmp/upload/lenovo_ng_fs_user.key.pwd"下
    	$userKeyWord = $_POST['userKeyWord'];
    	if($userKeyWord !== ""){
    		file_put_contents(USERKEYWORDNAME_PATH, $userKeyWord);	
    	}
    	//根据四个文件来判断是否导入成功
		if(file_exists(CACERTNAME_PATH)&&file_exists(SISCERTNAME_PATH)&&
			file_exists(SISKEYNAME_PATH)&&file_exists(USERKEYWORDNAME_PATH)){
			$cli = new cli();
			$cmd ="/usr/sbin/backpkg config"; 
			$cli->run($cmd);	
    		echo json_encode(array('msg' => '导入成功'));	
		}else{
			echo json_encode(array('msg' => '导入失败'));	
		}
    	
    }  else if (!empty($_POST['delId'])) {
        // 删除
        $delId    = $_POST['delId'];

        if($delId==='CAcert'){
        	unlink(CACERTNAME_PATH);
        }else if($delId==='SIScert'){
        	unlink(SISCERTNAME_PATH);
        }else{
        	unlink(SISKEYNAME_PATH);
        }
        $cli = new cli();
		$cmd ="dbswapctl reconfigure 1>/dev/null"; 
		$cli->run($cmd);
        echo json_encode(array('msg' => "删除成功."));
    } else if (isset($_POST['orderStatement'])) {
        // 刷新页面
        $tpl =  'client/dbSync/basicConfTable.tpl';
     	$status = certStatus();        
        echo V::getInstance()->assign('status', $status)
        		             ->fetch($tpl);      		
    }
?>
