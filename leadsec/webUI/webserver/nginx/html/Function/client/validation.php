<?php
    require_once('../common.php');
    $errMsg = array();
    $res    = netGapRes::getInstance();
    
    // FTP Client
    if ((($id = $_GET['ftpTransId']) || ($id = $_GET['ftpGeneralId'])|| ($id = $_GET['ftpId'])) &&
        ('false' === $res->checkExistTaskId('ftp', $id))) {
        $errMsg[] = '任务号已存在';
    }
    if ($idPlusPort = $_GET['ftpClientTaskAndPort']) {
        $sql = 'SELECT id FROM ftp_trans_client_acl WHERE (id+dport) = ' .
            $idPlusPort;
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        if ($db->query($sql)->getCount() > 0) {
            $errMsg[] = '任务号加目的端口号已存在';
        }
    }
    if (($lport = $_GET['ftpGeneralLport']) && ($lip = $_GET['lip'])) {
        $sql = "SELECT id FROM ftp_comm_client_acl WHERE lport = $lport" .
            " AND lip = '$lip'";
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        if ($db->query($sql)->getCount() > 0) {
            $errMsg[] = 'The combination of lip and lport has been used';
        }
    }
    if (($lport = $_GET['ftpTranslportReq']) && ($lip = $_GET['lip'])) {
        $sql = "SELECT id FROM ftp_trans_client_acl WHERE dport = $lport" .
            " AND da = '$lip'";
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        if ($db->query($sql)->getCount() > 0) {
            $errMsg[] = 'The combination of lip and lport has been used';
        }
    }
    //custom
    if ((($id = $_GET['customTcpGeneralId']) || ($id = $_GET['customUdpGeneralId'])) &&
        ('false' === $res->checkExistTaskId('customized', $id))) {
        $errMsg[] = '任务号已存在';
    }
    if (($lport = $_GET['tcpGeneralLport']) && ($lip = $_GET['lip'])) {
        $sql = "SELECT id FROM tcp_comm_client_acl WHERE lport = $lport" .
            " AND lip = '$lip'";
        $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
        if ($db->query($sql)->getCount() > 0) {
            $errMsg[] = 'The combination of lip and lport has been used';
        }
    }
    if (($lport = $_GET['udpGeneralLport']) && ($lip = $_GET['lip'])) {
        $sql = "SELECT id FROM udp_comm_client_acl WHERE lport = $lport" .
            " AND lip = '$lip'";
        $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
        if ($db->query($sql)->getCount() > 0) {
            $errMsg[] = 'The combination of lip and lport has been used';
        }
    }
    if ((($id = $_GET['customTcpTransId']) || ($id = $_GET['customUdpTransId'])) &&
        ('false' === $res->checkExistTaskId('customized', $id))) {
        $errMsg[] = '任务号已存在';
    }
    if ($idPlusPort = $_GET['customTcpTransClientTaskAndPort']) {
        $sql = 'SELECT id FROM tcp_trans_client_acl WHERE (id+dport) = ' .
            $idPlusPort;
        $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
        if ($db->query($sql)->getCount() > 0) {
            $errMsg[] = '任务号加目的端口号已存在';
        }
    }
    if ($idPlusPort = $_GET['customUdpTransClientTaskAndPort']) {
        $sql = 'SELECT id FROM udp_trans_client_acl WHERE (id+dport) = ' .
            $idPlusPort;
        $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
        if ($db->query($sql)->getCount() > 0) {
            $errMsg[] = '任务号加目的端口号已存在';
        }
    }
    // safePass Client
    if (($id = $_GET['safePassId']) &&
        ('false' === $res->checkExistTaskId('safepass', $id))) {
        $errMsg[] = '任务号已存在';
    }
    // POP3 Client
    if ((($id = $_GET['pop3TransId']) || ($id = $_GET['pop3GeneralId'])) &&
    		('false' === $res->checkExistTaskId('pop3', $id))) {
    	$errMsg[] = '任务号已存在';
    }
    if ($idPlusPort = $_GET['pop3ClientTaskAndPort']) {
    	$sql = 'SELECT id FROM pop3_trans_client_acl WHERE (id+dport) = ' .
    			$idPlusPort;
    	$db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
    	if ($db->query($sql)->getCount() > 0) {
    		$errMsg[] = '任务号加目的端口号已存在';
    	}
    }
    if (($lport = $_GET['pop3GeneralLport']) && ($lip = $_GET['lip'])) {
    	$sql = "SELECT id FROM pop3_comm_client_acl WHERE lport = $lport" .
    	" AND lip = '$lip'";
    	$db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
    	$num = $db->query($sql)->getCount();
    	$sql = "SELECT id FROM smtp_comm_client_acl WHERE lport = $lport" .
    	" AND lip = '$lip'";
    	$num = $num + $db->query($sql)->getCount();
    	if ($num > 0) {
    		$errMsg[] = 'The combination of lip and lport has been used';
    	}
    }
    // SMTP Client
    if ((($id = $_GET['smtpTransId']) || ($id = $_GET['smtpGeneralId'])) &&
    		('false' === $res->checkExistTaskId('smtp', $id))) {
    	$errMsg[] = '任务号已存在';
    }
    if ($idPlusPort = $_GET['smtpClientTaskAndPort']) {
    	$sql = 'SELECT id FROM smtp_trans_client_acl WHERE (id+dport) = ' .
    			$idPlusPort;
    	$db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
    	if ($db->query($sql)->getCount() > 0) {
    		$errMsg[] = '任务号加目的端口号已存在';
    	}
    }
    if (($lport = $_GET['smtpGeneralLport']) && ($lip = $_GET['lip'])) {
    	$sql = "SELECT id FROM smtp_comm_client_acl WHERE lport = $lport" .
    	" AND lip = '$lip'";
    	$db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
    	$num = $db->query($sql)->getCount();
    	$sql = "SELECT id FROM pop3_comm_client_acl WHERE lport = $lport" .
    	" AND lip = '$lip'";
    	$num = $num + $db->query($sql)->getCount();
    	if ($num > 0) {
    		$errMsg[] = 'The combination of lip and lport has been used';
    	}
    }
    // sendTask Client
    if (($id = $_GET['sendGeneralId']) &&
    		('false' === $res->checkExistTaskId('fileEx', $id))) {
    	$errMsg[] = '任务号已存在';
    }
     // db Client
    if ((($id = $_GET['cdbTransId']) || ($id = $_GET['cdbGeneralId'])) &&
        ('false' === $res->checkExistTaskId('trans', $id))) {
        $errMsg[] = '任务号已存在';
    }
    if ($idPlusPort = $_GET['cdbClientTaskAndPort']) {
        $sql = 'SELECT id FROM db_trans_client_acl WHERE (id+dport) = ' .
            $idPlusPort;
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        if ($db->query($sql)->getCount() > 0) {
            $errMsg[] = '任务号加目的端口号已存在';
        }
    }
    if (($lport = $_GET['cdbGeneralLport']) && ($lip = $_GET['lip'])) {
        $sql = "SELECT id FROM db_comm_client_acl WHERE lport = $lport" .
            " AND lip = '$lip'";
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        if ($db->query($sql)->getCount() > 0) {
            $errMsg[] = 'The combination of lip and lport has been used';
        }
    }
    // msgTrans Client
    if ((($id = $_GET['cmsgGeneralId'])) &&
        ('false' === $res->checkExistTaskId('msg', $id))) {
        $errMsg[] = '任务号已存在';
    }
    if (($lport = $_GET['cmsgGeneralLport']) && ($lip = $_GET['lip'])) {
        $sql = "SELECT id FROM msg_client_task WHERE lport = $lport" .
            " AND lip = '$lip'";
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        if ($db->query($sql)->getCount() > 0) {
            $errMsg[] = 'The combination of lip and lport has been used';
        }
    }
    // client fileSync taskId	
	if (($id = $_GET['clientFileSyncGeneralId']) && ('false' === $res->checkExistTaskId('fileSync', $id))) {
        $errMsg[] = '任务号已存在';
    }
	//client fileSync lport
	if (($lport = $_GET['csGeneralLport']) && ($lip = $_GET['lip'])) {
    	$sql = "SELECT id FROM sync_file_client WHERE lport = $lport" .
    	" AND lip = '$lip'";
    	$db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
    	if ($db->query($sql)->getCount() > 0) {
    		$errMsg[] = 'The combination of lip and lport has been used';
    	}
    }
	//client dbSync taskId
	if (($id = $_GET['clientDbSyncGeneralId']) && ('false' === $res->checkExistTaskId('dbSync', $id))) {
        $errMsg[] = '任务号已存在';
    }
	//client dbSync lport
	if (($lport = $_GET['cdbsGeneralLport']) && ($lip = $_GET['lip'])) {
    	$sql = "SELECT id FROM db_swap_client_acl WHERE lport = $lport" .
    	" AND lip = '$lip'";
    	$db  = new dbsqlite(DB_PATH . '/netgap_db_swap.db');
    	if ($db->query($sql)->getCount() > 0) {
    		$errMsg[] = 'The combination of lip and lport has been used';
    	}
    }
    echo json_encode(array('msg' => $errMsg));
    return true;
?>
