<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function addrNameDelPreffix($name) {
    	// 去掉最后一个下划线_ipv4或_ipv6
    	return substr($name,0,-5);    	
	}
    function freshMsgTransData($where) {
        $tpl =  'client/msgTrans/msgTransTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
	    $sql = "SELECT * FROM msg_client_task ";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
     	foreach ($result as $key => $array) {
       		$result[$key]['sa'] = addrNameDelPreffix($array['sa']);
    	}      
        echo V::getInstance()->assign('msgTrans', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
	function getWhereStatement($db, $cols, $keyword) {
        $value = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' where (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }
    function getDataCount() {
    	$sql = "SELECT id FROM msg_client_task";
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    function getAllLportList($lip) {
    	//获得同一个IP下已存在的本机端口
        $sql = "SELECT lport FROM msg_client_task where lip ='$lip'";            
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        if (count($result) === 0) {
        	$allLportList = array('0' => '');	
        } else {
        	foreach ($result as $k) {       	
        		$allLportList[] = $k['lport'];		       	
        	}	
        }       
        return $allLportList ;
    }
	function getCmd() {
		//组装命令行
        $type = $_POST['type'];
        if ($type === 'add') {
            $action = 'add';
        } elseif ($type === 'edit' || !empty($_POST['action'])) {
            $action = 'set';
        } else {
            throw new Exception('fatal action: [' . $type . '].');
        }
        $id         = intval($_POST['cmsgGeneralId']);
        $sAddress   = $_POST['cmsgsAddress'];
        $cmsgLip   = $_POST['cmsgGeneralLip'];
        $cmsglportReq  = $_POST['cmsgGeneralLport'];
        $ssl        = $_POST['ssl'] === 'Y' ? 'yes' : 'no';            
        $scanvirus  = $_POST['scanvirus'] === 'Y' ? 'yes' : 'no'; 
        $backup     = $_POST['backup'] === 'Y' ? 'yes' : 'no'; 
        $avtive     = $_POST['active'] === 'ok' ? 'on' : 'off';
        $timeList   = $_POST['timeList'];
        $comment    = $_POST['comment'];
        
        $result = "/usr/local/bin/msgctl $action task type client id $id sa $sAddress "
        	." lip $cmsgLip lport $cmsglportReq ssl $ssl"
        	." scanv $scanvirus backup $backup ";  
        	       	
        if ($timeList != '无') {
            $result .= "time $timeList ";
        }
        $result .= " comment \"$comment\"";
        return $result;
    }
    function getActionCmd() {
		//组装命令行
        $id  = intval($_POST['cmsgGeneralId']);
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $sql = "SELECT sa,lip,lport,time FROM msg_client_task where id = $id";          	  
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $sAddress   = $data['sa'];
        $cmsgLip    = $data['lip'];
        $cmsglportReq = $data['lport'];
        $ssl        = $_POST['ssl'] === 'Y' ? 'yes' : 'no';            
        $scanvirus  = $_POST['scanvirus'] === 'Y' ? 'yes' : 'no'; 
        $backup     = $_POST['backup'] === 'Y' ? 'yes' : 'no'; 
        $avtive     = $_POST['active'] === 'ok' ? 'on' : 'off';
        $timeList   = $data['time'];
        $comment    = $_POST['comment'];
        
        $result = "/usr/local/bin/msgctl set task type client id $id sa $sAddress "
        	." lip $cmsgLip lport $cmsglportReq ssl $ssl"
        	." scanv $scanvirus backup $backup ";  
        	       	
        if ($timeList !== '') {
            $result .= "time $timeList ";
        }
        $result .= " comment \"$comment\"";
        return $result;
    }
    if (!empty($_POST['editId'])) {
        // Get specified  data
        $id = $_POST['editId'];
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $sql = "SELECT id, sa, lip, lport, ssl, scanvirus, backup, active,  
        	time, comment,ip_ver FROM msg_client_task where id = $id";  
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);

        $tpl = 'client/msgTrans/msgTrans_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', netGapRes::getInstance()->getAddr(true))
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('localIp', netGapRes::getInstance()->getInterface())
            ->assign('res', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified  data
        $active    = $_POST['active'] === 'ok' ? 'on' : 'off';    
 		$cli = new cli();
 		$cmd = getCmd();
 		$cmd .= " active $active 1>/dev/null";
        $cli->setLog("编辑一条id为".$_POST['cmsgGeneralId']."的消息传输")->run($cmd);
        echo json_encode(array('msg' => '修改成功。'));	                
    } else if (!empty($_POST['delId'])) {
        // Delete the specified  data
        $delId    = $_POST['delId'];
        $cmd  = "/usr/local/bin/msgctl del task type client id $delId";
        $cli  = new cli();
        $cli->setLog("删除一条id为".$_POST['delId']."的消息传输")->run($cmd);
        echo json_encode(array('msg' => "删除成功。"));
    } else if ('add' === $_POST['type']) {
        // Add a new addr group data
        $active    = $_POST['active'] === 'ok' ? 'on' : 'off';    
 		$cli = new cli();
 		$cmd = getCmd();
 		$cmd .= " active $active 1>/dev/null";
        $cli->setLog("添加一条id为".$_POST['cmsgGeneralId']."的消息传输")->run($cmd);
        echo json_encode(array('msg' => '任务[' . intval($_POST['cmsgGeneralId']) . ']添加成功。'));	                            
    }else if (!empty($_POST['openDialog'])) {
        // Display add client comm dialog
        $tpl = 'client/msgTrans/msgTrans_editDialog.tpl';
        $result = V::getInstance()
        	->assign('res', $result)
            ->assign('addrOptions', netGapRes::getInstance()->getAddr(true))
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('localIp', netGapRes::getInstance()->getInterface())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
    	if ($action === 'disable') {
        	$active = 'off';
        	$act="关闭";	
        }else {
        	$active = 'on';
        	$act="开启";		
        }
        $cli = new cli();
        $cmd = getActionCmd();
        $cmd .= " active $active  1>/dev/null";
        $cli->setLog("$act id为".$_POST['cmsgGeneralId']."的消息传输")->run($cmd);
        echo json_encode(array('msg' => '成功。'));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort list
        freshMsgTransData($orderStatement);
    } else if (!empty($_GET['checkExistId'])) {
        // Check the same id exist or not
        echo netGapRes::getInstance()->checkExistTaskId('msg',$_GET['msgTransId']);
    }  else if ($_GET['checkExistLip']) {
        // enable or disable specified acl
    	if ($_GET['cmsgLip'] === "" ) {
        	$tag = 1;
        }else {
        	$tag = 0; 
        }
        echo  $tag > 0 ? 'false' : 'true';
    } else if ($_GET['checkExistLport']) {
        // Check the same port  exist or not
        $cmsglportReq = $_GET['cmsglportReq'];
        $cmsgLip  = $_GET['cmsgLip'];        
        $allLportList = getAllLportList($cmsgLip);             
        if ('add' === $_GET['type']){
        	if (array_search($cmsglportReq,$allLportList) !== false ) {
        		$tag = 1;
        	}else {
        		$tag = 0; 
        	}	
        } else {
        	$id = intval($_GET['cmsgGeneralId']);
        	$sql = "SELECT lip, lport FROM msg_client_task where id = $id ";            
        	$db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        	$result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);        
        	foreach ($result as $k) {       	
        		$Lport = $k['lport'];
        		$Lip = $k['lip'];		       	
        	}	
        	if (array_search($cdblportReq,$allLportList) !== false && 
        		($Lport != $cdblportReq || $Lip != $cdblip)) {
        		$tag = 1;
        	}else {
        		$tag = 0; 
        	}        	
        }     
        echo  $tag > 0 ? 'false' : 'true';
    }else {
        // init page data
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
