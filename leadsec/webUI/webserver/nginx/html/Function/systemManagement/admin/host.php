<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (!empty($_POST['editHostId'])) {
        // get specified admin host data
        $hostId = $_POST['editHostId'];
        $tpl    = $_POST['tpl'];
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query("SELECT * FROM adminips WHERE id = '$hostId'")
                     ->getAllData(PDO::FETCH_ASSOC);
        iconv_comment($result);
	$result = $result[0];
        $result = V::getInstance()->assign('ip',   $result['ip'])
            ->assign('netmask',  $result['netmask'])
            ->assign('comment', $result['comment'])
            ->assign('ipChecked', 'ipv6')
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $sql = 'SELECT * FROM adminips';
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        iconv_comment($result);
        V::getInstance()->assign('hosts', $result);
    }
    function iconv_comment(&$result) {
        // Performs a character 
        // set conversion on the string from GB2312 to UTF-8
        foreach ($result as $key => $value) {
            $result[$key]['comment'] =
                iconv("GB2312", "UTF-8", $result[$key]['comment']);
        }
    }
?>
