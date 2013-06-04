<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getCmd() {
        $type = $_POST['type'];
        if ($type === 'add') {
            $action = 'add';
        } elseif ($type === 'edit' || !empty($_POST['action'])) {
            $action = 'set';
        } else {
            throw new Exception('fatal action: [' . $type . '].');
        }
        $id        = intval($_POST['pop3GeneralId']);
        $sip       = $_POST['serverIp'];
        $sport     = $_POST['pop3GeneralSport'];
        if (!empty($_POST['action'])) {
            $active = $_POST['action'] === 'enable' ? 'on' : 'off';
        } else {
            $active = $_POST['active'] === 'ok' ? 'on' : 'off';
        }
        if (validateIpv4Format($sip)) {
            $ipver = 'ipver ipv4';
        } else {
            $ipver = 'ipver ipv6';
        }
        $comment   = $_POST['comment'];
        $cmd = array();
        $cmd['cmd'] = "pop3ctl $action task type server mode comm id $id sip $sip ".
            "sport $sport active $active $ipver comment \"$comment\"";
        $ct = $type === 'add' ? '添加' : '修改';
        $cmd['log'] = $ct.'服务端的邮件访问的POP3访问,任务号为'.$id;
        return $cmd;
    }

    function appendPop3CommServerAclData($where) {
        $tpl =  'server/mail/pop3Table.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
        $sql = "SELECT * FROM pop3_comm_server_acl";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $data['sql'];
        	$params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('pop3CommServerAcl', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getWhereStatement($db, $cols, $keyword) {
    	$value = '%' . $keyword . '%';
    	$params = array_fill(0, count(explode(',', $cols)), $value);
    	return array('sql'    => ' WHERE (' .
    			$db->getWhereStatement($cols, 'OR', 'like') . ')',
    			'params' => $params);
    }
    
    function getDataCount() {
        $sql = 'SELECT id FROM pop3_comm_server_acl';
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    if ($id = $_POST['editId']) {
        // Open dialog to show specified pop3 general server acl data
        $sql  = "SELECT * FROM pop3_comm_server_acl WHERE id = '$id'";
        $db   = new dbsqlite(DB_PATH . '/netgap_mail.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $tpl  = 'server/mail/pop3_editDialog.tpl';
        $result = V::getInstance()
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified pop3 general server data
        $cli = new cli();
        $cmdArr =  getCmd();
        $cli->setLog($cmdArr['log'])->run($cmdArr['cmd']);
        echo json_encode(array('msg' => '修改成功。'));
    } else if ('add' === $_POST['type']) {
        // Add a new pop3 general server data
        $cli = new cli();
        $cmdArr =  getCmd();
        $cli->setLog($cmdArr['log'])->run($cmdArr['cmd']);
        echo json_encode(array('msg' => '添加成功。'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Open new pop3 comm server dialog
        $tpl    = 'server/mail/pop3_editDialog.tpl';
        $result = V::getInstance()
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($id = $_POST['delId']) {
        // Delete the specified Pop3 General Server data
        $cmd  = "pop3ctl del task type server mode comm id $id";
        $cli  = new cli();
        $cli->setLog('删除服务端的邮件访问的POP3访问,任务号为'.$id)->run($cmd);
        echo json_encode(array('msg' => "删除成功。"));
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
        $cli = new cli();
        if ($action === 'enable') {
        	$msg = '启动';
        } else {
        	$msg = '停止';
        }
        $cmdArr =  getCmd();
        $cli->setLog($cmdArr['log'])->run($cmdArr['cmd']);
        echo json_encode(array('msg' => $msg .'成功。'));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort pop3_comm_server_acl table
        appendPop3CommServerAclData($orderStatement);
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
