<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendKeywordData($where) {
        $tpl =  'client/mail/keywordTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
	    $sql = "SELECT * FROM keyword";
	    $params = array();
	    if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
	    	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
	    	$sql   .= $data['sql'];
	    	$params = $data['params'];
	    }
	    $sql .=  ' ' . $where;
	    $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('keyword', $result)
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
    	$sql = "SELECT id FROM keyword";
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
    		return "mailresource del keyword id $id";
    	} else {
    		$id = $_POST['id'];
    	}
    	if($type === 'add') {
    		$action = 'add';
    	} else {
    		$action = 'set';
    	}
    	$name = $_POST['keywordName'];    	
    	$keywordArr = $_POST['keywordList'];
        $keyword = join(',', $keywordArr);
        $keywordType = $_POST['keywordType'] === 'subject' ? 'subject' : 'context';
        $comment = $_POST['comment'];
    	$cmd = "mailresource $action keyword name $name value $keyword type $keywordType comment $comment";
    	return $cmd;
    }

    function checkKeyword($delname){
    	$db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
    	$sql = "SELECT * FROM filter WHERE skeyword = '".$delname."' OR ckeyword = '".$delname."'";
    	return $db->query($sql)->getCount();
    }
    
    if (!empty($_POST['editId'])) {
        // Open a specified keywordFilter data
        $tpl = $_POST['tpl'];
        $id  = $_POST['editId'];
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
        $sql = "SELECT * FROM keyword WHERE id='$id'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $keywordList = split(',',$result['value']);
        $keywordType = $result['type'] === '主题' ? 'subject' : 'context';
        $result = V::getInstance()
        	->assign('editKeyword', $result)
        	->assign('keywordList', $keywordList)
        	->assign('keywordType', $keywordType)
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
    	$name = $_POST['keywordName'];
    	$rc = checkKeyword($name);
    	if($rc != 0){
    		echo json_encode(array('msg' => "此内容关键字策略被引用，不能被修改。"));
    	}else{
    		$cli->setLog("修改邮件访问模块下的内容关键字, 名称为{$name}")
    		->run(getCmd('edit'));
    		echo json_encode(array('msg' => '修改成功。'));
    	}       
    } else if ('add' === $_POST['type']) {
        // Add a new keywordFilter data
        $cli = new cli();
    	$name = $_POST['keywordName'];
        $cli->setLog("添加邮件访问模块下的内容关键字, 名称为{$name}")
            ->run(getCmd('add'));
        echo json_encode(array('msg' => '添加成功。'));
    } else if (!empty($_POST['delId'])) {
        // Delete the specified keywordFilter data 
    	$rc = checkKeyword($_POST['delName']);
    	if($rc != 0){
    		echo json_encode(array('msg' => "此内容关键字策略被引用，不能被删除。"));
    	}else{
    		$cli = new cli();
    		$id  = $_POST['delId'];
    		$cli->setLog("删除邮件访问模块下的内容关键字, id为{$id}")
    		->run(getCmd('del'));
    		echo json_encode(array('msg' => "删除成功。"));
    	}
   } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort keywordFilter list
        appendKeywordData($orderStatement);
    } else if (!empty($_GET['checkExistName'])) {
    	echo netGapRes::getInstance()->checkExistTaskId('keyword',$_GET['keywordName']);
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
