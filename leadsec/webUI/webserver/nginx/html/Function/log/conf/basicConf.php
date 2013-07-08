<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getLogSize() {
        $cli = new cli();
        $cmd = 'du -k ' . LOG_PATH;
        $lines = $cli->setGetResult(true)->setIsRec(false)->run($cmd);
        list($size, ) = explode(' ', $lines[0], 2);
        return intval($size);
    }

    if ($_POST['synLogToEnd'] || $_POST['udpPort'] || $_POST['tcpPort'] || 
    	$_POST['logLimitSize']) {
        // modify basic status
        $synLogToEnd  = $_POST['synLogToEnd'] === 'on' ? 'yes':'no';
        $udpPort = $_POST['udpPort'] === 'on' ? 'yes':'no';
     //   $tcpPort = $_POST['tcpPort'] === 'on' ? 'yes':'no';
        $tcpPort = 'no';
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
        
        $result['alert'] = '';
        $alertLimit = intval($result['sizelimit']) - 5;
        if (getLogSize() >= ($alertLimit * 1024)) {
            $result['alert'] = "日志文件容量超过警戒值[{$alertLimit}]MB.";
        }
        V::getInstance()->assign('basic', $result);
    }
?>
