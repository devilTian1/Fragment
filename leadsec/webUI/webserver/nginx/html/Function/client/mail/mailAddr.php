<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendMailAddrData($where) {
        $tpl =  'client/mail/mailAddrTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
	    $sql = "SELECT * FROM mailaddr";
        $params = array();
	    if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
	    	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
	    	$sql   .= $data['sql'];
	    	$params = $data['params'];
	    }
	    $sql .=  ' ' . $where;
	    $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('mailAddr', $result)
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
    	$sql = "SELECT id FROM mailaddr";
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
    		return "mailresource del mailaddr id $id";
    	} else {
    		$id = $_POST['id'];
    	}
    	if($type === 'add') {
    		$action = 'add';
    	} else {
    		$action = 'set';
    	}
    	$name = $_POST['mailName'];    	
    	$mailArr = $_POST['mailList'];
        $mail = join(',',$mailArr);
        $mailType = $_POST['mailType'] === 'recv' ? 'recv' : 'sender';
        $comment = $_POST['comment'];
    	$cmd = "mailresource $action mailaddr name $name value $mail type $mailType comment $comment";
    	return $cmd;
    }

    function checkMailAddr(){
    	$db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
    	$sql = "SELECT * FROM filter WHERE allowsender = '".$_POST['delName']."' OR allowrecv = '".$_POST['delName']."'";
    	return $db->query($sql)->getCount();
    }
    
    if (!empty($_POST['editId'])) {
        // Open a specified keywordFilter data
        $tpl = $_POST['tpl'];
        $id  = $_POST['editId'];
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
        $sql = "SELECT * FROM mailaddr WHERE id='$id'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $mailList = split(',',$result['value']);
        $mailType = $result['type'] === '收件人' ? 'recv' : 'sender';
        $result = V::getInstance()
        	->assign('editMail', $result)
        	->assign('mailList', $mailList)
        	->assign('mailType', $mailType)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
     } else if (isset($_POST['openAddDialog'])) {
        // Open a new keywordFilter dialog
        $tpl = $_POST['tpl'];
        $result = V::getInstance()
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified keywordFilter data
        $cli  = new cli();
    	$name = $_POST['mailName'];    	
        $cli->setLog("修改邮件访问模块下的邮件地址, 名称为{$name}")
            ->run(getCmd('edit'));
        echo json_encode(array('msg' => '修改成功。'));
    } else if ('add' === $_POST['type']) {
        // Add a new keywordFilter data
        $cli = new cli();
    	$name = $_POST['mailName'];    	
        $cli->setLog("添加邮件访问模块下的邮件地址, 名称为{$name}")
            ->run(getCmd('add'));
        echo json_encode(array('msg' => '添加成功。'));
    } else if (!empty($_POST['delId'])) {
        // Delete the specified keywordFilter data 
    	$rc = checkMailAddr();
    	if($rc != 0){
    		echo json_encode(array('msg' => "此邮件地址策略被引用，不能被删除。"));
    	}else{
    		$cli = new cli();
    		$id  = $_POST['delId'];
    		$cli->setLog("删除邮件访问模块下的邮件地址, id为{$id}")
    		->run(getCmd('del'));
    		echo json_encode(array('msg' => "删除成功。"));
    	}
   } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort keywordFilter list
        appendMailAddrData($orderStatement);
    } else if (!empty($_GET['checkExistName'])) {
    	echo netGapRes::getInstance()->checkExistTaskId('mailAddr',$_GET['mailName']);
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
