<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshOptionsFilterData($where) {
        $tpl =  'client/db/optionsFilterTable.tpl';
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
        $name      = $_POST['optionName'];
        $userName  = $_POST['userNameList'];
        $sqlName   = $_POST['sqlNameList'];          
        $comment   = $_POST['comment'];
	 	      
        $result = "dbctl $action filter name $name ";
        if ($userName != '无') {
            $result .= "usergrp $userName ";
        }
	    if ($sqlName != '无') {
            $result .= "sqlgrp $sqlName ";
        }  	  	                  
        $result .= " comment \"$comment\"";
        return $result;
    }

    if (!empty($_POST['editId'])) {
        // Get specified data
        $tpl =  'client/db/optionsFilter_editDialog.tpl';
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
        $name = $_POST['optionName'];
        $cmd = getCmd();
        $cli  = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[$name]修改成功."));
    } else if ('add' === $_POST['type']) {
        // Add a new  data
        $name        = $_POST['optionName'];
        $cmd = getCmd();
        $cli  = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[$name]添加成功."));	       
    } else if (!empty($_POST['delName'])) {
        // Delete the specified  data
        $id = $_POST['delName'];
        $cmd  = "dbctl del filter id \"$id\"";
        $cli  = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "删除成功."));
    } else if (!empty($_POST['openDialog'])) {
        // Display add dialog
        $tpl =  'client/db/optionsFilter_editDialog.tpl';
        $userList = getUserFilterList();
		$sqlList = getSqlFilterList();
        $result = V::getInstance()
            ->assign('res',$optionsFilter)
            ->assign('userList',$userList)
            ->assign('sqlList',$sqlList)
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    }  else if ($_GET['checkExistOptionsName']) {
        // enable or disable specified acl
    	$sql = 'SELECT name FROM db_option_list WHERE name = "' .
            $_GET['optionName'] . '"';
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
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
