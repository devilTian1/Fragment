<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendSendTaskData($where) {
        $tpl =  'client/fileEx/sendTaskTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $sql = "SELECT * FROM dir_info WHERE mode = 'C' $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('sendTask', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getCmd() {
        $id        = $_POST['sendTaskId'];
        $ip        = $_POST['sip'];
        $shareName = $_POST['shareName'];
        $fs        = $_POST['fs'];
        if ($fs === 'smbfs') {
            $user = $_POST['smbUser'];
            $pwd  = $_POST['smbPwd'];
            $fs .= " user $user password $pwd";
        }
        $method = $_POST['sendMethod'];
        if ($method === 'C') {
            $rs = $_POST['readyString'];
            $cs = $_POST['completeString'];
            $method .= "changename readystring $rs completestring $cs";
        } else if ($method === 'R') {
            $method = 'remove';
        } else if ($method === 'S') {
            $method = 'sync';
        } else {
            throw new Exception('Incorrect transmit: ' . $method);
        }
        $subdir = $_POST['subdir'] === 'Y' ? 'yes' : 'no';
        $kv     = $_POST['killvirus'] === 'Y' ? 'yes' : 'no';
        $inv    = $_POST['interval'];
        $time   = $_POST['time'];
        $filter = $_POST['FEfilterOpt'];
        $active = $_POST['active'] === 'Y' ? 'on' : 'off';

        $db     = new dbsqlite(DB_PATH . '/netgap_system.db');
        $data   = $db->query("SELECT host, out_ip, in_ip  FROM system")
                     ->getFirstData(PDO::FETCH_ASSOC);
        $oip    = $data['out_ip'];
        $iip    = $data['in_ip'];
        if ($data['host'] === 'I') {
            $exip = "hexip $iip  pexip $oip";
        } else { //O
            $exip = "hexip $oip  pexip $iip";
        }
        $lip  = $_POST['lip'];
        $port = $_POST['portReq'];
        $cmd  = "fsctl add task id $id mode client $exip ip $ip lip $lip " .
            "port $port share $shareName filesystem $fs method $method " .
            "subdir $subdir killvirus $kv interval $inv active $active";
        if (!empty($time)) {
            $cmd .=  " time $time";
        }
        if (!empty($filter)) {
            $cmd .= " filter $filter";
        }
        return $cmd . ' 1>/dev/null';
    }

    function getDataCount() {
        $sql = 'SELECT task_id FROM dir_info WHERE mode = "C"';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        return $db->query($sql)->getCount();
    }

    if ($id = $_POST['editId']) {
        // Display dialog of specified send task data
        $tpl  =  'client/fileEx/editSendTaskDialog.tpl';
        $sql  = "SELECT * FROM dir_info WHERE task_id = $id";
        $db   = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()->assign('data', $data)
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('filters', netGapRes::getInstance()->getFileExFilterOpts())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));

    } else if ('edit' === $_POST['type']) {
        // Edit specified send task data
        $cli = new cli();
        $cli->run('fsctl del task id ' . $_POST['sendTaskId']);
        $cli->run(getCmd());
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // add a new send task data
        $cli = new cli();
        $cli->run(getCmd());
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($id = $_POST['delId']) {
        // delete specified allowed file data
        $cli = new cli();
        $cli->run('fsctl del task id ' . $id);
        echo json_encode(array('msg' => '删除成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display dialog to add send task data
        $tpl =  'client/fileEx/editSendTaskDialog.tpl';
        $result = V::getInstance()
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('filters', netGapRes::getInstance()->getFileExFilterOpts())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_GET['checkExistId'])) {
        // Check the same send task id exist or not
        $sql = "SELECT task_id FROM dir_info WHERE task_id = " .
            $_GET['sendTaskId'];
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
        $cli = new cli();
        $cli->run('fsctl del task id ' . $_POST['sendTaskId']);
        $cli->run(getCmd());
        if ($action === 'enable') {
            $msg = "启动成功.";
        } else {
            $msg = "停止成功.";
        }
        echo json_encode(array('msg' => $msg));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort file sync client table data
        appendSendTaskData($orderStatement);
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
