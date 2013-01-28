<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendPop3TransClientAclData($where) {
        $tpl  =  'client/mail/pop3TransVisitTable.tpl';
        $db   = new dbsqlite(DB_PATH . '/netgap_mail.db');
	    $sql  = "SELECT * FROM pop3_trans_client_acl $where";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('pop3TransClientAcl', $data)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT id FROM pop3_trans_client_acl";
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
        return $db->query($sql)->getCount();
    }

    function getCmd($action) {
        if (!empty($_POST['action'])) {
            $active = $_POST['action'] === 'enable' ? 'on' : 'off';
        } else {
            $active = $_POST['active'] === 'ok' ? 'on' : 'off';
        }
        $id      = $_POST['pop3Id'];
        $sa      = $_POST['sa'];
        $da      = $_POST['da'];
        $dport   = $_POST['dportReq'];
        $comment = $_POST['comment'];
        $time    = $_POST['time'];
        $filter  = $_POST['filter'];
        $usergrp = $_POST['usergrp'];

        $result = "pop3ctl $action task type client mode trans id $id sa $sa " .
            " da $da dport $dport ";
        if (!empty($filter)) {
            $result .= "filter $filter ";
        }
        $result .= "active $active ";
        if (!empty($usergrp)) {
            $result .= "auth $usergrp ";
        }
        if (!empty($time)) {
            $result .= "time $time ";
        }
        $result .= " comment \"$comment\"";
        return $result;
    }

    if ($id = $_POST['editId']) {
        // Show Dialog to get specified pop3 trans client acl data
	    $sql  = "SELECT * FROM pop3_trans_client_acl WHERE id = $id";
        $db   = new dbsqlite(DB_PATH . '/netgap_mail.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $tpl  = 'client/mail/pop3TransVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('filterOptions',
                netGapRes::getInstance()->getMailFilterOpts('pop3'))
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit specified data
        $cli = new cli();
        $cli->run(getCmd('set'));
        echo json_encode(array('msg' =>
            '任务[' . $_POST['pop3Id'] . ']修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new pop3 trans client acl
        $cli = new cli();
        $cli->run(getCmd('add'));
        echo json_encode(array('msg' =>
            '任务[' . $_POST['pop3Id'] . ']添加成功.'));
    } else if ($id = $_POST['delId']) {
        // Delete the specified pop3 trans client acl
        $cli = new cli();
        $cli->run('pop3ctl del task type client mode trans id '. $id);
        echo json_encode(array('msg' =>
            '任务[' . $id . ']删除成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display add new pop3 trans client acl dialog
        $tpl    = 'client/mail/pop3TransVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('filterOptions',
                netGapRes::getInstance()->getMailFilterOpts('pop3'))
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
        $cli = new cli();
        $cli->run(getCmd('set'));
        if ($action === 'enable') {
            $msg = "启动成功.";
        } else {
            $msg = "停止成功.";
        }
        echo json_encode(array('msg' => $msg));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort pop3 trans client list
        appendPop3TransClientAclData($orderStatement);
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
