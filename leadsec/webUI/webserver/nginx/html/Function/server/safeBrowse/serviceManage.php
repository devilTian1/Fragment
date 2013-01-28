<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (!empty($_POST['stopService'])) {
        // modify service enable
        $status = 0;
        $msg = '设置成功.';
        if ($_POST['stopService'] === 'disable') {
        	$cmd = "httpctl server_stop";
	    } else if ($_POST['stopService'] === 'enable') {
	    	$cmd = "httpctl server_start";
	    } else {
	    	$status = -1;
	    	$msg = '执行动作错误.';
	    	echo json_encode(array('status' => $status, 'msg' => $msg));
	    	return;
	    }
	    
        $cli = new cli();
       	$cli->run($cmd);
        echo json_encode(array('status' => $status, 'msg' => $msg));
   } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/netgap_system.db');
        $result = $db->query('SELECT http_server_status FROM system')
                     ->getFirstData(PDO::FETCH_ASSOC);        
        V::getInstance()->assign('httpStatus', $result['http_server_status']);
    }
?>
