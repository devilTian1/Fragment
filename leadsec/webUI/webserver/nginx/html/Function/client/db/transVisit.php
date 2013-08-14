<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function addrNameDelPreffix($name) {
    	// 去掉最后一个下划线_ipv4或_ipv6
    	return substr($name,0,-5);    	
	}
    function freshClientTransData($where) {
        $tpl =  'client/db/transVisitTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
	    $sql = "SELECT * FROM db_trans_client_acl ";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC); 

        foreach ($result as $key => $array) {
       		$result[$key]['da'] = addrNameDelPreffix($array['da']);
       		$result[$key]['sa'] = addrNameDelPreffix($array['sa']);
    	}
        echo V::getInstance()->assign('clientTrans', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function checkExistTaskAndPort() {
    	$sql    = 'SELECT id FROM db_trans_client_acl WHERE (id+dport) = ' .
            $_GET['idPlusPort']. ' AND id != ' . $_GET['taskId'];
        $db     = new dbsqlite(DB_PATH . '/netgap_db.db');
        $result = $db->query($sql)->getCount() > 0 ? 'false' : 'true';
        echo $result;
    } 
    function getOracleIp() {
    	$db  = new dbsqlite(DB_PATH . '/netgap_db.db');
	    $sql = "SELECT dataip FROM oracle_dataip";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC); 
        return $result;
    }
	function freshOracleDataIp($where) {
		$dataip = $where['oracleDataIp'];
		$cli = new cli();
 		$cmd = "dbctl set dataip value $dataip"; 	
        $cli->run($cmd);
        $tpl =  'client/db/transOracleDataIpTable.tpl';     
        $result = getOracleIp();      
        echo V::getInstance()->assign('data', $result)
            ->assign('localIp', netGapRes::getInstance()->getInterface())
            ->fetch($tpl);
    }
    function getWhereStatement($db, $cols, $keyword) {
        $params = array_fill(0, count(explode(',', $cols)), $keyword);
        return array('sql'    => ' where (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $db->getFilterParams($params));
    }
    function getDataCount() {
    	$sql = "SELECT id FROM db_trans_client_acl";
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
		$keyword='/'.$_GET['keyword'];
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $keyword);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
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
        $id        = intval($_POST['cdbTransId']);
        $dbType    = $_POST['dbType'];
        $sAddress  = $_POST['sAddress'];
        $dAddress  = $_POST['lAddress'];
        $dportReq  = $_POST['cdbTransLport'];
        $filter    = $_POST['filter'];           
        $roleList  = $_POST['roleList'];
        $timeList  = $_POST['timeList'];
        //$killVirus = $_POST['killVirus'] === 'Y' ? 'yes' : 'no';
        $comment   = $_POST['comment'];
        if ($dbType == 'oracle') {
        	$data = getOracleIp();
        	foreach ($data as $d) {
            	$ip = $d;
        	}     	
        	$dataip = " dataip $ip ";
        }else {
        	$dataip = " ";
        }
        $result = "/usr/local/bin/dbctl $action task db $dbType type client mode trans id $id "
        	." sa $sAddress da $dAddress dport $dportReq ".$dataip; 
  
        if ($timeList != '无' ) {
            $result .= " time $timeList ";
        }
	    if ($roleList != '无' ) {
            $result .= " auth $roleList ";
        }
		if ($filter != '' ) {
            $result .= "filter $filter ";
        }	 	                 
        $result .= " comment \"$comment\"";
        return $result;
    }
    function getActionCmd() {
		//组装命令行
        $id = intval($_POST['cdbTransId']);
        $sql = 'SELECT sa, da, dport,time, filter,usergrp' .
            " FROM db_trans_client_acl WHERE id = '$id'";
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);   
        
        $dbType    = $_POST['dbType'];
        $sAddress  = $data['sa'];
        $dAddress  = $data['da'];
        $dportReq  = $data['dport'];
        $filter    = $data['filter'];           
        $roleList  = $data['usergrp'];;
        $timeList  = $data['time'];
        $comment   = $_POST['comment'];

        if ($dbType == 'oracle') {
        	$data = getOracleIp();
        	foreach ($data as $d) {
            	$ip = $d;
        	}    	
        	$dataip = " dataip $ip ";
        }else {
        	$dataip = "";
        }
        $result = "/usr/local/bin/dbctl set task db $dbType type client mode trans id $id "
        	." sa $sAddress da $dAddress dport $dportReq ".$dataip; 
  
        if ($timeList != '' ) {
            $result .= " time $timeList ";
        }
    	if ($roleList != '' ) {
            $result .= " auth $roleList ";
        }
		if ($filter != '' ) {
            $result .= "filter $filter ";
        }	 	                
        $result .= " comment \"$comment\"";
        return $result;
    }
    
    $killVirusIsUsed = antiIsUsed();
    
    if (!empty($_POST['editId'])) {
        // Get specified  data
        $id = $_POST['editId'];
        $sql = 'SELECT id, dbtype, sa, da, dport, time, active, filter, ' .
            "comment,usergrp FROM db_trans_client_acl WHERE id = '$id'";
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $filterOptions = getFilterList();
        $tpl = 'client/db/transVisit_editDialog.tpl';
        $result = V::getInstance()
            ->assign('saddrOptions', netGapRes::getInstance()->getAddr(true))
            ->assign('daddrOptions', netGapRes::getInstance()->getAddr())
            ->assign('filterOptions', $filterOptions)
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('res', $result)
            ->assign('killVirusIsUsed',$killVirusIsUsed)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified  data 
        $id = $_POST['cdbTransId'];     
        $active    = $_POST['active'] === 'Y' ? 'on' : 'off';    
 		$cli = new cli();
 		$cmd = getCmd();
 		$cmd .= " active $active";
 		$cli->setLog("编辑一条id为".$_POST['cdbTransId']."的数据库访问的透明访问控制")->run($cmd);
        echo json_encode(array('msg' => '修改成功。'));	        
        
    }  else if (!empty($_POST['delId'])) {
        // Delete the specified  data
        $delId    = $_POST['delId'];
        $sql = "SELECT dbtype FROM db_trans_client_acl WHERE id =$delId";            
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        foreach ($result as $d) {              
            $dbType = $d;           
        }
        $cmd  = "/usr/local/bin/dbctl del task db $dbType type client mode trans id $delId";
        $cli  = new cli();
        $sql = "delete FROM db_trans_client_acl WHERE id =''";    
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = $db->close();
        $cli->setLog("删除一条id为".$_POST['delId']."的数据库访问的透明访问控制")->run($cmd);
        echo json_encode(array('msg' => "删除成功。"));
    } else if ('add' === $_POST['type']) {
        // Add a new  data        
        $active    = $_POST['active'] === 'Y' ? 'on' : 'off';    
 		$cli = new cli();
 		$cmd = getCmd();
 		$cmd .= " active $active";
 		$cli->setLog("添加一条id为".$_POST['cdbTransId']."的数据库访问的透明访问控制")->run($cmd);
        echo json_encode(array('msg' => '任务[' . intval($_POST['cdbTransId']) . ']添加成功。'));	                     
    }else if (!empty($_POST['openDialog'])) {
        // Display add client trans dialog
        $tpl = 'client/db/transVisit_editDialog.tpl';
        $filterOptions = getFilterList();
        //$result['dport'] = '1521';
        $result = V::getInstance()
        	->assign('res', $result)
        	->assign('saddrOptions', netGapRes::getInstance()->getAddr(true))
            ->assign('daddrOptions', netGapRes::getInstance()->getAddr())
            ->assign('filterOptions', $filterOptions)
            ->assign('timeList', netGapRes::getInstance()->getTimeList())
            ->assign('roleList', netGapRes::getInstance()->getRoleList())
            ->assign('killVirusIsUsed',$killVirusIsUsed)
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($action = $_POST['action']) {
        // enable or disable specified acl
    	if ($action === 'disable') {
        	$active = 'off';
        	$act="停止";	
        }else {
        	$active = 'on';
        	$act="开启";		
        }          
        $cli = new cli();
        $cmd = getActionCmd();
        $cmd .= " active $active";
        $cli->setLog("$act id为".$_POST['cdbTransId']."的数据库访问的透明访问控制")->run($cmd);
        echo json_encode(array('msg' => $act.'成功。'));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort client trans list
        freshClientTransData($orderStatement);
    } else if ($oracleDataIp = $_POST['oracleDataIp']) {
        // fresh and resort oracle ip 
        freshOracleDataIp($oracleDataIp);
    } else if (!empty($_GET['checkExistId'])) {
        // Check the same id exist or not
        echo netGapRes::getInstance()->checkExistTaskId('trans',intval($_GET['cdbTransId']));
    }else if (!empty($_GET['checkExistTaskAndPort'])) {
        // check the new name existed or not
        checkExistTaskAndPort();
        return true;
    }else {
        // init page data
        $result = getDataCount();
        $data = getOracleIp(); 
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2)
	        ->assign('data', $data)
	        ->assign('localIp', netGapRes::getInstance()->getInterface());
    }
?>
