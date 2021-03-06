<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function checkIDSStatus() {
    	$path = "/usr/local/lxnids/lxnids.options";
    	$idsenable = getParamFromFile($path,'/^LXNIDS_RUN=(\w{2,3})/');
    	if($idsenable[1] === 'YES'){
    		return 1;
    	}else{
    		return -1;
    	}
    }
    
    //if (isset($_POST['scanInterval']) && isset($_POST['connectTimes'])) {
     if (isset($_GET['scanConf'])) {
        // modify
    	$idsstatus = checkIDSStatus();
    	if($idsstatus === 1){
    		$enableScan = $_POST['enableScan'] === 'on' ? 'on' : 'off';
    		$interval = $_POST['scanInterval'];
    		$connectTimes = $_POST['connectTimes'];
    		$ignoreIp = $_POST['ignoreIp'];
    		$ip = str_replace(',',' ',$ignoreIp);
    		$cmd = "ids scanconf $enableScan $interval $connectTimes";
    		if ($ip !== '') {
    			$cmd .= ' ' . $ip;
    		}
    		$cli = new cli();
    		$cli->setLog("开启ids服务")->run('ids start');
    		$cli->setLog("配置扫描检测")->run($cmd);
    		echo json_encode(array('msg' => '修改成功。'));
    	}else{    		
			echo json_encode(array('msg' => '请先启动入侵检测。'));
    	}    	
    } else if(isset($_GET['clearScanConf'])) {
    	$idsstatus = checkIDSStatus();
    	if($idsstatus === 1){
    		$enableScan = $_POST['enableScan'] === 'on' ? 'on' : 'off';
        	$interval = $_POST['scanInterval'];
        	$connectTimes = $_POST['connectTimes'];
    		$cmd = "ids scanconf $enableScan $interval $connectTimes";
    		$cli = new cli();
			$cli->setLog("开启ids服务")->run('ids start');
       		$cli->setLog("应用防护的入侵检测的扫描检测配置清除IP")->run($cmd);
        	echo json_encode(array('msg' => 'IP清除成功。'));
    	}else{    		
			echo json_encode(array('msg' => '请先启动入侵检测。'));
    	}     	
    } else {
        // init page data
        $path = '/usr/local/lxnids/lxnids.scan';
        $params= getParamFromFile($path,'/^#preprocessor portscan: \$HOME_NET/');
        if (empty($params)) {
            $enableScan = 1;
        } else {
            $enableScan = 0;
        }
        
        $params = getParamFromFile($path,'/^#?preprocessor portscan: \$HOME_NET (\d+) (\d+)/');
        $interval = $params[1];
        $connectTimes = $params[2];

        
        $match = getParamFromFile($path,'/^#?preprocessor portscan-ignorehosts: \[([^\]]+)\]/');
        $ipList = $match[1];
        $ipArr = explode(',',$ipList);
        $ip = array();
        foreach ($ipArr as $arr) {
            $label = strpos($arr,'/');
            $ip[] = substr($arr,0,$label);
        }
        $ipstr = join(',',$ip);
        V::getInstance() ->assign('enableScan', $enableScan)
                                    ->assign('interval', $interval)
        				->assign('connectTimes',$connectTimes)
        				->assign('ipList', $ipstr);  
    }
?>
