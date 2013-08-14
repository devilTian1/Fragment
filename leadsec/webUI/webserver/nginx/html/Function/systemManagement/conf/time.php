<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

	function getTimeStr($str) {
		$pos = strpos($str,':');
		$result = substr($str,$pos+1);
		return $result;
	}

    if ($localTime = $_POST['localTime']) {
        // set server time to localtime
		$cli = new cli();
		$localTime = $_POST['localTime'];
        $cmd = "clock set $localTime";
		$msg_log = '系统管理模块系统维护下的时间同步';
        $cli->setLog($msg_log)->run($cmd);
		$servertime = time();
		V::getInstance()->assign('servertime',$servertime);
		//echo json_encode(array('msg' =>$servertime));
        echo json_encode(array('msg' => '时间同步成功。'));
    } else if (!empty($_POST['syncTime'])) {
        // sync time immediately
        $cmd = 'ntp sync';
		$msg_log = '系统管理模块系统维护下的同步时钟服务器';
        $cli = new cli();
        list($status, $lines) = $cli->setLog($msg_log)->execCmdGetStatus($cmd);
        if ($status == 2) {
            $msg = 'NTP服务器没有被配置。';
        } else if ($status == 0) {
            $msg = '同步成功。';
        } else {
            $msg = join('<br/>', $lines);
        }
        echo json_encode(array('status'=>$status,'msg' =>$msg));
    } else if ($_POST['switchNTP'] === 'on') {
        // sync ntp server
        $ip = $_POST['ip'];
        $interval = $_POST['ntpSyncInterval'];
        $cmd1 = 'ntp off';
        $cmd2 = "ntp set ip $ip interval $interval";
		$msg_log2 = '系统管理模块系统维护下的设置同步时钟服务器'.$ip;
        $cmd3 = 'ntp on';
        $cli = new cli();
        $cli->run($cmd1);
        $cli->setLog($msg_log2)->run($cmd2);
        $cli->run($cmd3);
        echo json_encode(array('msg' => '同步成功。'));
    } else if (!empty($_GET['c'])) {
        // disable NTP server
        $cmd = 'ntp off';
        $cli = new cli();
		$msg_log = '系统管理模块系统维护下的同步时钟服务器取消';
        $cli->setLog($msg_log)->run($cmd);
        echo json_encode(array('msg' => '取消时间同步成功！'));
    } else {
		//init page
		$cli = new cli();
		$cmd = 'ntp show';
		// get server timestamp for current now 
		$servertime = time();
		$return = $cli->setGetResult(true)->run($cmd);
		$str = strtolower($return[2]);
		if (false !== strpos($str,'enable')) {
			if (false !== strpos($str,'on')) {
				$nip_set_type = 'on';
			} else {
				$nip_set_type = 'off';
			}
			$arr_ntp = preg_split("/[\s,]+/",$return[3]);
			$nip = $arr_ntp[2];
			$arr_interval = preg_split("/[\s,]+/",$return[4]);
			$interval = $arr_interval[2];
		} 
		V::getInstance()->assign('nip',$nip)
			->assign('servertime',$servertime)
			->assign('interval',$interval)
			->assign('type',$nip_set_type);
    }
?>
