<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getHostData() {
        return array($_POST['ip'], $_POST['netmask'], $_POST['comment']);
    }

    function delSpecifiedHost($ip, $netmask) {
        $cmd = "admhost del ip $ip netmask $netmask";
        $cli = new cli();
        $cli->run($cmd);
    }

    if (!empty($_POST['editHostId'])) {
        // get specified admin host data
        $hostId = $_POST['editHostId'];
        $tpl    = $_POST['tpl'];
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query("SELECT * FROM adminips WHERE id = '$hostId'")
                     ->getFirstData(PDO::FETCH_ASSOC);
        if (preg_match("/^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}/",
            $result['ip'])) {
            $ipChecked = 'ipv4';
        } else {
            $ipChecked = 'ipv6';
        }
        $result = V::getInstance()->assign('ip',   $result['ip'])
            ->assign('netmask',   $result['netmask'])
            ->assign('comment',   $result['comment'])
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('add' === $_POST['type']) {
        // add a specified host
        list($ip, $netmask, $comment) = getHostData();
        $cmd = "admhost add ip $ip netmask $netmask comment \"$comment\"";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[$ip]添加成功."));
    } else if ('edit' === $_POST['type']) {
        // edit specified host
        list($ip, $netmask, $comment) = getHostData();
        delSpecifiedHost($_POST['oldIp'], $_POST['oldNetmask']);
        $cmd = "admhost add ip $ip netmask $netmask comment \"$comment\"";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[{$_POST['oldIp']}]修改成功."));
    } else if (!empty($_POST['delHostIp'])) {
        // delete a specified host id
        $ip      = $_POST['delHostIp'];
        $netmask = $_POST['delHostNetmask'];
        delSpecifiedHost($ip, $netmask);
        echo json_encode(array('msg' => "[$ip]删除成功."));
    } else if (!empty($_POST['freshHostList'])) {
        $tpl = 'systemManagement/admin/hostTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query('SELECT * FROM adminips')
            ->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('hosts', $result)->fetch($tpl);
    } else {
        // init page data
    }
?>
