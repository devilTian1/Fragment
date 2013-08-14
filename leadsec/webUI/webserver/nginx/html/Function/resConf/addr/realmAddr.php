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
            " FROM domain_property";
	    $params = array();
	    if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
	    	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
	    	$sql   .= $data['sql'];
	    	$params = $data['params'];
	    }
	    $sql .=  ' ' . $where;
	    $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $k => $v) {
            $r = getIpList($v['name']);
            $result[$k]['delname'] = $v['name'];
            $key = $v['name'];
            $val = substr($key, 0, -5);
            $result[$k]['name'] = $val;
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
        $name        = $_POST['domainAddrName'];
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
        $cmdArr = array(array());
        $cmdArr['cmd'] = "domain $type name $name".'_ipv4'." domain $domain ip $ip ".
            "auto_resolve $autoResolve record_type $recordType ".
            "max_record $maxRecord interval $interval expire $expire ".
            "primary_dns $primaryDns slave_dns $slaveDns comment $comment";
        $logt = $type === 'add' ? '添加' : '修改';
        $cmdArr['log'] = $logt.'资源配置的域名地址'.$name;
        return $cmdArr;
    }

    function getWhereStatement($db, $cols, $keyword) {
    	$value = '%' . $keyword . '%';
    	$params = array_fill(0, count(explode(',', $cols)), $value);
    	return array('sql'    => ' WHERE (' .
    			$db->getWhereStatement($cols, 'OR', 'like') . ')',
    			'params' => $params);
    }
    
    function getDataCount() {
        $sql = "SELECT id FROM domain_property";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    if ($id = $_POST['specId']) {
        // Get specified realmAddr data
        $tpl = $_POST['tpl'];
        $db  = new dbsqlite(DB_PATH . '/rule.db');
	    $sql = "SELECT * FROM domain_property
            WHERE id = '$id'";	    
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $r = getIpList($result['name']);
        $key = $result['name'];
        $val = substr($key, 0, -5);
        $result['name'] = $val;
        $result['dynamicIpList'] = array();
        $result['dynamicIpList'] = array();
        
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
        if (getDataCount() >= RESCONF_LIMIT) {
            $msg = '资源数达到上限[' . RESCONF_LIMIT . ']。';
        	echo json_encode(array('msg' => $msg));
        	return;
        }
        // Add new realm addr
        if ($_POST['domainAddrName'] === "any") {
        	echo json_encode(array('msg' => "[any]为内部关键字，不允许定义为名称。"));
        	return;
        }
        $cmd = getAddOrEditCmd('add');
        $cli = new cli();
        $cli->setLog($cmd['log'])->run($cmd['cmd']);
        echo json_encode(array('msg' => "添加成功。"));
    } else if ('edit' === $_POST['type']) {
        // Edit specified realm addr
        $cmd = getAddOrEditCmd('set');
        $cli = new cli();
        $cli->setLog($cmd['log'])->run($cmd['cmd']);
        echo json_encode(array('msg' => "修改成功。"));
    } else if ($delName = $_POST['delName']) {
        // Delete specified realm addr    	
        $cmd = "domain del name $delName";
        $name = substr($delName, 0, -5);
        $cli = new cli();
        $cli->setLog('删除资源配置的域名地址'.$delName)->run($cmd);
        echo json_encode(array('msg' => "[$name]已经删除。"));
    } else if ($refreshId = $_POST['refreshName']) {
        // refresh specified realm addr
    	$db  = new dbsqlite(DB_PATH . '/rule.db');
    	$sql = "SELECT name FROM domain_property
    	WHERE id = '$refreshId'";
    	$result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
    	$refreshName = $result['name'];    	
    	$cmd = "domain refresh name $refreshName";
    	$name = substr($refreshName, 0, -5);
        $cli = new cli();
        $cli->setLog('刷新资源配置的域名地址'.$refreshName)->run($cmd);
        echo json_encode(array('msg' => "[$name]已刷新。"));
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
