<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendSendTaskData($where) {
        $tpl =  'client/fileEx/sendTaskTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $sql = "SELECT * FROM dir_info WHERE mode = 'C'";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('sendTask', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
	
    function getCmd($action) {
        $id        = intval($_POST['sendTaskId']);
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
			$method = "changename readystring '$rs' completestring '$cs'";
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
		if (!empty($_POST['action'])) {
			$active = $_POST['action'] === 'enable' ? 'on' : 'off';
		} else {
			$active = $_POST['active'] === 'Y' ? 'on' : 'off';
		}
        $port = $_POST['sendTaskPort'];
        $cmd  = "fsctl $action task id $id mode client ip $ip share $shareName filesystem $fs port $port method $method  subdir $subdir killvirus $kv interval $inv active $active";
        if (!empty($time)) {
            $cmd .=  " time $time";
        }
        if (!empty($filter)) {
            $cmd .= " filter $filter";
        }
		return $cmd;
    }

    function getWhereStatement($db, $cols, $keyword) {
        $value = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' AND (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }

    function getDataCount() {
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $sql = "SELECT task_id FROM dir_info WHERE mode = 'C'";
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }
    
    function getTaskNumber() {
    	$sql = "SELECT task_id FROM dir_info" ;           
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        return $db->query($sql)->getCount();
    }
    
	function getStatusInfo($status) {
		switch ($status) {
			case 1:
				return '命令行错误。';
			case 2:
				return '数据库错误。';
			case 4:
				return '系统错误。';
			case 6:
				return '挂载共享路径错误，请检查共享配置。';
			case 8:
				return '卸载错误。';
            default:
                return '无法识别的错误类型[' . $status . ']。';
		}
		return $showErrorInfo;
	}
	$killVirusIsUsed = antiIsUsed();
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
            ->assign('killVirusIsUsed',$killVirusIsUsed)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit specified send task data
		$msg = '客户端文件交换模块的发送任务,修改任务号为'.$_POST['sendTaskId'];
        $cli = new cli();
		list($status, $result) = $cli->setLog($msg)
                                     ->execCmdGetStatus(getCmd('set'), false);
		if ($status > 0) {
			echo json_encode(array('msg' => getStatusInfo($status)));
		} else {
			 echo json_encode(array('msg' => '修改成功。'));
		}
    } else if ('add' === $_POST['type']) {
        // add a new send task data
        $cli = new cli();
		$cmd = getCmd('add');
		$id  = intval($_POST['sendTaskId']);
		// get the status 
		$msg = '客户端文件交换模块的发送任务,添加任务号为'.$id;
		list($status, $result) = $cli->setLog($msg)
                                     ->execCmdGetStatus($cmd, false);
		if ($status > 0) {
			echo json_encode(array('msg' => getStatusInfo($status)));
		} else {
			 echo json_encode(array('msg' => '添加成功。'));
		}
    } else if ($id = $_POST['delId']) {
        // delete specified allowed file data
        $cli = new cli();
		$msg = '客户端文件交换模块的发送任务,删除任务号为'.$id;
		$cmd = 'fsctl del task id '. $id;
        list($status, $result) = $cli->setLog($msg)->execCmdGetStatus($cmd, false);
        if ($status > 0) {
        	echo json_encode(array('msg' => getStatusInfo($status)));
        } else {
        	echo json_encode(array('msg' => '删除成功。'));
        }
    } else if (!empty($_POST['openAddDialog'])) {
        if (getTaskNumber() >= 20) {
            echo json_encode(array('status' => -1,
                                   'msg' => '添加任务数目已达上限20条，已无法添加。'));
            return false;
        }
        // Display dialog to add send task data
        $tpl =  'client/fileEx/editSendTaskDialog.tpl';
        $result = V::getInstance()
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('filters', netGapRes::getInstance()->getFileExFilterOpts())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('killVirusIsUsed',$killVirusIsUsed)
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
        $cli = new cli();
        if ($action === 'enable') {
			$msg_log = '客户端文件交换模块的发送任务添加任务号为'.$_POST['sendTaskId'].
				'任务由停止变为启动';
			$cli->setLog($msg_log)->run(getCmd('set'));
            $msg = "启动成功。";
        } else {
			$msg_log = '客户端文件交换模块的发送任务添加任务号为'.$_POST['sendTaskId'].
				'任务由启动变为停止';
			$cli->setLog($msg_log)->run(getCmd('set'));
            $msg = "停止成功。";
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
