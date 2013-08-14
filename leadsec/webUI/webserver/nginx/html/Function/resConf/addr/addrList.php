<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshAddrList($where) {
    	preg_match('/OFFSET\s(\d+)$/', $where, $match);
    	$offset = intval($match[1]) + 1;
        $tpl =  'resConf/addr/addrTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "SELECT * FROM address WHERE name!='any_ipv6'";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $data['sql'];
        	$params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $key => $array) {
       		$result[$key]['name'] = addrNameDelPreffix($array['name']);
       		$result[$key]['fullName'] = $array['name'];
       		$result[$key]['ip'] = ipConvert($array['ip'],$array['mask']);
    	}
        echo V::getInstance()->assign('addrList', $result)
            ->assign('beginId', $offset)
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
    		$ipstr = preg_replace('/(:0)+/', ':', $iptmp,1);
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
    	$cmdInfo = array();
    	if ($type === 'del') {
            $name = $_POST['delName'];
        	$cmdArr['cmd'] = "/usr/local/bin/address del name \"$name\"";
        	$cmdArr['log'] = '删除资源配置的地址列表' . $name;
        	$cmdInfo = $cli->setLog($cmdArr['log'])
                           ->execCmdGetStatus($cmdArr['cmd']);    	    
        }else if ($type === 'edit') {
        	// 删除之前的ipset，须先读出原来的名字
        	$name = addrNameAddPreffix($_POST['addrName']);
        	$cmdArr['cmd'] = "/usr/local/bin/address set name \"$name\" ip " . composeIp()." comment \"{$_POST['comment']}\"";
            $cmdArr['log'] = '修改资源配置的地址列表'.$name.'地址';
            $cmdInfo = $cli->setLog($cmdArr['log'])->execCmdGetStatus($cmdArr['cmd']);            
        }else{
        	$name = addrNameAddPreffix($_POST['addrName']);
        	$cmdArr['cmd'] = "/usr/local/bin/address add name \"$name\" ip " . composeIp()." comment \"{$_POST['comment']}\"";
        	$cmdArr['log'] = '添加资源配置的地址列表'.$name.'地址';
        	$cmdInfo = $cli->setLog($cmdArr['log'])->execCmdGetStatus($cmdArr['cmd']);
        }
        return $cmdInfo[0];
    }

    function composeIp() {
        $ipType  = $_POST['addrType'];
        $result  = '';
        if ($ipType === 'range') {
            $result = $_POST['range_s'] . '-' . $_POST['range_e'];
        } else { //default
            $ip   = $_POST['ip'];
            $mask = $_POST['addrnetmask'];
            $result = $ip . '/' . $mask;
            /*
            if (validateIpv4Format($ip)) {
                $result = $ip . '/' . convertToIpv4Mask($mask, 'int');
            } else {
                $result = $ip . '/' . $mask;
            }*/
        }
        return $result;
    }

    function getWhereStatement($db, $cols, $keyword) {
    	$value = '%' . $keyword . '%';
    	$params = array_fill(0, count(explode(',', $cols)), $value);
    	return array('sql'    => ' AND (' .
    			$db->getWhereStatement($cols, 'OR', 'like') . ')',
    			'params' => $params);
    }
    
    function getDataCount() {
        $sql = "SELECT id FROM address WHERE name!='any_ipv6'";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
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
	    
	function checkAddress($name){
		$db  = new dbsqlite(DB_PATH . '/rule.db');
		$sql = 'SELECT addrgrpid FROM addrmap WHERE addrid='.$name;
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
        if (getDataCount() >= RESCONF_LIMIT) {
            $msg = '资源数达到上限[' . RESCONF_LIMIT . ']。';
        	echo json_encode(array('msg' => $msg));
        	return;
        }
        // 查询新添加的地址名是否已存在
        if ($addrName_src === "any") {
        	echo json_encode(array('msg' => "[any]为内部关键字，不允许定义为名称。"));
        	return;
        }
        if (checkAddrName($addrName_src)) {
        	echo json_encode(array('msg' => "[$addrName_src]已存在。"));
        	return;
        }
        $id = getCmdArr('add');
        if($id == 0){
        echo json_encode(array('msg' => "[{$_POST['addrName']}]添加成功。"));
        }else{
        	if($id == 5){
        		echo json_encode(array('msg' => "[{$_POST['addrName']}]地址不存在。"));
        	}else if($id == 6 || $id == 89){
        		echo json_encode(array('msg' => "[{$_POST['addrName']}]地址被引用。"));
        	}else{
        		echo json_encode(array('msg' => "[{$_POST['addrName']}]地址添加不成功。"));
        	}
        }      
    } else if ('edit' === $_POST['type']) {
        // Edit the specified ipAddr
        $name = $_POST['addrName'];
        if (($result = netGapRes::getInstance()->checkAddrResUsed($name, true))
            && count($result) > 0) {
            $msg  = "[$name]地址被引用。";
            $msg .= '<table><tr><th>模块名称</th><th>任务号</th></tr>';
            foreach ($result as $r) {
                $msg .= '<tr><td>' . $r['mod'] . '</td><td>[' . $r['id'] .
                ']</td></tr>';
            }
            $msg .= '</table>';
        	echo json_encode(array('msg' => $msg));
            return false;
        }
        $rc = checkAddress($_POST['id']);
        if($rc != 0){
        	echo json_encode(array('msg' => "此地址为地址组成员，不能被修改。"));
        } else {
        	$id = getCmdArr('edit');
        	if($id == 0){
        		echo json_encode(array('msg' => "[$name]修改成功。"));
        	} else {
        		if($id == 5){
        			echo json_encode(array('msg' => "[$name]地址不存在。"));
        		}else if($id == 6 || $id == 89){
        			echo json_encode(array('msg' => "[$name]地址被引用。"));
        		}else{
        			echo json_encode(array('msg' => "[$name]地址修改不成功。"));
        		}
        	}
        }       
    } else if (!empty($_POST['delId'])) {
        // Delete the specified ipAddr
        $name = $_POST['delName'];
        $n    = substr($name, 0, -5);
        if (($result = netGapRes::getInstance()->checkAddrResUsed($n)) &&
            count($result) > 0) {
            $msg  = "[$name]地址被引用。";
            $msg .= '<table><tr><th>模块名称</th><th>任务号</th></tr>';
            foreach ($result as $r) {
                $msg .= '<tr><td>' . $r['mod'] . '</td><td>[' . $r['id'] .
                ']</td></tr>';
            }
            $msg .= '</table>';
        	echo json_encode(array('msg' => $msg));
            return false;
        }
        $rc = checkAddress($_POST['delId']);
        if($rc != 0){
        	echo json_encode(array('msg' => "此地址为地址组成员，不能被删除。"));
        } else {
        	$id = getCmdArr('del');
        	if($id == 0){
        	    echo json_encode(array('msg' => "[$name]删除成功。"));
        	}else{
        		if($id == 5){
        			echo json_encode(array('msg' => "[$name]地址不存在。"));
        		}else if($id == 6 || $id == 89){
        			echo json_encode(array('msg' => "[$name]地址被引用。"));
        		}else{
        			echo json_encode(array('msg' => "[$name]地址删除不成功。"));
        		}
        	}       	
        }              
    } else if ($_GET['checkExistAddrName']){
        // Check the same name exist or not
    	$name = $_GET['addrName'] ? $_GET['addrName'] : $_GET['domainAddrName'];
    	if($name == 'any_ipv4' || $name == 'any_ipv6'){
    		echo false;
    	}else{
    		$nameipv4 = $name."_ipv4";
    		$nameipv6 = $name."_ipv6";
    		$sql = "SELECT name FROM address WHERE name = '$nameipv4' or name = '$nameipv6'
    		UNION SELECT name FROM addrgrp WHERE name = '$nameipv4' or name = '$nameipv6'";
    		$db  = new dbsqlite(DB_PATH . '/rule.db');
    				echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
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
