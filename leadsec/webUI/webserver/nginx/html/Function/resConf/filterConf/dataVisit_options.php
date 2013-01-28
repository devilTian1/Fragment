<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshOptionsFilterData($where) {
        $tpl =  'resConf/filterConf/dataVisit_optionsTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
	    $sql = "SELECT id, name, usergrp, sqlgrp, comment FROM db_option_list $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);     
        echo V::getInstance()->assign('res', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
    function getDataCount() {
    	$sql = "SELECT id FROM db_option_list";
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        return $db->query($sql)->getCount();
    }
    function getUserFilterList() {
   	   //获得用户名过滤组
   	    $db     = new dbsqlite(DB_PATH . '/netgap_db.db');
        $sql    = 'SELECT name FROM db_user_filter';
        $result = array('' => '无');
        $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($data as $d) {
            $result[] = $d['name'];
        }
        return $result;
    }   
    function getSqlFilterList() {
   	   //获得SQL语句过滤组
   	    $db     = new dbsqlite(DB_PATH . '/netgap_db.db');
        $sql    = 'SELECT name FROM db_sql_filter';
        $result = array('' => '无');
        $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($data as $d) {
            $result[] = $d['name'];
        }
        return $result;
    } 
    function getAllNameList() {
    	//获得已配置的名称
        $sql = "SELECT name FROM db_option_list";            
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        if (count($result) === 0) {
        	$allNameList = array('0' => '');	
        } else {
        	foreach ($result as $k) {       	
        		$allNameList[] = $k['name'];		       	
        	}	
        }       
        return $allNameList ;
    }  
	function getCmd() {
		//组装命令行
        $type = $_POST['type'];
        if ($type === 'add') {
            $action = 'add';
        } elseif ($type === 'edit') {
            $action = 'set';
        } else {
            throw new Exception('fatal action: [' . $type . '].');
        }
        $name      = $_POST['name'];
        $userName  = $_POST['userName'];
        $sqlName   = $_POST['sqlName'];          
        $comment   = $_POST['comment'];        
        $result = "dbctl $action fliter name $name usergrp $userName "
        	." sqlgrp $sqlName";  	                  
        $result .= " comment \"$comment\"";
        return $result;
    }

    if (!empty($_POST['editId'])) {
        // Get specified data
        $tpl =  'resConf/filterConf/dataVisit_options_editDialog.tpl';
        $id  = $_POST['editId']; 
               // print_r($id);   
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        $sql = "SELECT id, name, usergrp, sqlgrp, comment FROM 
        	db_option_list where id = $id";
        $userFilter = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
		$userList = getUserFilterList();
		$sqlList = getSqlFilterList();
        $result = V::getInstance()->assign('res', $userFilter)
        	->assign('userList',$userList)
            ->assign('sqlList',$sqlList)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified addr group data
        $name = $_POST['name'];
        $cmd = getCmd();
        $cli  = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[$name]修改成功."));
    } else if ('add' === $_POST['type']) {
        // Add a new  data
        $name        = $_POST['name'];
        $allNameList = getAllNameList(); 
        if (array_search($name,$allNameList) !== false ) {
        	$msg = "名称为 < $name >的过滤选项组已经存在，请重新设置";
        	echo json_encode(array('msg' => $msg));
        }else {
        	$cmd = getCmd();
        	$cli  = new cli();
        	$cli->run($cmd);
        	echo json_encode(array('msg' => "[$name]添加成功."));	
        }
       
    } else if (!empty($_POST['delName'])) {
        // Delete the specified  data
        $id = $_POST['delName'];
        $cmd  = "dbctl del filter id \"$id\"";
        $cli  = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[$name]删除成功."));
    } else if (!empty($_POST['openDialog'])) {
        // Display add dialog
        $tpl =  'resConf/filterConf/dataVisit_options_editDialog.tpl';
        $userList = getUserFilterList();
		$sqlList = getSqlFilterList();
        $result = V::getInstance()
            ->assign('res',$optionsFilter)
            ->assign('userList',$userList)
            ->assign('sqlList',$sqlList)
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort list
        freshOptionsFilterData($orderStatement);
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
