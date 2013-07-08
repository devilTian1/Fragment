<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendAllowedFileData($where) {
        $tpl =  'client/msgTrans/callowedFileTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $sql = "SELECT filename FROM msg_filter_filename ";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('allowedFile', $result)
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
        $sql = 'SELECT filename FROM msg_filter_filename';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    if ($filename = $_POST['editId']) {
        // Display dialog of specified allowed file name data
        $tpl  = 'client/msgTrans/ceditAllowedFileDialog.tpl';
        $sql  = "SELECT * FROM msg_filter_filename WHERE 
        	filename = '$filename'";
        $db   = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit specified allowed file data
        $filename = $_POST['cfilename'];
        $editname = $_POST['editname'];
        $cmdArr = array("msgctl del filename \"$editname\"",
        	"msgctl add filename \"$filename\"","/usr/local/bin/msgctl restart 1>/dev/null");         	 	      	
        $cli = new cli(); 
    	$cli->setLog("删除名称为".$_POST['editname']."的文件名控制")->run($cmdArr[0]);
    	$cli->setLog("添加名称为".$_POST['cfilename']."的文件名控制")->run($cmdArr[1]);
        $cli->setLog("重新启动消息传输服务")->run($cmdArr[2]);          
        echo json_encode(array('msg' => '修改成功。'));
    } else if ('add' === $_POST['type']) {
        // add a new allowed file data
        $filename = $_POST['cfilename'];
        $cmdArr = array("msgctl add filename \"$filename\"",
        	"/usr/local/bin/msgctl restart 1>/dev/null");        	
        $cli = new cli(); 
    	$cli->setLog("添加名称为".$_POST['cfilename']."的文件名控制")->run($cmdArr[0]);
        $cli->setLog("重新启动消息传输服务")->run($cmdArr[1]);  
        echo json_encode(array('msg' => '添加成功。'));
    } else if ($filename = $_POST['delId']) {
        // delete specified allowed file data
        $cmdArr = array("msgctl del filename \"$filename\"",
        	"/usr/local/bin/msgctl restart 1>/dev/null");        	      	
        $cli = new cli(); 
    	$cli->setLog("删除名称为".$_POST['delId']."的文件名控制")->run($cmdArr[0]);
        $cli->setLog("重新启动消息传输服务")->run($cmdArr[1]); 
        echo json_encode(array('msg' => '删除成功。'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display dialog to add allowed file
        $tpl =  'client/msgTrans/ceditAllowedFileDialog.tpl';
        $result = V::getInstance()->assign('type', 'add')
        						  ->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_GET['checkExistcFileName'])) {
        // Check the same file name  exist or not
        $sql = 'SELECT filename FROM msg_filter_filename WHERE filename = "' .
            $_GET['cfilename'] . '"';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
    	$data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $flag = '';
    	if(count($data) > 0 && $_GET['type']==='edit' && $_GET['hi_list'] ===
    		$_GET['cfilename'] && $_GET['cfilename'] ===$data['filename']){
        	$flag = 0;
        }
        if(count($data) > 0 && $_GET['type']==='edit' && $_GET['hi_list'] !==
        	$_GET['cfilename'] && $_GET['cfilename'] ===$data['filename']){
        	$flag = 1;
        }        
    	if($db->query($sql)->getCount() > 0 && $_GET['type']==='add'){
        	$flag = 1;
        }
        echo $flag > 0 ? 'false' : 'true';
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort file sync client table data
        appendAllowedFileData($orderStatement);
    } else if ($action_file = $_POST['action_file']) {
        // 文件名控制 
        if ($action_file === 'off') {
        	$cmdArr = array("/usr/local/bin/msgctl set basic fnamefilter off",
        			"/usr/local/bin/msgctl restart 1>/dev/null");        
            $cli = new cli();
            $cli->setLog("关闭文件名控制服务")->run($cmdArr[0]);
            $cli->setLog("重新启动消息传输服务")->run($cmdArr[1]);
            echo json_encode(array('status' => 0, 'msg' => "文件名控制已关闭。"));
        } else if ($action_file === 'on') {
        	$cmdArr = array("/usr/local/bin/msgctl set basic fnamefilter on",
        			"/usr/local/bin/msgctl restart 1>/dev/null");
            $cli = new cli();
            $cli->setLog("启动文件名控制服务")->run($cmdArr[0]);
            $cli->setLog("重新启动消息传输服务")->run($cmdArr[1]);
            echo json_encode(array('status' => 0, 'msg' => "文件名控制已启动。"));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误。'));
        }
    } else if ($action_bin = $_POST['action_bin']) {
        // 二进制控制  
        if ($action_bin === 'off') {
        	$cmdArr = array("/usr/local/bin/msgctl set basic binfilter on",
        			"/usr/local/bin/msgctl restart 1>/dev/null");      
            $cli = new cli();
            $cli->setLog("关闭二进制控制服务")->run($cmdArr[0]);
            $cli->setLog("重新启动消息传输服务")->run($cmdArr[1]);
            echo json_encode(array('status' => 0, 'msg' => "二进制控制已关闭。"));
        } else if ($action_bin === 'on') {
        	$cmdArr = array("/usr/local/bin/msgctl set basic binfilter off",
        			"/usr/local/bin/msgctl restart 1>/dev/null");
            $cli = new cli();
            $cli->setLog("启动二进制控制服务")->run($cmdArr[0]);
            $cli->setLog("重新启动消息传输服务")->run($cmdArr[1]);
            echo json_encode(array('status' => 0, 'msg' => "二进制控制已启动。"));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误。'));
        }
    } else {
        // init page data
        $result = getDataCount();
     	$db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $sql = "SELECT namefilter_status,bin_file_status FROM msg_ctl_status";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach($data as $d){
        	$status['namefilter_status'] = $d['namefilter_status'];
        	$status['bin_file_status'] = $d['bin_file_status'];	
        }
        V::getInstance()->assign('dataCount', $result)
        	->assign('status', $status)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
