<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (!empty($_POST['stopService'])) {
        // modify service enable
        //$status = 0;
		$cli = new cli();
        if ($_POST['stopService'] === 'disable') {
        	$cmd = "avctl stop";
			$msg_log = '停止引擎管理服务';
			list($status,$result) = $cli->setLog($msg_log)->execCmdGetStatus($cmd);
			if ($status > 0) {
				echo json_encode(array('status'=>$status,'msg' => '停止引擎管理服务失败!'));
			} else {
				echo json_encode(array('status'=>$status,'msg' => '停止引擎管理服务成功!'));
			}
	    } else if ($_POST['stopService'] === 'enable') {
	    	$cmd = "avctl start";
	    	$msg_log = '启动引擎管理服务';
			list($status,$result) = $cli->setLog($msg_log)->execCmdGetStatus($cmd);
			if ($status > 0) {
				echo json_encode(array('status'=>$status,'msg' => '启动引擎管理服务失败!'));
			} else {
				echo json_encode(array('status'=>$status,'msg' => '启动引擎管理服务成功!'));
			}
	    } 
   } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/netgap_av.db');
        $result = $db->query('SELECT service_status FROM av_basic')
                     ->getFirstData(PDO::FETCH_ASSOC);        
        V::getInstance()->assign('serviceStatus', $result['service_status']);
    }
?>
