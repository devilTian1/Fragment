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
        $id        = $_POST['customId'];
        $sa        = $_POST['sa'];
        $lip       = $_POST['lip'];
        $lport     = $_POST['lportReq'];
        if (!empty($_POST['action'])) {
            $active = $_POST['action'] === 'enable' ? 'on' : 'off';
        } else {
            $active = $_POST['active'] === 'Y' ? 'on' : 'off';
        }
        $killVirus = $_POST['killVirus'] === 'Y' ? 'yes' : 'no';
        $usergrp   = $_POST['usergrp'];
        $time      = $_POST['time'];
        $comment   = $_POST['comment'];

        $result = "cudpctl $action task type client mode comm id $id sa $sa " .
            "lip $lip lport $lport killvirus $killVirus active $active ";
        if (!empty($usergrp)) {
            $result .= "auth $usergrp ";
        }
        if (!empty($time)) {
            $result .= "time $time ";
        }
        $result .= "comment \"$comment\"";
        return $result;
    }

    function appendUdpCommClientAclData($where) {
        $tpl =  'client/customized/udpGeneralVisitTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
        $sql = 'SELECT id, sa, lip, lport, killvirus, usergrp, time, active, ' .
            "comment FROM udp_comm_client_acl $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('udpCommClientAcl', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $sql = 'SELECT id FROM udp_comm_client_acl';
        $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
        return $db->query($sql)->getCount();
    }

    if ($id = $_POST['editId']) {
        // Open dialog to show specified udp general client acl data
        $sql  = 'SELECT id, sa, lip, lport, killvirus, usergrp, time, active, '.
            "comment FROM udp_comm_client_acl WHERE id = '$id'";
        $db   = new dbsqlite(DB_PATH . '/netgap_custom.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $tpl  = 'client/customized/udpGeneralVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified udp general client data
        $cli = new cli();
        $cli->run(getCmd());
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new udp general client data
        $cli = new cli();
        $cli->run(getCmd());
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Open new udp comm client dialog
        $tpl    = 'client/customized/udpGeneralVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($id = $_POST['delId']) {
        // Delete the specified Udp General Client data
        $cmd  = "cudpctl del task type client mode comm id $id";
        $cli  = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "删除成功."));
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
        $cli = new cli();
        $cli->run(getCmd());
        echo json_encode(array('msg' => '成功.'));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort udp_comm_client_acl table
        appendUdpCommClientAclData($orderStatement);
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
