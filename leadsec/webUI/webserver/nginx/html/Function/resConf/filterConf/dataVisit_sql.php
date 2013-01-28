<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshSqlFilterData($where) {
        $tpl =  'resConf/filterConf/dataVisit_sqlTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
	    $sql = "SELECT id, name, allow, sqllist, comment FROM db_sql_filter $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);  
        echo V::getInstance()->assign('res', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT id FROM db_sql_filter";
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        return $db->query($sql)->getCount();
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
        $name    = $_POST['name'];
        $cmdInfo = $_POST['cmdInfo'];
        $sqlList = join(',', $cmdInfo);
        $sqlList = $sqlList.",";
        $filterMold = $_POST['filterMold']; 
        if ($filterMold === 'A') {
        	$filter = 'allow';	
        }else if ($filterMold === 'F'){
        	$filter = 'forbidden';	
        }   
        $comment   = $_POST['comment'];        
        $result = "dbctl $action sqlgrp name $name value $sqlList "
        	." action $filter";  	                  
        $result .= " comment \"$comment\"";
        $cmdArr = array($result,"dbctl reconfigure");
        return $cmdArr;
    }

    if (!empty($_POST['editId'])) {
        // Get specified data
        $tpl =  'resConf/filterConf/dataVisit_sql_editDialog.tpl';
        $id  = $_POST['editId'];   
        $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
        $sql = "SELECT id, name, allow, sqllist, comment FROM 
        	db_sql_filter where id = $id";
        $userFilter = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $userFilter['sqllist'] = explode(',', $userFilter['sqllist']);
        $result = V::getInstance()->assign('res', $userFilter)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified addr group data
        $name = $_POST['name'];
        $cmdArr = getCmd();
        $cli  = new cli();
    	foreach ($cmdArr as $cmd) {
	    	$cli->run($cmd);
	    }
        echo json_encode(array('msg' => "[$name]修改成功."));
    } else if ('add' === $_POST['type']) {
        // Add a new  data
        $name = $_POST['name'];
        $cmdArr = getCmd();
        $cli  = new cli();
    	foreach ($cmdArr as $cmd) {
	    	$cli->run($cmd);
	    }
        echo json_encode(array('msg' => "[$name]添加成功."));
    } else if (!empty($_POST['delName'])) {
        // Delete the specified  data
        $name = $_POST['delName'];
        $cmdArr = array("dbctl del sqlgrp name \"$name\"",
        	"dbctl reconfigure");
	    $cli    = new cli();
	    foreach ($cmdArr as $cmd) {
	    	$cli->run($cmd);
	    }
        echo json_encode(array('msg' => "[$name]删除成功."));
    } else if (!empty($_POST['openDialog'])) {
        // Display add dialog
        $tpl =  'resConf/filterConf/dataVisit_sql_editDialog.tpl';
        $userFilter['allow'] = 'F';
        $result = V::getInstance()
            ->assign('res',$userFilter)
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort list
        freshSqlFilterData($orderStatement);
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
