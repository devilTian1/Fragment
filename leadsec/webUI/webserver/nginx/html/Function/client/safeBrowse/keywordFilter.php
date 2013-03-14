<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendKeywordData($where) {
        $tpl =  'client/safeBrowse/keywordFilterTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
	    $sql = "SELECT * FROM context $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('keywordFilter', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT id FROM context";
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        return $db->query($sql)->getCount();
    }

    if (!empty($_POST['editId'])) {
        // Open a specified keywordFilter data
        $tpl = $_POST['tpl'];
        $id  = $_POST['editId'];
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        $sql = "SELECT * FROM context WHERE id='$id'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $contextList = split(',',$result['context']);
        $result = V::getInstance()
        	->assign('editKey', $result)
        	->assign('contextList', $contextList)
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
        $id = $_POST['id'];
        $name = $_POST['keyName'];
        $contextArr = $_POST['contextList'];
        $context = join(',',$contextArr);
        $comment = $_POST['comment'];        
        $cmd = "http_blacklistctl del unallowedcontext id \"$id\"";
        $cmd1 = "http_blacklistctl add unallowedcontext name \"$name\" \"$context\" comment \"$comment\"";
        $cli = new cli();
        $cli->run($cmd);
        $cli->run($cmd1);
        $cli->run("http_blacklistctl reconfigure ");
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new keywordFilter data
        $name = $_POST['keyName'];
        $contextArr = $_POST['contextList'];
        $context = join(',',$contextArr);
        $comment = $_POST['comment'];
        $cmd = "http_blacklistctl add unallowedcontext name \"$name\" \"$context\" comment \"$comment\" ";
        $cli = new cli();
        $cli->run($cmd);
        $cli->run("http_blacklistctl reconfigure ");
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['delId'])) {
        // Delete the specified keywordFilter data 
        $id = $_POST['delId'];  
        $cmd = "http_blacklistctl del unallowedcontext id \"$id\"";     
        $cli = new cli();
        $cli->run($cmd);
        $cli->run("http_blacklistctl reconfigure ");
        echo json_encode(array('msg' => "删除成功."));
   } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort keywordFilter list
        appendKeywordData($orderStatement);
    } else if (!empty($_GET['checkExistName'])) {
    	echo netGapRes::getInstance()->checkExistTaskId('filterKeyword',$_GET['keyName']);
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
