<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (isset($_POST['usrAuthenChk'])) {
        // modify dns ip
        $usrAuthenChk  = $_POST['usrAuthenChk'];
        $cmd = "httpctl set authmode $usrAuthenChk";
        $cli = new cli();
        $cli->setLog("设置用户认证方式为{$usrAuthenChk}")->run($cmd);
        $cli->setLog("修改安全浏览配置")->run("httpctl	reconfigure");
        echo json_encode(array('msg' => '修改成功。'));
    } else if (isset($_GET['radius'])) {
    	$sip = $_POST['radiusSIp'];
    	$port = $_POST['radiusPort'];
    	$key = $_POST['sharedKey'];
    	$cmd = "httpctl	set	radius ip \"$sip\" port \"$port\" passwd \"$key\"";
    	$cli = new cli();
        $cli->setLog("Radius配置:服务器IP为{$sip}，端口为{$port}，共享密钥为{$key}")->run($cmd);
        $cli->setLog("修改安全浏览配置")->run("httpctl	reconfigure");
        echo json_encode(array('msg' => '修改成功。'));
    } else if (isset($_GET['ldap'])) {
    	$sip = $_POST['ldapSIp'];
    	$dn = $_POST['ldapDN'];
    	$attr = $_POST['searchProperty'];
    	$opt = $_POST['branchSearch'] === "on" ? "on" : "off";
    	$cmd = "httpctl	set	ldap ip	$sip dn \"$dn\" attr \"$attr\" opt $opt";
    	$cli = new cli();
        $cli->setLog("LDAP配置:LDAP服务器地址为{$sip}，LDAP DN为{$dn}")->run($cmd);
        $cli->setLog("修改安全浏览配置")->run("httpctl	reconfigure");
        echo json_encode(array('msg' => '修改成功。'));
    } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/netgap_http.db');
        $result = $db->query('SELECT * FROM auth_info')
                     ->getFirstData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('usrAuthen', $result);
    }
?>
