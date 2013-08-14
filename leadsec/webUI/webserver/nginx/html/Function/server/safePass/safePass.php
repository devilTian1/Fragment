<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendFastPassData($where) {
        $tpl =  'server/safePass/safePassTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_fastpass.db');
	    $sql = "SELECT * FROM fastpass_server_acl";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('fpServerList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
    
    function getWhereStatement($db, $cols, $keyword) {
        $value  = $keyword ;
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' WHERE (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $db->getFilterParams($params));
    }

    function getDataCount() {
    	$sql = "SELECT id FROM fastpass_server_acl";
        $db  = new dbsqlite(DB_PATH . '/netgap_fastpass.db');
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
    	if (!empty($_POST['delId'])) {
    		$id     = $_POST['delId'];
    		return "fpctl del task type server id $id";
    	}
        $type = $_POST['type'];
        if ($type === 'add') {
            $action = 'add';            
        } elseif ($type === 'edit' || !empty($_POST['activeSwitch'])) {
            $action = 'set';
        } else {
            throw new Exception('fatal action: [' . $type . '].');
        }
        $id     	= intval($_POST['safePassId']);
        $serverIp   = $_POST['spServerIp'];
        if ($_POST['serverPort'] === "") {
       		if ($_POST['serviceList']==='tcp_any' || $_POST['serviceList']==='udp_any') {
       			$serverPort = "sport 1:65535";
       		} else {
       			$serverPort = "";
       		}	    		
       	} else if ($_POST['serverPort'] === "----") {
       		$serverPort = "sport 1:65535";
    	} else {
    		$serverPort = "sport ".$_POST['serverPort'];    		
    	}
    	if(isset($_POST['publicPort'])) {
            $publicPort = $_POST['publicPort'] === "" ? "1:65535" : $_POST['publicPort'];
        } else {
            $publicPort = "1:65535";
        }
        $outflowIp = $_POST['outflowIpList'];
        $service = $_POST['serviceList'];
        
        $active = $_POST['activeChk'] === 'ok' ? 'on' : 'off';
        $log 	   = $_POST['logChk'] === 'Y' ? 'on' : 'off';
        $comment   = $_POST['comment'];

        $result = "fpctl $action task type server id $id sip $serverIp " .$serverPort.
            " inport $publicPort eip $outflowIp service $service active $active log $log";
        $result .= " comment \"$comment\"";
        return $result;
    }    

    if (!empty($_POST['editId'])) {
        // Open a specified safepass data
        $tpl = $_POST['tpl'];
        $id  = $_POST['editId'];		
        $db  = new dbsqlite(DB_PATH . '/netgap_fastpass.db');
        $sql = "SELECT * FROM fastpass_server_acl WHERE id = '$id'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);       
        $result = V::getInstance()        	
            ->assign('interfaceList', netGapRes::getInstance()->getInterface())
        	->assign('editSafePass', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
     } else if (isset($_POST['openAddDialog'])) {
        // Open a new safepass dialog
        $tpl = $_POST['tpl'];
        $result = V::getInstance()            
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
    	$activeLog = $_POST['activeChk']==='ok'?'开启':'停止';
        $cli->setLog($activeLog."任务号为".$_POST['safePassId']."的安全通道")->run(getCmd());
        echo json_encode(array('msg' => $activeLog.'成功。'));
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
