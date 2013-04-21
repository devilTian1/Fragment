<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendTcpTransClientAclData($where) {
        $tpl =  'client/customized/tcpTransVisitTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
        $sql = 'SELECT id, sa, da, dport, usergrp, time, active, killvirus, ' .
            "comment FROM tcp_trans_client_acl $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('tcpTransClientAcl', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $sql = 'SELECT id FROM tcp_trans_client_acl';
        $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
        return $db->query($sql)->getCount();
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
        $id        = intval($_POST['cusTcpTransId']);
        $sa        = $_POST['sa'];
        $da        = $_POST['da'];
        $dport     = $_POST['tcpTranslportReq'];
        if (!empty($_POST['action'])) {
            $active = $_POST['action'] === 'enable' ? 'on' : 'off';
        } else {
            $active = $_POST['active'] === 'Y' ? 'on' : 'off';
        }
        $killVirus = $_POST['killVirus'] === 'Y' ? 'yes' : 'no';
        $usergrp   = $_POST['usergrp'];
        $time      = $_POST['time'];
        $comment   = $_POST['comment'];

        $result = "ctcpctl $action task type client mode trans id $id sa $sa " .
            "da $da dport $dport killvirus $killVirus active $active ";
        if (!empty($usergrp)) {
            $result .= "auth $usergrp ";
        }
        if (!empty($time)) {
            $result .= "time $time ";
        }
        $result .= "ipver ipv4 comment \"$comment\"";
        return $result;
    }
	function checkExistTaskAndPort() {
    	$sql    = 'SELECT id FROM tcp_trans_client_acl WHERE (id+dport) = ' .
            $_GET['idPlusPort']. ' AND id != ' . $_GET['taskId'];
        $db     = new dbsqlite(DB_PATH . '/netgap_custom.db');
        $result = $db->query($sql)->getCount() > 0 ? 'false' : 'true';
        echo $result;
    } 
    
    if ($id = $_POST['editId']) {
        // Open dialog to show specified tcp trans client acl data
        $sql = 'SELECT id, sa, da, dport, usergrp, time, active, killvirus, ' .
            "comment FROM tcp_trans_client_acl WHERE id = '$id'";
        $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $tpl = 'client/customized/tcpTransVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('data', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_POST['openAddDialog'])) {
        // Open new tcp trans client dialog
        $tpl    = 'client/customized/tcpTransVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified tcp trans client data
        $cli = new cli();
        $cli->setLog("修改定制TCP透明访问任务,任务号为".$_POST['customId'])->run(getCmd());
        echo json_encode(array('msg' => '修改成功.'));
    } else if (!empty($_GET['checkExistId'])) {
        // Check the same id exist or not
        echo netGapRes::getInstance()->checkExistTaskId('customized',
            intval($_GET['cusTcpTransId']));
    } else if ('add' === $_POST['type']) {
        // Add a new tcp trans client data
        $cli = new cli();
        $cli->setLog("添加定制TCP透明访问任务,任务号为".intval($_POST['cusTcpTransId']))->run(getCmd());
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($id = $_POST['delId']) {
        // Delete the specified Tcp Trans Client data
        $cmd  = "ctcpctl del task type client mode trans id $id";
        $cli  = new cli();
        $cli->setLog("删除定制TCP透明访问任务,任务号为".$id)->run($cmd);
        echo json_encode(array('msg' => "删除成功."));
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
        $cli = new cli();
        $cli->setLog("修改定制TCP透明访问任务,任务号为".$_POST['cusTcpTransId'])->run(getCmd());
        echo json_encode(array('msg' => '成功.'));
    } else if (!empty($_GET['checkExistTaskAndPort'])) {
        // check the new name existed or not
        checkExistTaskAndPort();
        return true;
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort tcp_trans_client_acl table
        appendTcpTransClientAclData($orderStatement);
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
