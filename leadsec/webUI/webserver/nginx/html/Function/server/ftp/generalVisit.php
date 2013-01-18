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
        $id        = $_POST['ftpId'];
        $sip       = $_POST['serverIp'];
        $sport     = $_POST['sportReq'];
        if (!empty($_POST['action'])) {
            $active = $_POST['action'] === 'enable' ? 'on' : 'off';
        } else {
            $active = $_POST['active'] === 'Y' ? 'on' : 'off';
        }
        /*
        if (validateIpv4Format($sip)) {
            $ipver = 'ipver ipv4';
        } else {
            $ipver = 'ipver ipv6';
        }
        */
        $comment   = $_POST['comment'];
        return "cftpctl $action task type server mode comm id $id sip $sip ".
            "sport $sport active $active comment \"$comment\"";
    }

    function appendFtpCommServerAclData($where) {
        $tpl =  'server/ftp/generalVisitTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        $sql = 'SELECT id, serverip, sport, active, comment ' .
            "FROM ftp_comm_server_acl $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('ftpCommServerAcl', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $sql = 'SELECT id FROM ftp_comm_server_acl';
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        return $db->query($sql)->getCount();
    }

    if ($id = $_POST['editId']) {
        // Open dialog to show specified ftp general server acl data
        $sql  = 'SELECT id, serverip, sport, active, comment ' .
            "FROM ftp_comm_server_acl WHERE id = '$id'";
        $db   = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $tpl    = 'server/ftp/generalVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified ftp general server data
        $cli = new cli();
        $cli->run(getCmd());
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new ftp general server data
        $cli = new cli();
        $cli->run(getCmd());
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Open new ftp comm server dialog
        $tpl    = 'server/ftp/generalVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($id = $_POST['delId']) {
        // Delete the specified Ftp General Server data
        $cmd  = "cftpctl del task type server mode comm id $id";
        $cli  = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "删除成功."));
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
        $cli = new cli();
        $cli->run(getCmd());
        echo json_encode(array('msg' => '成功.'));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort ftp_comm_server_acl table
        appendFtpCommServerAclData($orderStatement);
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
