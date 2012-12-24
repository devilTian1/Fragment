<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
    function getAllAddrList() {
        $addrListArr = array();
        $sql = "SELECT name FROM address";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
       // print_r($result);
        foreach ($result as $k => $v) {
        	$addr=split("_",$v['name']);
        	if ($addr[0] != 'any' && $addr[1] == 'ipv4') {
        		$addrListArr[] = $addr[0];
        	}
            if ($addr[0] == 'any') {
            	$addrListArr[] = $v['name'];
            }
        }
        return $addrListArr;
    }

    function getSpecAddrListName($id) {
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "select address.name from addrmap INNER JOIN address ".
            "ON addrmap.addrid == address.id where addrmap.addrgrpid=$id";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);      
        return $result;
    }

    function appendAddrGroupData($where) {
        $tpl =  'resConf/addr/addrGroupTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/rule.db');
	    $sql = "SELECT id, name, comment FROM addrgrp $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $k => $v) {
            $r = getSpecAddrListName($v['id']);          
            foreach ($r as $name) {
	            $addr=split("_",$name['name']);
	        	if ($addr[0] != 'any' && $addr[1] == 'ipv4') {
	        		 $result[$k]['addrNames'] .= $addr[0] . '&nbsp;';
	        	}
	            if ($addr[0] == 'any') {
	            	$result[$k]['addrNames'] .= $name['name'] . '&nbsp;';
	            }                
            }
	    }
        echo V::getInstance()->assign('addrGroup', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT id FROM addrgrp";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        return $db->query($sql)->getCount();
    }

    function getAddOrEditData() {
        $name    = $_POST['addrGrpName'];
        $comment = $_POST['comment'];
        $mbrArr  = $_POST['addrGrpMember'];
        $addmbr  = join('" "', $mbrArr);
        $addr=split('" "',$addmbr);
        for ($i=0;$i<count($addr);$i++) {
        	if (count(split("_",$addr[$i])) == 1) {
        	    $addrname = $addr[$i].'_ipv4';
        	}else {
        		$addrname = $addr[$i];
        	}
            $sql = "SELECT id FROM address where name = '$addrname'";
	        $db  = new dbsqlite(DB_PATH . '/rule.db');
	        $result[$i] = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
	        foreach ($result[$i] as $row) {
            	$addOrEditId[$i]=$row['id'];
        	}
        	$sql2 = "SELECT type FROM address where name = '$addrname'";
	        $db  = new dbsqlite(DB_PATH . '/rule.db');
	        $result2[$i] = $db->query($sql2)->getAllData(PDO::FETCH_ASSOC);
	        foreach ($result2[$i] as $row2) {
            	$addOrEditType[$i]=$row2['type'];
        	}      
        }
        return array($name, $comment, $addmbr,$addOrEditId,$addOrEditType);
    }
    function handlerAddr($type) {
        $db   = new dbsqlite(DB_PATH . '/rule.db');
              
        if ($type === 'edit') {
        	$editId = $_POST['editId'];
        	list($name, $comment, $addmbr,$addOrEditId,$addOrEditType) = getAddOrEditData();
        	$outEditId = array();   
        	for ($i = 0;$i < count($addOrEditId);$i++) {
        		$outEditId[$i] = $editId;
        	}
        	  	    
            $sql = "UPDATE addrgrp SET comment=? WHERE id = ?";
            $params = array($comment,$editId); 
            $db->exec($sql, $params);            
            $sql    = 'DELETE FROM addrmap WHERE addrgrpid = ?';
            $params = array($editId);
            $db->exec($sql, $params); 
            $sql   = 'INSERT INTO addrmap VALUES(?, ?, ?)';
            $params = array($outEditId, $addOrEditId,$addOrEditType); 
            $db->execByTransaction($sql, $params);           
            return $editId;               
        } else if ($type === 'add') {
        	$addId = getDataCount() + 1;
        	list($name, $comment, $addmbr,$addOrEditId,$addOrEditType) = getAddOrEditData();
        	$outAddId = array();   
        	for ($i = 0;$i < count($addOrEditId);$i++) {
        		$outAddId[$i] = $addId;
        	}	        	    
            $sql    = 'INSERT INTO addrgrp VALUES(?, ?, ?)';
            $params = array($addId, $name,$comment); 
            $db->exec($sql, $params);
            $retId = $db->getLastInsertId();
            $sql   = 'INSERT INTO addrmap VALUES(?, ?, ?)';
            $params = array($outAddId, $addOrEditId,$addOrEditType); 
            $db->execByTransaction($sql, $params);
            return $retId;
        } else { //delete
        	$delId = $_POST['delId'];
            $sql    = 'DELETE FROM addrgrp WHERE id = ?';
            $params = array($delId);
            $db->exec($sql, $params);
            return $delId;
        }

    }
    
    function composeIpFrDb($array) {
    	// 输入参数为address某一行的数组，返回由此行数组组合的ip/mask或ip1-ip2
    	if($array['type'] === '1') {
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
    
    function ipsetCmdPack() {
	// 组装cmd字段
        $name = $_POST['addrGrpName'];
        $ipNameList = $_POST['addrGrpMember'];
        $cmdStr = Array();
	    if (strpos($ipNameList[0],"_ipv4")) {
            $cmdStr[] = "/usr/local/sbin/ipset create $name hash:net";
        } else {
            $cmdStr[] = "/usr/local/sbin/ipset create $name hash:net family inet6";
        }
        $addrListTable = readAddrList();	        
        foreach ($ipNameList as $array) {
        	$key = array_search($array,$addrListTable);
        	$cmdStr[] = "/usr/local/sbin/ipset add $name " . composeIpFrDb($addrListTable[$key]);
        }
        return $cmdStr;
    }
    
    function addIpsetCmdToSql($type,$id) {
		// 将ipset命令保存到shell.db中的ipset_addr_list中
		if ($type === 'delete') {
            $sql = "DELETE FROM ipset_addr_grp WHERE id=?";
            $params = array($id);
        } else {	        
	        $cmd = ipsetCmdPack();
	        $cmdStr = join(";",$cmd);
	        if ($type === 'edit') {
	        	$sql = "UPDATE ipset_addr_grp SET cmd=? WHERE id=?";
	        	$params = array($cmdStr,$id);
	        } else {
				$sql = "INSERT INTO ipset_addr_grp VALUES(?, ?)";
				$params = array($id,$cmdStr);
	    	}
    	}
    	//error_log('\n####sql='.$sql.';addOrEditId='.$cmdStr.';id='.$id,3,'/var/log/error.log');
        $db   = new dbsqlite(DB_PATH . '/shell.db');
        $db->exec($sql, $params);
	}
	if (!empty($_POST['editId'])) {
        // Get specified addrGroup data
        $tpl = $_POST['tpl'];
        $id  = $_POST['editId'];

        $r   = getSpecAddrListName($id);        
        $addrGrpMemberArr = array();
        foreach ($r as $row) {
        	$addr=split("_",$row['name']);
        	if ($addr[0] != 'any' && $addr[1] == 'ipv4') {
	        	    $addrGrpMemberArr[] = $addr[0];
	        	}
	        if ($addr[0] == 'any') {
	            	$addrGrpMemberArr[] = $row['name'];
	            }           
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
    } else if ('edit' === $_POST['type']) {
        // Edit a specified addr group data
        list($name, $comment, $addmbr,$addOrEditId,$addOrEditType) = getAddOrEditData();
        
        if ($addmbr == "") {
        	echo json_encode(array('msg' => "请选择至少一个地址组成员."));
        } else {
        	//$cmd1 = "addrgrp set name \"$name\" comment \"$comment\"";
	        //$cmd2 = "addrgrp set name \"$name\" delallmbr";
	        //$cmd3 = "addrgrp set name \"$name\" addmbr \"$addmbr\"";
	        //$cli  = new cli();
	        //$cli->run($cmd1);
	        //$cli->run($cmd2);
	        //$cli->run($cmd3);
	        $id = handlerAddr('edit');
	        addIpsetCmdToSql('edit',$id);
	        echo json_encode(array('msg' => "[$name]修改成功."));
        }           
        
    } else if ('add' === $_POST['type']) {
        // Add a new addr group data
        list($name, $comment, $addmbr,$addOrEditId,$addOrEditType) = getAddOrEditData();
        $addrListArr = getAllAddrList();        
        if (array_search($name,$addrListArr) !== false) {
        	$msg = "插入失效，在地址列表中存在名称为\"$name\"成员";
        	echo json_encode(array('msg' => $msg));
        } else {
        	if ($addmbr == "") {
        		echo json_encode(array('msg' => "请选择至少一个地址组成员."));
	        } else {
	        	//$cmd1 = "addrgrp add name \"$name\" comment \"$comment\"";
		        //$cmd2 = "addrgrp set name \"$name\" addmbr \"$addmbr\"";
		        //$cli  = new cli();
		        //$cli->run($cmd1);
		        //$cli->run($cmd2);
		        $id = handlerAddr('add');
		        addIpsetCmdToSql('add',$id);
		        echo json_encode(array('msg' => "[$name]添加成功."));
	        }	
        }
        
        
    } else if (!empty($_POST['delName'])) {
        // Delete the specified addrGroup data
        $name = $_POST['delName'];
        $cmd  = "addrgrp del name \"$name\"";
        //$cli  = new cli();
        //$cli->run($cmd);
        $id = handlerAddr('delete');
        addIpsetCmdToSql('delete',$id);
        echo json_encode(array('msg' => "[$name]删除成功."));
    } else if (!empty($_POST['openAddAddrGrpDialog'])) {
        // Display add addr group dialog
        $tpl = $_POST['tpl'];
        $addrListArr = getAllAddrList();
        $result = V::getInstance()->assign('addrListArr', $addrListArr)
            ->assign('addrGrpMemberArr', array())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
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
