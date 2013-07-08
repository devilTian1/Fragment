<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
  
    function getWhereStatement($db, $cols, $keyword) {
        $value = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' where (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }

    function getAndStatement($db, $cols, $keyword) {
        $value = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' AND (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }

    function getSpecComment($name) {
        $db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql  = "SELECT comment FROM grp_comment WHERE name = '$name'";
        $params = array();
        	if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            	$data   = getAndStatement($db, $_GET['cols'], $_GET['keyword']);
            	$sql   .= $data['sql'];
            	$params = $data['params'];
        	}
        	$sql .=  ' ' . $where;
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return $data['comment'];
    }

    function getTimeGroupData($where) {
        $db     = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $regexp = '/^(.+)\sLIMIT (\d+) OFFSET (\d+)/';
        if (preg_match($regexp, $where, $match)) {
            $orderStatement = $db->replaceAlp($match[1], 'time_grp.name');
            $limit = $match[2];
            $offset = $match[3];
        } else if (preg_match('/^ORDER BY/', $where, $match)) {
            $orderStatement = $db->replaceAlp($where, 'time_grp.name');
            $offset = 0;
        } else {
			throw new Exception("Incorrect Where Statement: [$where].");
		}
        $sql = 'SELECT DISTINCT time_grp.name as name, ' .
            'time_grp.subname as subname, grp_comment.comment as comment ' .
            'FROM time_grp, grp_comment ' .
            'WHERE time_grp.name = grp_comment.name AND time_grp.subname ' .
            'IN (SELECT DISTINCT name FROM time_grp UNION ' .
            'SELECT name FROM time_span WHERE spantype = 0) ' . $orderStatement;
        $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        // information-filter
        foreach ($data as $d) {
            $grpName = $d['name'];
            $member  = $d['subname'];
            $comment = $d['comment'];
            $result[$grpName]['subname'][] = $member;
            if (!isset($result[$grpName]['comment'])) {
                $result[$grpName]['comment'] = $comment;
            }
        }
        // keyword-searching
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $keyword = $_GET['keyword'];
            foreach ($result as $key => $val) {
                if (false === strpos($key, $keyword) &&
                    false === array_search($keyword, $val['subname'])) {
                    unset($result[$key]);
                }
            }
        }
        return array_slice($result, $offset, $limit);
    }

    function freshTimeGroup($where) {
        $tpl  = 'resConf/time/timeGroupTable.tpl';
        $data = getTimeGroupData($where);
        echo V::getInstance()->assign('timeGroup', $data)
            ->fetch($tpl);
    }

 	function getDataCount() {
        $sql = 'SELECT DISTINCT name FROM time_grp WHERE subname in ' .
            '(SELECT DISTINCT name FROM time_grp UNION ' .
            'SELECT name FROM time_span WHERE spantype = 0)';
        $db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getAndStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    function getAllTimeList() {
        $tpl  = 'resConf/time/timeListTable.tpl';
        $db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql  = "SELECT name, spantype FROM time_span";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        $weekName = array('mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun');
        foreach ($data as $v) {
        	if ($v['spantype'] !== '0') {
        		$pos = strrpos($v['name'], '_');
                if ($pos !== false) {
               	 	$nameSuffix = substr($v['name'], $pos+1);
                	if (false !== array_search($nameSuffix, $weekName)) {
                    	$name = substr($v['name'], 0, -4);
                    	$result[$name] = true;
                	} else {
                    	$result[$v['name']] = true;
                	}
            	} else {
                	$result[$v['name']] = true;
            	}        		        		
        	} else {
        		$result[$v['name']] = true;	
        	}
        }
        return array_keys($result);
    }

    function getTimeListBySpecGrp($name) {
        $db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql  = "SELECT subname FROM time_grp WHERE name = '$name'";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $d) {
            $result[] = $d['subname'];
        }
        return $result;
    }

    function getTimeGroupInUse($name) {
    	 $flag = 0;
    	 //文件交换
     	 $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
    	 $sql = "SELECT time FROM dir_info WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//文件同步
     	 $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
    	 $sql = "SELECT time FROM sync_file_client WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//数据库同步
     	 $db  = new dbsqlite(DB_PATH . '/netgap_db_swap.db');
    	 $sql = "SELECT time FROM db_swap_client_acl WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//安全浏览
     	 $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
    	 $sql = "SELECT time FROM acl WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//FTP访问
     	 $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
    	 $sql = "SELECT time FROM ftp_comm_client_acl WHERE time = '$name' 
    	     UNION SELECT time FROM ftp_trans_client_acl WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//邮件访问
     	 $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
    	 $sql = "SELECT time FROM pop3_comm_client_acl WHERE time = '$name' 
    	     UNION SELECT time FROM pop3_trans_client_acl WHERE time = '$name'
    	     UNION SELECT time FROM smtp_comm_client_acl WHERE time = '$name'
    	     UNION SELECT time FROM smtp_trans_client_acl WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//数据库访问
     	 $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
    	 $sql = "SELECT time FROM db_trans_client_acl WHERE time = '$name' 
    	     UNION SELECT time FROM db_comm_client_acl WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//定制访问
     	 $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
    	 $sql = "SELECT time FROM tcp_comm_client_acl WHERE time = '$name' 
    	     UNION SELECT time FROM tcp_trans_client_acl WHERE time = '$name'
    	     UNION SELECT time FROM udp_comm_client_acl WHERE time = '$name'
    	     UNION SELECT time FROM udp_trans_client_acl WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//安全通道
     	 $db  = new dbsqlite(DB_PATH . '/netgap_fastpass.db');
    	 $sql = "SELECT time FROM fastpass_client_acl WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//消息传输
     	 $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
    	 $sql = "SELECT time FROM msg_client_task WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	 return $flag;
    }
    if ($name = $_POST['name']) {
        // Get specified time group data
        $tpl = 'resConf/time/editTimeGroupDialog.tpl';
        $data['name']    = $name;
        $data['comment'] = getSpecComment($name);
        $allTimeList = getAllTimeList();
        $specMbr = getTimeListBySpecGrp($name);
        $specTL = array_diff($allTimeList, $specMbr);
        $result = V::getInstance()->assign('timeGroup', $data)
            ->assign('timeGroupArr', $specTL)
            ->assign('timeGrpMemberArr', $specMbr)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('add' === $_POST['type']) {
        // Add new time group data
        $name    = $_POST['resTimeName'];
        $addmbr  = $_POST['timeGrpMember'];
        $comment = $_POST['comment'];

        $cli = new cli();
        $cmd = "timegrp add name \"$name\" comment \"$comment\"";
        $cli->setLog("添加名称为".$_POST['resTimeName']."的时间组的备注内容")->run($cmd);

        foreach ($addmbr as $m) {
            $cmd = "timegrp set name \"$name\" addmbr \"$m\"";
            $cli->setLog("添加名称为".$_POST['resTimeName']."的时间组的成员")->run($cmd);
        }
        echo json_encode(array('msg' => '添加成功。'));
    } else if ('edit' === $_POST['type']) {
        // Edit the specified time group data
        $name = $_POST['resTimeName'];
        $flag = getTimeGroupInUse($name);
        if ($flag == 1) {       	
        	$msg = "<p>名称为\"$name\"的时间组被引用，无法编辑。</p>";
        	echo json_encode(array('status' => -1, 'msg' => $msg));
            return false;
        }
        $addmbr  = $_POST['timeGrpMember'];
        $comment = $_POST['comment'];

        $cli = new cli();
        $cmd = "timegrp set name \"$name\" delallmbr";
        $cli->setLog("删除名称为".$_POST['resTimeName']."的时间组的所有成员")->run($cmd);
        $cmd = "timegrp set name \"$name\" comment \"$comment\"";
        $cli->setLog("编辑名称为".$_POST['resTimeName']."的时间组的备注内容")->run($cmd);
        foreach ($addmbr as $m) {
            $cmd = "timegrp set name \"$name\" addmbr \"$m\"";
            $cli->setLog("编辑名称为".$_POST['resTimeName']."的时间组的成员")->run($cmd);
        }
        echo json_encode(array('msg' => '修改成功。'));
    } else if ($name = $_POST['delName']) {
        // Delete the specified time group data
        $flag = getTimeGroupInUse($name);
        if ($flag == 1) {       	
        	$msg = "名称为\"$name\"的时间组被引用，无法删除。";
        	echo json_encode(array('msg' => $msg));
        } else {
            $cmd  = "timegrp del name \"$name\"";
        	$cli  = new cli();
        	$cli->setLog("删除名称为".$_POST['delName']."的时间组")->run($cmd);
        	echo json_encode(array('msg' => "[$name]删除成功。"));	
        }       
    } else if (!empty($_POST['openNewTimeGrpDialog'])) {
        // Display add time group dialog
        $tpl = 'resConf/time/editTimeGroupDialog.tpl';
        $timeGroupArr = getAllTimeList();
        $result = V::getInstance()->assign('timeGroupArr', $timeGroupArr)
            ->assign('timeGrpMemberArr', array())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));

    } else if ($order = $_POST['orderStatement']) { 
        // fresh and resort time group Table
        freshTimeGroup($order);
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
