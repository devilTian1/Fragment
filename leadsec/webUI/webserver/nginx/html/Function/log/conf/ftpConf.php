<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getParam() {
        $ip        = $_POST['ip'];
        $ftpMode   = $_POST['ftpMode']=== '1' ? 'passive':'active';;
        $ftpName   = $_POST['ftpName'];
        $ftpPasswd = $_POST['password1'];
        $ftpPort   = $_POST['ftpPort'];
        return array($ip, $ftpMode, $ftpName, $ftpPasswd, $ftpPort);
    }	

    if ('test' === $_POST['action']) {
        list($ip, $ftpMode, $ftpName, $ftpPasswd, $ftpPort) = getParam();
        $connId = @ftp_connect($ip, $ftpPort, 5);
        if (!$connId) {
            echo json_encode(array('msg' => "无法连接到$ip。"));
            return ;
        }
        if (@ftp_login($connId, $ftpName, $ftpPasswd)) {
            echo json_encode(array('msg' => '测试成功。'));
        } else {
            echo json_encode(array('msg' => '测试失败。'));
        }
    } else if ('clear' === $_POST['action']) {
    	$cmd = "/usr/local/bin/logserver clear ftpsrv";
    	$cli = new cli();
    	$cli->setLog("清除Ftp相关配置")->run($cmd);
    	echo json_encode(array('msg' => '清除成功。'));
    } else if ('conf' === $_POST['action']) {
        // modify dns ip
        list($ip, $ftpMode, $ftpName, $ftpPasswd, $ftpPort) = getParam();
        $cmd = "/usr/local/bin/logserver set ftpsrv ip $ip port $ftpPort ".
        	"mode $ftpMode user $ftpName pass $ftpPasswd";
        $cli = new cli();
        $cli->setLog("修改Ftp相关配置")->run($cmd);
        echo json_encode(array('msg' => '修改成功。'));
    } else if (isset($_GET['auto'])) {  	
		$autoUpload  = $_POST['autoUpload'] === 'on' ? 'yes':'no';
    	if($_POST['upWay'] === '1'){
    		// 按时间长度，每N小时上传一次    			
    		$hour = $_POST['hour'];
    		$timeStr = "upway h hour $hour";
    	}
    	else if($_POST['upWay'] === '2'){
    		// 按固定时间，每天N点上传
    		$day = $_POST['day'];
    		$timeStr = "upway d day $day";
    	}
    	else if($_POST['upWay'] === '3'){
    		// 按每周时间，每周星期M，N点上传
    		$week = $_POST['week'];
    		$whour = $_POST['whour'];
    		$timeStr = "upway w week $week w_hour $whour";
    	}
        $cmd = "/usr/local/bin/logserver set autoupload enable $autoUpload ".
        	$timeStr;
        $cli = new cli();
        $cmdInfo = $cli->setLog("修改自动上传日志配置")->execCmdGetStatus($cmd);
        if($cmdInfo[0] != '0'){
        	echo json_encode(array('msg' => '设置自动上传日志失败，请确认配置是否正确。'));
        }else{
        	echo json_encode(array('msg' => '修改成功。'));
        }       
   } else if (isset($_GET['log'])) {
        // 立即上传日志
        $cmd = "/usr/local/bin/logserver ftplog";       	         	 	      	
        $cli = new cli(); 
        //$cli->setLog("立即上传日志")->run($cmd);
        $cmdInfo = $cli->setLog("立即上传日志")->execCmdGetStatus($cmd);
        if($cmdInfo[0] != '0'){
        	echo json_encode(array('msg' => '上传日志失败，请确认配置是否正确。'));
        }else{
        	echo json_encode(array('msg' => '上传日志成功。'));
        }
        
        
    }else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query('SELECT * FROM log_ftpsrv')
                     ->getAllData(PDO::FETCH_ASSOC);
   		foreach($result as $r){
        	$ftp['ftpsrv']=$r['ftpsrv'];
        	$ftp['user']=$r['user'];
        	$ftp['pass']=$r['pass'];
        	$ftp['passive']=$r['passive'];
        	$ftp['port']=$r['port'];
        }             
		$result1 = $db->query('SELECT * FROM logupload')
                     ->getAllData(PDO::FETCH_ASSOC);
        foreach($result1 as $r1){
        	$auto['enable']=$r1['enable'];
        	$auto['upway']=$r1['upway'];
        	$auto['shour']=$r1['hour'];
        	$auto['sday']=$r1['day'];
        	$auto['sweek']=$r1['week'];
        	$auto['swh']=$r1['w_hour'];
        }
        V::getInstance()->assign('ftp', $ftp)
        				->assign('auto', $auto);
    }
?>
