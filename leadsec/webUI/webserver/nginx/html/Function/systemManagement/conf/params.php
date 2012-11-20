<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if ($name = $_POST['netname']) {
        // modify system params
        $cmd = 'set someting like name = ' . $name;
        $cli = new cli();
        //$cli->run($cmd);
        echo json_encode(array('msg' => $cmd . '修改成功'));
    }
?>
