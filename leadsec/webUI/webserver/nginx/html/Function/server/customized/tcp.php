<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
    function getWhereStatement($db, $cols, $keyword) {
    	$value = '%' . $keyword . '%';
    	$params = array_fill(0, count(explode(',', $cols)), $value);
    	return array('sql'    => ' WHERE (' .
    			$db->getWhereStatement($cols, 'OR', 'like') . ')',
    			'params' => $params);
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
        $id        = intval($_POST['customId']);
        $sip       = $_POST['serverIp'];
        $sport     = $_POST['sportReq'];
        if (!empty($_POST['action'])) {
            $active = $_POST['action'] === 'enable' ? 'on' : 'off';
        } else {
            $active = $_POST['active'] === 'Y' ? 'on' : 'off';
        }
        if (validateIpv4Format($sip)) {
            $ipver = 'ipver ipv4';
        } else {
            $ipver = 'ipver ipv6';
        }
        $comment   = $_POST['comment'];
        return "ctcpctl $action task type server mode comm id $id sip $sip ".
            "sport $sport active $active $ipver comment \"$comment\"";
    }

    function appendTcpCommServerAclData($where) {
        $tpl =  'server/customized/tcpTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
        $sql = 'SELECT id, serverip, sport, active, comment ' .
            "FROM tcp_comm_server_acl ";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$dataSearch   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $dataSearch['sql'];
        	$params = $dataSearch['params'];
        }
        $sql .=  ' ' . $where;             
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('tcpCommServerAcl', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $sql = 'SELECT id FROM tcp_comm_server_acl';
        $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $data['sql'];
        	$params = $data['params'];
        }        
        return $db->query($sql, $params)->getCount();
    }

    if ($id = $_POST['editId']) {
        // Open dialog to show specified tcp general server acl data
        $sql  = 'SELECT id, serverip, sport, active, comment ' .
            "FROM tcp_comm_server_acl WHERE id = '$id'";
        $db   = new dbsqlite(DB_PATH . '/netgap_custom.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $tpl  = 'server/customized/editTcpDialog.tpl';
        $result = V::getInstance()
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified tcp general server data
        $cli = new cli();
        $cli->setLog("修改定制TCP普通访问服务端任务,任务号为".$_POST['customId'])->run(getCmd());
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new tcp general server data
        $cli = new cli();
        $cli->setLog("添加定制TCP普通访问服务端任务,任务号为".intval($_POST['customId']))->run(getCmd());
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Open new tcp comm server dialog
        $tpl    = 'server/customized/editTcpDialog.tpl';
        $result = V::getInstance()
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($id = $_POST['delId']) {
        // Delete the specified Tcp General Server data
        $cmd  = "ctcpctl del task type server mode comm id $id";
        $cli  = new cli();
        $cli->setLog("删除定制TCP普通访问服务端任务,任务号为".$id)->run($cmd);
        echo json_encode(array('msg' => "删除成功."));
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
        $cli = new cli();
        $cli->setLog("修改定制TCP普通访问服务端任务,任务号为".$_POST['customId'])->run(getCmd());
        echo json_encode(array('msg' => '成功.'));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort tcp_comm_server_acl table
        appendTcpCommServerAclData($orderStatement);
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
