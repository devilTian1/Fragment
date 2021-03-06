<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getAllIpAddr() {
    	$path = "/usr/local/lxnids/idsauto.ignore";
    	$fp = @fopen($path, 'r');
    	if (!$fp) {
    		throw New Exception("Can not read file [$path]");
    	}
    	$str = file_get_contents($path);    	
    	$IpListArr = explode(PHP_EOL,$str);
    	$IpListArr = array_diff($IpListArr, array(''));
    	return $IpListArr;
    }
    
    function checkIDSStatus() {
    	$path = "/usr/local/lxnids/lxnids.options";
    	$idsenable = getParamFromFile($path,'/^LXNIDS_RUN=(\w{2,3})/');
    	if($idsenable[1] === 'YES'){
    		return 1;
    	}else{
    	    return -1;
    	}
    }
    
    if (isset($_GET['autoConf'])) {
    	$idsstatus = checkIDSStatus();
    	if($idsstatus === 1){
    		$enable = $_POST['autoenable'] === 'on' ? 'on' : 'off';
    		$time = $_POST['timeLimit'];
    		$iplist = $_POST['iplist'];
    		$cmd = '';
    		$path1 = "/usr/local/lxnids/lxnids.options";
    		$autoenable = getParamFromFile($path1,'/^idsautoRUN=([^\n]+)/');
    		if($enable === 'off')
    		{
    			$cmd = "ids setauto off";
    			$cli = new cli();
    			$cli->setLog('应用防护的入侵检测的自动响应配置停止')->run($cmd);
    		}
    		else if($enable === 'on')
    		{
    			$cmd = "ids setauto on $time";
    			if($iplist != '')
    			{
    				$ipstr = str_replace(","," ", $iplist);
    				$cmd = $cmd." $ipstr";
    			}
    			else
    			{
    				$cmd = $cmd.' ""';
    			}
    			$cli = new cli();
    			$cli->setLog('应用防护的入侵检测的自动响应配置启用')->run($cmd);
    		}
    		echo json_encode(array('msg' => '修改成功。'));
    	}else{
    		echo json_encode(array('msg' => '请先启动入侵检测。'));
    	}
    }
    else if(isset($_GET['clear']))
    {
    	$idsstatus = checkIDSStatus();
    	if($idsstatus === 1){
    		$cmd = 'ids setauto on 1 ""';
    		$cli = new cli();
    		$cli->setLog('应用防护的入侵检测的自动响应配置清除')->run($cmd);
    		echo json_encode(array('msg' => '修改成功。'));
    	}else{
    		echo json_encode(array('msg' => '请先启动入侵检测。'));
    	}    	
    }
    else
    {    	
    	$iparray = getAllIpAddr();
    	$iplist = '';
    	if(count($iparray) != 0)
    	{
    		$iplist = join(",",$iparray);
    	}
    	$path1 = "/usr/local/lxnids/lxnids.options"; 
    	$autoenable = getParamFromFile($path1,'/^idsautoRUN=([^\n]+)/');
    	$path2 = "/usr/local/lxnids/idsauto.conf";
    	$time = getParamFromFile($path2,'/^timeLimit\s+(\d+)/');    	
    	V::getInstance()->assign('iplist', $iplist)
    	                ->assign('autoenable', $autoenable[1])
    	                ->assign('time', $time[1]);
    }        
?>
