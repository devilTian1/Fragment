<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

     function getWhereStatement($db, $cols, $keyword) {
    	$value = '%' . $keyword . '%';
    	$params = array_fill(0, count(explode(',', $cols)), $value);
    	return array('sql'    => ' WHERE (' .
    			$db->getWhereStatement($cols, 'OR', 'like') . ')',
    			'params' => $params);
    }
    
    function appendFtpTransClientAclData($where) {
        $tpl  =  'client/ftp/transVisitTable.tpl';
        $db   = new dbsqlite(DB_PATH . '/gateway_ftp.db');
	    $sql  = "SELECT * FROM ftp_trans_client_acl ";	    
	    $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$dataSearch   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $dataSearch['sql'];
        	$params = $dataSearch['params'];
        }
        $sql .=  ' ' . $where;     	    
        $data = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('ftpTransClientAcl', $data)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT id FROM ftp_trans_client_acl";
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');        
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
            $active = $_POST['active'] === 'Y' ? 'on' : 'off';
        }
        $id      = intval($_POST['ftpTransId']);
        $sa      = $_POST['sa'];
        $da      = $_POST['da'];
        $dport   = $_POST['ftpTranslportReq'];
        $comment = $_POST['comment'];
        $time    = $_POST['time'];
        $filter  = $_POST['filter'];
        $usergrp = $_POST['usergrp'];
		$killVirus = $_POST['killVirus'] === 'Y' ? 'Y' : 'N';
		
        $result = "cftpctl $action task type client mode trans id $id sa $sa " .
            " da $da dport $dport active $active ";
        if (!empty($usergrp)) {
            $result .= "auth $usergrp ";
        }
        if (!empty($time)) {
            $result .= "time $time ";
        }
        if (!empty($filter)) {
            $result .= "filter $filter ";
        }
        $result .= " comment \"$comment\"";
        $result .= " virus $killVirus";
        return $result;
    }

    if ($id = $_POST['editId']) {
        // Show Dialog to get specified ftp trans client acl data
	    $sql  = "SELECT * FROM ftp_trans_client_acl WHERE id = $id";
        $db   = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);        
        $tpl  = 'client/ftp/transVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr(true))            
            ->assign('addrDestOptions', netGapRes::getInstance()->getAddrList())          
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('filterOptions',
                netGapRes::getInstance()->getFtpFilterOpts())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit specified data
        $cli = new cli();
        $cli->setIsRec(false)->run('cftpctl del task type client mode trans id ' .
            $_POST['ftpTransId']);
        $cli->setIsRec(true)->setLog("修改一条FTP透明访问任务,任务号为".$_POST['ftpTransId'])->run(getCmd('set'));
        echo json_encode(array('msg' =>
            '任务[' . $_POST['ftpTransId'] . ']修改成功.'));

    } else if ('add' === $_POST['type']) {
        // Add a new ftp trans client acl
        $cli = new cli();
        $cli->setLog("添加一条新的FTP透明访问任务,任务号为".$_POST['ftpTransId'])->run(getCmd('add'));
        echo json_encode(array('msg' =>
            '任务[' . intval($_POST['ftpTransId']) . ']添加成功.'));
    } else if ($id = $_POST['delId']) {
        // Delete the specified ftp trans client acl
        $cli = new cli();
        $cli->setLog("删除一条FTP透明访问任务,任务号为".$id)->run('cftpctl del task type client mode trans id '. $id);
        echo json_encode(array('msg' =>
            '任务[' . $id . ']删除成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display add new ftp trans client acl dialog
        $tpl    = 'client/ftp/transVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr(true))
            ->assign('addrDestOptions', netGapRes::getInstance()->getAddrList())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('filterOptions',
                netGapRes::getInstance()->getFtpFilterOpts())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
        $cli = new cli();
        $cli->setLog("修改一条FTP透明访问任务,任务号为".$_POST['ftpTransId'])->run(getCmd('set'));
        if ($action === 'enable') {
            $msg = "启动成功.";
        } else {
            $msg = "停止成功.";
        }
        echo json_encode(array('msg' => $msg));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort ftp trans client list
        appendFtpTransClientAclData($orderStatement);
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
