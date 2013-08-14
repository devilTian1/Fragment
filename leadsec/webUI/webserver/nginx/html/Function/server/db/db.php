<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
  
    function freshServerCommData($where) {
        $tpl =  'server/db/dbTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
	    $sql = "SELECT * FROM db_comm_server_acl ";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC); 
       
        echo V::getInstance()->assign('serverComm', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
	function getWhereStatement($db, $cols, $keyword) {
        $params = array_fill(0, count(explode(',', $cols)), $keyword);
        return array('sql'    => ' where (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $db->getFilterParams($params));
    }
    function getDataCount() {
    	$sql = "SELECT id FROM db_comm_server_acl";
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
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
        $id        = intval($_POST['clientId']);
        $dbType    = $_POST['dbType'];
        $serverIp  = $_POST['ip'];
        $sportReq = $_POST['sportReq'];;
        $comment   = $_POST['comment']; 
        $result = "/usr/local/bin/dbctl $action task db $dbType type server mode comm id $id "
        	." sip $serverIp sport $sportReq ";         	          
        $result .= " comment \"$comment\"";
        return $result;
    }
    if (!empty($_POST['editId'])) {
        // Get specified  data
        $id = $_POST['editId'];
        $sql = 'SELECT id, dbtype, serverip, sport, active, ' .
            "comment FROM db_comm_server_acl WHERE id = '$id'";
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $tpl = 'server/db/db_editDialog.tpl';
        $result = V::getInstance()
            ->assign('res', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified  data 
        $active    = $_POST['active'] === 'Y' ? 'on' : 'off';    
 		$cli = new cli();
 		$cmd = getCmd();
 		$cmd .= " active $active";
        $cli->setLog("编辑一条id为".$_POST['clientId']."的服务端数据库访问")->run($cmd);
        echo json_encode(array('msg' => '修改成功。'));	                  
    }  else if (!empty($_POST['delId'])) {
        // Delete the specified  data
        $delId    = $_POST['delId'];
        $sql = "SELECT dbtype FROM db_comm_server_acl WHERE id =$delId";            
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        foreach ($result as $d) {              
            $dbType = $d;           
        }
        $cmd  = "/usr/local/bin/dbctl del task db $dbType type server mode comm id $delId";
        $cli  = new cli();
        $sql = "delete FROM db_comm_server_acl WHERE id =''";    
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = $db->close();
        $cli->setLog("删除一条id为".$_POST['delId']."的服务端数据库访问")->run($cmd);
        echo json_encode(array('msg' => "删除成功。"));
    } else if ('add' === $_POST['type']) {
        // Add a new data
        $active    = $_POST['active'] === 'Y' ? 'on' : 'off';    
 		$cli = new cli();
 		$cmd = getCmd();
 		$cmd .= " active $active";
        $cli->setLog("添加一条id为".$_POST['clientId']."的服务端数据库访问")->run($cmd);
        echo json_encode(array('msg' => '任务[' . intval($_POST['clientId']) . ']添加成功。'));	                      
    }else if (!empty($_POST['openDialog'])) {
        // Display add server comm dialog
        $tpl = 'server/db/db_editDialog.tpl';
        $result['sport'] = '1521';
        $result = V::getInstance()
        	->assign('res', $result)
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
    	if ($action === 'disable') {
        	$active = 'off';
        	$act="停止";	
        }else {
        	$active = 'on';
        	$act="开启";		
        }
        $cli = new cli();
        $cmd = getCmd();
        $cmd .= " active $active";
        $cli->setLog("$act id为".$_POST['clientId']."的服务端数据库访问")->run($cmd);
        echo json_encode(array('msg' => $act.'成功。'));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort  list
        freshServerCommData($orderStatement);
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
