<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    if ($action = $_POST['action']) {
        // Switch Service    
        $name = $_POST['switch_name'];
        if ($action === 'disable') {
            $cmd = "cftpctl stop";
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('msg' => "[$name]已关闭."));
        } else if ($action === 'enable') {
            $cmd = "cftpctl start";
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('msg' => "[$name]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }else {
        // init page data
        $db  = new dbsqlite(DB_PATH . '/netgap_system.db');
        $sql = "SELECT ftp_status FROM system";
        $result = $db->query($sql)
                  ->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $row) {
        	$ftp=$row['ftp_status'];
        }
        V::getInstance()->assign('ftp', $ftp);     
    }
?>
