<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
    if ($localTime = $_POST['localTime']) {
        $cmd = "clock set $localTime";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else {

    }
?>
