<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if ($name = $_POST['netname']) {
        // modify system params
        $cmd = 'hostname set hostname "' . $name . '"';
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else {
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query("SELECT hostname FROM hostname")
                     ->getFirstData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('netname', $result['hostname']);
    }
?>
