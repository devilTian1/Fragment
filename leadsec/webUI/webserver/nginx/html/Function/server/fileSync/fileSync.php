<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendFileSyncServerAclData($where) {
        $tpl = 'server/fileSync/fileSyncTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        $sql = "SELECT * FROM sync_file_server";
		$params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
		$sql .=  ' ' . $where;
        $result = $db->query($sql,$params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('fileSyncServerAcl', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getCmd($action) {
		if (!empty($_POST['sfileSyncTaskId'])) {
			$id = intval($_POST['sfileSyncTaskId']);
		} else {
			$id = intval($_POST['fsId']);
		}
        $sip     = $_POST['serverIp'];
        if (validateIpv4Format($sip)) {
            $ipver = 'ipver ipv4';
        } else {
            $ipver = 'ipver ipv6';
        }
        $sport   = $_POST['lport'];
        if ($_POST['ssl'] === 'Y') {
            $ssl   = 'yes';
            $cname = $_POST['commname']; 
        } else {
            $ssl   = 'no';
            $cname = '""';
        }
        $comment = $_POST['comment'];
        $result  = "fs2ctl $action task type server id $id sip $sip sport " .
            "$sport mode quick ssl $ssl commname $cname $ipver " .
            "comment \"$comment\" 1>/dev/null";
        return $result;
    }

	function getWhereStatement($db, $cols, $keyword) {
        $value  = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' WHERE (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }

    function getDataCount() {
        $sql = 'SELECT id FROM sync_file_server';
        $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
		$params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    if ($id = $_POST['editId']) {
        // Open dialog to show specified file sync server acl data
        $sql  = "SELECT * FROM sync_file_server WHERE id = '$id'";
        $tpl  = 'server/fileSync/fileSync_editDialog.tpl';
        $db   = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit specified file sync server data
        $cli = new cli();
        $cli->run(getCmd('set'));
        echo json_encode(array('msg' => '编辑成功。'));
    } else if ($id = $_POST['delId']) {
        // Delete spec file sync server data
        $cmd = "fs2ctl del task type server id $id";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '删除成功。'));
    } else if ('add' === $_POST['type']) {
        // Add a new file sync server data
        $cli = new cli();
        $cli->run(getCmd('add'));
        echo json_encode(array('msg' => '添加成功。'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Open new file sync dialog
        $tpl    = 'server/fileSync/fileSync_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort file sync server table data
        appendFileSyncServerAclData($orderStatement);
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
