<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendFastPassData($where) {
        $tpl =  'client/safePass/safePassTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_fastpass.db');
	    $sql = "SELECT * FROM fastpass_client_acl";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $key => $arr) {
        	$result[$key]['sa'] = addrNameDelPreffix($arr['sa']);
        	if ($arr['samenet'] === 'no') {
        		$result[$key]['da'] = addrNameDelPreffix($arr['da']);
        	}
        }
        echo V::getInstance()->assign('fpList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
    
    function getWhereStatement($db, $cols, $keyword) {
        $value  = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' WHERE (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }

    function getDataCount() {
    	$sql = "SELECT id FROM fastpass_client_acl";
        $db  = new dbsqlite(DB_PATH . '/netgap_fastpass.db');
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    function getCmd() {
    	if (!empty($_POST['delId'])) {
    		$id     = $_POST['delId'];
    		return "fpctl del task type client id $id";
    	}
        $type = $_POST['type'];
        if ($type === 'add') {
            $action = 'add';            
        } elseif ($type === 'edit' || !empty($_POST['activeSwitch'])) {
            $action = 'set';
        } else {
            throw new Exception('fatal action: [' . $type . '].');
        }
        $id     = intval($_POST['safePassId']);
        $acessType = $_POST['accessType'];
        $sa 	   = $_POST['srcIpList'];
        $da 	   = $acessType==='yes' ? $_POST['destIpList_normal'] : $_POST['destIpList_trans'];
        $service   = $_POST['serviceList'];
    	if (empty($_POST['safePassSrcPort']) || $_POST['safePassSrcPort'] === '----') {
    		$sport = '1:65535';        	
    	} else {
    		$sport = $_POST['safePassSrcPort'];
    	}
    	if (empty($_POST['safePassDestPort']) || $_POST['safePassDestPort'] === '----') {
    		$dport = '1:65535';        	
    	} else {
    		$dport = $_POST['safePassDestPort'];
    	} 
        

        $active = $_POST['activeChk'] === 'ok' ? 'on' : 'off';

        $log 	   = $_POST['logChk'] === 'Y' ? 'on' : 'off';
        if (!empty($_POST['timeList'])) {
        	$time  = $_POST['timeList'];
    	} else {
    		$time  = "none";
    	}
        $comment   = $_POST['comment'];
        $syn 	   = $_POST['synFloodChk'] === 'on' ? $_POST['synFloodTxt'] : 'off';
        $udp 	   = $_POST['udpFloodChk'] === 'on' ? $_POST['udpFloodTxt'] : 'off';
        $icmp 	   = $_POST['icmpFloodChk'] === 'on' ? $_POST['icmpFloodTxt'] : 'off';
        $ping	   = $_POST['pingFloodChk'] === 'on' ? 'on' : 'off';;

        $result = "fpctl $action task type client id $id samenet $acessType sa $sa sport $sport" .
            " da $da dport $dport service $service time $time active $active log $log syn $syn" . 
            " udp $udp icmp $icmp ping $ping ";
        $result .= "comment \"$comment\"";
        return $result;
    }    
    
    function addrNameDelPreffix($name) {
    	// 去掉最后一个下划线_ipv4或_ipv6
    	return substr($name,0,-5);    	
	}

    if (!empty($_POST['editId'])) {
        // Open a specified safepass data
        $tpl = $_POST['tpl'];
        $id  = $_POST['editId'];		
        $db  = new dbsqlite(DB_PATH . '/netgap_fastpass.db');
        $sql = "SELECT * FROM fastpass_client_acl WHERE id = '$id'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);       
        $result = V::getInstance()
        	->assign('saddrOptions', netGapRes::getInstance()->getAddr(true))
        	->assign('daddrOptions', netGapRes::getInstance()->getAddr())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('interfaceList', netGapRes::getInstance()->getInterface())
        	->assign('editSafePass', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
     } else if (isset($_POST['openAddDialog'])) {
        // Open a new safepass dialog
        $tpl = $_POST['tpl'];
        $result = V::getInstance()
            ->assign('saddrOptions', netGapRes::getInstance()->getAddr(true))
            ->assign('daddrOptions', netGapRes::getInstance()->getAddr())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('interfaceList', netGapRes::getInstance()->getInterface())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified safepass data
        $cli = new cli();
        $cli->setLog("修改一条任务号为".$_POST['safePassId']."的安全通道")->run(getCmd());
        echo json_encode(array('status'=>0,'msg' => "修改成功。"));
    } else if ('add' === $_POST['type']) {
        // Add a new safepass data
        $cli = new cli();
        $cli->setLog("添加一条任务号为".intval($_POST['safePassId'])."的安全通道")->run(getCmd());
        echo json_encode(array('status'=>0,'msg' => '添加成功。'));
    } else if (!empty($_POST['delId'])) {
        // Delete the specified safepass data        
        $cli = new cli();
        $cli->setLog("删除一条任务号为".$_POST['delId']."的安全通道")->run(getCmd());
        echo json_encode(array('msg' => "删除成功。"));
    } else if ($_POST['activeSwitch']) {
    	// active on/off a safepass
    	$cli = new cli();
    	$activeLog = $_POST['activeChk']==='ok'?'开启':'关闭';
        $cli->setLog($activeLog."任务号为".$_POST['safePassId']."的安全通道")->run(getCmd());
        echo json_encode(array('msg' => '成功.'));
    } else if (!empty($_GET['checkExistId'])) {
        // Check the same id exist or not
        echo netGapRes::getInstance()->checkExistTaskId('safepass',intval($_GET['safePassId']));
        //checkExistId($_GET['safePassId']);
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort safepass list
        appendFastPassData($orderStatement);
    } else {
        // init page data
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
