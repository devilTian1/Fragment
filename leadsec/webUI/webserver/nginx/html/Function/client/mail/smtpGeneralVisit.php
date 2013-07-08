<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendSmtpCommClientAclData($where) {
        $tpl  =  'client/mail/smtpGeneralVisitTable.tpl';
        $db   = new dbsqlite(DB_PATH . '/netgap_mail.db');
	    $sql  = "SELECT * FROM smtp_comm_client_acl";
	    $params = array();
	    if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
	    	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
	    	$sql   .= $data['sql'];
	    	$params = $data['params'];
	    }
	    $sql .=  ' ' . $where;
	    $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('smtpCommClientAcl', $result)
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
    	$sql = "SELECT id FROM smtp_comm_client_acl";
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
        $id      = intval($_POST['smtpGeneralId']);
        $lip     = $_POST['smtpGeneralLip'];
        $lport   = $_POST['smtpGeneralLport'];
        $sa      = $_POST['sa'];
        $comment = $_POST['comment'];
        $ipver   = $_POST['ipType'];
        $time    = $_POST['time'];
        $filter  = $_POST['filter'];
        $usergrp = $_POST['usergrp'];
        $virus = $_POST['virus'];
        $result = "smtpctl $action task type client mode comm id $id sa $sa " .
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
        $result .= "ipver $ipver virus $virus comment \"$comment\"";
        return $result;
    }

    if ($id = $_POST['editId']) {
        // Show Dialog to get specified smtp comm client acl data
	    $sql  = "SELECT * FROM smtp_comm_client_acl WHERE id = $id";
        $db   = new dbsqlite(DB_PATH . '/netgap_mail.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);   
        //print_r($data);    	 
        $key = $data['sa'];
        $val = substr($key, -4, 4);
        $data['ip_ver'] = $val;
        $tpl  = 'client/mail/smtpGeneralVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr(true))
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
        $id  = $_POST['smtpGeneralId'];
        $cli->setLog("修改邮件访问下的smtp普通访问任务, 任务号为{$id}")
            ->run(getCmd('set'));
        echo json_encode(array('msg' => "任务[$id]修改成功。"));
    } else if ('add' === $_POST['type']) {
        // Add a new smtp comm client acl
        $cli = new cli();
        $id  = intval($_POST['smtpGeneralId']);
		list($status,$result) = $cli->setLog("添加邮件访问下的smtp普通访问任务, 任务号为{$id}")
				->execCmdGetStatus(getCmd('add'));
        //$cli->setLog("添加邮件访问下的smtp普通访问任务, 任务号为{$id}")
        //    ->run(getCmd('add'));
		if ($status>0) {
			echo json_encode(array('msg' => "任务[$id]添加失败,请检查配置。"));
		} else {
			echo json_encode(array('msg' => "任务[$id]添加成功。"));
		}
    } else if ($id = $_POST['delId']) {
        // Delete the speciied smtp comm client acl
        $cli = new cli();
        $cli->setLog("删除邮件访问下的smtp普通访问任务, 任务号为{$id}")
            ->run('smtpctl del task type client mode comm id ' . $id);
        echo json_encode(array('msg' =>
            '任务[' . $id . ']删除成功。'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display add new smtp comm client acl dialog
        $tpl    = 'client/mail/smtpGeneralVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr(true))
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
        $id  = $_POST['smtpGeneralId'];
        if ($action === 'enable') {
            $msg = '启动';
        } else {
            $msg = '停止';
        }
        $cli->setLog("{$msg}邮件访问下的smtp普通访问任务, 任务号为{$id}")
            ->run(getCmd('set'));
        echo json_encode(array('msg' => $msg . '成功。'));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort smtp comm client list
        appendSmtpCommClientAclData($orderStatement);
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
