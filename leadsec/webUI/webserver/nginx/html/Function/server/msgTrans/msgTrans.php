<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshMsgTransData($where) {
        $tpl =  'server/msgTrans/msgTransTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
	    $sql = "SELECT * FROM msg_server_task ";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
     	
        echo V::getInstance()->assign('serverMsg', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
	function getWhereStatement($db, $cols, $keyword) {
        $value = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' where (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }
    function getDataCount() {
    	$sql = "SELECT id FROM msg_server_task";
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }
     
	function getCmd() {
		//组装命令行
        $type = $_POST['type'];
        if ($type === 'add') {
            $action = 'add';
        } elseif ($type === 'edit' || !empty($_POST['action'])) {
            $action = 'set';
        } else {
            throw new Exception('fatal action: [' . $type . '].');
        }
        $id         = intval($_POST['msgTransId']);
        $serip      = $_POST['ip'];
        $serverPortReq = $_POST['serverPortReq'];
        $ssl        = $_POST['ssl'] === 'Y' ? 'yes' : 'no';            
        $backup     = $_POST['backup'] === 'Y' ? 'yes' : 'no'; 
        $comment    = $_POST['comment'];        
        $result = "/usr/local/bin/msgctl $action task type server id $id sip $serip "
        	." sport $serverPortReq ssl $ssl backup $backup";
        	       	
        $result .= " comment \"$comment\"";
        return $result;
    }
   
    if (!empty($_POST['editId'])) {
        // Get specified  data
        $id = $_POST['editId'];
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $sql = "SELECT id, serip, serport, ssl, backup, active,  
        	comment FROM msg_server_task where id = $id";  
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        //print_r($result);
        $tpl = 'server/msgTrans/msgTrans_editDialog.tpl';
        $result = V::getInstance()
            ->assign('res', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified  data  
        $active    = $_POST['active'] === 'ok' ? 'on' : 'off';    
 		$cli = new cli();
 		$cmd = getCmd();
 		$cmd .= " active $active 1>/dev/null";
        $cli->setLog("编辑一条id为".$_POST['msgTransId']."的服务端消息传输")->run($cmd);
        echo json_encode(array('msg' => '修改成功。'));	                
    } else if (!empty($_POST['delId'])) {
        // Delete the specified  data
        $delId    = $_POST['delId'];
        $cmd  = "/usr/local/bin/msgctl del task type server id $delId";
        $cli  = new cli();
        $cli->setLog("删除一条id为".$_POST['delId']."的服务端消息传输")->run($cmd);
        echo json_encode(array('msg' => "删除成功。"));
    } else if ('add' === $_POST['type']) {
        // Add a new addr group data	
        $active    = $_POST['active'] === 'ok' ? 'on' : 'off';    
 		$cli = new cli();
 		$cmd = getCmd();
 		$cmd .= " active $active ";
        $cli->setLog("添加一条id为".$_POST['msgTransId']."的服务端消息传输")->run($cmd);
        echo json_encode(array('msg' => '任务[' . intval($_POST['msgTransId']) . ']添加成功。'));	                 
    }else if (!empty($_POST['openDialog'])) {
        // Display add client comm dialog
        $tpl = 'server/msgTrans/msgTrans_editDialog.tpl';
        $result = V::getInstance()
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
        if ($action === 'disable') {
        	$active = 'off';	
        }else {
        	$active = 'on';	
        }
        $cli = new cli();
        $cmd = getCmd();
        $cmd .= " active $active ";
        $cli->setGetResult(true)->run($cmd);
        echo json_encode(array('msg' => '成功。'));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort list
        freshMsgTransData($orderStatement);
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
