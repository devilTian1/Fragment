<?php
    if (false) {

    } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $sql = 'SELECT * FROM adminips';
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        // Performs a character 
        // set conversion on the string from GB2312 to UTF-8
        foreach ($result as $key => $value) {
            $str = &$result[$key]['comment'];
            $str = iconv("GB2312", "UTF-8", $str);
        }
        V::getInstance()->assign('hosts', $result);
    }
?>
