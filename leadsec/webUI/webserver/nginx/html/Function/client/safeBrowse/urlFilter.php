<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendUrlData($where) {
        $tpl =  'client/safeBrowse/urlFilterTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
	    $sql = "SELECT * FROM url WHERE type='U' $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('urlFilter', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT list FROM url WHERE type='U'";
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        return $db->query($sql)->getCount();
    }

    if (!empty($_POST['editList'])) {
        // Open a specified safepass data
        $tpl = $_POST['tpl'];
        $list  = $_POST['editList'];
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        $sql = "SELECT * FROM url WHERE type='U' AND list='$list'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);       
        $result = V::getInstance()
        	->assign('editUrl', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
     } else if (isset($_POST['openAddDialog'])) {
        // Open a new safepass dialog
        $tpl = $_POST['tpl'];
        $result = V::getInstance()
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified safepass data
        $delList = $_POST['hid_list'];
        $addLisr = $_POST['url_list'];
        $comment = $_POST['comment'];
        $cmd = "httpctl del url \"$delList\"";
        $cmd1 = "httpctl add url \"$addLisr\" comment \"$comment\"";
        $cli = new cli();
        $cli->run($cmd);
        $cli->run($cmd1);
        $cli->run("httpctl	reconfigure ");
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new safepass data
        $addLisr = $_POST['url_list'];
        $comment = $_POST['comment'];
        $cmd = "httpctl add url \"$addLisr\" comment \"$comment\"";
        $cli = new cli();
        $cli->run($cmd);
        $cli->run("httpctl reconfigure ");
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['delList'])) {
        // Delete the specified safepass data 
        $delList = $_POST['delList'];  
        $cmd = "httpctl del url \"$delList\"";     
        $cli = new cli();
        $cli->run($cmd);
        $cli->run("httpctl	reconfigure ");
        echo json_encode(array('msg' => "删除成功."));
   } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort safepass list
        appendUrlData($orderStatement);
    } else if (!empty($_GET['checkExistList'])) {
    	if ($_GET['edit'] === 'edit' && ($_GET['hi_list'] === $_GET['url_list'])) {
    		echo 'true';
    		return;
    	}
    	echo netGapRes::getInstance()->checkExistTaskId('filterList',$_GET['url_list']);
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
