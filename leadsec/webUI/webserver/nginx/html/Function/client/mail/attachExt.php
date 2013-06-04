<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendAttachExtData($where) {
        $tpl =  'client/mail/attachExtTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
	    $sql = "SELECT * FROM attach_ext";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $data['sql'];
        	$params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('attach', $result)
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
    	$sql = "SELECT id FROM attach_ext";
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }
    
    function getCmd($type) {
    	if($type === 'del') {
    		$id = $_POST['delId'];
    		return "mailresource del attachext id $id";
    	} else {
    		$id = $_POST['id'];
    	}
    	if($type === 'add') {
    		$action = 'add';
    	} else {
    		$action = 'set';
    	}
    	$name = $_POST['attachName'];    	
    	$arr = $_POST['attachList'];    	
        $attach = join(',',$arr);
        $comment = $_POST['comment'];
    	$cmd = "mailresource $action attachext name $name value $attach comment $comment";
    	return $cmd;
    }

    function checkExt(){
    	$db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
    	$sql = "SELECT * FROM filter WHERE allowext = '".$_POST['delName']."'";
    	return $db->query($sql)->getCount();
    }
    
    if (!empty($_POST['editId'])) {
        // Open a specified attachExt data
        $tpl = $_POST['tpl'];
        $id  = $_POST['editId'];
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
        $sql = "SELECT * FROM attach_ext WHERE id='$id'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $attachList = split(',',$result['value']);
        $result = V::getInstance()
        	->assign('editAtt', $result)
        	->assign('attachList', $attachList)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
     } else if (isset($_POST['openAddDialog'])) {
        // Open a new attachExt dialog
        $tpl = $_POST['tpl'];
        $result = V::getInstance()
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified attachExt data
        $cli = new cli();
    	$name = $_POST['attachName'];    	
        $cli->setLog("修改邮件访问模块下名称为{$name}的附件扩展名")
            ->run(getCmd('edit'));
        echo json_encode(array('msg' => '修改成功。'));
    } else if ('add' === $_POST['type']) {
        // Add a new attachExt data
        $cli = new cli();
    	$name = $_POST['attachName'];    	
        $cli->setLog("添加邮件访问模块下名称为{$name}的附件扩展名")
            ->run(getCmd('add'));
        echo json_encode(array('msg' => '添加成功。'));
    } else if (!empty($_POST['delId'])) {
        // Delete the specified attachExt data 
    	$rc = checkExt();
    	if($rc != 0){
    		echo json_encode(array('msg' => "此附件扩展名策略被引用，不能被删除。"));
    	}else{
    		$cli = new cli();
    		$id = $_POST['delId'];
    		$cli->setLog("删除邮件访问模块下id为{$id}的附件扩展名")
    		->run(getCmd('del'));
    		echo json_encode(array('msg' => "删除成功。"));
    	}
   } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort attachExt list
        appendAttachExtData($orderStatement);
    } else if (!empty($_GET['checkExistName'])) {
    	echo netGapRes::getInstance()->checkExistTaskId('attachExt',$_GET['attachName']);
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
