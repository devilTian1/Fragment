<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
    function getWhereStatement($db, $cols, $keyword) {
    	$value = '%' . $keyword . '%';
    	$params = array_fill(0, count(explode(',', $cols)), $value);
    	return array('sql'    => ' WHERE (' .
    			$db->getWhereStatement($cols, 'OR', 'like') . ')',
    			'params' => $params);
    }
    
    function appendUdpTransClientAclData($where) {
        $tpl =  'client/customized/udpTransVisitTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
        $sql = 'SELECT id, sa, da, dport, usergrp, time, active, killvirus, ' .
            "comment FROM udp_trans_client_acl ";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$dataSearch   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $dataSearch['sql'];
        	$params = $dataSearch['params'];
        }
        $sql .=  ' ' . $where;     
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('udpTransClientAcl', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $sql = 'SELECT id FROM udp_trans_client_acl';
        $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
         if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $data['sql'];
        	$params = $data['params'];
        }        
        return $db->query($sql, $params)->getCount();
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
        $id        = intval($_POST['customUdpTransId']);
        $sa        = $_POST['sa'];
        $da        = $_POST['da'];
        $dport     = $_POST['customUdpTransLport'];
        if (!empty($_POST['action'])) {
            $active = $_POST['action'] === 'enable' ? 'on' : 'off';
        } else {
            $active = $_POST['active'] === 'Y' ? 'on' : 'off';
        }
        $killVirus = $_POST['killVirus'] === 'Y' ? 'yes' : 'no';
        $usergrp   = $_POST['usergrp'];
        $time      = $_POST['time'];
        $comment   = $_POST['comment'];

        $result = "cudpctl $action task type client mode trans id $id sa $sa " .
            "da $da dport $dport killvirus $killVirus active $active ";
        if (!empty($usergrp)) {
            $result .= "auth $usergrp ";
        }
        if (!empty($time)) {
            $result .= "time $time ";
        }
        $result .= "ipver ipv4 comment \"$comment\" 1>/dev/null";
        return $result;
    }
	function checkExistTaskAndPort() {
    	$sql    = 'SELECT id FROM udp_trans_client_acl WHERE (id+dport) = ' .
            $_GET['idPlusPort']. ' AND id != ' . $_GET['taskId'];
        $db     = new dbsqlite(DB_PATH . '/netgap_custom.db');
        $result = $db->query($sql)->getCount() > 0 ? 'false' : 'true';
        echo $result;
    } 
    
    if ($id = $_POST['editId']) {
        // Open dialog to show specified udp trans client acl data
        $sql  = 'SELECT id, sa, da, dport, usergrp, time, active, killvirus, ' .
            "comment FROM udp_trans_client_acl WHERE id = '$id'";
        $db   = new dbsqlite(DB_PATH . '/netgap_custom.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $tpl  = 'client/customized/udpTransVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('saaddrOptions', netGapRes::getInstance()->getAddr(true))
            ->assign('daaddrOptions', netGapRes::getInstance()->getAddrList(true))
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_POST['openAddDialog'])) {
        // Open new udp trans client dialog
        $tpl    = 'client/customized/udpTransVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('saaddrOptions', netGapRes::getInstance()->getAddr(true))
            ->assign('daaddrOptions', netGapRes::getInstance()->getAddrList(true))
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified udp trans client data
        $cli = new cli();
        $cli->setLog("修改定制UDP透明访问任务,任务号为".$_POST['customUdpTransId'])->run(getCmd());
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new udp trans client data
        $cli = new cli();
        $cli->setLog("添加定制UDP透明访问任务,任务号为".intval($_POST['customUdpTransId']))->run(getCmd());
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($id = $_POST['delId']) {
        // Delete the specified Udp Trans Client data
        $cmd  = "cudpctl del task type client mode trans id $id";
        $cli  = new cli();
        $cli->setLog("删除定制UDP透明访问任务,任务号为".$id)->run($cmd);
        echo json_encode(array('msg' => "删除成功."));
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
        $cli = new cli();
        $cli->setLog("修改定制UDP透明访问任务,任务号为".$_POST['customUdpTransId'])->run(getCmd());
        echo json_encode(array('msg' => '成功.'));
    } else if (!empty($_GET['checkExistId'])) {
        // Check the same id exist or not
        echo netGapRes::getInstance()->checkExistTaskId('customized',
            $_GET['customUdpTransId']);
    } else if (!empty($_GET['checkExistTaskAndPort'])) {
        // check the new name existed or not
        checkExistTaskAndPort();
        return true;
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort udp_trans_client_acl table
        appendUdpTransClientAclData($orderStatement);
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
