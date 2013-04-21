<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendReceiveTaskData($where) {
        $tpl =  'server/fileEx/receiveTaskTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $sql = 'SELECT task_id, ip, share_name, fs, user, password, active, ' .
            "lip, port FROM dir_info WHERE mode = 'S' $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('receiveTask', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getCmd() {
        $id        = intval($_POST['receiveTaskId']);
        $ip        = $_POST['sip'];
        $shareName = $_POST['shareName'];
        $fs        = $_POST['fs'];
        if ($fs === 'smbfs') {
            $user = $_POST['smbUser'];
            $pwd  = $_POST['smbPwd'];
            $fs .= " user $user password $pwd";
        }
		if (!empty($_POST['action'])) {
			$active = $_POST['action'] === 'enable' ? 'on' : 'off';
		} else {
			$active = $_POST['active'] === 'Y' ? 'on' : 'off';
		}
        $port = $_POST['portReq'];
        $cmd = array();       
        $cmd['cmd']  = "fsctl add task id $id mode server ip $ip port $port share $shareName" .
		" filesystem $fs active $active";
        $cmd['log']  = '添加服务端的文件交换的接收任务,id号为'.$id;        
        return $cmd;
    }

    function getDataCount() {
        $sql = 'SELECT task_id FROM dir_info WHERE mode = "S"';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        return $db->query($sql)->getCount();
    }

    if ($id = $_POST['editId']) {
        // Display dialog of specified receive task data
        $tpl  =  'server/fileEx/editReceiveTaskDialog.tpl';
        $sql  = 'SELECT task_id, ip, share_name, fs, user, password, active ' .
            "FROM dir_info WHERE task_id = $id";
        $db   = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()->assign('data', $data)
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));

    } else if ('edit' === $_POST['type']) {
        // Edit specified receive task data
        $cli = new cli();
        $cli->setLog('删除服务端的文件交换的接收任务'. $_POST['receiveTaskId'])->run('fsctl del task id ' . $_POST['receiveTaskId']);
        $cmdArr =  getCmd();
        $cli->setLog($cmdArr['log'])->run($cmdArr['cmd']);
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // add a new receive task data
        $cli = new cli();
        $cmdArr =  getCmd();
        $cli->setLog($cmdArr['log'])->run($cmdArr['cmd']);
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($id = $_POST['delId']) {
        // delete specified allowed file data
        $cli = new cli();
        $cli->setLog('删除服务端的文件交换的接收任务'. $id)->run('fsctl del task id ' . $id);
        echo json_encode(array('msg' => '删除成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display dialog to add receive task data
        $tpl =  'server/fileEx/editReceiveTaskDialog.tpl';
        $result = V::getInstance()
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_GET['checkExistId'])) {
        // Check the same receive task id exist or not
        $sql = "SELECT task_id FROM dir_info WHERE task_id = " .
            $_GET['receiveTaskId'];
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
        $cli = new cli();
        $cli->setLog('删除服务端的文件交换的接收任务'. $_POST['receiveTaskId'])->run('fsctl del task id ' . $_POST['receiveTaskId']);
        $cmdArr =  getCmd();
        $cli->setLog($cmdArr['log'])->run($cmdArr['cmd']);
        if ($action === 'enable') {
            $msg = "启动成功.";
        } else {
            $msg = "停止成功.";
        }
        echo json_encode(array('msg' => $msg));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort receive task table data
        appendReceiveTaskData($orderStatement);
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
