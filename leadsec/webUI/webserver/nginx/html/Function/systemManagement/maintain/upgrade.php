<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

	function freshList($where) {
        $tpl  = 'systemManagement/maintain/upgradeListTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/private.db');
        $sql = "SELECT * FROM upgrade_history $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('upgradeList',$result)->fetch($tpl);
    }
	
    if (!empty($_FILES)) {
        // Upgrade System and then upgrage
        $uploadfs = new fileUpload($_FILES);
        $uploadfs->upload();
        $cmd = "upgrade package \"{$_FILES['file']['name']}\"";
		$msg_log = "系统管理下系统维护模块下的系统更新中的升级文件".$_FILES['upgradeFile']['name'];
        $cli = new cli();
		list($status,$result) = $cli->setLog($msg_log)->execCmdGetStatus($cmd);
		if ($status == 0) {
			echo json_encode(array('msg' => '升级成功。'));
		} else {
			echo json_encode(array('msg' => '升级失败。'));
		}
    } else if (!empty($_GET['reboot'])) {
        // Reboot system
		$msg_log = "系统管理下系统维护模块下对网闸进行重启";
        $cli = new cli();
        $cli->setLog($msg_log)->run('/sbin/reboot');
    } else if ('exportUpgradeHistory' === $_POST['action']) {
        $db = new dbsqlite(DB_PATH . '/private.db');
        $result_list = $db->query("SELECT * FROM  upgrade_history ORDER BY up_time DESC")
            ->getAllData(PDO::FETCH_ASSOC);
		$ua = $_SERVER["HTTP_USER_AGENT"];
		$filename = 'upgrade_history.txt';
        $encoded_filename = urlencode('upgrade_history.txt');
		$encoded_filename = str_replace("+","%20",$encoded_filename);
        header("Content-Type: application/octet-stream; charset=utf-8;");
        header("Content-Disposition: attachment; filename=\"$filename\";");
        header('Pragma: no-cache;');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0;');
		$str_encod_time  = iconv('utf-8','gb2312','下载时间:');
		$str_encod_sernum = iconv('utf-8','gb2312','序号');
		$str_encod_upvision = iconv('utf-8','gb2312','升级以后版本号');
		$str_encod_uptime = iconv('utf-8','gb2312','升级时间');
		$str_encod_comment = iconv('utf-8','gb2312','更新描述');
        if(!empty($result_list)) {
            echo $str_encod_time . date('Y-n-d H:i:s',time()) . "\r\n";
            echo $str_encod_sernum ."\t". $str_encod_upvision . "\t\t" . $str_encod_uptime . "\t\t" . $str_encod_comment . "\r\n";
            foreach($result_list as $val){
				echo $val['id'] . "\t" . $val['up_version'] . "\t\t" . $val['up_time'] . "\t" .
					$val['del_bugs'] . "\r\n";
            }
        } else {
            echo "No Upgrade History Data." ;
        }
        return true;
    } else if ($order = $_POST['orderStatement']) {
		freshList($order);
   
    } else {
		//init date
		$db = new dbsqlite(DB_PATH . '/private.db');
        $sql = 'SELECT * FROM upgrade_history';
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('lastestVersion', $result['up_version']);
	}
?>
