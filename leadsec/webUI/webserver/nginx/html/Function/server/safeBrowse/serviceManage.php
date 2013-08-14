<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (!empty($_POST['stopService'])) {
        // modify service enable
        //$status = 0;
		$cli = new cli();
        if ($_POST['stopService'] === 'disable') {
        	$cmd = "httpctl server_stop";
        	$activeLog = "关闭安全浏览服务端";
       		$cli->setLog($activeLog)->run($cmd);
			echo json_encode(array('status' =>0, 'msg' =>'服务端停止成功。'));
	    } else if ($_POST['stopService'] === 'enable') {
	    	$cmd = "httpctl server_start";
	    	$activeLog = "开启安全浏览服务端";
			$cli->setLog($activeLog)->run($cmd);
			echo json_encode(array('status' =>0, 'msg' =>'服务端开启成功。'));
	    } 
   } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/netgap_system.db');
        $result = $db->query('SELECT http_server_status FROM system')
                     ->getFirstData(PDO::FETCH_ASSOC);        
        V::getInstance()->assign('httpStatus', $result['http_server_status']);
    }
?>
