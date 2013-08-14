<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
     function getWhereStatement($db, $cols, $keyword) {
    	$value = $keyword;
    	$params = array_fill(0, count(explode(',', $cols)), $value);
    	return array('sql'    => ' WHERE (' .
    			$db->getWhereStatement($cols, 'OR', 'like') . ')',
    			'params' => $db->getFilterParams($params));
    }
    
    function getCmd() {
        $type = $_POST['type'];
        if ($type === 'add') {
            $action = 'add';
        } elseif ($type === 'edit' || !empty($_POST['action'])) {
            $action = 'set';
        } else {
            throw new Exception('fatal action: [' . $type . '].');
        }
        $id        = intval($_POST['ftpId']);
        $sip       = $_POST['serverIp'];
        $sport     = $_POST['sportReq'];
        if (!empty($_POST['action'])) {
            $active = $_POST['action'] === 'enable' ? 'on' : 'off';
        } else {
            $active = $_POST['active'] === 'Y' ? 'on' : 'off';
        }
        $comment   = $_POST['comment'];
        return "cftpctl $action task type server mode comm id $id sip $sip ".
            "sport $sport active $active comment \"$comment\"";
    }

    function appendFtpCommServerAclData($where) {
        $tpl =  'server/ftp/generalVisitTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        $sql = 'SELECT id, serverip, sport, active, comment ' .
            "FROM ftp_comm_server_acl ";        
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$dataSearch   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $dataSearch['sql'];
        	$params = $dataSearch['params'];
        }
        $sql .=  ' ' . $where;  
        
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('ftpCommServerAcl', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $sql = 'SELECT id FROM ftp_comm_server_acl';
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
         if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $data['sql'];
        	$params = $data['params'];
        }     
        return $db->query($sql, $params)->getCount();
    }

    if ($id = $_POST['editId']) {
        // Open dialog to show specified ftp general server acl data
        $sql  = 'SELECT id, serverip, sport, active, comment ' .
            "FROM ftp_comm_server_acl WHERE id = '$id'";
        $db   = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $tpl    = 'server/ftp/generalVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified ftp general server data
        $cli = new cli();
        $cli->setLog("修改FTP服务端普通访问任务,任务号为".$_POST['ftpId'])->run(getCmd());
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new ftp general server data
        $cli = new cli();
        $cli->setLog("添加一条新的FTP服务端普通访问任务,任务号为".intval($_POST['ftpId']))->run(getCmd());
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Open new ftp comm server dialog
        $tpl    = 'server/ftp/generalVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($id = $_POST['delId']) {
        // Delete the specified Ftp General Server data
        $cmd  = "cftpctl del task type server mode comm id $id";
        $cli  = new cli();
        $cli->setLog("删除一条FTP服务端普通访问任务,任务号为".$id)->run($cmd);
        echo json_encode(array('msg' => "删除成功."));
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
        $cli = new cli();
        $cli->setLog("修改FTP服务端普通访问任务,任务号为".$_POST['ftpId'])->run(getCmd());
        if ($action === 'enable') {
            $msg = '启动成功.';
        } else {
            $msg = '停止成功.';
        }
        echo json_encode(array('msg' => $msg));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort ftp_comm_server_acl table
        appendFtpCommServerAclData($orderStatement);
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
