<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendBannedContentData($where) {
        $tpl =  'client/msgTrans/callowedContentTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $sql = "SELECT * FROM msg_filter_whitelist $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('bannedContent', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $sql = 'SELECT whitelist FROM msg_filter_whitelist';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        return $db->query($sql)->getCount();
    }

    if ($whitelist = $_POST['editId']) {
        // Display dialog of specified banned content data
        $tpl  = 'client/msgTrans/ceditAllowedContentDialog.tpl';
        $sql  = "SELECT * FROM msg_filter_whitelist WHERE whitelist = '$whitelist'";
        $db   = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit specified banned content data
        $whitelist  = $_POST['cwhitelist'];
        $cmdArr = array("msgctl del whitelist \"$whitelist\"",
        	"msgctl add whitelist \"$whitelist\"","msgctl restart");         	 	      	
        $cli = new cli(); 
    	foreach ($cmdArr as $cmd) {
            $cli->run($cmd);
        }       
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // add a new banned content data
        $whitelist  = $_POST['cwhitelist'];
        $cmdArr = array("msgctl add whitelist \"$whitelist\"",
        	"msgctl restart");        	
        $cli = new cli(); 
    	foreach ($cmdArr as $cmd) {
            $cli->run($cmd);
        }  
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($whitelist = $_POST['delId']) {
        // delete specified banned content data
        $cmdArr = array("msgctl del whitelist \"$whitelist\"",
        	"msgctl restart");        	      	
        $cli = new cli(); 
    	foreach ($cmdArr as $cmd) {
            $cli->run($cmd);
        } 
        echo json_encode(array('msg' => '删除成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display dialog to add banned content data
        $tpl  = 'client/msgTrans/ceditAllowedContentDialog.tpl';
        $result = V::getInstance()->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_GET['checkExistcWhitelist'])) {
        // Check the same file name  exist or not
        $sql = 'SELECT whitelist FROM msg_filter_whitelist WHERE whitelist = "' .
            $_GET['cwhitelist'] . '"';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort file sync client table data
        appendBannedContentData($orderStatement);
    } else if (!empty($_POST['ctl'])) {
        // switch control service
        $bl = 'off';
        if ('on' === $_POST['whilist']) {
            $bl = 'on';
        }
    	$cli = new cli();
        $cmdArr[]=array("msgctl set basic whitelist $bl",
        	"msgctl restart"); 
    	foreach ($cmdArr as $cmd) {
            $cli->run($cmd);
        }
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
