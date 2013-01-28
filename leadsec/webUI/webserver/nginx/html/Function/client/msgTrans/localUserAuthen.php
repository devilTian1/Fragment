<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendUserManageData($where) {
        $tpl =  'client/msgTrans/localUserAuthenTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
	    $sql = "SELECT * FROM msg_user_auth $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);        
        echo V::getInstance()->assign('UsrMng', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT username FROM msg_user_auth";
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        return $db->query($sql)->getCount();
    }

    function getCmd() {
    	if (!empty($_POST['delName'])) {
    		$delName     = $_POST['delName'];    		
    		$cmd = "msgctl del user type auth name  $delName";
    		return $cmd;
    	}
        $type = $_POST['type'];
        
		if ($type === 'edit') {			
			$act = 'set';            
        } else {
        	$act = 'add';
        }
        $name    	= $_POST['userAuthenName'];
        if ($type === 'edit' && $_POST['modifyEnable'] !== 'on') {
        	$passwd	= "";
        } else {
        	$passwd	= "passwd \"" . $_POST['psswd1'] ."\"";
    	}
		$cmd = "msgctl $act user type auth name  \"$name\" $passwd ";
        return $cmd;
    }    

    if (!empty($_POST['editName'])) {
        // Open a specified safepass data
        $tpl = 'client/msgTrans/localUserAuthen_editDialog.tpl';
        $editName  = $_POST['editName'];
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $sql = "SELECT * FROM msg_user_auth WHERE username = '$editName'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);       
        $result = V::getInstance()
        	->assign('editUsrMng', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
     } else if (isset($_POST['openAddDialog'])) {
        // Open a new safepass dialog
        $tpl = 'client/msgTrans/localUserAuthen_editDialog.tpl';
        $result = V::getInstance()
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified safepass data
        $cmd = getCmd();
        $cli = new cli();
        $cli->run($cmd);
        $cli->run("msgctl	reconfigure ");
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new safepass data
        $cmd = getCmd();
        $cli = new cli();
        $cli->run($cmd);
        $cli->run("msgctl reconfigure ");
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['delName'])) {
        // Delete the specified safepass data   
        $cmd = getCmd();     
        $cli = new cli();
        $cli->run($cmd);
        $cli->run("msgctl reconfigure ");
        echo json_encode(array('msg' => "删除成功."));
   } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort safepass list
        appendUserManageData($orderStatement);
    } else if (!empty($_GET['checkExistAuthenName'])) {
    	$sql = 'SELECT username FROM msg_user_auth WHERE username = "' .
            $_GET['userAuthenName'] . '"';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
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
