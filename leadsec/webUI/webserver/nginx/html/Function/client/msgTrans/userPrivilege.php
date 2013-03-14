<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendUserManageData($where) {
        $tpl =  'client/msgTrans/userPrivilegeTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
	    $sql = "SELECT * FROM msg_user_privilege $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);        
        echo V::getInstance()->assign('UsrMng', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
    	$sql = "SELECT username FROM msg_user_privilege";
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        return $db->query($sql)->getCount();
    }

    function getCmd() {
    	if (!empty($_POST['delName'])) {
    		$delName     = $_POST['delName'];    		
    		$cmd = "msgctl del user type comm name  $delName";
    		return $cmd;
    	}
        $type = $_POST['type'];
        
		if ($type === 'edit') {			
			$act = 'set';            
        } else {
        	$act = 'add';
        }
        $name   = $_POST['UserPriName'];
        $cmdInfo   = $_POST['cmdInfo'];
        if (count($cmdInfo) === 0) {
        	$pri = "pri \"none\" ";
        }else if(count($cmdInfo) === 2){
        	$pri = "pri \"both\" ";
        }else {
        	foreach($cmdInfo as $srpri){
        		if($srpri === '发送'){
        			$pri = "pri \"send\" ";	
        		}else {
        			$pri = "pri \"recv\" ";
        		}	
        	}
        }
        if ($type === 'edit' && $_POST['modifyEnable'] !== 'on') {
        	$passwd	= "password  \"$name\"";
        } else {
        	$passwd	= "password \"" . $_POST['psswd1'] ."\"";
    	}   
		$cmd = "msgctl $act user type comm  name \"$name\" $passwd $pri";
        return $cmd;
    }    

    if (!empty($_POST['editName'])) {
        // Open a specified safepass data
        $tpl = 'client/msgTrans/userPrivilege_editDialog.tpl';
        $editName  = $_POST['editName'];
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $sql = "SELECT * FROM msg_user_privilege WHERE username = '$editName'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC); 
        $prilist = array();
        if($result['send_pri'] === 'Y' && $result['recv_pri'] ==='Y'){
        	$prilist = array('发送','接收');	
        }else if($result['send_pri'] === 'Y' && $result['recv_pri'] !=='Y'){
        	$prilist = array('发送');
        }else if($result['send_pri'] !== 'Y' && $result['recv_pri'] ==='Y'){
        	$prilist = array('接收');
        }else {
        	$prilist = array();	
        }
        $result['prilist'] = $prilist;
        $result = V::getInstance()
        	->assign('editUsrMng', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
     } else if (isset($_POST['openAddDialog'])) {
        // Open a new safepass dialog
        $tpl = 'client/msgTrans/userPrivilege_editDialog.tpl';
        $result = V::getInstance()
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified safepass data
        $cmd = getCmd();
        $cli = new cli();
        $cli->run($cmd);
        //$cli->run("msgctl reconfigure");
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new safepass data
        $cmd = getCmd();
        $cli = new cli();
        $cli->run($cmd);
        //$cli->run("msgctl reconfigure");
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['delName'])) {
        // Delete the specified safepass data   
        $cmd = getCmd();     
        $cli = new cli();
        $cli->run($cmd);
       // $cli->run("msgctl reconfigure");
        echo json_encode(array('msg' => "删除成功."));
   } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort safepass list
        appendUserManageData($orderStatement);
    } else if (!empty($_GET['checkExistUserPriName'])) {
    	$sql = 'SELECT username FROM msg_user_privilege WHERE username = "' .
            $_GET['UserPriName'] . '"';
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
