<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (!empty($_POST['stopService'])) {
        // modify service enable
        $status = 0;
        $msg = '设置成功.';
        if ($_POST['stopService'] === 'disable') {
        	$cmd = "ddosctl off";
        	$act="关闭";	
	    } else if ($_POST['stopService'] === 'enable') {
	    	$cmd = "ddosctl on";
	    	$act="开启";	
	    } else {
	    	$status = -1;
	    	$msg = '执行动作错误.';
	    	echo json_encode(array('status' => $status, 'msg' => $msg));
	    	return;
	    }
	    
        $cli = new cli();
       	$cli->setLog("$act抗DDos设置")->run($cmd);
        echo json_encode(array('status' => $status, 'msg' => $msg));
   } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/netgap_system.db');
        $result = $db->query('SELECT ddos_status FROM system')
                     ->getFirstData(PDO::FETCH_ASSOC);        
        V::getInstance()->assign('serviceStatus', $result['ddos_status']);
    }
?>
