<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
    function getAllAddrList() {
    	//获得地址列表option
        $addrListArr = array();
        $addrListArrValue = array();
        $sql = "SELECT name FROM address";
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $k => $v) {        	
        	$key = $v['name'];
            if ($key === 'any_ipv4' || $key === 'any_ipv6') {
            	$addrListArr[] = $key;
            	$addrListArrValue[] = $key;
            } else {
                $addrListArr[] = substr($key, 0, -5);
            	$addrListArrValue[] = $key;
            }       	
        }
        return array($addrListArr, $addrListArrValue);
    }

    function getSpecAddrListName($id) {
    	//获得已添加到地址组的成员名
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "select address.name from addrmap INNER JOIN address ".
            "ON addrmap.addrid == address.id where addrmap.addrgrpid = $id";       
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
        	$name = $v['name'];
            $result[$k]['name']     = substr($name, 0, -5);	
            $result[$k]['fullName'] = $name;
        	    
            $r = getSpecAddrListName($v['id']);          
            foreach ($r as $n) {
            	//获得在页面显示的成员名称
            	$addrName = $n['name'];
            	if($addrName === 'any_ipv4' || $addrName === 'any_ipv6'){
            		$result[$k]['addrNames'] .= $addrName. '&nbsp;';
            	} else {
            		$val = substr($addrName, 0, -5);
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

    function delGrp($delName) {
		$cli = new cli();
        $log = '删除资源配置的地址组' . $delName;
        $cmd = "/usr/local/bin/addrgrp del name \"$delName\""; 
        list($stat, $l) = $cli->setLog($log)->execCmdGetStatus($cmd, false);
        return $stat;
    }

    function addNewGrp($grpName, $addrList, $comment) {
		$cli    = new cli();
        $addmbr = '"' . join('" "', $addrList) . '"';
        $family = strtolower(substr($addrList[0], -4)); // ipv4|ipv6
        $name   = "{$grpName}_$family";

        $log[0] = '添加资源配置的地址组' . $grpName;
        $log[1] = '向资源配置的地址组[' . $grpName . ']中添加地址[' .
            $addmbr . ']';
        $cmd[0] = "/usr/local/bin/addrgrp add name \"$name\"" .
            " family \"$family\" comment \"$comment\"";
        $cmd[1] = "/usr/local/bin/addrgrp set name \"$name\" addmbr " .
            "$addmbr";
        for ($i = 0; $i < 2; $i++) {
            list($stat, $l) = $cli->setLog($log[$i])
                                  ->execCmdGetStatus($cmd[$i], false);
            if ($stat != 0) {
                return $stat;
            }
        }
        return $stat;
    }

	function getCmdStatus($type) {
		if ($type === 'del') {
        	$delName = $_POST['delName'];
            $status = delGrp($delName);
            return $status;
        } else if ($type === 'add') {
            $grpName  = $_POST['addrGrpName']; 
            $addrList = $_POST['addrGrpMember'];
            $comment  = $_POST['comment'];
            return addNewGrp($grpName, $addrList, $comment);
        } else if ($type === 'edit') {
            // first delete
            $grpName  = $_POST['addrGrpName']; 
            $addrList = $_POST['addrGrpMember'];
            $comment  = $_POST['comment'];
            $family   = strtolower(substr($addrList[0], -4)); // ipv4|ipv6
            $delName  = "{$grpName}_$family";
            $status   = delGrp($delName);
            if ($status != 0) {
                return $status;
            }
            // secondly add
            return addNewGrp($grpName, $addrList, $comment);
        }
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
        list($addrListArr, $addrListArrValue) = getAllAddrList();
        $addrListArr = array_diff($addrListArr, $addrGrpMemberArr);
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
        $name = $_POST['addrGrpName'];
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

	    $status = getCmdStatus('edit');
	    if ($status == 0) {
	    	echo json_encode(array('msg' => "[$name]修改成功。"));
	    } else {
	    	if ($status == 5) {
	    		echo json_encode(array('msg' => "[$name]地址组不存在。"));
	    	} else if($status == 6 || $status == 89) {
	    		echo json_encode(array('msg' => "[$name]地址组被引用。"));
	    	} else{
	    		echo json_encode(array('msg' => "[$name]地址组修改不成功。"));
	    	}
	    }        
    } else if ('add' === $_POST['type']) {
        if (getDataCount() >= RESCONF_LIMIT) {
            $msg = '资源数达到上限[' . RESCONF_LIMIT . ']。';
        	echo json_encode(array('msg' => $msg));
        	return;
        }
        // Add a new addr group data
        $name   = $_POST['addrGrpName'];
		$status = getCmdStatus('add');
		if ($status == 0) {
			echo json_encode(array('msg' => "[$name]添加成功。"));           
		} else {
			if ($status == 5) {
				echo json_encode(array('msg' => "[$name]地址组不存在。"));
			} else if ($status == 6 || $status == 89) {
				echo json_encode(array('msg' => "[$name]地址组被引用。"));
			} else {
				echo json_encode(array('msg' => "[$name]地址组添加不成功。"));
			}
		}		 
    } else if (!empty($_POST['delName'])) {
        // Delete the specified addrGroup data
        $name   = $_POST['delName'];
        $n      = substr($name, 0, -5);
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
        $status = getCmdStatus('del');
        if ($status == 0){
        	echo json_encode(array('msg' => "[$name]删除成功。"));        	
        } else {
        	if ($status == 5){
        		echo json_encode(array('msg' => "[$name]地址组不存在。"));
        	} else if ($status == 6 || $status == 89){
        		echo json_encode(array('msg' => "[$name]地址组被引用。"));
        	} else {
        		echo json_encode(array('msg' => "[$name]地址组删除不成功。"));
        	}
        }                
    } else if (!empty($_POST['openAddAddrGrpDialog'])) {
        // Display add addr group dialog    		
        $tpl = $_POST['tpl'];
        list($addrListArr, $addrListArrValue) = getAllAddrList();
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
        $sql = "SELECT name FROM address WHERE name = '$nameipv4' or " .
            "name = '$nameipv6' UNION SELECT name FROM addrgrp WHERE " .
            "name = '$nameipv4' or name = '$nameipv6'";
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
