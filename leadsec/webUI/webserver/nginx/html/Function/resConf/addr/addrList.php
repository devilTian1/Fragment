<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function iconv_data(&$result) {
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

    function freshAddrList($where) {
        $tpl =  'resConf/addr/addrTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "SELECT * FROM address $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        iconv_data($result);
        echo V::getInstance()->assign('addrList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
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

    $addrTypeArr = array('', 'default', 'range', 'reverse');

    if (!empty($_POST['id'])) {
        // get specified admin host data
        $id  = $_POST['id'];
        $tpl = $_POST['tpl'];
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "SELECT * FROM address WHERE id = '$id'";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        iconv_data($result);
        $result = $result[0];
        $result['type'] = $addrTypeArr[$result['type']];
        $result = V::getInstance()->assign('addr', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_POST['pageNum'])) {
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
        $sql = "SELECT * FROM address $where";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $result = $db->query($sql)->getCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	    ->assign('prev', 1)
	    ->assign('next', 2);
    }
?>
