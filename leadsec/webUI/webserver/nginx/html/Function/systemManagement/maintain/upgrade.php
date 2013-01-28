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
        $cmd = "upgrade package \"{$_FILES['upgradeFile']['name']}\"";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '升级成功'));
    } else if (!empty($_GET['reboot'])) {
        // Reboot system
        $cli = new cli();
        $cli->run('/sbin/reboot');
        echo json_encode(array('msg' => '重启成功'));
    } else if ('exportUpgradeHistory' === $_POST['action']) {
        $db = new dbsqlite(DB_PATH . '/private.db');
        $result_list = $db->query("SELECT * FROM  upgrade_history ORDER BY up_time DESC")
            ->getAllData(PDO::FETCH_ASSOC);
        $filename = urlencode('upgrade_history.txt');
        header("Content-Type: application/octet-stream; charset=utf-8;");
        header("Content-Disposition: attachment; filename=\"$filename\";");
        header('Pragma: no-cache;');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0;');
        if(!empty($result_list)) {
            echo '下载时间: ' . date('Y-n-d H:i:s',time()) .  "\r\n";
            echo "序号\t升级以后版本号\t升级时间 \t\t更新描述\r\n";
            foreach($result_list as $val){
                echo str_pad(substr($val['id'], 0, 5), 5) . "\t" .
                    str_pad(substr($val['up_version'], 0, 10), 10) . "\t" .
                    $val['up_time'] . "\t" . $val['del_bugs'] . "\r\n";
            }
        } else {
            echo "No Upgrade History Data." ;
        }
        return true;
    } else if ($order = $_POST['orderStatement']) {
		freshList($order);
   
    } else {
		
	}
?>
