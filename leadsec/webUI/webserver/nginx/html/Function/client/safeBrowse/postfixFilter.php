<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendPostfixData($where) {
        $tpl =  'client/safeBrowse/postfixFilterTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
	    $sql = "SELECT * FROM url WHERE type='P' $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('postfixFilter', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT list FROM url WHERE type='P'";
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        return $db->query($sql)->getCount();
    }

    if (!empty($_POST['editList'])) {
        // Open a specified safepass data
        $tpl = $_POST['tpl'];
        $list  = $_POST['editList'];
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        $sql = "SELECT * FROM url WHERE type='P' AND list='$list'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);       
        $result = V::getInstance()
        	->assign('editPostfix', $result)
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
        $addLisr = $_POST['postfix_list'];
        $comment = $_POST['comment'];
        $cmd = "httpctl del postfix \"$delList\"";
        $cmd1 = "httpctl add postfix \"$addLisr\" comment \"$comment\"";
        $cli = new cli();
        $cli->setLog("删除一条文件后缀名为{$delList}的过滤配置")->run($cmd);
        $cli->setLog("添加一条文件后缀名为{$addLisr}的过滤配置")->run($cmd1);
        $cli->setLog("修改安全浏览配置")->run("httpctl reconfigure ");
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new safepass data
        $addLisr = $_POST['postfix_list'];
        $comment = $_POST['comment'];
        $cmd = "httpctl add postfix \"$addLisr\" comment \"$comment\"";
        $cli = new cli();
        $cli->setLog("添加一条文件后缀名为{$addLisr}的过滤配置")->run($cmd);
        $cli->setLog("修改安全浏览配置")->run("httpctl reconfigure ");
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['delList'])) {
        // Delete the specified safepass data 
        $delList = $_POST['delList'];  
        $cmd = "httpctl del postfix \"$delList\"";     
        $cli = new cli();
        $cli->setLog("删除一条文件后缀名为{$delList}的过滤配置")->run($cmd);
        $cli->setLog("修改安全浏览配置")->run("httpctl reconfigure ");
        echo json_encode(array('msg' => "删除成功."));
   } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort safepass list
        appendPostfixData($orderStatement);
    } else if (!empty($_GET['checkExistList'])) {
    	if ($_GET['edit'] === 'edit' && ($_GET['hi_list'] === $_GET['postfix_list'])) {
    		echo 'true';
    		return;
    	}
    	echo netGapRes::getInstance()->checkExistTaskId('filterList',$_GET['postfix_list']);
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
