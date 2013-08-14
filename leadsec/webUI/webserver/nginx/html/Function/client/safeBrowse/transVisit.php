<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendTransAccData($where) {
        preg_match('/OFFSET\s(\d+)$/', $where, $match);
        $offset = intval($match[1]) + 1;

        $tpl =  'client/safeBrowse/transVisitTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
	    $sql = "SELECT * FROM acl WHERE transparent=1";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $key => $arr) {
        	$result[$key]['sip']= addrNameDelPreffix($arr['sip']);
        	$result[$key]['dip']= addrNameDelPreffix($arr['dip']);
        }
        echo V::getInstance()->assign('TransAcc', $result)
            ->fetch($tpl);
    }
    
    function getWhereStatement($db, $cols, $keyword) {
        $value  = $keyword ;
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' AND (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $db->getFilterParams($params));
    }

    function getDataCount() {
    	$sql = "SELECT id FROM acl WHERE transparent=1";
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        $params = array();
		$keyword='/'.$_GET['keyword'];
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $keyword);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    function getCmd() {
    	$cmd  = Array();
    	if (!empty($_POST['delId'])) {
    		$id     = $_POST['delId'];    		
    		$cmd[] = "httpctl del transparentacl id $id";
    		return $cmd;
    	}
        $type = $_POST['type'];
        
		if ($type === 'edit') {
			$id    = $_POST['transAccId'];
			$addId = $_POST['transAccId'];
            $cmd[] = "httpctl del transparentacl id $id";
        } else {
        	$addId = getAddIdFromSql();
    	}
    	//$killVirus = $_POST['killVirus'] === 'Y' ? 'yes' : 'no';
        $srcIp	   = $_POST['srcIpList'];
        $destIp	   = $_POST['destIpList'];
        $destPort  = $_POST['destPort'];
        $comment   = $_POST['comment'];

		$str = "httpctl add transparentacl id $addId sip $srcIp dip $destIp";
		//if ($_POST['httpEnableChk'] === 'on') {
		//	$str .= " https yes";
		//}
		if ($_POST['authUsrGrpList'] !== '') {
			$str .= " auth ".$_POST['authUsrGrpList'];
		}
		if ($_POST['timeList'] !== '') {
			$str .= " time ".$_POST['timeList'];
		}
		$str .= " port $destPort";
		if (!empty($comment)) {
        	$str .= " comment \"$comment\"";
        }
        
        $cmd[] = $str;

        return $cmd;
    }    
    
    function addrNameDelPreffix($name) {
    	// 去掉最后一个下划线_ipv4或_ipv6
    	return substr($name,0,-5);    	
	}
	
	function getAddIdFromSql() {
		$db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        $sql = "SELECT id FROM acl ORDER BY id DESC";
        $num = $db->query($sql)->getCount();
        if ($num === 0) {
        	return 1;
    	}
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC); 
        return $result['id']+1;
	}

	//判断是否开启病毒扫描
	function getKillVirus(){
        $db   = new dbsqlite(DB_PATH . '/netgap_http.db');	
		$data = $db->query('SELECT scan_virus FROM cf_info')
				   ->getFirstData(PDO::FETCH_ASSOC);	 
		return $data['scan_virus'] == 1 ? 'Y' : 'N';
	}
	
    if (!empty($_POST['editId'])) {
        // Open a specified safebrowser data
        $tpl = $_POST['tpl'];
        $id  = $_POST['editId'];
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        $sql = "SELECT * FROM acl WHERE id = '$id'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);  
        $killVirusIsUsed = antiIsUsed();     
        $result = V::getInstance()
        	->assign('saddrOptions', netGapRes::getInstance()->getAddr(true))
        	->assign('daddrOptions', netGapRes::getInstance()->getAddr())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
        	->assign('editTransAcc', $result)
        	->assign('killVirusIsUsed',$killVirusIsUsed)
			->assign('killVirus',getKillVirus())
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
     } else if (isset($_POST['openAddDialog'])) {
        // Open a new safebrowser dialog
        $tpl = $_POST['tpl'];
        $killVirusIsUsed = antiIsUsed();     
        $result = V::getInstance()
            ->assign('saddrOptions', netGapRes::getInstance()->getAddr(true))
            ->assign('daddrOptions', netGapRes::getInstance()->getAddr())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('killVirusIsUsed',$killVirusIsUsed)
			->assign('killVirus',getKillVirus())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified safebrowser data
        $cmd = getCmd();
        $cli = new cli();
        $cli->setLog("删除一条id为".$_POST['transAccId']."的透明访问控制")->run($cmd[0]);
        $cli->setLog("添加一条新的id为".$_POST['transAccId']."的透明访问控制")->run($cmd[1]);
        $cli->setLog("修改安全浏览配置")->run("httpctl	reconfigure ");
        echo json_encode(array('status'=>0,'msg' => '修改成功。'));
    } else if ('add' === $_POST['type']) {
        // Add a new safebrowser data
        $cmd = getCmd();
        $cli = new cli();
        $cli->setLog("添加一条新的透明访问控制")->run($cmd[0]);
        $cli->setLog("修改安全浏览配置")->run("httpctl reconfigure ");
        echo json_encode(array('status'=>0,'msg' => '添加成功。'));
    } else if (!empty($_POST['delId'])) {
        // Delete the specified safebrowser data   
        $cmd = getCmd();     
        $cli = new cli();
        $cli->setLog("删除一条id为".$_POST['delId']."的透明访问控制")->run($cmd[0]);
        $cli->setLog("修改安全浏览配置")->run("httpctl	reconfigure ");
        echo json_encode(array('msg' => "删除成功。"));
    } else if ($_GET['checkAddrValid'] == '1') {
        $sa    = $_GET['srcAddr'];
        $da    = $_GET['destAddr'];
        $dport = $_GET['destPort'];
        $sql = 'SELECT count(id) as count FROM acl ' .
            "WHERE sip='$sa' AND dip='$da' AND port=$dport AND transparent=1";
        if ($id = $_GET['id']) {
            $sql .= " AND id != $id";
        }
        $db   = new dbsqlite(DB_PATH . '/netgap_http.db');	
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC); 
        $msg  = $data['count'] > 0 ?
            array('源地址,目的地址和目的端口的组合必须唯一') : array();
        echo json_encode(array('msg' => $msg));
        return true;
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort safebrowser list
        appendTransAccData($orderStatement);
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
