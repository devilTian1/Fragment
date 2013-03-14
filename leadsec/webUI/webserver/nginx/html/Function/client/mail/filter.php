<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendFilterData($where) {
        $tpl =  'client/mail/filterTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
	    $sql = "SELECT * FROM filter $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('filter', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT id FROM filter";
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
        return $db->query($sql)->getCount();
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
        $av       = $_POST['fileav'];
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
            $result .= "skeyword $ckeyword ";
        } else {
            $result .= 'skeyword novalue ';
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

    if ($id = $_POST['editId']) {
        // Open a specified attachExt data
        $tpl  = 'client/mail/filter_editDialog.tpl';
        $db   = new dbsqlite(DB_PATH . '/netgap_mail.db');
        $sql  = "SELECT * FROM filter WHERE id = '$id'";
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
        $tpl = 'client/mail/filter_editDialog.tpl';
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
        $cli = new cli();
        $cli->run(getCmd('edit'));
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new attachExt data
        $cli = new cli();
        $cli->run(getCmd('add'));
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['delId'])) {
        // Delete the specified attachExt data 
        $cli = new cli();
        $cli->run(getCmd('del'));
        echo json_encode(array('msg' => "删除成功."));
   } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort attachExt list
        appendFilterData($orderStatement);
    } else if (!empty($_GET['checkExistName'])) {
        $sql = "SELECT id FROM filter WHERE name = '" .
            $_GET['MfilterName'] . "'";
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
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
