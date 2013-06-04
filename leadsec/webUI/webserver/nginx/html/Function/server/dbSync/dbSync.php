<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');


    function appendDbSyncinformation($where) {
        $tpl =  'server/dbSync/dbSyncTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_db_swap.db');
	    $sql = "SELECT * FROM db_swap_server_acl";
		$params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql,$params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('dataInfo', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

	function getWhereStatement($db, $cols, $keyword) {
        $value  = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' WHERE (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }

    function getDataCount() {
    	$sql = "SELECT id FROM db_swap_server_acl $where";
        $db  = new dbsqlite(DB_PATH . '/netgap_db_swap.db');
		$params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql,$params)->getCount();
    }

	function getCmd($action) {
		//任务号
		if (!empty($_POST['serverDbSyncTaskId'])) {
			$id = intval($_POST['serverDbSyncTaskId']);
		} else {
			$id = intval($_POST['serverDbId']);
		}
		//本机地址
        $sip     = $_POST['serverip'];
		if (validateIpv4Format($_POST['serverip'])) {
			$ipver = 'ipv4';
		} else {
			$ipver = 'ipv6';
		}
		//本机端口
        $sport   = $_POST['serverport'];
        if ($_POST['ssl'] === 'Y') {
		//身份认证及传输加密,若加密则客户端证书有名称
            $ssl   = 'yes';
            $cname = $_POST['commname']; 
        } else {
		//身份认证及传输不加密,若加密则客户端证书无名称
            $ssl   = 'no';
            $cname = '""';
        }
        
		$ac = $_POST['active'] === 'Y' ? 'on' : 'off';
        $comment = $_POST['comment'];
        $result = "dbswapctl $action task type server id $id sip $sip " .
            "sport $sport ssl $ssl commname $cname comment \"$comment\" active $ac ipver $ipver";
        return $result;
    }

    if ($id = ($_POST['editId'])) {
        // Get specified addrGroup data
		$sql  = "SELECT * FROM db_swap_server_acl WHERE id = '$id'";
        $tpl  = 'server/dbSync/dbSync_editDialog.tpl';
        $db   = new dbsqlite(DB_PATH . '/netgap_db_swap.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
		$cli = new cli();
		$msg_log = '服务端数据库同步模块下修改任务'.$_POST['serverDbId'];
        $cli->setLog($msg_log)->run(getCmd('set'));
        echo json_encode(array('msg' => '编辑成功.'));
    } else if ('add' === $_POST['type']) {
		$cli = new cli();
		$msg_log = '服务端数据库同步模块下添加任务'.$_POST['serverDbId'];
        $cli->setLog($msg_log)->run(getCmd('add'));
        echo json_encode(array('msg' => '添加成功.'));	
    } else if ($id = ($_POST['delId'])) {
		$cmd = "dbswapctl del task type server id  $id";
        $cli = new cli();
		$msg_log = '服务端数据库同步模块下删除任务'.$_POST['delId'];
        $cli->setLog($msg_log)->run($cmd);
        echo json_encode(array('msg' => '删除成功.'));	
    } else if (!empty($_POST['openDialog'])) {
        // Display add dbSyncinformation
        $tpl = $_POST['tpl'];
        $result = V::getInstance()
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and dbSyncinformation
        appendDbSyncinformation($orderStatement);
    } else if ($action = $_POST['action']) {
		$id        = $_POST['switch_id'];
		$sip  = $_POST['switch_serverip'];
		$sport     = $_POST['switch_sport'];
		if ($_POST['switch_ssl'] === 'Y') {
			$ssl   = 'yes';
            $cname = $_POST['switch_commname']; 
        } else {
            $ssl   = 'no';
            $cname = '""';
        }
		$comment = $_POST['switch_comment'];
		if (validateIpv4Format($serverip)) {
			$ipver = 'ipv4';
		} else {
			$ipver = 'ipv6';
		}
		$cli = new cli();
		if ($action === 'disable') {
			//停止任务 
			$ac  = 'off';
			$cmd = "dbswapctl set task type server id $id sip $sip " .
            "sport $sport ssl $ssl commname $cname active " .
		    "$ac comment \"$comment\" ipver $ipver";
			$msg_log = '服务端数据库同步模块下停止任务号'.$_POST['switch_id'];
			$cli->setLog($msg_log)->run($cmd);
			echo json_encode(array('msg' => "任务[$id]已停止！"));
		} else if ($action ==='enable'){
			//开启任务
			$ac  = 'on';
			$cmd = "dbswapctl set task type server id $id sip $sip " .
            "sport $sport ssl $ssl commname $cname active " .
		    "$ac comment \"$comment\" ipver $ipver";
			$msg_log = '服务端数据库同步模块下启动任务号'.$_POST['switch_id'];
			$cli->setLog($msg_log)->run($cmd);
			echo json_encode(array('msg' => "任务[$id]已开启！"));
		}
	} else if (!empty($_GET['checkExistId'])) {
		echo netGapRes::getInstance()->checkExistTaskId('dbSync',
            $_GET['serverDbId']);
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
