<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshAddrList($where) {
        $tpl =  'resConf/addr/addrTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "SELECT * FROM address WHERE name!='any_ipv6' $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $key => $array) {
       		$result[$key]['name'] = addrNameDelPreffix($array['name']);
    	}
        echo V::getInstance()->assign('addrList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getCmdArr($type) {
        if ($type === 'del') {
        	// 删除之前的ipset，须先读出原来的名字
        	$db  = new dbsqlite(DB_PATH . '/rule.db');
        	$sql = "SELECT name FROM address WHERE name='{$_POST['delName']}" .
                "_ipv4' or  name='{$_POST['delName']}_ipv6'";
        	$result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            return "/usr/local/sbin/ipset destroy {$result['name']}";
        }
        $cmdArr = array();

        $name = addrNameAddPreffix($_POST['addrName']);
        if ($type === 'edit') {
        	// 删除之前的ipset，须先读出原来的名字
        	$db  = new dbsqlite(DB_PATH . '/rule.db');
        	$sql = "SELECT name FROM address WHERE name='{$_POST['addrName']}" .
                "_ipv4' or  name='{$_POST['addrName']}_ipv6'";
        	$result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            $cmdArr[] = "/usr/local/sbin/ipset destroy {$result['name']}";
        }
        if (($_POST['addrType']==='default' && validateIpv4Format($_POST['ip'])) ||
            ($_POST['addrType']==='range' && validateIpv4Format($_POST['range_s']))) {
            $cmdArr[] = "/usr/local/sbin/ipset create $name hash:net";
        } else {
            $cmdArr[] = "/usr/local/sbin/ipset create $name hash:net family inet6";
        }
        $cmdArr[] = "/usr/local/sbin/ipset add $name " . composeIp();
        return $cmdArr;
    }

    function composeIp() {
        $ipType  = $_POST['addrType'];
        $result  = '';
        if ($ipType === 'range') {
            $result = $_POST['range_s'] . '-' . $_POST['range_e'];
        } else { //default
            $ip   = $_POST['ip'];
            $mask = $_POST['netmask'];
            if (validateIpv4Format($ip)) {
                $result = $ip . '/' . convertToIpv4Mask($mask, 'int');
            } else {
                $result = $ip . '/' . $mask;
            }
        }
        return $result;
    }

    function handlerAddr($t) {
        $db   = new dbsqlite(DB_PATH . '/rule.db');
        $type = $_POST['addrType'] === 'default' ? '1' : '2';
        if ($type === '1') {
            $ip1  = $_POST['ip'];
            $mask = $_POST['netmask'];
            if (validateIpv4Format($ip1)) {
                $ip2 = convertToIpv4Mask($mask, 'dot');
            } else {
                $ip2 = $mask;
            }
        } else { // 2
            $ip1 = $_POST['range_s'];
            $ip2 = $_POST['range_e'];
        }
        if ($t === 'edit') {
        	$addrName = addrNameAddPreffix($_POST['addrName']);
            $sql = 'UPDATE address SET name=?, type=?, ip=?, mask=?, ' .
                'comment=? WHERE id = ' . $_POST['id'];
            $params = array($addrName, $type, $ip1, 
                            $ip2,      $_POST['comment'],);
        } else if ($t === 'add') {
        	$addrName = addrNameAddPreffix($_POST['addrName']);
            $sql    = 'INSERT INTO address VALUES(?, ?, ?, ?, ?, ?)';
            $params = array(NULL, $addrName, $type,
                            $ip1, $ip2,      $_POST['comment']);
        } else { //delete
            $sql    = 'DELETE FROM address WHERE id = ?';
            $params = array($_POST['delId']);
        }
        $db->exec($sql, $params);
        if($t === 'add') {
        	return $db->getLastInsertId();
        } else if ($t === 'edit') {
        	return $_POST['id'];
        } else {
        	return $_POST['delId'];
        }        
    }

    function getDataCount() {
        $sql = "SELECT id FROM address WHERE name!='any_ipv6'";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        return $db->query($sql)->getCount();
    }
    
    function checkAddrName($name) {
    	// 检查地址名是否已存在
    	$sql = "SELECT id FROM address WHERE name='{$name}_ipv4' OR name='{$name}_ipv6'";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $num = $db->query($sql)->getCount();
        if ($num === 0) {
        	return false;
        } else {
        	return true;
        }        	
    }
    
    function addrNameDelPreffix($name) {
    	// 去掉最后一个下划线_ipv4或_ipv6
    	return substr($name,0,-5);    	
	}
	
	function addrNameAddPreffix($name) {
		// 判断ipv4还是v6, 在地址名后添加_ipv4或_ipv6
        $type = $_POST['addrType'] === 'default' ? '1' : '2';
        if ($type === '1') {
        	$flgIPv4 = validateIpv4Format($_POST['ip']);
        } else {
        	$flgIPv4 = true;
        }
        if ($flgIPv4) {
        	$addrName = $name . "_ipv4";
        } else {
        	$addrName = $name . "_ipv6";
        }
        return $addrName;
	}
	
	function addIpsetCmdToSql($type,$id) {
		// 将ipset命令保存到shell.db中的ipset_addr_list中
		if ($type === 'del') {
            $sql = "DELETE FROM ipset_addr_list WHERE id=?";
            $params = array($id);
        } else {
	        // 组装cmd字段
	        $name = addrNameAddPreffix($_POST['addrName']);
		    if (($_POST['addrType']==='default' && validateIpv4Format($_POST['ip'])) ||
            ($_POST['addrType']==='range' && validateIpv4Format($_POST['range_s']))) {
	            $cmdStr = "/usr/local/sbin/ipset create $name hash:net";
	        } else {
	            $cmdStr = "/usr/local/sbin/ipset create $name hash:net family inet6";
	        }
	        $cmdStr .= ";"."/usr/local/sbin/ipset add $name " . composeIp();
	        if ($type === 'edit') {
	        	$sql = "UPDATE ipset_addr_list SET cmd=? WHERE id=?";
	        	$params = array($cmdStr,$id);
	        } else {
				$sql = "INSERT INTO ipset_addr_list VALUES(?, ?)";
				$params = array($id,$cmdStr);
	    	}
    	}
        $db   = new dbsqlite(DB_PATH . '/shell.db');
        $db->exec($sql, $params);
	}

    $addrTypeArr = array('', 'default', 'range');

    if (!empty($_POST['addrId'])) {
        // Get specified addrlist data
        $id  = $_POST['addrId'];
        $tpl = 'resConf/addr/editAddrDialog.tpl';
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "SELECT * FROM address WHERE id = '$id'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result['type'] = $addrTypeArr[$result['type']];
        $result['name'] = addrNameDelPreffix($result['name']);
        $result = V::getInstance()->assign('addr', $result)
            ->assign('id', $id)->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('add' === $_POST['type']) {
        // Add new ipAddr
        $addrName_src = $_POST['addrName'];        
        // 查询新添加的地址名是否已存在
        if ($addrName_src === "any") {
        	echo json_encode(array('msg' => "[any]为内部关键字，不允许定义为名称."));
        	return;
        }
        if (checkAddrName($addrName_src)) {
        	echo json_encode(array('msg' => "[$addrName_src]已存在."));
        	return;
        }
        $cli  = new cli();
        foreach (getCmdArr('add') as $cmd) {
            $cli->run($cmd);
        }
        $id = handlerAddr('add');
        addIpsetCmdToSql('add',$id);
        echo json_encode(array('msg' => "[{$_POST['addrName']}]添加成功."));
    } else if ('edit' === $_POST['type']) {
        // Edit the specified ipAddr
        $cli  = new cli();
        foreach (getCmdArr('edit') as $cmd) {
            $cli->run($cmd);
        }
        $id = handlerAddr('edit');
        addIpsetCmdToSql('edit',$id);
        echo json_encode(array('msg' => "[{$_POST['addrName']}]修改成功."));
    } else if (!empty($_POST['delId'])) {
        // Delete the specified ipAddr
        $cli  = new cli();
        $cli->run(getCmdArr('del'));
        $id = handlerAddr('del');
        addIpsetCmdToSql('del',$id);
        echo json_encode(array('msg' => "[{$_POST['delName']}]删除成功."));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort addrlist Table
        freshAddrList($orderStatement);
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
