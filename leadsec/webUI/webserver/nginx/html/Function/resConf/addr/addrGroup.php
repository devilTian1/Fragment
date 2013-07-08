<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
    function getAllAddrList() {
    	//获得地址列表option的值
        $addrListArr = array();
        $sql = "SELECT name FROM address";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $k => $v) {        	
        	$key = $v['name'];
            if ($key === 'any_ipv4' || $key === 'any_ipv6') {
                //$addrList = 'any';
            	$addrListArr[] = $key;
            } else {
                $val = substr($key, 0, -5);
                $addrListArr[] = $val;
            }       	
        }
        //$addrListArr[] = $addrList;
        return $addrListArr ;
    }
    function getAllAddrListValue() {
    	//获得地址列表的values值
        $addrListArrValue = array();
        $sql = "SELECT name FROM address";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $k => $v) {              	
        	$key = $v['name'];
            if ($key === 'any_ipv4' || $key === 'any_ipv6') {
                //$addrListValue = 'any';
            	$addrListArrValue[] = $key;
            }else {
            	$addrListArrValue[] = $v['name'];    	
            }        	    	
        }
        //$addrListArrValue[] = $addrListValue; 
        return $addrListArrValue ;
    }
    function getAllAddrGrpList() {
    	//获得已存在的地址组名称
        $addrGrpListArr = array();
        $sql = "SELECT name FROM addrgrp";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $k => $v) {
        	$key = $v['name'];
        	$val = substr($key, 0, -5);       
            $addrGrpListArr[] = $val;
        }
        return $addrGrpListArr;
    }
    function getSpecAddrListName($id) {
    	//获得已添加到地址组的成员名
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "select address.name from addrmap INNER JOIN address ".
            "ON addrmap.addrid == address.id where addrmap.addrgrpid=$id";       
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);    
        return $result;
    }

    function appendAddrGroupData($where) {
        $tpl =  'resConf/addr/addrGroupTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/rule.db');
	    $sql = "SELECT id, name, comment FROM addrgrp";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $data['sql'];
        	$params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $k => $v) {
        	//获得在页面显示的名称
        	$key = $v['name'];
            $val = substr($key, 0, -5);
            $result[$k]['name'] = $val;	
        	    
            $r = getSpecAddrListName($v['id']);          
            foreach ($r as $n) {
            	//获得在页面显示的成员名称
            	$key = $n['name'];
            	if($key === 'any_ipv4' || $key === 'any_ipv6'){
            		$result[$k]['addrNames'] .= $key. '&nbsp;';
            	}else{
            		$val = substr($key, 0, -5);
            		$result[$k]['addrNames'] .= $val. '&nbsp;';
            	}                      	 	            
            }
	    }
        echo V::getInstance()->assign('addrGroup', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getWhereStatement($db, $cols, $keyword) {
    	$value = '%' . $keyword . '%';
    	$params = array_fill(0, count(explode(',', $cols)), $value);
    	return array('sql'    => ' WHERE (' .
    			$db->getWhereStatement($cols, 'OR', 'like') . ')',
    			'params' => $params);
    }
    
    function getDataCount() {
    	$sql = "SELECT id FROM addrgrp";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    function getAddOrEditData() {
    	//得到添加或编辑的相关数据
        $name    = $_POST['addrGrpName'];
        $comment = $_POST['comment'];
        $mbrArr  = $_POST['addrGrpMember'];
        $addmbr  = join('" "', $mbrArr);
        $addr=split('" "',$addmbr);
        if($mbrArr[0] !== 'any'){
        	if (strpos($mbrArr[0],"_ipv4")) {
	    		$flag = "_ipv4";           
        	} else {
        		$flag = "_ipv6";           
        	} 	
        }else {
        	if (strpos($mbrArr[1],"_ipv4")) {
	    		$flag = "_ipv4";           
        	} else {
        		$flag = "_ipv6";           
        	}
        }      
        for ($i=0;$i<count($addr);$i++) {   
        	$addrname = $addr[$i];
        	if($addrname === 'any'){
        		$addrname .= $flag;	
        	}            
        	$sql = "SELECT id,name FROM address where name='$addrname' ";
        	$db  = new dbsqlite(DB_PATH . '/rule.db');
	        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
	       	 foreach ($result as  $row) {
            	$addOrEditId[$i]=$row['id'];
        	}
        	
        	$sql = "SELECT type FROM address where name='$addrname' ";
	        $db  = new dbsqlite(DB_PATH . '/rule.db');
	        $result2 = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
	        foreach ($result2 as $row2) {
            	$addOrEditType[$i]=$row2['type'];
        	} 
        } 
        $name.= $flag;   	             	                	                 
        return array($name, $comment, $addmbr,$addOrEditId,$addOrEditType);
    }
    
    function composeIpFrDb($array) {
    	// 输入参数为address某一行的数组，返回由此行数组组合的ip/mask或ip1-ip2
    	//print_r($array);
    	if($array['type'] === '1') {
    	    if (validateIpv4Format($array['ip'])) {
    	        $array['mask'] = convertToIpv4Mask($array['mask'], 'int');    		
    	    }
    	    return $array['ip']."/".$array['mask'];
    	} else {
    		return $array['ip']."-".$array['mask'];
    	}
    }
    
    function readAddrList() {
    	// 读取address表，并返回所有结果
    	$db  = new dbsqlite(DB_PATH . '/rule.db');
    	$sql = "SELECT * FROM address";
	    $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
	    return $result;
    }
    function readAddrListName() {
    	// 读取address表，并返回所有地址列表名称的结果
    	$db  = new dbsqlite(DB_PATH . '/rule.db');
    	$sql = "SELECT name FROM address";
	    $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
	    foreach ($result as $r) {
	    	$addrListName[] = $r['name']; 	
	    }
	    return $addrListName;
    }
    
    function ipsetCmdPack() {
	// 组装cmd字段
        $name = $_POST['addrGrpName'];
        $ipNameList = $_POST['addrGrpMember'];
        $cmdStr = array();
        $cmdLog = array();
        $cli  = new cli();
        if($ipNameList[0] !== 'any'){
        	if (strpos($ipNameList[0],"_ipv4")) {
	    		$name = $name."_ipv4";
	    		$flag = "_ipv4";
            	$cmdStr['cmd'] = "/usr/local/sbin/ipset create $name hash:net";   
            	$cmdStr['log'] = '添加资源配置的地址组'.$name.'(ipv4类型) hash链';
        	} else {
        		$name = $name."_ipv6";
        		$flag = "_ipv6";
            	$cmdStr['cmd'] = "/usr/local/sbin/ipset create $name hash:net family inet6";
            	$cmdStr['log'] = '添加资源配置的地址组'.$name.'(ipv6类型) hash链';
        	} 	
        }else {
        	if (strpos($ipNameList[1],"_ipv4")) {
	    		$name = $name."_ipv4";
	    		$flag = "_ipv4";
            	$cmdStr['cmd'] = "/usr/local/sbin/ipset create $name hash:net"; 
            	$cmdStr['log'] = '添加资源配置的地址组'.$name.'(ipv6类型) hash链';
        	} else {
        		$name = $name."_ipv6";
        		$flag = "_ipv6";
            	$cmdStr['cmd'] = "/usr/local/sbin/ipset create $name hash:net family inet6";
            	$cmdStr['log'] = '添加资源配置的地址组'.$name.'(ipv6类型) hash链';
        	}
        }
        $cmdLog['cmd'] = $cmdStr['cmd'];
        $cmdInfo = $cli->setLog($cmdStr['log'])->execCmdGetStatus($cmdStr['cmd']);
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "SELECT id FROM addrgrp ";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        if(count($result) === 0){
        	$addId = 1;
        } else {
        	foreach ($result as $row) {
        		$id = $row['id'];
        	}
        	$addId = $id + 1;
        }
        list($name, $comment, $addmbr,$addOrEditId,$addOrEditType)
        = getAddOrEditData();
        $outAddId = array();
        for ($i = 0;$i < count($addOrEditId);$i++) {
        	$outAddId[$i] = $addId;
        }
        if($cmdInfo[0] != '0'){
        	$cmdLog['errornum'] = -$cmdInfo[0];
        	return $cmdLog;
        }else{       	
        	$sql    = 'INSERT INTO addrgrp VALUES(?, ?, ?)';
        	$params = array($addId, $name,$comment);
        	$db->exec($sql, $params);
        }
        $retId = $db->getLastInsertId();
        for($i=0;$i<count($ipNameList);$i++){
        	if($ipNameList[$i]==='any'){
        		$ipNameList[$i].=$flag;	
        	}		
        }       
        $addrListTable = readAddrList();
        $addrListTableName = readAddrListName();	        
        foreach ($ipNameList as $array) {       	
        	$key = array_search($array,$addrListTableName);
        	if ($addrListTableName[$key] === 'any_ipv4') {
        	    $cmdStr['cmd'] = "/usr/local/sbin/ipset add $name 0.0.0.0/1";
        	    $cmdStr['log'] = '添加资源配置的地址组'.$name.' 0.0.0.0/1';
        	    $cmdLog['cmd'] = $cmdLog['cmd'].';'.$cmdStr['cmd'];
        	    $cmdInfo = $cli->setLog($cmdStr['log'])->execCmdGetStatus($cmdStr['cmd']);
        	    $cmdStr['cmd'] = "/usr/local/sbin/ipset add $name 128.0.0.0/1";
        	    $cmdStr['log'] = '添加资源配置的地址组'.$name.' 128.0.0.0/1';
        	} else if ($addrListTableName[$key] === 'any_ipv6') {
        	    $cmdStr['cmd'] = "/usr/local/sbin/ipset add $name ::/1";
        	    $cmdStr['log'] = '添加资源配置的地址组'.$name.' ::/1';
        	    $cmdLog['cmd'] = $cmdLog['cmd'].';'.$cmdStr['cmd'];
        	    $cmdInfo = $cli->setLog($cmdStr['log'])->execCmdGetStatus($cmdStr['cmd']);
        	    $cmdStr['cmd'] = "/usr/local/sbin/ipset add $name 8000::0/1";
        	    $cmdStr['log'] = '添加资源配置的地址组'.$name.' 8000::0/1';
        	} else {
            $cmdStr['cmd'] = "/usr/local/sbin/ipset add $name " . composeIpFrDb($addrListTable[$key]);
            $cmdStr['log'] = '添加资源配置的地址组'.$name;
            }
            $cmdLog['cmd'] = $cmdLog['cmd'].';'.$cmdStr['cmd'];
            $cmdInfo = $cli->setLog($cmdStr['log'])->execCmdGetStatus($cmdStr['cmd']);
            if($cmdInfo[0] != '0'){
        	    $cmdLog['errornum'] = -$cmdInfo[0];
        	    return $cmdLog;
            }else{
            	$db  = new dbsqlite(DB_PATH . '/rule.db');
            	$sql   = 'INSERT INTO addrmap VALUES(?, ?, ?)';
            	$params = array($addId, $addrListTable[$key]['id'],$addrListTable[$key]['type']);
            	$db->exec($sql, $params);
            }
        }
        $cmdLog['errornum'] = 0;
        $cmdLog['addId'] = $addId;
        return $cmdLog;
    }
    
    function addIpsetCmdToSql($type,$id) {
		// 将ipset命令保存到shell.db中的ipset_addr_list中
		if ($type === 'del') {
            $sql = "DELETE FROM ipset_addr_grp WHERE id=?";
            $params = array($id['addId']);
        } else {	        
	        if ($type === 'edit') {
	        	$sql = "UPDATE ipset_addr_grp SET cmd=? WHERE id=?";
	        	$params = array($id['cmd'],$id['addId']);
	        } else {
				$sql = "INSERT INTO ipset_addr_grp VALUES(?, ?)";
				$params = array($id['addId'],$id['cmd']);
	    	}
    	}
    	//error_log('\n####sql='.$sql.';addOrEditId='.$cmdStr.';id='.$id,3,'/var/log/error.log');
        $db   = new dbsqlite(DB_PATH . '/shell.db');
        $db->exec($sql, $params);
	}
	function getCmdArr($type) {
		$cmdArr = array();
		$cli  = new cli();
		if ($type === 'del') {
        	$delName = $_POST['delName'];
        	$delipv4 = $delName."_ipv4"; 
        	$delipv6 = $delName."_ipv6"; 
        	$db  = new dbsqlite(DB_PATH . '/rule.db');
    		$sql = "SELECT name,id FROM addrgrp where name = '$delipv4' or name ='$delipv6' ";
	    	$result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
	    	foreach ($result as $row) {
	    		$delName = $row['name'];
	    		$delId = $row['id'];
	    	}	
	    	$cmdArr['cmd'] = "/usr/local/sbin/ipset destroy $delName";
	    	$cmdArr['log'] = '删除资源配置的地址组'.$delName;
	    	$cmdInfo = $cli->setLog($cmdArr['log'])->execCmdGetStatus($cmdArr['cmd']);
	    	if($cmdInfo[0] != '0'){
	    		$errornum = -$cmdInfo[0];
	    		if($cmdInfo[0] == '5'){
	    			$db  = new dbsqlite(DB_PATH . '/rule.db');
	    			$sql    = 'DELETE FROM addrgrp WHERE id = ?';
	    			$params = array($delId);
	    			$db->exec($sql, $params);
	    			$sql    = 'DELETE FROM addrmap WHERE addrgrpid = ?';
	    			$params = array($delId);
	    			$c = array();
	    			$c['addId'] = $delId;
	    			addIpsetCmdToSql($type,$c);
	    			$db->exec($sql, $params);
	    		}
	    		return $errornum;
	    	}else{
	    		$db  = new dbsqlite(DB_PATH . '/rule.db');
	    		$sql    = 'DELETE FROM addrgrp WHERE id = ?';
	    		$params = array($delId);
	    		$db->exec($sql, $params);
	    		$sql    = 'DELETE FROM addrmap WHERE addrgrpid = ?';
	    		$params = array($delId);
	    		$db->exec($sql, $params);
	    		$c = array();
	    		$c['addId'] = $delId;
	    		addIpsetCmdToSql($type,$c);
	    		return $delId;
	    	}
        } 
        $name = $_POST['addrGrpName']; 
        $ipNameList = $_POST['addrGrpMember'];
        
        if($ipNameList[0] !== 'any'){
        	if (strpos($ipNameList[0],"_ipv4")) {
	    		$flag = "_ipv4";           
        	} else {
        		$flag = "_ipv6";           
        	} 	
        }else {
        	if (strpos($ipNameList[1],"_ipv4")) {
	    		$flag = "_ipv4";           
        	} else {
        		$flag = "_ipv6";           
        	}
        }
        $name .= $flag; 
             
        if ($type === 'edit') {
        	$cmdArr['cmd'] = "/usr/local/sbin/ipset destroy $name";
        	$cmdArr['log'] = '删除资源配置的地址组'.$name;        	
        	$cmdInfo = $cli->setLog($cmdArr['log'])->execCmdGetStatus($cmdArr['cmd']);
        	$db  = new dbsqlite(DB_PATH . '/rule.db');
        	$sql = "SELECT name,id FROM addrgrp where name = '$name'";
        	$result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        	foreach ($result as $row) {
        		$delName = $row['name'];
        		$delId = $row['id'];
        	}
        	if($cmdInfo[0] != '0'){
        		$errornum = -$cmdInfo[0];
        		if($cmdInfo[0] == '5'){
        			$db  = new dbsqlite(DB_PATH . '/rule.db');
        			$sql    = 'DELETE FROM addrgrp WHERE id = ?';
        			$params = array($delId);
        			$db->exec($sql, $params);
        			$sql    = 'DELETE FROM addrmap WHERE addrgrpid = ?';
        			$params = array($delId);
        			$db->exec($sql, $params);
        		}
        		return $errornum;
        	}else{
        		
        		$db  = new dbsqlite(DB_PATH . '/rule.db');
        		$sql    = 'DELETE FROM addrgrp WHERE id = ?';
        		$params = array($delId);
        		$db->exec($sql, $params);
        		$sql    = 'DELETE FROM addrmap WHERE addrgrpid = ?';
        		$params = array($delId);
        		$db->exec($sql, $params);
        	}
        }       
	    $b = ipsetCmdPack();
	    if($b['errornum'] < 0){
	    	return $b['errornum'];
	    }
	    $delId = $b['addId'];
	    addIpsetCmdToSql($type,$b);
        return $delId;
    }
    
    if (!empty($_POST['editId'])) {
        // Get specified addrGroup data
        $tpl = $_POST['tpl'];
        $id  = $_POST['editId'];         
        $r   = getSpecAddrListName($id);      
        $addrGrpMemberArr = array();
        $addrGrpMemberArrValue = array();
        foreach ($r as $row) {        	       	        	
        	$key = $row['name'];
            if ($key === 'any_ipv4' || $key === 'any_ipv6') {
                //$addrGrpMember = 'any';
            	$addrGrpMember = $key;
             
            } else {
            	$tag=substr($key, -4);
                $val = substr($key, 0, -5);
                $addrGrpMemberArr[] = $val;
                $addrGrpMemberArrValue[] = $key; 
            }                  	      
        } 
        if($addrGrpMember === 'any_ipv4' || $addrGrpMember === 'any_ipv6'){
        	$addrGrpMemberArr[] = $addrGrpMember;
            $addrGrpMemberArrValue[] = $addrGrpMember; 	
        }                 
        $addrListArr = getAllAddrList();
        $addrListArr = array_diff($addrListArr, $addrGrpMemberArr);
        $addrListArrValue = getAllAddrListValue();
        $addrListArrValue = array_diff($addrListArrValue,$addrGrpMemberArrValue);     
        $db  = new dbsqlite(DB_PATH . '/rule.db');
	    $sql = "SELECT name FROM addrgrp WHERE id = $id";
        $addrName = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        foreach ($addrName as $a) {       	       	        	
        	$key = $a;
            $val = substr($key, 0, -5);
            $addrGroup = $val;              	      
        }   
        $sql = "SELECT comment FROM addrgrp WHERE id = $id";
        $addrComment = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        foreach ($addrComment as $a) {       	       	        	
        	$key = $a;
            $comment = $key;              	      
        }       
        $result = V::getInstance()->assign('addrListArr', $addrListArr)
            ->assign('addrListArrValue', $addrListArrValue)
            ->assign('addrGrpMemberArr', $addrGrpMemberArr)
            ->assign('addrGrpMemberArrValue', $addrGrpMemberArrValue)
            ->assign('addrGroup', $addrGroup)
            ->assign('comment', $comment)
            ->assign('iptype', $tag)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified addr group data
        list($name) = getAddOrEditData();
	    $id = getCmdArr('edit');
	    $name = substr($name, 0, -5);
	    if($id >= 0){
	    	echo json_encode(array('msg' => "[$name]修改成功。"));
	    }else{
	    	if($id == -5){
	    		echo json_encode(array('msg' => "[$name]地址组不存在。"));
	    	}else if($id == -6){
	    		echo json_encode(array('msg' => "[$name]地址组被引用。"));
	    	}else if($id == -7){
	    		echo json_encode(array('msg' => "[$name]地址组成员重复添加。"));
	    	}else{
	    		echo json_encode(array('msg' => "[$name]地址组修改不成功。"));
	    	}
	    }        
    } else if ('add' === $_POST['type']) {
        // Add a new addr group data  
        list($name, $comment, $addmbr,$addOrEditId,$addOrEditType)=getAddOrEditData();      		        	
		$id = getCmdArr('add');
		$name = substr($name, 0, -5);
		if($id >= 0){
			echo json_encode(array('msg' => "[$name]添加成功。"));           
		}else{
			if($id == -5){
				echo json_encode(array('msg' => "[$name]地址组不存在。"));
			}else if($id == -6){
				echo json_encode(array('msg' => "[$name]地址组被引用。"));
			}else if($id == -7){
				echo json_encode(array('msg' => "[$name]地址组成员重复添加。"));
			}else{
				echo json_encode(array('msg' => "[$name]地址组添加不成功。"));
			}
		}		 
    } else if (!empty($_POST['delName'])) {
        // Delete the specified addrGroup data
        $name = $_POST['delName'];
        $id = getCmdArr('del');
        if($id >= 0){
        	echo json_encode(array('msg' => "[$name]删除成功。"));        	
        }else{
        	if($id == -5){
        		echo json_encode(array('msg' => "[$name]地址组不存在。"));
        	}else if($id == -6){
        		echo json_encode(array('msg' => "[$name]地址组被引用。"));
        	}else{
        		echo json_encode(array('msg' => "[$name]地址组删除不成功。"));
        	}
        }                
    } else if (!empty($_POST['openAddAddrGrpDialog'])) {
        // Display add addr group dialog    		
        $tpl = $_POST['tpl'];
        $addrListArr = getAllAddrList();
        $addrListArrValue = getAllAddrListValue();
        $result = V::getInstance()->assign('addrListArr', $addrListArr)
            ->assign('addrListArrValue', $addrListArrValue)
            ->assign('addrGrpMemberArr', array())
            ->assign('addrGrpMemberArrValue', array())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($_GET['checkExistAddrGrpName']){
        // Check the same name exist or not
    	$name = $_GET['addrGrpName'];
    	$nameipv4 = $name."_ipv4";
    	$nameipv6 = $name."_ipv6";
        $sql = "SELECT name FROM address WHERE name = '$nameipv4' or name = '$nameipv6'
        	UNION SELECT name FROM addrgrp WHERE name = '$nameipv4' or name = '$nameipv6'";           
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort addr-group list        
        appendAddrGroupData($orderStatement);
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
