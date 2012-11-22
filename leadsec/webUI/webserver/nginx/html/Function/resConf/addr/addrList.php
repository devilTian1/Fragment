<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshAddrList($where) {
        $tpl =  'resConf/addr/addrTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "SELECT * FROM address $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('addrList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function composeIp() {
        $ipType  = $_POST['addrType'];
        if ($ipType === 'reverse') {
            $ip = $_POST['ipAddr_r'] . '~' . $_POST['netmask_r'];
        } else if ($ipType === 'range') {
            $ip = $_POST['range_s'] . '-' . $_POST['range_e'];
        } else { //default
            $ip = $_POST['ip'] . '/' . $_POST['netmask_default'];
        }
        return $ip;
    }

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

    function getDataCount() {
        $sql = "SELECT id FROM address";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        return $db->query($sql)->getCount();
    }

    $addrTypeArr = array('', 'default', 'range', 'reverse');

    if (!empty($_POST['id'])) {
        // Get specified addrlist data
        $id  = $_POST['id'];
        $tpl = $_POST['tpl'];
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "SELECT * FROM address WHERE id = '$id'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result['type'] = $addrTypeArr[$result['type']];
        $result = V::getInstance()->assign('addr', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('add' === $_POST['type']) {
        // Add new ipAddr
        $name    = $_POST['addrName'];
        $ip      = composeIp();
        $comment = $_POST['comment'];
        $cmd     = "address add name \"$name\" ip $ip comment \"$comment\"";
        $cli    = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[$ip]添加成功."));
    } else if ('edit' === $_POST['type']) {
        // Edit the specified ipAddr
        $name    = $_POST['addrName'];
        $ip      = composeIp();
        $comment = $_POST['comment'];
        $cmd = "address set name \"$name\" ip $ip comment \"$comment\"";
        $cli    = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[$ip]修改成功."));
    } else if (!empty($_POST['delName'])) {
        // Delete the specified ipAddr
        $name = $_POST['delName'];
        $cmd  = "address del name \"$name\"";
        $cli  = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[$name]删除成功."));
    } else if (!empty($_POST['isResortTable'])) {
        // resort addr-list
        $pageNum   = $_POST['pageNum'];
        $sortData  = $_POST['sortData'];
        $rowsCount = $_POST['rowsCount'];
        $where = getWhereStatement($pageNum, $sortData, $rowsCount);
        freshAddrList($where);
    } else if (!empty($_POST['freshAddrList'])) {
        // auto-load addrlist
        freshAddrList('ORDER BY id ASC LIMIT 10');
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
