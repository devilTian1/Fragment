<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (!empty($_POST['stopService'])) {
        // modify service enable
        $status = 0;
        $msg = '设置成功.';
        if ($_POST['stopService'] === 'disable') {
        	$cmd = "avctl stop";
        	$engineLog = "停止";
	    } else if ($_POST['stopService'] === 'enable') {
	    	$cmd = "avctl start";
	    	$engineLog = "启动";
	    } else {
	    	$status = -1;
	    	$msg = '执行动作错误.';
	    	echo json_encode(array('status' => $status, 'msg' => $msg));
	    	return;
	    }
	    
        $cli = new cli();
       	$cli->setLog($engineLog."引擎管理服务")->run($cmd);
        echo json_encode(array('status' => $status, 'msg' => $msg));
   } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/netgap_av.db');
        $result = $db->query('SELECT service_status FROM av_basic')
                     ->getFirstData(PDO::FETCH_ASSOC);        
        V::getInstance()->assign('serviceStatus', $result['service_status']);
    }
?>
