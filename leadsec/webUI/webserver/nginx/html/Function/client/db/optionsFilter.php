<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshOptionsFilterData($where) {
        $tpl =  'client/db/optionsFilterTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
	    $sql = "SELECT id, name, usergrp, sqlgrp, comment FROM db_option_list ";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);   
        echo V::getInstance()->assign('res', $result)
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
    	$sql = "SELECT id FROM db_option_list";
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount(); 
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
	function getOptionFilterInUse($name) {
		$flag = 0;
	 	$db  = new dbsqlite(DB_PATH . '/netgap_db.db');
    	$sql = "SELECT filter FROM db_trans_client_acl WHERE filter = '$name' 
    	     UNION SELECT filter FROM db_comm_client_acl WHERE filter = '$name'";
    	$data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	}
    	return $flag;
	}
    if (!empty($_POST['editId'])) {
        // Get specified data
        $tpl =  'client/db/optionsFilter_editDialog.tpl';
        $id  = $_POST['editId']; 
               // print_r($id);   
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        if(!empty($_POST['plug'])){
	    	$sql = "SELECT * FROM db_option_list WHERE name = '$id'";
	    }else{
	    	$sql = "SELECT * FROM db_option_list WHERE id = '$id'";
	    }  
        //$sql = "SELECT id, name, usergrp, sqlgrp, comment FROM 
        	//db_option_list where id = $id";
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
        $cli->setLog("编辑名称为".$_POST['optionName']."的过滤选项集")->run($cmd);
        echo json_encode(array('msg' => "[$name]修改成功。"));
    } else if ('add' === $_POST['type']) {
        // Add a new  data
        $name        = $_POST['optionName'];
        $cmd = getCmd();
        $cli  = new cli();
        $cli->setLog("添加名称为".$_POST['optionName']."的过滤选项集")->run($cmd);
        echo json_encode(array('msg' => "[$name]添加成功。"));	       
    } else if (!empty($_POST['delName'])) {
        // Delete the specified  data
        $id = $_POST['delName'];
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
    	$sql = "SELECT name FROM db_option_list WHERE id = $id";
    	$result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);   	
    	foreach ($result as $r) {
			$flag = getOptionFilterInUse($r['name']);
    	}
        if ($flag == 1) {       	
        	$msg = "序号为".$id."的过滤选项集被引用，无法删除。";
        	echo json_encode(array('msg' => $msg));
        } else {
        	$cmd  = "dbctl del filter id \"$id\"";
        	$cli  = new cli();
        	$cli->setLog("删除序号为".$_POST['delName']."的过滤选项集")->run($cmd);
        	echo json_encode(array('msg' => "删除成功。"));
        }              
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
    } else if (!empty($_POST['selectList'])) {
        // fresh  select list
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
	    $sql = 'SELECT name FROM db_option_list';
        $d   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	$result = array();
    	foreach ($d as $v) {
    		$result[] = $v['name'];
    	}
	    echo json_encode(array('msg' => $result));
    }else if ($orderStatement = $_POST['orderStatement']) {
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
