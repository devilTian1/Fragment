<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if ($_POST['synLogToEnd'] || $_POST['udpPort'] || $_POST['tcpPort'] || 
    	$_POST['logLimitSize']) {
        // modify basic status
        $synLogToEnd  = $_POST['synLogToEnd'] === 'on' ? 'yes':'no';
        $udpPort = $_POST['udpPort'] === 'on' ? 'yes':'no';
        $tcpPort = $_POST['tcpPort'] === 'on' ? 'yes':'no';
        $logLimitSize = $_POST['logLimitSize'];
        $cmd = "/usr/local/bin/logserver set basic sendother $synLogToEnd ".
        	"tcpenable $tcpPort udpenable $udpPort sizelimit $logLimitSize";
        $cli = new cli();
        $cli->setLog("修改日志配置的基本配置")->run($cmd);
        echo json_encode(array('msg' => '修改成功。'));
    } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query('SELECT sendother,tcp_enable,udp_enable,sizelimit FROM log_basic')
                     ->getFirstData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('basic', $result);
    }
?>
