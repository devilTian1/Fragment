<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendSmtpTransClientAclData($where) {
        $tpl  =  'client/mail/smtpTransVisitTable.tpl';
        $db   = new dbsqlite(DB_PATH . '/netgap_mail.db');
	    $sql  = "SELECT * FROM smtp_trans_client_acl $where";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('smtpTransClientAcl', $data)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT id FROM smtp_trans_client_acl";
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
        return $db->query($sql)->getCount();
    }
    
    function checkExistTaskAndPort() {
    	$sql    = 'SELECT id FROM smtp_trans_client_acl WHERE (id+dport) = ' .
            $_GET['idPlusPort']. ' AND id != ' . $_GET['taskId'];
        $db     = new dbsqlite(DB_PATH . '/netgap_mail.db');
        $result = $db->query($sql)->getCount() > 0 ? 'false' : 'true';
        echo $result;
    }    

    function getCmd($action) {
        if (!empty($_POST['action'])) {
            $active = $_POST['action'] === 'enable' ? 'on' : 'off';
        } else {
            $active = $_POST['active'] === 'ok' ? 'on' : 'off';
        }
        $id      = intval($_POST['smtpTransId']);
        $sa      = $_POST['sa'];
        $da      = $_POST['da'];
        $dport   = $_POST['smtpTransdportReq'];
        $comment = $_POST['comment'];
        $time    = $_POST['time'];
        $filter  = $_POST['filter'];
        $usergrp = $_POST['usergrp'];
		//$killVirus = $_POST['killVirus'] === 'Y' ? 'yes' : 'no';
        
        $result = "smtpctl $action task type client mode trans id $id sa $sa " .
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
        // Show Dialog to get specified smtp trans client acl data
	    $sql  = "SELECT * FROM smtp_trans_client_acl WHERE id = $id";
        $db   = new dbsqlite(DB_PATH . '/netgap_mail.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $tpl  = 'client/mail/smtpTransVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('filterOptions',
                netGapRes::getInstance()->getMailFilterOpts('smtp'))
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit specified data
        $cli = new cli();
        $id  = $_POST['smtpTransId'];
        $cli->setLog("修改邮件访问下的smtp透明访问任务, 任务号为{$id}")
            ->run(getCmd('set'));
        echo json_encode(array('msg' => "任务[$id]修改成功."));
    } else if ('add' === $_POST['type']) {
        // Add a new smtp trans client acl
        $cli = new cli();
        $id  = intval($_POST['smtpTransId']);
        $cli->setLog("添加邮件访问下的smtp透明访问任务, 任务号为{$id}")
            ->run(getCmd('add'));
        echo json_encode(array('msg' => "任务[$id]添加成功."));
    } else if ($id = $_POST['delId']) {
        // Delete the specified smtp trans client acl
        $cli = new cli();
        $cli->setLog("删除邮件访问下的smtp透明访问任务, 任务号为{$id}")
            ->run('smtpctl del task type client mode trans id '. $id);
        echo json_encode(array('msg' =>
            '任务[' . $id . ']删除成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display add new smtp trans client acl dialog
        $tpl    = 'client/mail/smtpTransVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('filterOptions',
                netGapRes::getInstance()->getMailFilterOpts('smtp'))
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
       $cli = new cli();
        $id  = $_POST['smtpId'];
        if ($action === 'enable') {
            $msg = '启动';
        } else {
            $msg = '停止';
        }
        $cli->setLog("{$msg}邮件访问下的smtp透明访问任务, 任务号为{$id}")
            ->run(getCmd('set'));
        echo json_encode(array('msg' => $msg));
    }  else if (!empty($_GET['checkExistTaskAndPort'])) {
        // check the new name existed or not
        checkExistTaskAndPort();
        return true;
    } else if (!empty($_GET['checkExistId'])) {
        // Check the same id exist or not
        echo netGapRes::getInstance()->checkExistTaskId('smtp',
            $_GET['smtpTransId']);
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort smtp trans client list
        appendSmtpTransClientAclData($orderStatement);
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
