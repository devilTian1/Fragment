<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendPop3CommClientAclData($where) {
        $tpl  =  'client/mail/pop3GeneralVisitTable.tpl';
        $db   = new dbsqlite(DB_PATH . '/netgap_mail.db');
	    $sql  = "SELECT * FROM pop3_comm_client_acl $where";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);        
        echo V::getInstance()->assign('pop3CommClientAcl', $data)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT id FROM pop3_comm_client_acl";
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
        return $db->query($sql)->getCount();
    }

    function getCmd($action) {
        if (!empty($_POST['action'])) {
            $active = $_POST['action'] === 'enable' ? 'on' : 'off';
        } else {
            $active = $_POST['active'] === 'ok' ? 'on' : 'off';
        }
        $id      = intval($_POST['pop3Id']);
        $lip     = $_POST['pop3lip'];
        $lport   = $_POST['pop3lportReq'];
        $sa      = $_POST['sa'];
        $comment = $_POST['comment'];
        //$ipver   = $_POST['ipType'];
        $time    = $_POST['time'];
        $filter  = $_POST['filter'];
        $usergrp = $_POST['usergrp'];
        $result = "pop3ctl $action task type client mode comm id $id sa $sa " .
            " lip $lip lport $lport ";
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
        //$result .= "ipver $ipver comment \"$comment\"";
        $result .= " comment \"$comment\"";
        return $result;
    }

    if ($id = $_POST['editId']) {
        // Show Dialog to get specified pop3 comm client acl data
	    $sql  = "SELECT * FROM pop3_comm_client_acl WHERE id = $id";
        $db   = new dbsqlite(DB_PATH . '/netgap_mail.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $key = $data['sa'];
        $val = substr($key, -4, 4);
        $data['ip_ver'] = $val;
        $tpl  = 'client/mail/pop3GeneralVisit_editDialog.tpl';
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
        $id  = $_POST['pop3Id'];
        $cli->setLog("修改邮件访问下的pop3普通访问任务, 任务号为{$id}")
            ->run(getCmd('set'));
        echo json_encode(array('msg' => "任务[$id]修改成功."));
    } else if ('add' === $_POST['type']) {
        // Add a new pop3 comm client acl
        $cli = new cli();
        $id  = intval($_POST['pop3Id']);
        $cli->setLog("添加邮件访问下的pop3普通访问任务, 任务号为{$id}")
            ->run(getCmd('add'));
        echo json_encode(array('msg' => "任务[$id]添加成功."));
    } else if ($id = $_POST['delId']) {
        // Delete the speciied pop3 comm client acl
        $cli = new cli();
        $cli->setLog("删除邮件访问下的pop3普通访问任务, 任务号为{$id}")
            ->run('pop3ctl del task type client mode comm id ' . $id);
        echo json_encode(array('msg' =>
            '任务[' . $id . ']删除成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display add new pop3 comm client acl dialog
        $tpl    = 'client/mail/pop3GeneralVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('filterOptions',
                netGapRes::getInstance()->getMailFilterOpts('pop3'))
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_GET['checkExistId'])) {
        // Check the same id exist or not
        echo netGapRes::getInstance()->checkExistTaskId('pop3',
            $_GET['pop3Id']);
    } else if (!empty($_GET['checkExistLport'])) {
        // Check the same lport exist or not
    	$id  = intval($_GET['pop3Id']);
        $sql = 'SELECT id FROM pop3_comm_client_acl WHERE lport = ' .
            $_GET['pop3lportReq'] . ' AND lip = "' . $_GET['pop3lip'] . '"';
        if($id != -1) {
        	$sql .= " and id != $id";
        }
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
        $cli = new cli();
        $id  = $_POST['pop3Id'];
        if ($action === 'enable') {
            $msg = '启动';
        } else {
            $msg = '停止';
        }
        $cli->setLog("{$msg}邮件访问下的pop3透明访问任务, 任务号为{$id}")
            ->run(getCmd('set'));
        echo json_encode(array('msg' => $msg . '成功.'));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort pop3 comm client list
        appendPop3CommClientAclData($orderStatement);
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
