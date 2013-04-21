<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendUserManageData($where) {
        $tpl =  'client/safeBrowse/localUsrManageTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
	    $sql = "SELECT * FROM user $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);        
        echo V::getInstance()->assign('UsrMng', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT name FROM user";
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        return $db->query($sql)->getCount();
    }

    function getCmd() {
    	if (!empty($_POST['delName'])) {
    		$delName     = $_POST['delName'];    		
    		$cmd = "httpctl del user $delName";
    		return $cmd;
    	}
        $type = $_POST['type'];
        
		if ($type === 'edit') {			
			$act = 'set';            
        } else {
        	$act = 'add';
        }
        $name    	= $_POST['usrName'];
        $comment    = $_POST['comment'];
        if ($type === 'edit' && $_POST['modifyEnable'] !== 'on') {
        	$passwd	= "";
        } else {
        	$passwd	= "passwd \"" . $_POST['psswd1'] ."\"";
    	}
		$cmd = "httpctl $act user name \"$name\" $passwd comment \"$comment\"";
        return $cmd;
    }    

    if (!empty($_POST['editName'])) {
        // Open a specified safepass data
        $tpl = $_POST['tpl'];
        $editName  = $_POST['editName'];
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        $sql = "SELECT * FROM user WHERE name = '$editName'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);       
        $result = V::getInstance()
        	->assign('editUsrMng', $result)
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
        $cmd = getCmd();
        $cli = new cli();
        $cli->setLog("修改本地用户".$_POST['usrName']."的配置")->run($cmd);
        $cli->setLog("修改安全浏览配置")->run("httpctl reconfigure ");
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new safepass data
        $cmd = getCmd();
        $cli = new cli();
        $cli->setLog("添加名为".$_POST['usrName']."的本地用户")->run($cmd);
        $cli->setLog("修改安全浏览配置")->run("httpctl reconfigure ");
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['delName'])) {
        // Delete the specified safepass data   
        $cmd = getCmd();     
        $cli = new cli();
        $cli->setLog("删除名为".$_POST['delName']."的本地用户")->run($cmd);
        $cli->setLog("修改安全浏览配置")->run("httpctl reconfigure ");
        echo json_encode(array('msg' => "删除成功."));
   } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort safepass list
        appendUserManageData($orderStatement);
    } else if (!empty($_GET['checkExistName'])) {
    	echo netGapRes::getInstance()->checkExistTaskId('localUsrMng',$_GET['usrName']);
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
