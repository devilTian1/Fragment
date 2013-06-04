<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendUserManageData($where) {
        $tpl =  'client/msgTrans/localUserAuthenTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
	    $sql = "SELECT * FROM msg_user_auth ";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);     
        echo V::getInstance()->assign('UsrMng', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
	function getWhereStatement($db, $cols, $keyword) {
        $value = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' where (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }
    function getDataCount() {
    	$sql = "SELECT username FROM msg_user_auth";
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
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
        	$passwd	= "password \"" . $_POST['psswd1'] ."\"";
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
        $cli->setLog("编辑名称为".$_POST['userAuthenName']."的本地用户认证")->run($cmd);
        $cli->setLog("重新启动消息传输服务")->run("msgctl restart 1>/dev/null");
        echo json_encode(array('msg' => '修改成功。'));
    } else if ('add' === $_POST['type']) {
        // Add a new safepass data
        $cmd = getCmd();
        $cli = new cli();
        $cli->setLog("添加名称为".$_POST['userAuthenName']."的本地用户认证")->run($cmd);
        $cli->setLog("重新启动消息传输服务")->run("msgctl restart 1>/dev/null");
        echo json_encode(array('msg' => '添加成功。'));
    } else if (!empty($_POST['delName'])) {
        // Delete the specified safepass data   
        $cmd = getCmd();     
        $cli = new cli();
        $cli->setLog("删除名称为".$_POST['delName']."的本地用户认证")->run($cmd);
        $cli->setLog("重新启动消息传输服务")->run("msgctl restart 1>/dev/null");
        echo json_encode(array('msg' => "删除成功。"));
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
