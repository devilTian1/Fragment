<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
    if ($localTime = $_POST['localTime']) {
        // set server time to localtime
        $cmd = "clock set $localTime";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else if (!empty($_POST['syncTime'])) {
        // sync time immediately
        $cmd = 'ntp sync';
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '同步成功.'));
    } else if ($_POST['switchNTP'] === 'on') {
        // sync ntp server
        $ip = $_POST['ip'];
        $interval = $_POST['ntpSyncInterval'];
        $cmd1 = 'ntp off';
        $cmd2 = "ntp set ip $ip interval $interval";
        $cmd3 = 'ntp on';
        $cli = new cli();
        $cli->run($cmd1);
        $cli->run($cmd2);
        $cli->run($cmd3);
        echo json_encode(array('msg' => '同步成功.'));
    } else if (!empty($_GET['c'])) {
        // disable NTP server
        $cmd = 'ntp off';
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '同步成功.'));
    } else {

    }
?>
