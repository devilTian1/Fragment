<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
	   
    function freshUserFilterData($where) {
        $tpl =  'client/db/userFilterTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        $where = $db->replaceAlp($where, 'name');
	    $sql = "SELECT id, name, allow, usrnamelist, comment FROM 
	    	db_user_filter ";
	    $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	if($_GET['keyword'] === '阻止'){
        		$sql .= ' where allow=\'F\' or (comment like \'%阻止%\')';
        	}else if($_GET['keyword'] === '允许'){
        		$sql .= ' where allow=\'A\' or (comment like \'%允许%\')';
        	}else{
        		$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        		$sql   .= $data['sql'];
        		$params = $data['params'];
        	}
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
    	$sql = "SELECT id FROM db_user_filter";
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        if($_GET['keyword'] === '阻止'){
        		$sql .= ' where allow=\'F\' or (comment like \'%阻止%\')';
        	}else if($_GET['keyword'] === '允许'){
        		$sql .= ' where allow=\'A\' or (comment like \'%允许%\')';
        	}else{
        		$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        		$sql   .= $data['sql'];
        		$params = $data['params'];
        	}
        }
        return $db->query($sql, $params)->getCount();        
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
        $name   = $_POST['userName'];
        $userNameList    = $_POST['userFilterNameList'];
        $filterMold  = $_POST['filterMold']; 
        if ($filterMold === 'A') {
        	$filter = 'allow';	
        }else if ($filterMold === 'F'){
        	$filter = 'forbidden';	
        }   
        $comment   = $_POST['comment'];        
        $result = "dbctl $action usergrp name $name user $userNameList "
        	." action $filter";  	                  
        $result .= " comment \"$comment\"";
        return $result;
    }

    if (!empty($_POST['editId'])) {
        // Get specified data
        $tpl =  'client/db/userFilter_editDialog.tpl';
        $name  = $_POST['editId']; 
               // print_r($id);   
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        $sql = "SELECT id, name, allow, usrnamelist, comment FROM 
        	db_user_filter where name = '$name'";
        $userFilter = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
       // print_r($userFilter);
        $result = V::getInstance()->assign('res', $userFilter)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified addr group data
        $name = $_POST['userName'];
        $cmd = getCmd();
        $cli  = new cli();
        $cli->setLog("编辑名称为".$_POST['userName']."的用户过滤")->run($cmd);
        echo json_encode(array('msg' => "[$name]修改成功。"));
    } else if ('add' === $_POST['type']) {
        // Add a new  data
        $name = $_POST['userName'];
        $cmd = getCmd();
        $cli  = new cli();
		$cli->setLog("添加名称为".$_POST['userName']."的用户过滤")->run($cmd);
        echo json_encode(array('msg' => "[$name]添加成功。"));
    } else if (!empty($_POST['delName'])) {
        // Delete the specified  data
        $name = $_POST['delName'];
        $cmd  = "dbctl del usergrp name \"$name\"";
        $cli  = new cli();
        $cli->setLog("删除名称为".$_POST['delName']."的用户过滤")->run($cmd);
        echo json_encode(array('msg' => "[$name]删除成功。"));
    } else if (!empty($_POST['openDialog'])) {
        // Display add dialog
        $tpl =  'client/db/userFilter_editDialog.tpl';
        $userFilter['allow'] = 'F';
        $result = V::getInstance()
            ->assign('res',$userFilter)
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($_GET['checkExistUserName']) {
        // enable or disable specified acl
    	$sql = 'SELECT name FROM db_user_filter WHERE name = "' .
            $_GET['userName'] . '"';
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort list
        freshUserFilterData($orderStatement);
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
