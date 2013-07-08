<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendPop3TransClientAclData($where) {
        $tpl  =  'client/mail/pop3TransVisitTable.tpl';
        $db   = new dbsqlite(DB_PATH . '/netgap_mail.db');
	    $sql  = "SELECT * FROM pop3_trans_client_acl";
	    $params = array();
	    if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
	    	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
	    	$sql   .= $data['sql'];
	    	$params = $data['params'];
	    }
	    $sql .=  ' ' . $where;
	    $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('pop3TransClientAcl', $result)
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
    	$sql = "SELECT id FROM pop3_trans_client_acl";
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    function getCmd($action) {
        if (!empty($_POST['action'])) {
            $active = $_POST['action'] === 'enable' ? 'on' : 'off';
        } else {
            $active = $_POST['active'] === 'ok' ? 'on' : 'off';
        }
        $id      = intval($_POST['pop3TransId']);
        $sa      = $_POST['sa'];
        $da      = $_POST['da'];
        $dport   = $_POST['pop3TranslportReq'];
        $comment = $_POST['comment'];
        $time    = $_POST['time'];
        $filter  = $_POST['filter'];
        $usergrp = $_POST['usergrp'];
        $virus = $_POST['virus'];
		//$killVirus = $_POST['killVirus'] === 'Y' ? 'yes' : 'no';
        
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
        $result .= "virus $virus comment \"$comment\"";
        return $result;
    }
	
    if ($id = $_POST['editId']) {
        // Show Dialog to get specified pop3 trans client acl data
	    $sql  = "SELECT * FROM pop3_trans_client_acl WHERE id = $id";
        $db   = new dbsqlite(DB_PATH . '/netgap_mail.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $tpl  = 'client/mail/pop3TransVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('saddrOptions', netGapRes::getInstance()->getAddr(true))
            ->assign('daddrOptions', netGapRes::getInstance()->getAddr())
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
        $id  = $_POST['pop3TransId'];
        $cli->setLog("修改邮件访问下的pop3透明访问任务, 任务号为{$id}")
            ->run(getCmd('set'));
        echo json_encode(array('msg' => "任务[$id]修改成功。"));
    } else if ('add' === $_POST['type']) {
        // Add a new pop3 trans client acl
        $cli = new cli();
        $id  = intval($_POST['pop3TransId']);
        $cli->setLog("添加邮件访问下的pop3透明访问任务, 任务号为{$id}")
            ->run(getCmd('add'));
        echo json_encode(array('msg' => "任务[$id]添加成功。"));
    } else if ($id = $_POST['delId']) {
        // Delete the specified pop3 trans client acl
        $cli = new cli();
        $cli->setLog("删除邮件访问下的pop3透明访问任务, 任务号为{$id}")
            ->run('pop3ctl del task type client mode trans id '. $id);
        echo json_encode(array('msg' =>
            '任务[' . $id . ']删除成功。'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display add new pop3 trans client acl dialog
        $tpl    = 'client/mail/pop3TransVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('saddrOptions', netGapRes::getInstance()->getAddr(true))
            ->assign('daddrOptions', netGapRes::getInstance()->getAddr())
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
        $id  = $_POST['pop3TransId'];
        if ($action === 'enable') {
            $msg = '启动';
        } else {
            $msg = '停止';
        }
        $cli->setLog("{$msg}邮件访问下的pop3透明访问任务, 任务号为{$id}")
            ->run(getCmd('set'));
        echo json_encode(array('msg' => $msg . '成功。'));
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
