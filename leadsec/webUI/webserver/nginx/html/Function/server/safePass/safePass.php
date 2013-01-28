<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendFastPassData($where) {
        $tpl =  'server/safePass/safePassTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_fastpass.db');
	    $sql = "SELECT * FROM fastpass_server_acl $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('fpServerList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT id FROM fastpass_server_acl";
        $db  = new dbsqlite(DB_PATH . '/netgap_fastpass.db');
        return $db->query($sql)->getCount();
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
        $id     	= $_POST['safePassId'];
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
        $publicPort = $_POST['publicPort'] === "" ? "1:65535" : $_POST['publicPort'];
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
        $cli->run(getCmd());
        echo json_encode(array('msg' => "修改成功."));
    } else if ('add' === $_POST['type']) {
        // Add a new safepass data
        $cli = new cli();
        $cli->run(getCmd());
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['delId'])) {
        // Delete the specified safepass data        
        $cli = new cli();
        $cli->run(getCmd());
        echo json_encode(array('msg' => "删除成功."));
    } else if ($_POST['activeSwitch']) {
    	// active on/off a safepass
    	$cli = new cli();
        $cli->run(getCmd());
        echo json_encode(array('msg' => '成功.'));
    } else if (!empty($_GET['checkExistId'])) {
        // Check the same id exist or not
        echo netGapRes::getInstance()->checkExistTaskId('safepass',$_GET['safePassId']);
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