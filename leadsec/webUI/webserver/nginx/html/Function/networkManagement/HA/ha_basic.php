<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
    if (isset($_GET['server'])) {
        if($_POST['work_role']=='M') {
			$role = 'master';
		} else {
			$role = 'slave';
		}

        if($_POST['work_mode']=='P') {
			$mode = 'preempt';
		} else {
			$mode = 'nonpreempt';
		}

		if($_POST['ifcfg']=='D') {
			$ifcfg = 'disable';
		} else {
			$ifcfg = 'enable';
		}

		$ip	   = $_POST['ip'];
		$port  = $_POST['logPortReq'];
        $cmd = "hactl set basic role $role mode $mode ifcfg $ifcfg peerip $ip peerport $port";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '配置成功.'));
    } else {
        // init data
		$db = new dbsqlite(DB_PATH . '/netgap_ha.db');
        $sql = 'SELECT * FROM basic_configure';
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('data', $result[0]);   
    }
?>
