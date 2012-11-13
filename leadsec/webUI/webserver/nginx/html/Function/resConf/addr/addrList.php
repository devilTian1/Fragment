<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function iconv_comment(&$result) {
        // Performs a character 
        // set conversion on the string from GB2312 to UTF-8
        foreach ($result as $key => $value) {
            $result[$key]['comment'] =
                iconv("GB2312", "UTF-8", $result[$key]['comment']);
            $result[$key]['name'] =
                iconv("GB2312", "UTF-8", $result[$key]['name']);
        }
    }

    function getHostData() {
        return array($_POST[$_POST['ipType']], $_POST['netmask'], $_POST['comment'],
            $_POST['ipType']);
    }

    function delSpecifiedHost($ip, $netmask) {
        $cmd    = "admhost del ip $ip netmask $netmask";
        $cli    = new cli();
        return $cli->run($cmd);
    }

    if (!empty($_POST['editHostId'])) {
        // get specified admin host data

    } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/rule.db');
        $sql = 'SELECT * FROM address';
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        iconv_comment($result);
        V::getInstance()->assign('addrList', $result);
    }
 
?>
