<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function addrNameDelPreffix($name) {
    	// 去掉最后一个下划线_ipv4或_ipv6
    	return substr($name,0,-5);    	
	}
    function freshClientCommData($where) {
        $tpl =  'client/db/generalVisitTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
	    $sql = "SELECT * FROM db_comm_client_acl $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
     	foreach ($result as $key => $array) {
       		$result[$key]['sa'] = addrNameDelPreffix($array['sa']);
    	}
        echo V::getInstance()->assign('clientComm', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT id FROM db_comm_client_acl";
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        return $db->query($sql)->getCount();
    }
    function getAddressList() {
   	   //从资源定义的地址列表里得到客户端普通访问的源地址
   		$db = new dbsqlite(DB_PATH . '/rule.db');
        $sql    = 'SELECT name FROM address UNION SELECT name FROM addrgrp';
        $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $d) {
            $key = $d['name'];
            if ($key === 'any_ipv4' || $key === 'any_ipv6') {
                $result[] = 'any';
            } else {
                $val = substr($key, 0, -5);
                $result[] = $val;
            } 
        }
        return $result;
    }
    function getAddressListValue() {
   	   //从资源定义的地址列表里得到客户端普通访问的源地址的value
   		$db = new dbsqlite(DB_PATH . '/rule.db');
        $sql    = 'SELECT name FROM address UNION SELECT name FROM addrgrp';
        $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $resultValues = array();
        foreach ($data as $d) {          
            $resultValues[] = $d['name'];
        }
        return $resultValues;
    }
    
    function getFilterList() {
   	   //获得过滤选项
   	    $db     = new dbsqlite(DB_PATH . '/netgap_db.db');
        $sql    = 'SELECT name FROM db_option_list';
        $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array('' => '无');
        foreach ($data as $d) {
            $name = $d['name'];
            $result[$name] = $name;
        }
        return $result;
    }

    function getAllLportList($lip) {
    	//获得同一个IP下已存在的本机端口
        $sql = "SELECT lport FROM db_comm_client_acl where lip ='$lip'";            
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
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
        $id        = intval($_POST['clientId']);
        $dbType    = $_POST['dbType'];
        $sAddress  = $_POST['sAddress'];
        $cdblip    = $_POST['cdblip'];
        $cdblportReq = $_POST['cdblportReq'];
        $filter    = $_POST['filter'];           
        $roleList  = $_POST['roleList'];
        $timeList  = $_POST['timeList'];
        //$killVirus = $_POST['killVirus'] === 'Y' ? 'yes' : 'no';
        $comment   = $_POST['comment'];
 
        $result = "dbctl $action task db $dbType type client mode comm id $id "
        	." sa $sAddress lip $cdblip lport $cdblportReq ";  
        	          
        if ($timeList != '无') {
            $result .= "time $timeList ";
        }
		if ($roleList != '无' ) {
            $result .= " auth $roleList ";
        }
	    if ($filter != '') {
            $result .= "filter $filter ";
        }
        $result .= " comment \"$comment\"";
        return $result;
    }
    function getActionCmd() {
		//组装命令行
        $id = intval($_POST['clientId']);
        $sql = 'SELECT sa,lip,lport,time,filter' .
            " FROM db_comm_client_acl WHERE id = '$id'";
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);

        $dbType    = $_POST['dbType'];
        $sAddress  = $data['sa'];
        $cdblip  = $data['lip'];
        $cdblportReq = $data['lport'];
        $filter    = $data['filter'];           
        $roleList  = $_POST['roleList'];
        $timeList  = $data['time'];
        $comment   = $_POST['comment'];
 
        $result = "dbctl set task db $dbType type client mode comm id $id "
        	." sa $sAddress lip $cdblip lport $cdblportReq ";  
        	          
        if ($timeList != '') {
            $result .= "time $timeList ";
        }
    	if ($roleList != '' ) {
            $result .= " auth $roleList ";
        }
	    if ($filter != '') {
            $result .= "filter $filter ";
        }
        $result .= " comment \"$comment\"";
        return $result;
    }
    if (!empty($_POST['editId'])) {
        // Get specified  data     	
        $id = $_POST['editId'];
        $sql = 'SELECT id, dbtype, sa, lip, lport, time, active, filter, ' .
            "comment,ip_ver FROM db_comm_client_acl WHERE id = '$id'";
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        //print_r( $result);
        $addrOptions = getAddressList();
        $addrOptionsvalue = getAddressListValue();
        $filterOptions = getFilterList();
        $tpl = 'client/db/generalVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('addrOptions', $addrOptions)
            ->assign('addrOptionsvalue', $addrOptionsvalue)
            ->assign('filterOptions', $filterOptions)
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('localIp', netGapRes::getInstance()->getInterface())
            ->assign('res', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified  data 		    	    	
        $active    = $_POST['active'] === 'Y' ? 'on' : 'off';    
 		$cli = new cli();
 		$cmd = getCmd();
 		$cmd .= " active $active";
 		$cli->setLog("编辑一条id为".$_POST['clientId']."的普通访问控制")->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));	                
    }  else if (!empty($_POST['delId'])) {
        // Delete the specified  data
        $delId    = $_POST['delId'];
        $sql = "SELECT dbtype FROM db_comm_client_acl WHERE id =$delId";            
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        foreach ($result as $d) {              
            $dbType = $d;           
        }     
        $cmd  = "dbctl del task db $dbType type client mode comm id $delId ";
        $cli  = new cli();
        $sql = "delete FROM db_comm_client_acl WHERE id =''";    
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = $db->close();
        $cli->setLog("删除一条id为".$_POST['delId']."的普通访问控制")->run($cmd); 
        echo json_encode(array('msg' => "删除成功."));
    } else if ('add' === $_POST['type']) {
        // Add a new addr group data      
        $active    = $_POST['active'] === 'Y' ? 'on' : 'off';    
 		$cli = new cli();
 		$cmd = getCmd();
 		$cmd .= " active $active";
 		$cli->setLog("添加一条id为".$_POST['clientId']."的普通访问控制")->run($cmd);
        echo json_encode(array('msg' => '任务[' . intval($_POST['clientId']) . ']添加成功.'));	                     
    }else if (!empty($_POST['openDialog'])) {
        // Display add client comm dialog       
        $tpl = 'client/db/generalVisit_editDialog.tpl';
        $addrOptions = getAddressList();
        $filterOptions = getFilterList();
        $addrOptionsvalue = getAddressListValue();
        $result['lport'] = '';
        $result = V::getInstance()
        	->assign('res', $result)
            ->assign('addrOptions', $addrOptions)
            ->assign('addrOptionsvalue', $addrOptionsvalue)
            ->assign('filterOptions', $filterOptions)
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
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
        $cmd .= " active $active";
        $cli->setLog("$act id为".$_POST['clientId']."的普通访问控制")->run($cmd);
        echo json_encode(array('msg' => '成功.'));
    } else if ($_GET['checkExistLip']) {
        // enable or disable specified acl
    	if ($_GET['cdblip'] === "" ) {
        	$tag = 1;
        }else {
        	$tag = 0; 
        }
        echo  $tag > 0 ? 'false' : 'true';
    } else if ($_GET['checkExistLport']) {
        // Check the same port  exist or not
        $cdblportReq = $_GET['cdblportReq'];
        $cdblip  = $_GET['cdblip'];        
        $allLportList = getAllLportList($cdblip);             
        if ('add' === $_GET['type']){
        	if (array_search($cdblportReq,$allLportList) !== false ) {
        		$tag = 1;
        	}else {
        		$tag = 0; 
        	}	
        } else {
        	$id = intval($_GET['clientId']);
        	$sql = "SELECT lip, lport FROM db_comm_client_acl where id = $id";            
        	$db  = new dbsqlite(DB_PATH . '/netgap_db.db');
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
    }else if (!empty($_GET['checkExistId'])) {
        // Check the same id exist or not
        echo netGapRes::getInstance()->checkExistTaskId('trans',intval($_GET['clientId']));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort addr-group list
        freshClientCommData($orderStatement);
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
