<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (isset($_POST['dnssrv'])) {
        // modify dns ip
        $dnssrv=$_POST['dnssrv'];
        $dnssrv2=$_POST['dnssrv2'];
        $cmd="";
        if($dnssrv==''&&$dnssrv2==''){
        	$cmd="dns unset";
        }else {
        	$cmd = "dns set ip $dnssrv $dnssrv2";
        }
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else {
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query("SELECT dnssrv,dnssrv2 FROM dnssrv")
                     ->getFirstData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('dnssrv', $result);
    }
?>
