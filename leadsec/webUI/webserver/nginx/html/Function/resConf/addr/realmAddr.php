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
                    $result[$k]['dynamicIpList'] = $dip['ip'] . '<br/>';
                } else if ($dip['dynamic'] === '0') {
                    $result[$k]['staticIpList'] = $dip['ip'] . '<br/>';
                } else {
                    $result[$k]['dynamicIpList'] = 'empty';
                    $result[$k]['staticIpList']  = 'empty';
                    break 2;
                }
            }
	    }
        echo V::getInstance()->assign('realmAddr', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getAddOrEditCmd($type) {
        $name        = $_POST['addrName'];
        $domain      = $_POST['domainName'] === '' ? 'none' : $_POST['domainName'];
        $autoResolve = $_POST['auto_resolve'] === 'on' ? 'on' : 'off';
        $primaryDns  = $_POST['primaryDns'] === '' ? 'none' : $_POST['primaryDns'];
        $slaveDns    = $_POST['slaveDns'] === '' ? 'none' : $_POST['slaveDns'];
        $recordType  = 'a';
        if ($_POST['record_type_a'] === 'A') {
            if ($_POST['record_type_mx'] === 'MX') {
                $recordType = 'all';
            }
        } else if ($_POST['record_type_mx'] === 'MX') {
            $recordType = 'mx';
        } else {
            $recordType = '';
        }
        $maxRecord = $_POST['max_record'];
        $interval  = $_POST['interval'];
        $expire    = $_POST['autoParseErrInterval'];
        $ipType    = ''; //static/dynamic
        $ip        = 'none';
        if (!empty($_POST['staticAddrList'])) {
            $ipAddr =  $_POST['staticAddrList'];
            $ip     = '"' . join('", "', $ipAddr) . '"';
        }
        $comment = $_POST['comment'] === '' ? 'none' : $_POST['comment'];
    
        return "domain $type name $name domain $domain ip $ip ".
            "auto_resolve $autoResolve record_type $recordType ".
            "max_record $maxRecord interval $interval expire $expire ".
            "primary_dns $primaryDns slave_dns $slaveDns comment $comment";
    }

    function getDataCount() {
        $sql = "SELECT id FROM domain_property";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $result = $db->query($sql)->getCount();
        return $result;
    }

    if ($id = $_POST['specId']) {
        // Get specified realmAddr data
        $tpl = $_POST['tpl'];
        $db  = new dbsqlite(DB_PATH . '/rule.db');
	    $sql = "SELECT * FROM domain_property
            WHERE id = '$id'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result['dynamicIpList'] = array();
        $result['dynamicIpList'] = array();
        $r = getIpList($result['name']);
        foreach ($r as $dip) {
            if ($dip['dynamic'] === '1') {
                $result['dynamicIpList'][] = $dip['ip'];
            } else if ($dip['dynamic'] === '0') {
                $result['staticIpList'][] = $dip['ip'];
            } else {
                break 2;
            }
        }
        $result = V::getInstance()->assign('realmAddr', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('add' === $_POST['type']) {
        // Add new realm addr
        $cmd = getAddOrEditCmd('add');
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "添加成功."));
    } else if ('edit' === $_POST['type']) {
        // Edit specified realm addr
        $cmd = getAddOrEditCmd('set');
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "修改成功."));
    } else if ($delName = $_POST['delName']) {
        // Delete specified realm addr
        $cmd = "domain del name $delName";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[$delName]已经删除."));
    } else if ($name = $_POST['refreshName']) {
        // refresh specified realm addr
        $cmd = "domain refresh name $name";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[$name]已刷新."));
    } else if ($orderStatement = $_POST['orderStatement']) {
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
