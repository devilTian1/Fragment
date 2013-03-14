<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if ('1' === $_GET['s']) {
        // start/stop service
        $cli = new cli();
        if ('on' === $_POST['switch']) {
            $cli->run('lvsctl start 1>/dev/null');
            $msg = '服务已启动.';
        } else {
            // stop start
            $cli->run('lvsctl stop');
            $msg = '服务已停止.';
        }
        echo json_encode(array('msg' => $msg));
    } else if ('1' === $_GET['r']) {
        time();
        $cli = new cli();
        // modify role of lvs
        if ('D' === $_POST['role']) {//schedule
            $r = 'director';
        } else { //node
            $r = 'node';
        }
        $cli->run("lvsctl set basic role $r 1>/dev/null");
        echo json_encode(array('msg' => '修改成功.'));
    } else {
        // init page data
        $cli     = new cli();
        $return  = $cli->run('lvsctl status');
        $str     = strtolower($return[0]);
        if (false !== strpos($str, 'stop')) {
            $switch = 'off';
        } else if (false !== strpos($str, 'start')) {
            $switch = 'on';
        } else {
            throw new Exception('Can`t detect the status of lvs service.');
        }
        $db   = new dbsqlite(DB_PATH . '/netgap_ha.db');
        $data = $db->query('SELECT role FROM lvs_basic')
            ->getFirstData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('role', $data['role'])
            ->assign('status', $switch);
    }
?>
