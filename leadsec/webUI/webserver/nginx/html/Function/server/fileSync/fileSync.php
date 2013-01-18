<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendFileSyncServerAclData($where) {
        $tpl = 'server/fileSync/fileSyncTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        $sql = "SELECT * FROM sync_file_server $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('fileSyncServerAcl', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getCmd($action) {
        $id      = $_POST['fsId'];
        $sip     = $_POST['serverIp'];
        $sport   = $_POST['sportReq'];
        if ($_POST['ssl'] === 'Y') {
            $ssl   = 'yes';
            $cname = $_POST['commname']; 
        } else {
            $ssl   = 'no';
            $cname = '""';
        }
        $comment = $_POST['comment'];
        $result  = "fs2ctl $action task type server id $id sip $sip sport " .
            "$sport mode quick ssl $ssl commname $cname comment \"$comment\"";
        return $result;
    }

    function getDataCount() {
        $sql = 'SELECT id FROM sync_file_server';
        $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        return $db->query($sql)->getCount();
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
        echo json_encode(array('msg' => '编辑成功.'));
    } else if ($id = $_POST['delId']) {
        // Delete spec file sync server data
        $cmd = "fs2ctl del task type server id $id";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '删除成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new file sync server data
        $cli = new cli();
        $cli->run(getCmd('add'));
        echo json_encode(array('msg' => '添加成功.'));
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
    } else if (!empty($_GET['checkExistLport'])) {
        // Check the same lport exist or not
        $sql = 'SELECT id FROM sync_file_server WHERE lport = ' .
            $_GET['fslportReq'] . ' AND lip = "' . $_GET['fslip'] . '"';
        $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if (!empty($_GET['checkExistId'])) {
        // Check the same id exist or not
        echo netGapRes::getInstance()->checkExistTaskId('fileSync',
            $_GET['fsId']);
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
