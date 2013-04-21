<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
  
    function getDataCount() {
    	$sql = "SELECT logsrv FROM logsrv";
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        return $db->query($sql)->getCount();
    }
    function freshRemoteLogIPData($where) {
        $tpl =  'log/conf/remoteConfTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
	    $sql = "SELECT * FROM logsrv $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);     	
        echo V::getInstance()->assign('remote', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
	function getCmd() {
		//组装命令行
        $type = $_POST['type'];
        if ($type === 'add') {
            $action = 'add';
        } else {
            $action = 'set logsrv';
        } 
        
        $ip        = $_POST['remoteLogIp'];
        $logPort   = $_POST['logPortReq'];
        $protocol  = $_POST['protocol'];
        $comment   = $_POST['comment'];
 
        $result = "/usr/local/bin/logserver $action ip $ip "
        	." protocol $protocol port $logPort ";          	                  
        $result .= " comment \"$comment\"";
        return $result;
    }
   
    if (!empty($_POST['editId'])) {
        // Get specified  data     	
        $ip = $_POST['editId'];
        $sql = "SELECT logsrv,port,protocol,comment FROM logsrv WHERE logsrv ='$ip'";            
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $tpl = 'log/conf/remoteConf_editDialog.tpl';
        $result = V::getInstance()
            ->assign('res', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified  data 		    	    	   
 		$cli = new cli();
 		$cmd = getCmd();
        $cli->setLog("编辑服务器IP为".$_POST['remoteLogIp']."的远程配置")->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));	                
    }  else if (!empty($_POST['delId'])) {
        // Delete the specified  data 
        $delIP = $_POST['delId'];      
        $cmd  = "/usr/local/bin/logserver del ip $delIP ";
        $cli  = new cli();       
        $cli->setLog("编辑服务器IP为".$_POST['delId']."的远程配置")->run($cmd);
        echo json_encode(array('msg' => "删除成功."));
    } else if ('add' === $_POST['type']) {
        // Add a new addr group data         
 		$cli = new cli();
 		$cmd = getCmd();
        $cli->setLog("添加服务器IP为".$_POST['remoteLogIp']."的远程配置")->run($cmd);
        echo json_encode(array('msg' => '添加成功.'));	                     
    }else if (!empty($_POST['openDialog'])) {
        // Display add client comm dialog       
        $tpl = 'log/conf/remoteConf_editDialog.tpl';
        $result = V::getInstance()
        	->assign('res', $result)
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($_GET['checkExistServerIP']) {
        // Check the same port  exist or not
        $ip = $_GET['remoteLogIp'];
        $sql = "SELECT logsrv FROM logsrv where logsrv = '$ip'";            
        $db  = new dbsqlite(DB_PATH . '/configs.db');       	      	  
        echo  $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort addr-group list
        freshRemoteLogIPData($orderStatement);
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
