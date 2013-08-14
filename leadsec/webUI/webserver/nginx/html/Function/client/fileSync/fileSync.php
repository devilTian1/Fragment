<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendFileSyncClientAclData($where) {
        $tpl =  'client/fileSync/fileSyncTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        $sql = 'SELECT id, sa, lip, lport, ssl, commname, mode, killvirus, ' .
            "time, comment FROM sync_file_client";
		$params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql,$params)->getAllData(PDO::FETCH_ASSOC);
		foreach ($result as $key => $arr) {
				$result[$key]['sa'] = addrNameDelPreffix($arr['sa']);
			}
			echo V::getInstance()->assign('fileSyncClientAcl', $result)
				->assign('pageCount', 10)
				->fetch($tpl);
		}

    function getCmd($action) {
		if (!empty($_POST['clientFileSyncTaskId'])) {
			$id = intval($_POST['clientFileSyncTaskId']);
		} else {
			$id = intval($_POST['fsId']);
		}
        $sa      = $_POST['sa'];
        $lip     = $_POST['clientFileSyncLip'];
        $lport   = $_POST['clientFileSyncLport'];
        if ($_POST['ssl'] === 'Y') {
            $ssl   = 'yes';
            $cname = $_POST['commname']; 
        } else {
            $ssl   = 'no';
            $cname = '""';
        }
        $kv      = $_POST['killVirus'] === 'Y' ? 'yes' : 'no';
        $ipver   = $_POST['ipType'];
        $comment = $_POST['comment'];
        $time    = $_POST['time'];
        $result = "fs2ctl $action task type client id $id sa $sa lip $lip " .
            "lport $lport mode quick ssl $ssl commname $cname killvirus $kv ";
        if (!empty($time)) {
            $result .= "time $time ";
        }
        $result .= "seclevel 0 ipver $ipver comment \"$comment\" 1>/dev/null";
        return $result;
    }

	function getWhereStatement($db, $cols, $keyword) {
        //$value  = '%' . $keyword . '%';
		$value  = $keyword;
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' WHERE (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $db->getFilterParams($params));
    }

    function getDataCount() {
        $sql = 'SELECT id FROM sync_file_client';
        $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
		$params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql,$params)->getCount();
    }

    function addrNameDelPreffix($name) {
    	// 去掉最后一个下划线_ipv4或_ipv6
    	return substr($name,0,-5);    	
    }

	$killVirusIsUsed = antiIsUsed();
    if ($id = $_POST['editId']) {
        // Open dialog to show specified file sync client acl data
        $sql  = "SELECT * FROM sync_file_client WHERE id = '$id'";
        $tpl  = 'client/fileSync/fileSync_editDialog.tpl';
        $db   = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
			->assign('killVirusIsUsed',$killVirusIsUsed)
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit specified file sync client data
        $cli = new cli();
		$id  = $_POST['fsId'];
		$msg_log = "修改一条id为".$id."的客户端文件同步任务";
        $cli->setLog($msg_log)->run(getCmd('set'));
        echo json_encode(array('msg' => '修改成功。'));
    } else if ($id = $_POST['delId']) {
        // Delete spec file sync client data
        $cmd = "fs2ctl del task type client id $id";
        $cli = new cli();
		$msg_log = "删除一条id为".$id."的客户端文件同步任务";
        $cli->setLog($msg_log)->run($cmd);
        echo json_encode(array('msg' => '删除成功。'));
    } else if ('add' === $_POST['type']) {
        // Add a new file sync client data
        $cli = new cli();
		$id  = $_POST['clientFileSyncTaskId'];
		$msg_log =  "添加一条id为".$id."的客户端文件同步任务";
        $cli->setLog($msg_log)->run(getCmd('add'));
        echo json_encode(array('msg' => '添加成功。'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Open new file sync dialog
        $tpl    = 'client/fileSync/fileSync_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
			->assign('killVirusIsUsed',$killVirusIsUsed)
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort file sync client table data
        appendFileSyncClientAclData($orderStatement);
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
