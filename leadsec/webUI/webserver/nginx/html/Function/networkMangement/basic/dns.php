<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (isset($_POST['dnssrv']) && isset($_POST['dnssrv2'])) {
        // modify dns ip
        $dnssrv=trim($_POST['dnssrv']);
        $dnssrv2=trim($_POST['dnssrv2']);
        $cmd="";
        if(empty($dnssrv) && !empty($dnssrv2))
        {
        	echo json_encode(array('msg' => 'Error:域名服务器IP1不能为空.'));
        }
        else {
        	if($dnssrv==''&& $dnssrv2==''){
        	$cmd="dns unset";        
	        }else {
	        	$cmd = "dns set ip $dnssrv $dnssrv2";
	        }
	        $cli = new cli();
	        $cli->run($cmd);
	        echo json_encode(array('msg' => '修改成功.'));
        }
        
    } else {
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query("SELECT dnssrv,dnssrv2 FROM dnssrv")
                     ->getFirstData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('dnssrv', $result);
    }
?>
