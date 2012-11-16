<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function iconv_comment(&$result) {
        // Performs a character 
        // set conversion on the string from GB2312 to UTF-8
        foreach ($result as $key => $value) {
            $result[$key]['comment'] =
                iconv("GB2312", "UTF-8", $result[$key]['comment']);
        }
    }

    function getHostData() {
        return array($_POST['ip'], $_POST['netmask'], $_POST['comment']);
    }

    function delSpecifiedHost($ip, $netmask) {
        $cmd    = "admhost del ip $ip netmask $netmask";
        $cli    = new cli();
        return $cli->run($cmd);
    }

    if (!empty($_POST['editHostId'])) {
        // get specified admin host data
        $hostId = $_POST['editHostId'];
        $tpl    = $_POST['tpl'];
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query("SELECT * FROM adminips WHERE id = '$hostId'")
                     ->getAllData(PDO::FETCH_ASSOC);
        iconv_comment($result);
	    $result = $result[0];
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
        $result = $cli->run($cmd);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // edit specified host
        list($ip, $netmask, $comment) = getHostData();
        delSpecifiedHost($_POST['oldIp'], $_POST['oldNetmask']);
        $cmd = "admhost add ip $ip netmask $netmask comment \"$comment\"";
        $cli = new cli();
        $result = $cli->run($cmd);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_POST['delHostIp'])) {
        // delete a specified host id
        $ip      = $_POST['delHostIp'];
        $netmask = $_POST['delHostNetmask'];
        $msg     = delSpecifiedHost($ip, $netmask);
        echo json_encode(array('msg' => $msg));
    } else if (!empty($_POST['freshHostList'])) {
        $tpl = 'systemManagement/admin/hostTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query('SELECT * FROM adminips')
            ->getAllData(PDO::FETCH_ASSOC);
        iconv_comment($result);
        echo V::getInstance()->assign('hosts', $result)->fetch($tpl);
    } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $sql = 'SELECT * FROM adminips';
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        iconv_comment($result);
        V::getInstance()->assign('hosts', $result);
    }
?>
