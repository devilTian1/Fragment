<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (isset($_POST['managerName'])) {
        // modify		
		$cmdUnsetStr = "snmp unset";
		$cmdstr = "snmp set";
			
		// snmpip
		if(!empty($_POST['iplist']))
		{
			$iplist = $_POST['iplist'];
			$ipstr = join("|",$iplist);
			$cmdstr .= " snmpip \"" . $ipstr . "\"";
		}
		else {
			$cmdUnsetStr .= " snmpip";
		}
		// principal
		if(!empty($_POST['managerName']))
		{
			$managerName = $_POST['managerName'];
			$cmdstr .= " principal $managerName";
		}
		else {
			$cmdUnsetStr .= " principal";
		}
		// telephone
		if(!empty($_POST['managerTel']))
		{
			$managerTel = $_POST['managerTel'];
			$cmdstr .= " telephone $managerTel";
		}
		else{
			$cmdUnsetStr .= " telephone";
		}
		// cpu
		if(!empty($_POST['CPU']))
		{
			$cpu = $_POST['CPU'];
			$cmdstr .= " cpu $cpu";
		}
		else {
			$cmdUnsetStr .= " cpu";
		}
		// mem
		if(!empty($_POST['memory']))
		{
			$mem = $_POST['memory'];
			$cmdstr .= " mem $mem";
		}
		else {
			$cmdUnsetStr .= " mem";
		}
		// fs
		if(!empty($_POST['disk']))
		{
			$disk = $_POST['disk'];
			$cmdstr .= " fs $disk";
		}
		else {
			$cmdUnsetStr .= " fs";
		}
		// comment
		if(!empty($_POST['hostComment']))
		{
			$Comment = $_POST['hostComment'];
			$cmdstr .= " comment $Comment";
		}
		else {
			$cmdUnsetStr .= " comment";
		}
		//trapc
		if(!empty($_POST['trapStr']))
		{
			
			$trapc = $_POST['trapStr'];
			$cmdstr .= " trapc $trapc";
		}
		else {
			$cmdUnsetStr .= " trapc";
		}
		// snmpv1 & v2
		if($_POST['snmpChk'] === 'on')
		{
			if(!empty($_POST['readOnly']))
			{
				$rcomm = $_POST['readOnly'];
				$cmdstr .= " rcomm $rcomm";
			}
			else {
				$cmdUnsetStr .= " rcomm";
			}
			if(!empty($_POST['writeAndReady']))
			{
				$wcomm = $_POST['writeAndReady'];
				$cmdstr .= " wcomm $wcomm";
			}
			else {
				$cmdUnsetStr .= " wcomm";
			}
			$cmdstr .= " comm2sec on";
		}
		else {
			$cmdstr .= " comm2sec off";
		}

		// snmp v3
		if($_POST['snmpv3Chk']==='on')
		{
			$v3Username = $_POST['v3Usrname'];
			$secSelect = $_POST['secSelect'];
			$authProtoNum = $_POST['authProto'];
			if($authProtoNum === '0')
				$authProto = "MD5";
			else 
				$authProto = "SHA";
			$authPhrase = $_POST['authPhrase'];
			$privProtoNum = $_POST['privProto'];
			if($privProtoNum === '0')
				$privProto = "DES";
			else 
				$privProto = "AES";
			$privPhrase = $_POST['privPhrase'];
			$cmdv3Str = "snmpusm set user $v3Username level $secSelect authproto $authProto authpass \"$authPhrase\" privproto $privProto privpass \"$privPhrase\" active on ";
		}
		else {
			$cmdv3Str = "snmpusm set active off";
		}
		$cli = new cli();
		if($cmdUnsetStr !== "snmp unset") 
		{
			$cli->run($cmdUnsetStr);
		}  
       	$cli->run($cmdstr);

		$cli->run($cmdv3Str);
        echo json_encode(array('msg' => '修改成功。'));
    } else if (isset($_GET['reconf'])) {
		// start/stop service
        $cli = new cli();
		$path = "/usr/local/bin/";
        if ('on' === $_POST['switch']) {
			$msg_log = '集中管理模块下启动snmp代理服务';
			list($status,$result) = $cli->setLog($msg_log)
				->execCmdGetStatus($path.'snmpsvr start 1>/dev/null');
			if ($status > 0) {
				echo json_encode(array('msg' => 'snmp代理服务启动失败!请确认配置是否正确。'));
			} else {
				echo json_encode(array('msg' => 'snmp代理服务启动成功!'));
			}
        } else {
            // stop start
			$msg_log = '集中管理模块下启动snmp代理服务';
			list($status,$result) = $cli->setLog($msg_log)
				->execCmdGetStatus($path.'snmpsvr stop 1>/dev/null');
			if ($status > 0) {
				echo json_encode(array('msg' => 'snmp代理服务停止失败!'));
			} else {
				echo json_encode(array('msg' => 'snmp代理服务已停止!'));
			}
        }
	} else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query('SELECT * FROM snmp')
                     ->getFirstData(PDO::FETCH_ASSOC);
        $result1 = $db->query('SELECT * FROM snmpusm')
                     ->getFirstData(PDO::FETCH_ASSOC);
       $result2 = $db->query('SELECT * FROM hostname')
                     ->getFirstData(PDO::FETCH_ASSOC);
        if(!empty($result['ip']))
        	$iplist = split("\|",$result['ip']);
		// check the snmp service status
		$cli     = new cli();
        $return  = $cli->setGetResult(true)->run('snmpsvr status');
        $str     = strtolower($return[0]);
        if (false !== strpos($str, 'stop')) {
            $switch = 'off';
        } else if (false !== strpos($str, 'start')) {
            $switch = 'on';
        } else {
            throw new Exception('Can`t detect the status of lvs service.');
        }
        V::getInstance()->assign('snmp', $result)
        				->assign('iplist',$iplist)
        				->assign('hostname',$result2['hostname'])
        				->assign('snmpv3', $result1)
						->assign('status', $switch);
    }
?>
