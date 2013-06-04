<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (isset($_POST['dnssrv'], $_POST['dnssrv2'])) {
        // modify dns ip
        $dnssrv  = $_POST['dnssrv'];
        $dnssrv2 = $_POST['dnssrv2'];
        $cmd = '';
        if ('' === $dnssrv && '' === $dnssrv2) {
        	$cli = new cli();        	
            $cmd = 'dns unset';
            $cli->setLog("将域名服务器IP置空")->run($cmd);
        } else {
        	$cli = new cli();       	
            $cmd = "dns set ip $dnssrv $dnssrv2";
            $cli->setLog("设置域名服务器IP")->run($cmd);
        }
        echo json_encode(array('msg' => '修改成功。'));
    } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query('SELECT dnssrv, dnssrv2 FROM dnssrv')
                     ->getFirstData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('dns', $result);
    }
?>
