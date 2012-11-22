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

    function getAllAddrList() {
        $addrListArr = array();
        $sql = "SELECT name FROM address";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $k => $v) {
            $addrListArr[] = $v['name'];
        }
        return $addrListArr;
    }

    function getSpecAddrListName($id) {
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "select address.name from addrmap INNER JOIN address ".
            "ON addrmap.addrid == address.id where addrmap.addrgrpid=$id";
        return $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    }

    function appendAddrGroupData($where) {
        $tpl =  'resConf/addr/addrGroupTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/rule.db');
	    $sql = "SELECT id, name, comment FROM addrgrp $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $k => $v) {
            $r = getSpecAddrListName($v['id']);
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

    function getAddOrEditData() {
        $name    = $_POST['addrGrpName'];
        $comment = $_POST['comment'];
        $mbrArr  = $_POST['addrGrpMember'];
        $addmbr  = join('" "', $mbrArr);
        return array($name, $comment, $addmbr);
    }

    if (!empty($_POST['editId'])) {
        // Get specified addrGroup data
        $tpl = $_POST['tpl'];
        $id  = $_POST['editId'];

        $r   = getSpecAddrListName($id);
        $addrGrpMemberArr = array();
        foreach ($r as $row) {
            $addrGrpMemberArr[] = $row['name'];
        }
        $addrListArr = getAllAddrList();
        $addrListArr = array_diff($addrListArr, $addrGrpMemberArr);

        $db  = new dbsqlite(DB_PATH . '/rule.db');
	    $sql = "SELECT name, comment FROM addrgrp WHERE id = $id";
        $addrGroup = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()->assign('addrListArr', $addrListArr)
            ->assign('addrGrpMemberArr', $addrGrpMemberArr)
            ->assign('addrGroup', $addrGroup)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified addr group data
        list($name, $comment, $addmbr) = getAddOrEditData();
        $cmd1 = "addrgrp set name \"$name\" comment \"$comment\"";
        $cmd2 = "addrgrp set name \"$name\" delallmbr";
        $cmd3 = "addrgrp set name \"$name\" addmbr \"$addmbr\"";
        $cli  = new cli();
        $cli->run($cmd1);
        $cli->run($cmd2);
        $cli->run($cmd3);
        echo json_encode(array('msg' => "[$name]修改成功."));
    } else if ('add' === $_POST['type']) {
        // Add a new addr group data
        list($name, $comment, $addmbr) = getAddOrEditData();
        $cmd1 = "addrgrp add name \"$name\" comment \"$comment\"";
        $cmd2 = "addrgrp set name \"$name\" addmbr \"$addmbr\"";
        $cli  = new cli();
        $cli->run($cmd1);
        $cli->run($cmd2);
        echo json_encode(array('msg' => "[$name]添加成功."));
    } else if (!empty($_POST['delName'])) {
        // Delete the specified addrGroup data
        $name = $_POST['delName'];
        $cmd  = "addrgrp del name \"$name\"";
        $cli  = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[$name]删除成功."));
    } else if (!empty($_POST['openAddAddrGrpDialog'])) {
        // Display add addr group dialog
        $tpl = $_POST['tpl'];
        $addrListArr = getAllAddrList();
        $result = V::getInstance()->assign('addrListArr', $addrListArr)
            ->assign('addrGrpMemberArr', array())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
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
