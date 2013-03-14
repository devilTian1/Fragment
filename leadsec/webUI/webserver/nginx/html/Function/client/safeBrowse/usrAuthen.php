<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (isset($_POST['usrAuthenChk'])) {
        // modify dns ip
        $usrAuthenChk  = $_POST['usrAuthenChk'];
        $cmd = "httpctl set authmode $usrAuthenChk";
        $cli = new cli();
        $cli->run($cmd);
        $cli->run("httpctl	reconfigure");
        echo json_encode(array('msg' => '修改成功.'));
    } else if (isset($_GET['radius'])) {
    	$sip = $_POST['radiusSIp'];
    	$port = $_POST['radiusPort'];
    	$key = $_POST['sharedKey'];
    	$cmd = "httpctl	set	radius ip \"$sip\" port \"$port\" passwd \"$key\"";
    	$cli = new cli();
        $cli->run($cmd);
        $cli->run("httpctl	reconfigure");
        echo json_encode(array('msg' => '修改成功.'));
    } else if (isset($_GET['ldap'])) {
    	$sip = $_POST['ldapSIp'];
    	$dn = $_POST['ldapDN'];
    	$attr = $_POST['searchProperty'];
    	$opt = $_POST['branchSearch'] === "on" ? "on" : "off";
    	$cmd = "httpctl	set	ldap ip	$sip dn \"$dn\" attr \"$attr\" opt $opt";
    	$cli = new cli();
        $cli->run($cmd);
        $cli->run("httpctl	reconfigure");
        echo json_encode(array('msg' => '修改成功.'));
    } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/netgap_http.db');
        $result = $db->query('SELECT * FROM auth_info')
                     ->getFirstData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('usrAuthen', $result);
    }
?>
