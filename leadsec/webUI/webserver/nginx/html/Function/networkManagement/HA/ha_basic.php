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

		$ip	   = $_POST['ha_ip'];
		$port  = $_POST['logPortReq'];
		$time  = $_POST['haTime'];
        $cmd = "hactl set basic role $role mode $mode ifcfg $ifcfg peerip $ip peerport $port". 
			" interval $time";
        $cli = new cli();
		$msg_log = '网络管理模块下对双机热备进行基本配置';
        $cli->setLog($msg_log)->run($cmd);
        echo json_encode(array('msg' => '配置成功。'));
    } else if (isset($_GET['reconf'])) {
		// start/stop service
        $cli = new cli();
		$path = "/usr/local/bin/";
        if ('on' === $_POST['switch']) {
			$msg_log = '网络管理模块下启动双机热备服务';
			list($status,$result) = $cli->setLog($msg_log)
				->execCmdGetStatus($path.'hactl start 1>/dev/null');
			if ($status > 0) {
				echo json_encode(array('status'=>$status,'msg' => '服务启动失败!请确认配置是否正确。'));
			} else {
				echo json_encode(array('status'=>$status,'msg' => '服务启动成功!'));
			}
        } else {
            // stop start
			$msg_log = '网络管理模块下停止双机热备服务';
			list($status,$result) = $cli->setLog($msg_log)
				->execCmdGetStatus($path.'hactl stop 1>/dev/null');
			if ($status > 0) {
				echo json_encode(array('status'=>$status,'msg' => '服务停止失败!'));
			} else {
				echo json_encode(array('status'=>$status,'msg' => '服务已停止!'));
			}
        }
	} else {
        // init data
		$cli     = new cli();
        $return  = $cli->setGetResult(true)->setLog('获取双机热备服务状态')
            ->run('hactl status');
        $str     = strtolower($return[0]);
        if (false !== strpos($str, 'stop')) {
            $switch = 'off';
        } else if (false !== strpos($str, 'start')) {
            $switch = 'on';
        } else {
            throw new Exception('Can`t detect the status of lvs service.');
        }
		$db = new dbsqlite(DB_PATH . '/netgap_ha.db');
        $sql = 'SELECT * FROM basic_configure';
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('data', $result[0])
			 ->assign('status', $switch);
    }
?>
