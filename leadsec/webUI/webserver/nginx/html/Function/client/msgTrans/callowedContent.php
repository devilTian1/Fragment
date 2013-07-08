<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendBannedContentData($where) {
        $tpl =  'client/msgTrans/callowedContentTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $sql = "SELECT * FROM msg_filter_whitelist ";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('bannedContent', $result)
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
        $sql = 'SELECT whitelist FROM msg_filter_whitelist';
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
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
        $editname = $_POST['editname'];
        $cmdArr = array("msgctl del whitelist \"$editname\"",
        	"msgctl add whitelist \"$whitelist\"","/usr/local/bin/msgctl restart 1>/dev/null");         	 	      	
        $cli = new cli(); 
    	$cli->setLog("删除名称为".$_POST['editname']."的内容白名单")->run($cmdArr[0]);
    	$cli->setLog("添加名称为".$_POST['cwhitelist']."的内容白名单")->run($cmdArr[1]);
        $cli->setLog("重新启动消息传输服务")->run($cmdArr[2]);       
        echo json_encode(array('msg' => '修改成功。'));
    } else if ('add' === $_POST['type']) {
        // add a new banned content data
        $whitelist  = $_POST['cwhitelist'];
        $cmdArr = array("msgctl add whitelist \"$whitelist\"",
        	"/usr/local/bin/msgctl restart 1>/dev/null");        	
        $cli = new cli(); 
    	$cli->setLog("添加名称为".$_POST['cwhitelist']."的内容白名单")->run($cmdArr[0]);
        $cli->setLog("重新启动消息传输服务")->run($cmdArr[1]); 
        echo json_encode(array('msg' => '添加成功。'));
    } else if ($whitelist = $_POST['delId']) {
        // delete specified banned content data
        $cmdArr = array("msgctl del whitelist \"$whitelist\"",
        	"/usr/local/bin/msgctl restart 1>/dev/null");        	      	
        $cli = new cli(); 
    	$cli->setLog("删除名称为".$_POST['delId']."的内容白名单")->run($cmdArr[0]);
        $cli->setLog("重新启动消息传输服务")->run($cmdArr[1]); 
        echo json_encode(array('msg' => '删除成功。'));
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
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $flag = '';
    	if(count($data) > 0 && $_GET['type']==='edit' && $_GET['hi_list'] ===
    		$_GET['cwhitelist'] && $_GET['cwhitelist'] ===$data['whitelist']){
        	$flag = 0;
        }
        if(count($data) > 0 && $_GET['type']==='edit' && $_GET['hi_list'] !==
        	$_GET['cwhitelist'] && $_GET['cwhitelist'] ===$data['whitelist']){
        	$flag = 1;
        }        
    	if($db->query($sql)->getCount() > 0 && $_GET['type']==='add'){
        	$flag = 1;
        }
        echo $flag > 0 ? 'false' : 'true';
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort file sync client table data
        appendBannedContentData($orderStatement);
    } else if ($action_chk = $_POST['action_chk']) {
        // 白名单控制服务  
        if ($action_chk === 'off') {
        	$cmdArr = array("/usr/local/bin/msgctl set basic whitelist off",
        			"/usr/local/bin/msgctl restart 1>/dev/null");         
            $cli = new cli();
            $cli->setLog("关闭白名单控制服务")->run($cmdArr[0]);
            $cli->setLog("重新启动消息传输服务")->run($cmdArr[1]);
            echo json_encode(array('status' => 0, 'msg' => "白名单控制服务已关闭。"));
        } else if ($action_chk === 'on') {
        	$cmdArr = array("/usr/local/bin/msgctl set basic whitelist on",
        			"/usr/local/bin/msgctl restart 1>/dev/null");
            $cli = new cli();
            $cli->setLog("启动白名单控制服务")->run($cmdArr[0]);
            $cli->setLog("重新启动消息传输服务")->run($cmdArr[1]);
            echo json_encode(array('status' => 0, 'msg' => "白名单控制服务已启动。"));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误。'));
        }
    } else {
        // init page data
        $result = getDataCount();
        $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
        $sql = "SELECT whitelist_status FROM msg_ctl_status";
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
