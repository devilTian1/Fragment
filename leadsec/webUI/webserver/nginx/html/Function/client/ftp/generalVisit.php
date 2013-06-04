<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
    function getWhereStatement($db, $cols, $keyword) {
    	$value = '%' . $keyword . '%';
    	$params = array_fill(0, count(explode(',', $cols)), $value);
    	return array('sql'    => ' WHERE (' .
    			$db->getWhereStatement($cols, 'OR', 'like') . ')',
    			'params' => $params);
    }
    
    function appendFtpCommClientAclData($where) {
        $tpl  =  'client/ftp/generalVisitTable.tpl';
        $db   = new dbsqlite(DB_PATH . '/gateway_ftp.db');
	    $sql  = "SELECT * FROM ftp_comm_client_acl ";	    
	    $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$dataSearch   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $dataSearch['sql'];
        	$params = $dataSearch['params'];
        }
        $sql .=  ' ' . $where;      
        $data = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('ftpCommClientAcl', $data)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT id FROM ftp_comm_client_acl";    	
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
        $id      = intval($_POST['ftpGeneralId']);
        $lip     = $_POST['ftpGeneralLip'];
        $lport   = $_POST['ftpGeneralLport'];
        $sa      = $_POST['sa'];
        $comment = $_POST['comment'];
        $ipver   = $_POST['ipType'];
        $time    = $_POST['time'];
        $filter  = $_POST['filter'];
        $usergrp = $_POST['usergrp'];
        $killVirus = $_POST['killVirus'] === 'Y' ? 'Y' : 'N';
        
        $result = "cftpctl $action task type client mode comm id $id sa $sa " .
            " lip $lip lport $lport active $active ";
        if (!empty($usergrp)) {
            $result .= "auth $usergrp ";
        }
        if (!empty($time)) {
            $result .= "time $time ";
        }
        if (!empty($filter)) {
            $result .= "filter $filter ";
        }
        $result .= "ipver $ipver comment \"$comment\"";       
        $result .= " virus $killVirus";
        return $result;
    }

    if ($id = $_POST['editId']) {
        // Show Dialog to get specified ftp comm client acl data
	    $sql  = "SELECT * FROM ftp_comm_client_acl WHERE id = $id";
        $db   = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $tpl  = 'client/ftp/generalVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr(true))
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
        $cli->setLog("修改一条FTP普通访问任务,任务号为".$_POST['ftpGeneralId'])->run(getCmd('set'));
        echo json_encode(array('msg' =>
            '任务[' . $_POST['ftpGeneralId'] . ']修改成功.'));

    } else if ('add' === $_POST['type']) {
        // Add a new ftp comm client acl
        $cli = new cli();
		list($status,$result) = $cli->setLog("添加一条新的FTP普通访问任务,任务号为".$_POST['ftpGeneralId'])
				->execCmdGetStatus(getCmd('add'));
        //$cli->setLog("添加一条新的FTP普通访问任务,任务号为".$_POST['ftpGeneralId'])->run(getCmd('add'));
		if ($status>0) {
			echo json_encode(array('msg' =>
            '任务[' . intval($_POST['ftpGeneralId']) . ']添加失败,请检查配置.'));
		} else {
			echo json_encode(array('msg' =>
            '任务[' . intval($_POST['ftpGeneralId']) . ']添加成功.'));
		}
    } else if ($id = $_POST['delId']) {
        // Delete the specified ftp comm client acl
        $cli = new cli();
        $cli->setLog("删除一条FTP普通访问任务,任务号为".$id)->run('cftpctl del task type client mode comm id '. $id);
        echo json_encode(array('msg' =>
            '任务[' . $id . ']删除成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display add new ftp comm client acl dialog
        $tpl    = 'client/ftp/generalVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr(true))
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
        $cli->setLog("修改一条FTP普通访问任务,任务号为".$_POST['ftpGeneralId'])->run(getCmd('set'));
        if ($action === 'enable') {
            $msg = "启动成功.";
        } else {
            $msg = "停止成功.";
        }
        echo json_encode(array('msg' => $msg));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort ftp comm client list
        appendFtpCommClientAclData($orderStatement);
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
