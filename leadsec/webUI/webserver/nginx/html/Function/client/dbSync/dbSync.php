<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');


    function appendDbSyncinformation($where) {
        $tpl =  'client/dbSync/dbSyncTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_db_swap.db');
	    $sql = "SELECT * FROM db_swap_client_acl $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        	foreach ($result as $key => $arr) {
        	$result[$key]['sa'] = addrNameDelPreffix($arr['sa']);
        }
        echo V::getInstance()->assign('dataInfo', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT id FROM db_swap_client_acl $where";
        $db  = new dbsqlite(DB_PATH . '/netgap_db_swap.db');
        return $db->query($sql)->getCount();
    }

	function getCmd($action) {
		//任务号
        $id = $_POST['fsId'];
		//源地址
		$sa = $_POST['sa'];
		//ip类型
		$ipver   = $_POST['ipType'];
		//本机地址
        $lip     = $_POST['fslip'];
		//本机端口
        $lport   = $_POST['fslportReq'];
        if ($_POST['ssl'] === 'Y') {
		//身份认证及传输加密,若加密则客户端证书有名称
            $ssl   = 'yes';
            $cname = $_POST['commname']; 
        } else {
		//身份认证及传输不加密,若加密则客户端证书无名称
            $ssl   = 'no';
            $cname = '""';
        }
        //$kv      = $_POST['killVirus'] === 'Y' ? 'yes' : 'no';
		$kv = $_POST['killVirus'] ; 
		$ac = $_POST['active'] === 'Y' ? 'on' : 'off';
        $comment = $_POST['comment'];
        $time    = $_POST['time'];
        $result = "dbswapctl $action task type client id $id sa $sa lip $lip " .
            "lport $lport ssl $ssl commname $cname killvirus $kv active " .
		    "$ac comment \"$comment\" ipver $ipver 1>/dev/null";
        return $result;
    }

    function addrNameDelPreffix($name) {
    	// 去掉最后一个下划线_ipv4或_ipv6
    	return substr($name,0,-5);    	
    }
    
    if ($id = ($_POST['editId'])) {
        // Get specified addrGroup data
		$sql  = "SELECT * FROM db_swap_client_acl WHERE id = '$id'";
        $tpl  = 'client/dbSync/dbSync_editDialog.tpl';
        $db   = new dbsqlite(DB_PATH . '/netgap_db_swap.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr())
            ->assign('ifList', netGapRes::getInstance()->getInterface())
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
		$cli = new cli();
        $cli->run(getCmd('set'));
        echo json_encode(array('msg' => '编辑成功.'));
    } else if ('add' === $_POST['type']) {
		$cli = new cli();
        $cli->run(getCmd('add'));
        echo json_encode(array('msg' => '添加成功.'));	
    } else if ($id = ($_POST['delId'])) {
		$cmd = "dbswapctl del task type client id  $id";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '删除成功.'));	
    } else if (!empty($_POST['openDialog'])) {
        // Display add dbSyncinformation
        $tpl = $_POST['tpl'];
        $result = V::getInstance()
			->assign('addrOptions', netGapRes::getInstance()->getAddr())
			->assign('ifList', netGapRes::getInstance()->getInterface())
			->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and dbSyncinformation
        appendDbSyncinformation($orderStatement);
    } else if ($action = $_POST['action']) { 
		$id   = $_POST['switch_id'];
		$sa   = $_POST['switch_sa'];
		$lip  = $_POST['switch_lip'];
		$lport= $_POST['switch_lport'];
		if ($_POST['switch_ssl'] === 'Y') {
			$ssl   = 'yes';
            $cname = $_POST['switch_commname']; 
        } else {
            $ssl   = 'no';
            $cname = '""';
        }
		$time = $_POST['switch_time'];
		$kv = $_POST['switch_killvirus'];
		$comment = $POST['switch_comment'];
		if (validateIpv4Format($lip)) {
			$ipver = 'ipv4';
		} else {
			$ipver = 'ipv6';
		}
		$cli = new cli();
		if ($action === 'disable') {
			//停止任务
			$ac  = 'off';
			$cmd = "dbswapctl set task type client id $id sa $sa lip $lip " .
            "lport $lport ssl $ssl commname $cname killvirus $kv active " .
		    "$ac comment \"$comment\" ipver $ipver 1>/dev/null";
			$cli->run($cmd);
			echo json_encode(array('msg' => "任务[$id]已停止！"));
		} else if ($action ==='enable'){
			//开启任务
			$ac  = 'on';
			$cmd = "dbswapctl set task type client id $id sa $sa lip $lip " .
            "lport $lport ssl $ssl commname $cname killvirus $kv active " .
		    "$ac comment \"$comment\" ipver $ipver 1>/dev/null";
			$cli->run($cmd);
			echo json_encode(array('msg' => "任务[$id]已开启！"));
		}
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
