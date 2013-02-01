<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getDataCount() {
        $sql = 'SELECT * FROM service';
        $db  = new dbsqlite(DB_PATH . '/netgap_ha.db');
        return $db->query($sql)->getCount();
    }    

    if (false) {
    } else {
        // init page data
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
