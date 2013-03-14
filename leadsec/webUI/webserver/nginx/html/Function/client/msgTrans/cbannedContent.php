<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendBannedContentData($where) {
        $tpl =  'client/msgTrans/cbannedContentTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $sql = "SELECT * FROM msg_filter_blacklist $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('bannedContent', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $sql = 'SELECT blacklist FROM msg_filter_blacklist';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        return $db->query($sql)->getCount();
    }

    if ($blacklist = $_POST['editId']) {
        // Display dialog of specified banned content data
        $tpl  = 'client/msgTrans/ceditBannedContentDialog.tpl';
        $sql  = "SELECT * FROM msg_filter_blacklist WHERE blacklist = '$blacklist'";
        $db   = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit specified banned content data
        $blacklist  = $_POST['cblacklist'];
        $editname = $_POST['editname'];
        $cmdArr = array("msgctl del blacklist \"$editname\"",
        	"msgctl add blacklist \"$blacklist\"","msgctl restart");         	 	      	
        $cli = new cli(); 
    	foreach ($cmdArr as $cmd) {
            $cli->run($cmd);
        }       
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // add a new banned content data
        $blacklist  = $_POST['cblacklist'];
        $cmdArr = array("msgctl add blacklist \"$blacklist\"",
        	"msgctl restart");        	
        $cli = new cli(); 
    	foreach ($cmdArr as $cmd) {
            $cli->run($cmd);
        }  
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($blacklist = $_POST['delId']) {
        // delete specified banned content data
        $cmdArr = array("msgctl del blacklist \"$blacklist\"",
        	"msgctl restart");        	      	
        $cli = new cli(); 
    	foreach ($cmdArr as $cmd) {
            $cli->run($cmd);
        } 
        echo json_encode(array('msg' => '删除成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display dialog to add banned content data
        $tpl =  'client/msgTrans/ceditBannedContentDialog.tpl';
        $result = V::getInstance()->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_GET['checkExistcBlacklist'])) {
        // Check the same file name  exist or not
        $sql = 'SELECT blacklist FROM msg_filter_blacklist WHERE blacklist = "' .
            $_GET['cblacklist'] . '"';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort file sync client table data
        appendBannedContentData($orderStatement);
    } else if ($action_chk = $_POST['action_chk']) {
        // 黑名单控制服务  
        if ($action_chk === 'off') {
           	$cmd = "/usr/local/bin/msgctl set basic blacklist off";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "黑名单控制服务已关闭."));
        } else if ($action_chk === 'on') {
            $cmd = "/usr/local/bin/msgctl set basic blacklist on"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "黑名单控制服务已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    } else {
        // init page data
        $result = getDataCount();
     	$db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $sql = "SELECT blacklist_status FROM msg_ctl_status";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach($data as $d){
        	$status = $d;	
        }
        V::getInstance()->assign('dataCount', $result)
        	->assign('status', $status)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
