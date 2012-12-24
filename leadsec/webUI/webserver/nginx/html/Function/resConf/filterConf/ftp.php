<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendFtpFliterOptionsData($where) {
        $tpl =  'resConf/filterConf/ftpTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
	    $sql = 'SELECT name, user_info, cmd_info, virus, comment ' .
            "FROM options $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('ftpFilterOptions', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = 'SELECT id FROM options';
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        return $db->query($sql)->getCount();
    }


    if (!empty($_POST['editId'])) {
        // Get specified addrGroup data
    } else if ('edit' === $_POST['type']) {
        // Edit a specified addr group data
    } else if ('add' === $_POST['type']) {
        // Add a new addr group data
    } else if (!empty($_POST['delName'])) {
        // Delete the specified addrGroup data
    } else if (!empty($_POST['openNewDialog'])) {
        // Display add addr group dialog
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort ftp filtering options list data
        appendFtpFliterOptionsData($orderStatement);
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
