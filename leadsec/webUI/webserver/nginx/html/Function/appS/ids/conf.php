<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getAllIfname() {
    	$IfnameListArr = array();
    	$sql = "SELECT external_name FROM interface WHERE device_type=1 AND (workmode!=3) AND enable=1 AND valid=1 ORDER BY external_name asc";
    	$db  = new dbsqlite(DB_PATH . '/configs.db');
    	$result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	foreach ($result as $k => $v) {
    		$IfnameListArr[] = $v['external_name'];
    	}
    	return $IfnameListArr;
    }
    
    
    if (isset($_GET['conf'])) {
    	$ipsenable = $_POST['ipsenable'] === 'on' ? 'on' : 'off';
    	$ifname = $_POST['ifname'];
    	$ifused = $_POST['ifused'];
    	$ipaddr = $_POST['ipaddr'];
    	$cmd = ''; 
    	$path1 = "/usr/local/lxnids/lxnids.options";
    	$ipsstatus = getParamFromFile($path1,'/^LXNIDS_RUN=(\w{2,3})/');
    	if($ipsstatus[1] === 'YES' && $ipsenable === 'off')
    	{
    		$cli = new cli();
    		if($ifused !== $ifname){
    			$cmd = "ids setbasics off $ifused";
    			$cli->setLog('应用防护的入侵检测的基本配置停止')->run($cmd);
    		}
    		$cmd = "ids setbasics off $ifname";    		
    		$cli->setLog('应用防护的入侵检测的基本配置停止')->run($cmd);
    	}
    	else if($ipsstatus[1] === 'YES' && $ipsenable === 'on')
    	{
    		$cli = new cli();
    		$cmd = "ids setbasics on $ifname";
    		$cli->setLog('应用防护的入侵检测的基本配置启用在接口'.$ifname)->run($cmd);
    	}
    	else if($ipsstatus[1] === 'NO' && $ipsenable === 'on')
    	{
    		$cmd = 'ids start';
    		$cli = new cli();
    		$cli->setLog('应用防护的入侵检测的基本配置启用')->run($cmd);   
    		$cmd = "ids setbasics on $ifname";
    		$cli->setLog('应用防护的入侵检测的基本配置启用在接口'.$ifname)->run($cmd);
    	}
    	else if($ipsstatus[1] === 'NO' && $ipsenable === 'off')
    	{
    		$cli = new cli();
    		$cmd = "ids setbasics off $ifname";
    		$cli->setLog('应用防护的入侵检测的基本配置停止')->run($cmd);   	
    	}
    	$path2 = "/usr/local/lxnids/lxnids.conf";
    	if($ipaddr == "")
    	{
    		$val = "any";
    	}
    	else
    	{
    		$val = "[$ipaddr]";
    	}

    	modifyParamFromFile($path2, '/ipvar HOME_NET ((\[[^\]]+\])|(any))/',"ipvar HOME_NET $val");

    	echo json_encode(array('msg' => '修改成功。'));
 
    }
    else
    {    	
    	$iflist = getAllIfname();
    	$path1 = "/usr/local/lxnids/lxnids.options";
    	$path2 = "/usr/local/lxnids/lxnids.conf";
    	$ipsenable = getParamFromFile($path1,'/^LXNIDS_RUN=(\w{2,3})/');
    	$ipaddr = getParamFromFile($path2,'/^ipvar HOME_NET (any)/');
    	$ifused = getParamFromFile($path1,'/^(ETH)_(\d)=YES/');
    	$ifname = strtolower($ifused[1].$ifused[2]);
    	$sql = "SELECT external_name FROM interface WHERE internal_name='".$ifname."'";
    	$db  = new dbsqlite(DB_PATH . '/configs.db');
    	$ifchecked = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
    	if($ipaddr[1] == "any")
    	{
    		$ipaddr[1] = "";
    	}
    	else
    	{
    		$ipaddr = getParamFromFile($path2,'/^ipvar HOME_NET \[([^\]]+)\]/');
    	}
    	V::getInstance()->assign('ifnames', $iflist)
    	                ->assign('ipsenable', $ipsenable[1])
    	                ->assign('ipaddr', $ipaddr[1])
    	                ->assign('ifused', $ifchecked['external_name']);
    }        
?>
