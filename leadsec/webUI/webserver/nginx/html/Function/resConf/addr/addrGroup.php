<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
    function getAllAddrList() {
    	//获得地址列表option的值
        $addrListArr = array();
        $sql = "SELECT name FROM address";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $k => $v) {
        	$addr=split("_",$v['name']);
        	if (count($addr) == 2){
        		if($addr[0] != 'any') {
        			$addrList = $addr[0];
        			$addrListArr[] = $addrList;	
        		}else {
        			$addrListArr[] = $v['name'];	
        		}
        		
        	}else {
        		$addrList = $addr[0];
        		for ($i=1;$i<count($addr)-1;$i++){
        			$addrList = $addrList."_".$addr[$i];
        		} 
        		$addrListArr[] = $addrList;		
        	}        	
        }
        return $addrListArr ;
    }
    function getAllAddrListValue() {
    	//获得地址列表的values值
        $addrListArrValue = array();
        $sql = "SELECT name FROM address";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $k => $v) {
        	$addrListArrValue[] = $v['name'];        	
        }
        return $addrListArrValue ;
    }
    function getAllAddrGrpList() {
    	//获得已存在的地址组名称
        $addrGrpListArr = array();
        $sql = "SELECT name FROM addrgrp";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $k => $v) {       
            $addrGrpListArr[] = $v['name'];
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
	    $sql = "SELECT id, name, comment FROM addrgrp $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $k => $v) {
        	//获得在页面显示的名称
        	$addrname=split("_",$v['name']);
        	if (count($addrname) == 2) {
        		if($addrname[0] != 'any') {
        			$addrListName = $addrname[0];
        			$result[$k]['name'] = $addrListName ;	
        		}else {
        			$result[$k]['name'] = $v['name'];	
        		}	
        	}else {
            	$addrListName = $addrname[0];
        		for ($i=1;$i<count($addrname)-1;$i++){
        			$addrListName = $addrListName."_".$addrname[$i];
        		} 
	        	$result[$k]['name'] = $addrListName ;	
        	}
        	    
            $r = getSpecAddrListName($v['id']);          
            foreach ($r as $name) {
            	//获得在页面显示的成员名称
	            $addr=split("_",$name['name']);
	            if (count($addr) == 2) {
	            	if($addr[0] != 'any') {
	            		$addrList = $addr[0];
	            		$result[$k]['addrNames'] .= $addrList . '&nbsp;';	
	            	}else {
	            		$result[$k]['addrNames'] .= $name['name'] . '&nbsp;';
	            	}
	            	
	            }else {
	            	$addrList = $addr[0];
        		    for ($i=1;$i<count($addr)-1;$i++){
        				$addrList = $addrList."_".$addr[$i];
        			} 
	        		$result[$k]['addrNames'] .= $addrList . '&nbsp;';	
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
    	//得到添加或编辑的相关数据
        $name    = $_POST['addrGrpName'];
        $comment = $_POST['comment'];
        $mbrArr  = $_POST['addrGrpMember'];
        $addmbr  = join('" "', $mbrArr);
        $addr=split('" "',$addmbr);
        for ($i=0;$i<count($addr);$i++) {   
        	$addrname = $addr[$i];        	 
            $sql = "SELECT id FROM address where name = '$addrname'";
	        $db  = new dbsqlite(DB_PATH . '/rule.db');
	        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
	        foreach ($result as $row) {
            	$addOrEditId[$i]=$row['id'];
        	}
        	$sql = "SELECT type FROM address where name = '$addrname'";
	        $db  = new dbsqlite(DB_PATH . '/rule.db');
	        $result2 = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
	        foreach ($result2 as $row2) {
            	$addOrEditType[$i]=$row2['type'];
        	}      
        }      
        return array($name, $comment, $addmbr,$addOrEditId,$addOrEditType);
    }
    function handlerAddr($type) {
        $db   = new dbsqlite(DB_PATH . '/rule.db');
       // error_log('sdasd',3,'/var/log/error.log');     
        if ($type === 'edit') {  
        	//编辑时更改数据库      	
        	list($name, $comment, $addmbr,$addOrEditId,$addOrEditType) 
        		= getAddOrEditData();
        	$nameipv4 = $name."_ipv4"; 
        	$nameipv6 = $name."_ipv6"; 	
        	$db  = new dbsqlite(DB_PATH . '/rule.db');
    		$sql = "SELECT id FROM addrgrp where name='$nameipv4' or name='$nameipv6'";
	    	$result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
	    	foreach ($result as $row) {
	    		$editId = $row['id'];
	    	}	
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
        	for ($i = 0;$i < count($addOrEditId);$i++) {
            	$sql   = 'INSERT INTO addrmap VALUES(?, ?, ?)';
            	$params = array($outEditId[$i], $addOrEditId[$i],$addOrEditType[$i]); 
            	$db->exec($sql, $params);
            }                           
            return $editId;               
        } else if ($type === 'add') {
        	//添加时更改数据库
        	$db  = new dbsqlite(DB_PATH . '/rule.db');
    		$sql = "SELECT id FROM addrgrp ";
	    	$result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
	    	foreach ($result as $row) {
	    		$addId = $row['id'];
	    	}	
        	$addId = $addId + 1;
        	list($name, $comment, $addmbr,$addOrEditId,$addOrEditType) 
        		= getAddOrEditData();
        	$outAddId = array();   
        	for ($i = 0;$i < count($addOrEditId);$i++) {
        		$outAddId[$i] = $addId;
        	}        	    
            $sql    = 'INSERT INTO addrgrp VALUES(?, ?, ?)';
            $params = array($addId, $name,$comment); 
            $db->exec($sql, $params);
            $retId = $db->getLastInsertId();
            for ($i = 0;$i < count($addOrEditId);$i++) {
            	$sql   = 'INSERT INTO addrmap VALUES(?, ?, ?)';                        
            	$params = array($outAddId[$i], $addOrEditId[$i],$addOrEditType[$i]); 
            	$db->exec($sql, $params);
            }
            return $retId;
        } else { //delete
        	//删除时更改数据库
        	$delName = $_POST['delName'];
        	$delipv4 = $delName."_ipv4"; 
        	$delipv6 = $delName."_ipv6"; 
        	$db  = new dbsqlite(DB_PATH . '/rule.db');
    		$sql = "SELECT id FROM addrgrp where name = '$delipv4' or name ='$delipv6' ";
	    	$result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
	    	foreach ($result as $row) {
	    		$delId = $row['id'];
	    	}
            $sql    = 'DELETE FROM addrgrp WHERE id = ?';
            $params = array($delId);
            $db->exec($sql, $params);
            $sql    = 'DELETE FROM addrmap WHERE addrgrpid = ?';
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
	    	$name = $name."_ipv4";
            $cmdStr[] = "/usr/local/sbin/ipset create $name hash:net";
        } else {
        	$name = $name."_ipv6";
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
	function getCmdArr($type) {
        if ($type === 'del') {
        	$delName = $_POST['delName'];
        	$delipv4 = $delName."_ipv4"; 
        	$delipv6 = $delName."_ipv6"; 
        	$db  = new dbsqlite(DB_PATH . '/rule.db');
    		$sql = "SELECT name FROM addrgrp where name = '$delipv4' or name ='$delipv6' ";
	    	$result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
	    	foreach ($result as $row) {
	    		$delName = $row['name'];
	    	}	
            return "/usr/local/sbin/ipset destroy $delName";
        } 
        $name = $_POST['addrGrpName']; 
        $ipNameList = $_POST['addrGrpMember'];
	    if (strpos($ipNameList[0],"_ipv4")) {
	    	$name = $name."_ipv4";           
        } else {
        	$name = $name."_ipv6";           
        }             
        if ($type === 'edit') {
            $cmdArr[] = "/usr/local/sbin/ipset destroy $name";            
        }       
	    $reCmd = ipsetCmdPack();
	    if ($type === 'edit') {
	    	$cmdArr = array_merge($cmdArr,$reCmd);
	    }else {
	    	$cmdArr = $reCmd; 	
	    }
        return $cmdArr;
    }
    
    if (!empty($_POST['editId'])) {
        // Get specified addrGroup data
        $tpl = $_POST['tpl'];
        $id  = $_POST['editId'];         
        $r   = getSpecAddrListName($id);        
        $addrGrpMemberArr = array();
        $addrGrpMemberArrValue = array();
        foreach ($r as $row) {
        	$addrGrpMemberArrValue[] = $row['name'];
        	$addr=split("_",$row['name']); 
        	$nameIpType = $addr[count($addr)-1];  	
        	if (count($addr) == 2) {
        		if ($addr[0] != 'any') {
        			$addrGrpMember = $addr[0];
        			$addrGrpMemberArr[] = $addrGrpMember;	
        		}else {
        			$addrGrpMemberArr[] = $row['name'];
        		}
        		
        	}else {
        		$addrGrpMember = $addr[0];
        		for ($i=1;$i<count($addr)-1;$i++){
        			$addrGrpMember = $addrGrpMember."_".$addr[$i];
        		} 
        		$addrGrpMemberArr[] = $addrGrpMember;		
        	}        	      
        }          
        $addrListArr = getAllAddrList();
        $addrListArr = array_diff($addrListArr, $addrGrpMemberArr);
        $addrListArrValue = array_diff(getAllAddrListValue(),$addrGrpMemberArrValue);     
        $db  = new dbsqlite(DB_PATH . '/rule.db');
	    $sql = "SELECT name, comment FROM addrgrp WHERE id = $id";
        $addrGroup = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $addrname=split("_",$addrGroup['name']);
        if (count($addrname) == 2) {
        	if($addrname[0] != 'any') {
        		$addrListName = $addrname[0];
        		$addrGroup['name'] = $addrListName ;	
        	}else {
        		$addrGroup['name'] = $v['name'];	
        	}	
        }else {
            $addrListName = $addrname[0];
        	for ($i=1;$i<count($addrname)-1;$i++){
        		$addrListName = $addrListName."_".$addrname[$i];
        	} 
	        $addrGroup['name'] = $addrListName ;	
        }
        $result = V::getInstance()->assign('addrListArr', $addrListArr)
            ->assign('addrListArrValue', $addrListArrValue)
            ->assign('addrGrpMemberArr', $addrGrpMemberArr)
            ->assign('addrGrpMemberArrValue', $addrGrpMemberArrValue)
            ->assign('addrGroup', $addrGroup)
            ->assign('nameIpType', $nameIpType)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified addr group data
        list($name) = getAddOrEditData();
    	$cli  = new cli();
        foreach (getCmdArr('edit') as $cmd) {
            $cli->run($cmd);
        }
	    $id = handlerAddr('edit');
	    addIpsetCmdToSql('edit',$id);
	    echo json_encode(array('msg' => "[$name]修改成功."));
        
    } else if ('add' === $_POST['type']) {
        // Add a new addr group data
        list($name, $comment, $addmbr,$addOrEditId,$addOrEditType) = getAddOrEditData();
        $addrListArr = getAllAddrList(); 
        $addrGrpListArr = getAllAddrGrpList();               
        if (array_search($name,$addrListArr) !== false ) {
        	$msg = "插入失败，在地址列表中存在名称为\"$name\"成员";
        	echo json_encode(array('status' => 0, 'msg' => $msg));
        } elseif ( array_search($name,$addrGrpListArr) !== false) {
        	$msg = "插入失败，在地址组中已存在名称为\"$name\"成员";
        	echo json_encode(array('status' => 0, 'msg' => $msg));
        } else { 
        	$cli  = new cli();
	        foreach (getCmdArr('add') as $cmd) {
	            $cli->run($cmd);
	        }     		        	
		    $id = handlerAddr('add');
		    addIpsetCmdToSql('add',$id);
		    echo json_encode(array('msg' => "[$name]添加成功."));
        }                
    } else if (!empty($_POST['delName'])) {
        // Delete the specified addrGroup data
        $name = $_POST['delName'];
        $cli  = new cli();
        $cli->run(getCmdArr('del'));
        $id = handlerAddr('delete');
        addIpsetCmdToSql('delete',$id);
        echo json_encode(array('msg' => "[$name]删除成功."));
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
