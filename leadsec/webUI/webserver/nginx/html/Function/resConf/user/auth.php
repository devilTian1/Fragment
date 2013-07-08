<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshPolicyConfData($where) {
        $tpl =  'resConf/user/authTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
	    $sql = 'SELECT auth_policy_name, ip, netmask, ingress, port, sa_type,' .
            ' active, auth_policy_id, sa_id FROM auth_policy';	    
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        $policycount = getDataCount();
        for($i = 0;$i < $policycount;$i++)
        {
        	if($result[$i]['sa_type'] === '4' || $result[$i]['sa_type'] === '5' || $result[$i]['sa_type'] === '6')
        	{
        		$objaddr = $result[$i]['sa_id'];
        		$db  = new dbsqlite(DB_PATH . '/rule.db');
        		$sql = "SELECT name FROM address WHERE id = $objaddr";
        		$addrresult = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        		$result[$i]['sa_id'] = $addrresult['name'];
        	}
        	
        }
        echo V::getInstance()->assign('res', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
    
    function freshServerConfData() {
    	$db  = new dbsqlite(DB_PATH . '/auth_server.db');
    	$sql = 'SELECT * FROM auth_server_info';
    	$result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);    	
    	return $result;
    }
    
    function freshParamsConfData() {
    	$db  = new dbsqlite(DB_PATH . '/auth_server.db');
    	$sql = 'SELECT * FROM auth_config_info';
    	$result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
    	return $result;
    }
    
    function getIfList() {
    	$db  = new dbsqlite(DB_PATH . '/configs.db');
    	$sql = 'SELECT external_name FROM interface WHERE enable = 1';
    	$d   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	$result = array();
    	foreach ($d as $v) {
    		$result[] = $v['external_name'];
    	}
    	$result = array(-1=>'') + $result;
    	return $result;
    }
    
    function getAddrList() {  	
    	$db  = new dbsqlite(DB_PATH . '/rule.db');
    	$sql = "SELECT name,id FROM address WHERE name NOT LIKE '%_ipv6'";
    	$d   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	$result = array(array());
    	foreach ($d as $v) {
    		$result[0][] = $v['name'];
    		$result[1][] = $v['id'];
    	}
    	return $result;
    }
    
    function getSpecAuthData($name) {
    	$db  = new dbsqlite(DB_PATH . '/uma_auth.db');
    	$sql = "SELECT * FROM auth_policy where auth_policy_name = '$name'";
    	return $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
    }
    
    function getCmdStr($action) {
    	$AuthPolicyName = $_POST['AuthPolicyName'];
    	$addrType = $_POST['addrType'];
    	$ip = $_POST['authIp'];
    	$netmask = $_POST['authNetmask'];
    	$range_s = $_POST['authRange_s'];
    	$range_e = $_POST['authRange_e'];
    	$objaddr = $_POST['objaddr'];
    	$ingress = $_POST['ingress'];
    	$port = $_POST['dport'];
    	$active = $_POST['active'];
    	$ct = $active === 'add' ? '添加' : '修改';
    	$comment  = $_POST['comment'];
    	$cmd = "auth-policy $action policyname $AuthPolicyName";
    	if($ingress !== '')
    	{
    		$cmd = $cmd." ingress $ingress";
    		if($addrType === 'default')
    		{
    			if($ip !== '')
    			{
    				$cmd = $cmd." ipv4 $ip";
    				if($netmask !== '')
    				{
    					$cmd = $cmd."/$netmask";
    				}
    			}
    		}
    		else if($addrType === 'range')
    		{
    			if($range_s !== '')
    			{
    				$cmd = $cmd." ipv4 $range_s";
    				if($range_e !== '')
    				{
    					$cmd = $cmd.":$range_e";
    				}
    			}
    		}
    		else if($addrType === 'object')
    		{
    			if($objaddr !== '')
    			{
    				$cmd = $cmd." ipv4 $objaddr";
    			}
    		}
    	}
    	else
    	{
    		if($addrType === 'default')
    		{
    			if($ip !== '')
    			{
    				$cmd = $cmd." ipv4 $ip";
    				if($netmask !== '')
    				{
    					$cmd = $cmd."/$netmask";
    				}
    			}
    		}
    		else if($addrType === 'range')
    		{
    			if($range_s !== '')
    			{
    				$cmd = $cmd." ipv4 $range_s";
    				if($range_e !== '')
    				{
    					$cmd = $cmd.":$range_e";
    				}
    			}
    		}
    		else if($addrType === 'object')
    		{
    			if($objaddr !== '')
    			{
    				$cmd = $cmd." ipv4 $objaddr";
    			}
    		}
    	}
    	if($active === '1')
    	{
    		$cmd = $cmd.' active on';
    	}
    	else
    	{
    		$cmd = $cmd.' active off';
    	}
    	
    	if($port !== '')
    	{
    		$cmd = $cmd." port \"$port\"";
    	}
    	if($comment !== '')
    	{
    		$cmd = $cmd." comment \"$comment\"";
    	}
    	$cArr = array();
    	$cArr['cmd'] = $cmd;
    	$cArr['log'] = $ct.'资源配置的用户的认证配置认证策略'.$AuthPolicyName;
    	return $cArr;
    }
    
    function getWhereStatement($db, $cols, $keyword) {
    	$value = '%' . $keyword . '%';
    	$params = array_fill(0, count(explode(',', $cols)), $value);
    	return array('sql'    => ' WHERE (' .
    			$db->getWhereStatement($cols, 'OR', 'like') . ')',
    			'params' => $params);
    }
    
    function getDataCount() {
    	$sql = 'SELECT auth_policy_id FROM auth_policy';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    if (isset($_GET['serverConf'])) {    	
    	$authPort = $_POST['authPort'];
    	$redirectUrl = $_POST['redirectUrl'];
    	$log = $_POST['log'] === '1' ? 'on' : 'off';
    	$cmd = 'auth server workmode local';
    	$cli = new cli();
    	$cli->setLog('资源配置的用户的认证配置认证服务器配置')->run($cmd);    	
    	$cmd = "auth server localport $authPort";
    	$cli->setLog('资源配置的用户的认证配置认证服务器配置')->run($cmd);
    	$cmd = "auth server log $log";
    	$cli->setLog('资源配置的用户的认证配置认证服务器配置')->run($cmd);
    	$cmd = "auth server redirecturl $redirectUrl";
    	$cli->setLog('资源配置的用户的认证配置认证服务器配置')->run($cmd);
    	echo json_encode(array('msg' => '修改成功。'));
    }else if (isset($_GET['paramsConf'])){
    	$forceModify = $_POST['forceModify'] === 'on' ? 'yes' : 'no';
    	$pwdComplex = $_POST['pwdComplex'];
    	switch($pwdComplex)
    	{
    		case 1:
    			$pwdComplex = 'none';
    			break;
    		case 2:
    			$pwdComplex = 'weak';
    			break;
    		case 3:
    			$pwdComplex = 'normal';
    			break;
    		case 4:
    			$pwdComplex = 'good';
    			break; 
    		case 5:
    			$pwdComplex = 'better';
    			break;
    		case 6:
    			$pwdComplex = 'great';
    			break;
    		default:
    			$pwdComplex = 'normal';
    			break;
    	}
    	$maxLoadTimes = $_POST['maxLoadTimes'];
    	$unlockTime = $_POST['unlockTime'];
    	$pwdPeriod = $_POST['pwdPeriod'];
    	$pwdRemind = $_POST['pwdRemind'];
    	$idleTime = $_POST['idleTime'];
    	$cmd = "auth config forcemodify $forceModify pwdcomplex $pwdComplex maxloadtimes $maxLoadTimes unlocktime $unlockTime pwdperiod $pwdPeriod pwdremind $pwdRemind idletime $idleTime";
    	$cli = new cli();
    	$cli->setLog('资源配置的用户的认证配置认证参数配置')->run($cmd);
    	echo json_encode(array('msg' => '修改成功。'));
    }else if(isset($_POST['addNewAuthPolicy'])){
    	// Open add new auth policy dialog
    	$result = array();
    	$result['iflist'] = getIfList();
    	$addrlist = getAddrList();
    	$result['addrname'] = $addrlist[0];
    	$result['addrid'] = $addrlist[1];
    	$result = V::getInstance()->assign('autopolicy', $result)
    	->assign('type', 'add')->fetch('resConf/user/editAuthPolicyDialog.tpl');
    	echo json_encode(array('msg' => $result));
    }else if ($name = $_POST['editAuthPolicy']) {
    	// Open edit spec auth policy dialog
    	$authData =  getSpecAuthData($name);
    	$authData['iflist'] = getIfList();
    	$addrlist = getAddrList();
    	$authData['addrname'] = $addrlist[0];
    	//$authData['addrid'] = $addrlist[1];
    	switch($authData['sa_type'])
    	{
    		case 1:
    		case 2:
    			$authData['sa_type'] = 'default';
    			break;
    		case 3:
    			$authData['sa_type'] = 'range';
    			break;
    		case 4:
    		case 5:
    		case 6:
    			$authData['sa_type'] = 'object';
    			break;
    		default:
    			$authData['sa_type'] = 'default';
    			break;
    	}
    	$result = V::getInstance()->assign('autopolicy', $authData)
    	->assign('type', 'edit')
    	->fetch('resConf/user/editAuthPolicyDialog.tpl');
    	echo json_encode(array('msg' => $result));
    }else if ('edit' === $_POST['type']) {
    	// Edit spec auth policy
        $cli = new cli();
        $cmd = getCmdStr('set');
        $cli->setLog($cmd['log'])->run($cmd['cmd']);
        echo json_encode(array('msg' => '修改成功。'));
    }else if ('add' === $_POST['type']) {
    	// Add new auth policy
    	$cli = new cli();
    	$cmd = getCmdStr('add');
    	$cli->setLog($cmd['log'])->run($cmd['cmd']);
    	echo json_encode(array('msg' => '添加成功。'));
    }else if ($name = $_POST['delName']) {
        // Delete specified auth policy
        $cli = new cli();
        $cli->setLog('删除资源配置的用户的认证配置认证策略'.$name)->run("auth-policy del policyname $name");
        echo json_encode(array('msg' => '删除成功。'));
    }else if (!empty($_POST['delAllAuthPolicy'])) {
        // Delete All auth policy
        $cli = new cli();
        $cli->setLog('全部删除资源配置的用户的认证配置认证策略')->run('auth-policy del all');
        echo json_encode(array('msg' => '已清空认证策略。'));
    }else if ($policys = $_POST['delSpecAuthPolicy']) {
        // Batch Delete spec auth policy
        $cli = new cli();
        foreach ($policys as $name) {
            $cli->setLog('删除资源配置的用户的认证配置认证策略'.$name)->run("auth-policy del policyname $name");
        }
        echo json_encode(array('msg' => '批量删除成功。'));
    }else if ($action = $_POST['action']) {
        // Switch specified physical device
        $name = $_POST['switch_name'];
        $cli = new cli();
        if ($action === 'disable') {
            $cmd = "auth-policy active policyname \"$name\" off";
            $cli->setLog('停止资源配置的用户的认证配置认证策略'.$name)->run($cmd);
            echo json_encode(array('msg' => "[$name]已停止。"));
        } else if ($action === 'enable') {
            $cmd = "auth-policy active policyname \"$name\" on";
            $cli->setLog('启动资源配置的用户的认证配置认证策略'.$name)->run($cmd);
            echo json_encode(array('msg' => "[$name]已启用。"));
        } else {
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误。'));
        }
    }else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort list
        freshPolicyConfData($orderStatement);

    }else {
        // init page
        $result = getDataCount();
        $sresult = freshServerConfData();
        $presult = freshParamsConfData();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2)
	        ->assign('serverConf', $sresult)
	        ->assign('paramsConf', $presult);
    }
?>
