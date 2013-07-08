<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    if ($_POST['type'] === 'set') {
        $s = 'on' === $_POST['ssh'] ? 'on' : 'off';
        $cmds = array("admmode $s ssh", "admmode off ppp");
        $cli  = new cli();
        foreach ($cmds as $cmd) {
            $cli->run($cmd);
        }
        echo json_encode(array('msg' => '设置成功。'));
    } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query('SELECT * FROM admin_style')
            ->getFirstData(PDO::FETCH_ASSOC);
        $isSSH  = $result['use_ssh'] === '1' ? 'checked="checked"' : '';
        V::getInstance()->assign('isSSH', $isSSH);
    }
?>
