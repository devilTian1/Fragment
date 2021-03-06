<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if ('1' === $_GET['s']) {
        // start/stop service
        $cli = new cli();
        if ('on' === $_POST['switch']) {
        	$cli->setLog('网络管理的基本配置启用')->run('lvsctl start');
            $msg = '服务已启动。';
        } else {
            // stop start
            $cli->setLog('网络管理的基本配置停止')->run('lvsctl stop');
            $msg = '服务已停止。';
        }
        echo json_encode(array('status'=>0,'msg' => $msg));
    } else if ('1' === $_GET['r']) {
        time();
        $cli = new cli();
        // modify role of lvs
        if ('D' === $_POST['role']) {//schedule
            $r = 'director';
        } else { //node
            $r = 'node';
        }
        $cli->setLog('修改网络管理的基本配置:'.$r)->run("lvsctl set basic role $r");
        echo json_encode(array('msg' => '修改成功。'));
    } else {
        // init page data
        $cli     = new cli();
        $return  = $cli->setLog('查看负载均衡状态')->setGetResult(true)->run('lvsctl status');
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
