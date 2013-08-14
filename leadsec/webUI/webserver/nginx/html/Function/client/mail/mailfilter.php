<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendFilterData($where) {
        $tpl =  'client/mail/mailfilterTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
	    $sql = "SELECT * FROM filter";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $data['sql'];
        	$params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('filter', $result)
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
    	$sql = "SELECT id FROM filter";
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
    		return "mailresource del filter id $id";
    	} else {
    		$id = $_POST['id'];
    	}
    	if($type === 'add') {
    		$action = 'add';
    	} else {
    		$action = 'set';
    	}
    	$name     = $_POST['MfilterName'];
        $protocol = $_POST['filterProtocol'];
    	$max      = $_POST['attachmax'];
        $allowext = $_POST['allowextList'];
        $sender   = $_POST['senderList'];
        $sfilter  = $_POST['sendfilter'];
        $recv     = $_POST['recvList'];
        $rfilter  = $_POST['recvfilter'];
        $skeyword = $_POST['skeywordList'];
        $ckeyword = $_POST['ckeywordList'];
        $av       = 'off';
        $comment  = $_POST['comment'];

        $result   = "mailresource $action filter name $name " .
            "protocol $protocol attachmaxsize $max ";
        if (!empty($sender)) {
            $result .= "allowsender $sender ";
        } else {
            $result .= 'allowsender novalue ';
        }
        if (!empty($sfilter)) {
            $result .= "sflag '$sfilter' ";
        } else {
            $result .= "sflag '' ";
        }
        if (!empty($recv)) {
            $result .= "allowrecv $recv ";
        } else {
            $result .= 'allowrecv novalue ';
        }
        if (!empty($rfilter)) {
            $result .= "rflag '$rfilter' ";
        } else {
            $result .= "rflag '' ";
        }
        if (!empty($skeyword)) {
            $result .= "skeyword $skeyword ";
        } else {
            $result .= 'skeyword novalue ';
        }
        if (!empty($ckeyword)) {
            $result .= "ckeyword $ckeyword ";
        } else {
            $result .= 'ckeyword novalue ';
        }
        if (!empty($allowext)) {
            $result .= "allowext $allowext ";
        } else {
            $result .= 'allowext novalue ';
        }
        $result .= "av $av ";
        if (!empty($comment)) {
            $result .= "comment $comment";
        } else {
            $result .= 'comment';
        }
    	return $result;
    }

    function checkMailFilter($name,$action){

    	$db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
    	if($action === 'edit'){
    		$sql1 = "SELECT * FROM pop3_comm_client_acl WHERE active = 'ok' and filter = '$name'";
    		$num1 = $db->query($sql1)->getCount();
    		$sql2 = "SELECT * FROM smtp_comm_client_acl WHERE active = 'ok' and filter = '$name'";
    		$num2 = $db->query($sql2)->getCount();
    		$sql3 = "SELECT * FROM pop3_trans_client_acl WHERE active = 'ok' and filter = '$name'";
    		$num3 = $db->query($sql3)->getCount();
    		$sql4 = "SELECT * FROM smtp_trans_client_acl WHERE active = 'ok' and filter = '$name'";
    		$num4 = $db->query($sql4)->getCount();
    	}else{
    		$sql1 = "SELECT * FROM pop3_comm_client_acl WHERE filter = '$name'";
    		$num1 = $db->query($sql1)->getCount();
    		$sql2 = "SELECT * FROM smtp_comm_client_acl WHERE filter = '$name'";
    		$num2 = $db->query($sql2)->getCount();
    		$sql3 = "SELECT * FROM pop3_trans_client_acl WHERE filter = '$name'";
    		$num3 = $db->query($sql3)->getCount();
    		$sql4 = "SELECT * FROM smtp_trans_client_acl WHERE filter = '$name'";
    		$num4 = $db->query($sql4)->getCount();
    	}   	
    	return $num1+$num2+$num3+$num4;
    }
    
    if ($id = $_POST['editId']) {
        // Open a specified attachExt data
        $tpl  = 'client/mail/mailfilter_editDialog.tpl';
        $db   = new dbsqlite(DB_PATH . '/netgap_mail.db');
        if(!empty($_POST['plug'])){
        	$sql = "SELECT * FROM filter WHERE name = '$id'";
        }else{
        	$sql  = "SELECT * FROM filter WHERE id = '$id'";
        }        
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()
        	->assign('editFilter', $data)
            ->assign('allowextList',
                netGapRes::getInstance()->getMailFilterOpts('allowedext'))
            ->assign('senderList',
                netGapRes::getInstance()->getMailFilterOpts('smailaddr'))
            ->assign('recvList',
                netGapRes::getInstance()->getMailFilterOpts('rmailaddr'))
            ->assign('skeywordList',
                netGapRes::getInstance()->getMailFilterOpts('title'))
            ->assign('ckeywordList',
                netGapRes::getInstance()->getMailFilterOpts('content'))
            //->assign('', ),
        	->assign('filterList', $attachList)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
     } else if (isset($_POST['openAddDialog'])) {
        // Open a new attachExt dialog
        $tpl = 'client/mail/mailfilter_editDialog.tpl';
        $result = V::getInstance()
            ->assign('allowextList',
                netGapRes::getInstance()->getMailFilterOpts('allowedext'))
            ->assign('senderList',
                netGapRes::getInstance()->getMailFilterOpts('smailaddr'))
            ->assign('recvList',
                netGapRes::getInstance()->getMailFilterOpts('rmailaddr'))
            ->assign('skeywordList',
                netGapRes::getInstance()->getMailFilterOpts('title'))
            ->assign('ckeywordList',
                netGapRes::getInstance()->getMailFilterOpts('content'))
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified attachExt data
        $name = $_POST['MfilterName'];
        $rc = checkMailFilter($name,'edit');
    	if($rc != 0){
    		echo json_encode(array('msg' => "此过滤配置策略被引用，不能被修改。"));
    	}else{
        $cli  = new cli();
        $cli->setLog("修改邮件访问模块下的过滤配置, 名称为{$name}")
            ->run(getCmd('edit'));
        echo json_encode(array('msg' => '修改成功。'));
      }
    } else if ('add' === $_POST['type']) {
        // Add a new attachExt data
        $cli  = new cli();
    	$name = $_POST['MfilterName'];
        $cli->setLog("添加邮件访问模块下的过滤配置, 名称为{$name}")
            ->run(getCmd('add'));
        echo json_encode(array('msg' => '添加成功。'));
    } else if (!empty($_POST['delId'])) {
        // Delete the specified attachExt data 
        $name = $_POST['delName'];
    	$rc = checkMailFilter($name,'del');
    	if ($rc != 0) {
            $msg = '此过滤配置策略被引用，不能被删除。';
    		echo json_encode(array('msg' => $msg));
    	} else {
    		$cli = new cli();
    		$cli->setLog("删除邮件访问模块下的过滤配置, 名称为$name")
    		->run(getCmd('del'));
    		echo json_encode(array('msg' => '删除成功。'));
    	}
   } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort attachExt list
        appendFilterData($orderStatement);
    } else if (!empty($_GET['checkExistName'])) {
        $sql = "SELECT id FROM filter WHERE name = '" .
            $_GET['MfilterName'] . "'";
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if (!empty($_POST['selectList'])) {
        // fresh ftp select list
    	$type = $_GET['flag'];
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
	    $sql = "SELECT name FROM filter WHERE protocol = '$type'";
        $d   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	$result = array();
    	foreach ($d as $v) {
    		$result[] = $v['name'];
    	}
	    echo json_encode(array('msg' => $result));
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
