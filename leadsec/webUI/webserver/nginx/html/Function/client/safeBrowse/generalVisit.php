<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendGeneralAccData($where) {
        preg_match('/OFFSET\s(\d+)$/', $where, $match);
        $offset = intval($match[1]) + 1;

        $tpl =  'client/safeBrowse/generalVisitTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
	    $sql = "SELECT * FROM acl WHERE transparent=0";
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
        }
        echo V::getInstance()->assign('GeneralAcc', $result)
            ->fetch($tpl);
    }
    
    function getWhereStatement($db, $cols, $keyword) {
        $value  = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' AND (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }

    function getDataCount() {
    	$sql = "SELECT id FROM acl WHERE transparent=0";
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    function getCmd() {
    	$cmd  = Array();
    	if (!empty($_POST['delId'])) {
    		$id     = $_POST['delId'];    		
    		$cmd[] = "httpctl del acl id $id";
    		return $cmd;
    	}
        $type = $_POST['type'];
        
		if ($type === 'edit') {
			$id    = $_POST['generalAccId'];
			$addId = $_POST['generalAccId'];
            $cmd[] = "httpctl del acl id $id";
        } else {
        	$addId = getAddIdFromSql();
    	}
    	//$killVirus = $_POST['killVirus'] === 'Y' ? 'yes' : 'no';
        $srcIp	   = $_POST['srcIpList'];
        $comment   = $_POST['comment'];

		$str = "httpctl add acl id $addId sip $srcIp";
		if ($_POST['authUsrGrpList'] !== '') {
			$str .= " auth ".$_POST['authUsrGrpList'];
		}
		if ($_POST['timeList'] !== '') {
			$str .= " time ".$_POST['timeList'];
		}
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

    if (!empty($_POST['editId'])) {
        // Open a specified safepass data
        $tpl = $_POST['tpl'];
        $id  = $_POST['editId'];
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        $sql = "SELECT * FROM acl WHERE id = '$id'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);       
        $result = V::getInstance()
        	->assign('addrOptions', netGapRes::getInstance()->getAddr(true))
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
        	->assign('editGeneralAcc', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
     } else if (isset($_POST['openAddDialog'])) {
        // Open a new safepass dialog
        $tpl = $_POST['tpl'];
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr(true))
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified safepass data
        $cmd = getCmd();
        $cli = new cli();
        $cli->setLog("删除一条id为".$_POST['generalAccId']."的普通访问控制")->run($cmd[0]);
        $cli->setLog("添加一条新的id为".$_POST['generalAccId']."的普通访问控制")->run($cmd[1]);
        $cli->setLog("修改安全浏览配置")->run("httpctl	reconfigure ");
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new safepass data
        $cmd = getCmd();
        $cli = new cli();
        $cli->setLog("添加一条新的普通访问控制")->run($cmd[0]);
        $cli->setLog("修改安全浏览配置")->run("httpctl reconfigure ");
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['delId'])) {
        // Delete the specified safepass data   
        $cmd = getCmd();     
        $cli = new cli();
        $cli->setLog("删除一条id为".$_POST['delId']."的普通访问控制")->run($cmd[0]);
        $cli->setLog("修改安全浏览配置")->run("httpctl	reconfigure ");
        echo json_encode(array('msg' => "删除成功."));
   } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort safepass list
        appendGeneralAccData($orderStatement);
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
