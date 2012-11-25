<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

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
	    $sql = "SELECT * FROM domain_property
            WHERE id = '$id'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()->assign('realmAddr', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($orderStatement = $_POST['isResortTable']) {
        // fresh and resort realm addr table
        appendRealmAddrData($orderStatement);
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
