<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshAddrList($where) {
        $tpl =  'resConf/addr/addrTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "SELECT * FROM address WHERE name!='any_ipv6' $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $key => $array) {
       		$result[$key]['name'] = addrNameDelPreffix($array['name']);
       		$result[$key]['ip'] = ipConvert($array['ip'],$array['mask']);
    	}
        echo V::getInstance()->assign('addrList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
    
    function ipConvert($ip,$mask){
    	$ipArr = array();
    	$maskArr = array(); 
    	$ipstr = '';
    	if(strpos($ip,'.') !== false)
    	{
    		$ipArr = explode('.', $ip);
    		if(strpos($mask,'.')){
    			$maskArr = explode('.', $mask);
    			for($i = 0;$i < 4;$i++){
    				$maskArr[$i] = base_convert($maskArr[$i], 10, 2);
    			}
    		}else{
    			$maskStr1 = '11111111111111111111111111111111';
    			$maskStr2 = '00000000000000000000000000000000';
    			$maskStr = substr($maskStr1,0,$mask).substr($maskStr2,0,32-$mask);
    			for($i = 0;$i < 4;$i++){
    				$maskArr[$i] = substr($maskStr,$i*8,8);
    			}
    		}
    		for($i = 0;$i < 4;$i++){
    			$ipArr[$i] = base_convert((base_convert($ipArr[$i], 10, 2) & $maskArr[$i]),2,10);
    		}
    		$ipstr = implode('.',$ipArr);
    	}else{   		
    		if(strpos($ip,'::') !== false){
    			$ipArr = explode('::', $ip);
    			$ipArr1 = array();
    			$ipArr2 = array();
    			$ipArr3 = array();
    			$ipArr1 = explode(':',$ipArr[0]);
    			$ipArr2 = explode(':',$ipArr[1]);
    			$num = 8 - count($ipArr1) - count($ipArr2);				
    			$ipArr3 = $ipArr1;
    			for($i = 0;$i < $num;$i++){
    				array_push($ipArr3,'0');
    			}
    			for($i = 0;$i < count($ipArr2);$i++){
    				array_push($ipArr3,$ipArr2[$i]);
    			}
    			for($i = 0;$i < 8;$i++){
    				$ipArr3[$i] = base_convert($ipArr3[$i],16,2);
    			}
    		}else{
    			$ipArr = explode(':', $ip);
    			for($i = 0;$i < 8;$i++){
    				$ipArr3[$i] = base_convert($ipArr[$i],16,2);
    			}
    		}
    		$maskStr1 = '11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111';
    		$maskStr2 = '00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000';
    		$maskStr = substr($maskStr1,0,$mask).substr($maskStr2,0,128-$mask);
    		for($i = 0;$i < 8;$i++){
    			$maskArr[$i] = substr($maskStr,$i*16,16);
    		}
    		for($i = 0;$i < 8;$i++){
    			$ipArr[$i] = base_convert(($ipArr3[$i] & $maskArr[$i]),2,16);
    		}
    		$iptmp = implode(':',$ipArr);
    		$ipstr = preg_replace('/0?(:0)+/', ':', $iptmp,1);
    		$tmpArr = explode(':',$ipstr);
    		$tmplen = count($tmpArr)-1;
    		if($tmpArr[$tmplen] == '')
    			$ipstr = $ipstr.':';
    	}
    	return $ipstr;
    }

    function getCmdArr($type) {
    	$cmdArr = array();
    	$cli  = new cli();
    	$db   = new dbsqlite(DB_PATH . '/rule.db');
    	$addrtype = $_POST['addrType'] === 'default' ? '1' : '2';
    	if ($addrtype === '1') {
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
    	if ($type === 'del') {
        	// 删除之前的ipset，须先读出原来的名字
        	$db  = new dbsqlite(DB_PATH . '/rule.db');
        	$sql = "SELECT name,id FROM address WHERE name='{$_POST['delName']}" .
                "_ipv4' or  name='{$_POST['delName']}_ipv6'";
        	$result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        	$cmdArr['cmd'] = "/usr/local/sbin/ipset destroy {$result['name']}";
        	$cmdArr['log'] = '删除资源配置的地址列表'.$result['name'];
        	$cmdInfo = $cli->setLog($cmdArr['log'])->execCmdGetStatus($cmdArr['cmd']);
    	    if($cmdInfo[0] != '0'){
	    		$errornum = -$cmdInfo[0];
	    		if($cmdInfo[0] == '5'){
	    			$db  = new dbsqlite(DB_PATH . '/rule.db');
	    			$sql    = 'DELETE FROM address WHERE id = ?';
                    $params = array($result['id']);
	    			$db->exec($sql, $params);
	    		}
	    		return $errornum;
	    	}else{
	    		$db  = new dbsqlite(DB_PATH . '/rule.db');
	    		$sql    = 'DELETE FROM address WHERE id = ?';
	    		$params = array($result['id']);
	    		$db->exec($sql, $params);
	    		return $result['id'];
	    	}
        }       
        $name = addrNameAddPreffix($_POST['addrName']);
        if ($type === 'edit') {
        	// 删除之前的ipset，须先读出原来的名字
        	$db  = new dbsqlite(DB_PATH . '/rule.db');
        	$sql = "SELECT name,id FROM address WHERE name='{$_POST['addrName']}" .
                "_ipv4' or  name='{$_POST['addrName']}_ipv6'";
        	$result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            $cmdArr['cmd'] = "/usr/local/sbin/ipset destroy {$result['name']}";
            $cmdArr['log'] = '删除资源配置的地址列表'.$result['name'];
            $cmdInfo = $cli->setLog($cmdArr['log'])->execCmdGetStatus($cmdArr['cmd']);
            if($cmdInfo[0] != '0'){
            	$errornum = -$cmdInfo[0];
            	if($cmdInfo[0] == '5'){
            		$db  = new dbsqlite(DB_PATH . '/rule.db');
            		$sql    = 'DELETE FROM address WHERE id = ?';
            		$params = array($result['id']);
            		$db->exec($sql, $params);
            	}
            	return $errornum;
            }else{
            	$db  = new dbsqlite(DB_PATH . '/rule.db');
            	$sql    = 'DELETE FROM address WHERE id = ?';
            	$params = array($result['id']);
            	$db->exec($sql, $params);
            }
        }
        if (($_POST['addrType']==='default' && validateIpv4Format($_POST['ip'])) ||
            ($_POST['addrType']==='range' && validateIpv4Format($_POST['range_s']))) {
            $cmdArr['cmd'] = "/usr/local/sbin/ipset create $name hash:net";
            $cmdArr['log'] = '添加资源配置的地址列表' . $name . '(ipv4类型)';
        } else {
            $cmdArr['cmd'] = "/usr/local/sbin/ipset create $name hash:net family inet6";
            $cmdArr['log'] = '添加资源配置的地址列表' . $name . '(ipv6类型)';
        }
        $cmdInfo = $cli->setLog($cmdArr['log'])->execCmdGetStatus($cmdArr['cmd']);
        if($cmdInfo[0] != '0'){
        	$errornum = -$cmdInfo[0];
        	return $errornum;
        }else{
        	$db  = new dbsqlite(DB_PATH . '/rule.db');
        	$sql    = 'INSERT INTO address VALUES(?, ?, ?, ?, ?, ?)';
        	$params = array(NULL, $name, '1',
        			'', '',      $_POST['comment']);
        	$db->exec($sql, $params);
        }
        $cmdArr['cmd'] = "/usr/local/sbin/ipset add $name " . composeIp();
        $cmdArr['log'] = '添加资源配置的地址列表'.$name.'地址';
        $cmdInfo = $cli->setLog($cmdArr['log'])->execCmdGetStatus($cmdArr['cmd']);
        if($cmdInfo[0] != '0'){
        	$errornum = -$cmdInfo[0];
        	return $errornum;
        }else{
        	$db  = new dbsqlite(DB_PATH . '/rule.db');
        	$sql = "UPDATE address SET type=?, ip=?, mask=? WHERE name = '". $name."'";
        	$params = array($addrtype,$ip1, $ip2);
        	$db->exec($sql, $params);
        }    
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "SELECT id FROM address WHERE name = '". $name."'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return $result['id'];
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
    
	function checkAddress(){
		$db  = new dbsqlite(DB_PATH . '/rule.db');
		$sql = 'SELECT addrgrpid FROM addrmap WHERE addrid='.$_POST['delId'];
		return $db->query($sql)->getCount();
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
        $id = getCmdArr('add');
        if($id >= 0){
        	addIpsetCmdToSql('add',$id);
        echo json_encode(array('msg' => "[{$_POST['addrName']}]添加成功."));
        }else{
        	if($id == -5){
        		echo json_encode(array('msg' => "[{$_POST['addrName']}]地址不存在"));
        	}else if($id == -6){
        		echo json_encode(array('msg' => "[{$_POST['addrName']}]地址被引用"));
        	}else{
        		echo json_encode(array('msg' => "[{$_POST['addrName']}]地址添加不成功"));
        	}
        }      
    } else if ('edit' === $_POST['type']) {
        // Edit the specified ipAddr
        $id = getCmdArr('edit');
        if($id >= 0){
        	addIpsetCmdToSql('edit',$id);
        echo json_encode(array('msg' => "[{$_POST['addrName']}]修改成功."));
        }else{
        	if($id == -5){
        		echo json_encode(array('msg' => "[{$_POST['addrName']}]地址不存在"));
        	}else if($id == -6){
        		echo json_encode(array('msg' => "[{$_POST['addrName']}]地址被引用"));
        	}else{
        		echo json_encode(array('msg' => "[{$_POST['addrName']}]地址修改不成功"));
        	}
        }       
    } else if (!empty($_POST['delId'])) {
        // Delete the specified ipAddr
        $rc = checkAddress();
        if($rc != 0){
        	echo json_encode(array('msg' => "此地址为地址组成员,不能被删除"));
        }else{
        	$id = getCmdArr('del');
        	if($id >= 0){
        		addIpsetCmdToSql('del',$id);
        	    echo json_encode(array('msg' => "[{$_POST['delName']}]删除成功."));
        	}else{
        		if($id == -5){
        			echo json_encode(array('msg' => "[{$_POST['delName']}]地址不存在"));
        		}else if($id == -6){
        			echo json_encode(array('msg' => "[{$_POST['delName']}]地址被引用"));
        		}else{
        			echo json_encode(array('msg' => "[{$_POST['delName']}]地址删除不成功"));
        		}
        	}       	
        }              
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
