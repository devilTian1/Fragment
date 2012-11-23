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

    function getIpList($name) {
        $db  = new dbsqlite(DB_PATH . '/domain.db');
        $sql = "SELECT dynamic, ip FROM domain_ip WHERE name = '$name'";
        return $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    }

    function appendRealmAddrData($where) {
        $tpl =  'resConf/addr/realmAddrTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/rule.db');
	    $sql = "SELECT id, name, domain, primary_dns, slave_dns".
            " FROM domain_property $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $k => $v) {
            $r = getIpList($v['name']);
            foreach ($r as $dip) {
                if ($dip['dynamic'] === '1') {
                    $result[$k]['dynamicIpList'] .= $dip['ip'] . '<br/>';
                } else if ($dip['dynamic'] === '0') {
                    $result[$k]['staticIpList'] .= $dip['ip'] . '<br/>';
                } else {
                    $result[$k]['dynamicIpList'] = 'Empty';
                    $result[$k]['staticIpList']  = 'Empty';
                    break 2;
                }
            }
	    }
        echo V::getInstance()->assign('realmAddr', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $sql = "SELECT id FROM domain_property";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $result = $db->query($sql)->getCount();
        return $result;
    }

    if (!empty($_POST['editId'])) {
        // Get specified realmAddr data
        $tpl = $_POST['tpl'];
        $id  = $_POST['editId'];
        $db  = new dbsqlite(DB_PATH . '/rule.db');
	    $sql = "SELECT name, domain, auto_resolve, primary_dns, slave_dns, ".
            " FROM domain_property WHERE id = '$id'";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);



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

    } else if (!empty($_POST['freshRealmAddr'])) {
        // auto-append realmAddr data
        appendRealmAddrData('ORDER BY id ASC LIMIT 10');
    } else if (!empty($_POST['isResortTable'])) {
        // resort realm addr list
        $pageNum   = $_POST['pageNum'];
        $sortData  = $_POST['sortData'];
        $rowsCount = $_POST['rowsCount'];
        $where = getWhereStatement($pageNum, $sortData, $rowsCount);
        appendRealmAddrData($where);
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
