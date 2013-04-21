<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getCmd() {
        $type = $_POST['cmd'];
        $cmdstr = escapeshellcmd($type);
        $cmdarr = explode(" ",$cmdstr);
        if($cmdarr[0] == "tcpdump")
        {
        	$cmdstr = tcpdumpCmd($cmdarr[1]);
        }else if($cmdarr[0] == "traceroute"){
        	if(strpos($cmdarr[1],':') !== false){
        		$cmdstr = 'traceroute6 '.$cmdarr[1];
        	}
        }else if($cmdarr[0] == "ping"){
        	if(strpos($cmdarr[1],':') !== false){
        		$cmdstr = 'ping6 '.$cmdarr[1];
        	}
        }
        return $cmdstr;
    }
    function tcpdumpCmd($ifname){
    	
    	$tcpcmd = "";
    	$sql = "SELECT external_name,enable,device_type FROM interface WHERE external_name = '".$ifname."'";
    	$db  = new dbsqlite(DB_PATH . '/configs.db');
    	$result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	if(count($result) == 0)
    	{
    		return 1;
    	}
    	foreach ($result as $k => $v) {
    		if($v['enable'] == 0)
    		{
    			return 2;
    		}
    		else if($v['device_type'] != 1)
    		{
    			return 3;
    		}
    		$tcpcmd = "/usr/sbin/tcpdump -i ".$v['external_name']." -c 100";
    		return $tcpcmd;
    	}
    }
    if ($id = $_POST['cmd']) {
    	$rs = getCmd();
    	switch($rs){
    		case 1:
    			$result[0] = "tcpdumperror1";
    			break;
    		case 2:
    			$result[0] = "tcpdumperror2";
    			break;
    		case 3:
    			$result[0] = "tcpdumperror3";
    			break;    		
    		default:
    			$cli = new cli();
    			$result = $cli->setLog('状态监控的网络测试命令行')->setGetResult(true)->run(getCmd());
    			break;
    	}
        echo json_encode(array('msg' => $result));
    }
?>
