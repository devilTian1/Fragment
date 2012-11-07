<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getWhereStatement($pageNum, $sortData, $rowsCount) {
        $where  = '';
        $orders = array();
        foreach ($sortData as $k => $v) {
            $orders[] = "$k $v";
        }
        if (count($orders) === 0) {
            $where .= 'ORDER BY id ';
        } else {
            $where .= 'ORDER BY ' . join(',', $orders) . ' ';
        }
        if ($rowsCount !== 'all') {
            $where .= "LIMIT $rowsCount ";
            $where .= 'OFFSET ' . ($rowsCount * ($pageNum-1));
        }
        return $where;
    }


    function appendAddrGroupData($where) {
        $tpl =  'resConf/addr/addrGroupTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/rule.db');
	$sql = "SELECT id, name, comment FROM addrgrp $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
	foreach ($result as $k => $v) {
	    $sql = "select address.name from addrmap INNER JOIN address ".
		"ON addrmap.addrid == address.id where addrmap.addrgrpid={$v['id']}";
            $r = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
	    foreach ($r as $name) {
	    	$result[$k]['addrNames'] .= $name['name'] . '&nbsp;';
	    }
	}
        echo V::getInstance()->assign('addrGroup', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
	$sql = "SELECT id FROM addrgrp";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        return $db->query($sql)->getCount();
    }

    if(false) {

    } else if (!empty($_POST['freshAddrGroup'])) {
        // auto-append addrGroup data
        appendAddrGroupData('ORDER BY id ASC LIMIT 10');
    } else if (!empty($_POST['isResortTable'])) {
        // resort addr-group list
        $pageNum   = $_POST['pageNum'];
        $sortData  = $_POST['sortData'];
        $rowsCount = $_POST['rowsCount'];
        $where = getWhereStatement($pageNum, $sortData, $rowsCount);
        appendAddrGroupData($where);
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
