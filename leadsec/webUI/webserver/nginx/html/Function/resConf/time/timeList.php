<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getAndStatement($db, $cols, $keyword) {
        $value = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' AND (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }

    function freshTimeList($where) {
        $tpl  = 'resConf/time/timeListTable.tpl';
    	$db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql1 = 'SELECT time_grp.name as name, grp_comment.comment as comment' .
            ' FROM time_grp, grp_comment ' .
            'WHERE time_grp.name = grp_comment.name ' .
            'GROUP BY time_grp.name HAVING COUNT(*) = 7';
        $sql2 = ' UNION SELECT name, comment FROM time_span WHERE spantype = 0';
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $sql1  .= ' AND time_grp.' . $_GET['cols'] .
                " LIKE '%{$_GET['keyword']}%'";
            $sql2  .= ' AND ' . $_GET['cols'] .
                " LIKE '%{$_GET['keyword']}%'";
        }
        $sql = $sql1 . $sql2 . " $where";
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('timeList', $result)
            ->fetch($tpl);
    }

    function getDataCount() {
        $db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql1 = 'SELECT name FROM time_grp GROUP BY name HAVING COUNT(*) = 7';
        $sql2 = ' UNION select name from time_span WHERE spantype = 0';
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getAndStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql1  .= $data['sql'];
            $sql2  .= $data['sql'];
            $params = array_fill(0, count(explode(',', $_GET['cols'])) * 2,
                $value);
        }
        $sql = $sql1 . $sql2;
        $result  = $db->query($sql, $params)->getCount();
        return $result;
    }
    
    function getDateFormat($str, $type='fullDate') {
        if ($type === 'time') {
            return substr($str, 8, 2) . ':' .
                substr($str, 10, 2) . ':' . substr($str, 12, 2);
        } else {
            return substr($str, 0, 4) . '/' . substr($str, 4, 2) . '/' .
                substr($str, 6, 2) . ' ' . substr($str, 8, 2) . ':' .
                substr($str, 10, 2) . ':' . substr($str, 12, 2);
        }
    }

    function getAddWeekStr() {
        $result = array();
        if ($_POST['startTime_sun'] !== '') {
            $result[] = 'sun ' . $_POST['startTime_sun'] . '-' .
                $_POST['endTime_sun'];
        }
        if ($_POST['startTime_mon'] !== '') {
            $result[] = 'mon ' . $_POST['startTime_mon'] . '-' .
                $_POST['endTime_mon'];
        }
        if ($_POST['startTime_tue'] !== '') {

            $result[] = 'tue ' . $_POST['startTime_tue'] . '-' .
                $_POST['endTime_tue'];
        }
        if ($_POST['startTime_wed'] !== '') {
            $result[] = 'wed ' . $_POST['startTime_wed'] . '-' .
                $_POST['endTime_wed'];
        }
        if ($_POST['startTime_thu'] !== '') {
            $result[] = 'thu ' . $_POST['startTime_thu'] . '-' .
                $_POST['endTime_thu'];
        }
        if ($_POST['startTime_fri'] !== '') {
            $result[] = 'fri ' . $_POST['startTime_fri'] . '-' .
                $_POST['endTime_fri'] . ' ';
        }
        if ($_POST['startTime_sat'] !== '') {
            $result[] = 'sat ' . $_POST['startTime_sat'] . '-' .
                $_POST['endTime_sat'];
        }
        return join(' ', $result);
    }

    function getAddOrEditTimeCmd($type) {
        $name    = $_POST['resTimeName'];
        $comment = $_POST['comment'];

        if ($_POST['scheduleType'] === 'oneTime') {
            $stime = $_POST['startTime_f'];
            $etime = $_POST['endTime_f'];
            $cmd   = "/usr/local/bin/time $type name \"$name\" type once start $stime ".
                "stop $etime comment \"$comment\"";
            return $cmd;
        } else if ($_POST['scheduleType'] === 'week') {
            $str = getAddWeekStr();
            $cmd   = "/usr/local/bin/time $type name \"$name\" type week $str ".
                "comment \"$comment\"";
            return $cmd;
        } else {
            throw new Exception('wrong schedule type.'); 
        }
    }
    function getTimeListInUse($name) {
    	 $flag = 0;
    	 //时间组
    	 $db  = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
    	 $sql = "SELECT subname FROM time_grp WHERE subname = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
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
    
    function getTimeListInUseAndEnable($name) {
    	 $flagEnable = 0;
    	 //时间组
    	 $db  = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
    	 $sql = "SELECT subname FROM time_grp WHERE subname = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flagEnable = 1;
    	 	return $flagEnable;
    	 }
    	 //文件交换
     	 $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
    	 $sql = "SELECT time FROM dir_info WHERE time = '$name' and active = 'Y' ";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flagEnable = 1;
    	 	return $flagEnable;
    	 }
    	//文件同步
     	 $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
    	 $sql = "SELECT time FROM sync_file_client WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flagEnable = 1;
    	 	return $flagEnable;
    	 }
    	//数据库同步
     	 $db  = new dbsqlite(DB_PATH . '/netgap_db_swap.db');
    	 $sql = "SELECT time FROM db_swap_client_acl WHERE time = '$name' and active = 'Y'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flagEnable = 1;
    	 	return $flagEnable;
    	 }
    	//安全浏览
     	 $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
    	 $sql = "SELECT time FROM acl WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flagEnable = 1;
    	 	return $flagEnable;
    	 }
    	//FTP访问
     	 $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
    	 $sql = "SELECT time FROM ftp_comm_client_acl WHERE time = '$name' and active = 'Y' 
    	     UNION SELECT time FROM ftp_trans_client_acl WHERE time = '$name' and active = 'Y'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flagEnable = 1;
    	 	return $flagEnable;
    	 }
    	//邮件访问
     	 $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
    	 $sql = "SELECT time FROM pop3_comm_client_acl WHERE time = '$name' and active = 'ok'
    	     UNION SELECT time FROM pop3_trans_client_acl WHERE time = '$name' and active = 'ok'
    	     UNION SELECT time FROM smtp_comm_client_acl WHERE time = '$name' and active = 'ok'
    	     UNION SELECT time FROM smtp_trans_client_acl WHERE time = '$name' and active = 'ok'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flagEnable = 1;
    	 	return $flagEnable;
    	 }
    	//数据库访问
     	 $db  = new dbsqlite(DB_PATH . '/netgap_db.db');
    	 $sql = "SELECT time FROM db_trans_client_acl WHERE time = '$name' and active = 'Y'
    	     UNION SELECT time FROM db_comm_client_acl WHERE time = '$name' and active = 'Y'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flagEnable = 1;
    	 	return $flagEnable;
    	 }
    	//定制访问
     	 $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
    	 $sql = "SELECT time FROM tcp_comm_client_acl WHERE time = '$name' and active = 'Y'
    	     UNION SELECT time FROM tcp_trans_client_acl WHERE time = '$name' and active = 'Y'
    	     UNION SELECT time FROM udp_comm_client_acl WHERE time = '$name' and active = 'Y'
    	     UNION SELECT time FROM udp_trans_client_acl WHERE time = '$name' and active = 'Y'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flagEnable = 1;
    	 	return $flagEnable;
    	 }
    	//安全通道
     	 $db  = new dbsqlite(DB_PATH . '/netgap_fastpass.db');
    	 $sql = "SELECT time FROM fastpass_client_acl WHERE time = '$name' and active = 'ok'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flagEnable = 1;
    	 	return $flagEnable;
    	 }
    	//消息传输
     	 $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
    	 $sql = "SELECT time FROM msg_client_task WHERE time = '$name' and active = 'ok'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flagEnable = 1;
    	 	return $flagEnable;
    	 }
    	 return $flagEnable;
    }
    
    if ($name = $_POST['editName']) {
        // Get specified timelist data
        $tpl = 'resConf/time/editTimeListDialog.tpl';
        $db  = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql = "SELECT * FROM time_span WHERE name = '$name' or name like '{$name}\_%' ESCAPE '\'";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        $dataCount = count($data);
        if ($dataCount === 1) {
            $result['scheduleType'] = 'oneTime';
            $result['startTime_f']  = getDateFormat($data[0]['starttime']);
            $result['endTime_f']    = getDateFormat($data[0]['endtime']);
            $result['comment']      = $data[0]['comment']; 
        } else {
            $result['scheduleType']  = 'week';
            $sql  = "SELECT comment FROM grp_comment WHERE name = '$name'";
            $comments = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            $result['comment'] = $comments['comment'];
            foreach ($data as $v) {
                $nullTime = array('0', '00000000000000');
                if (array_search($v['starttime'], $nullTime) !== false || array_search($v['endtime'], $nullTime) !== false) {
                    continue;
                }
                switch ($v['name']) {
                    case $name . '_mon' :
                        $result['startTime_mon'] = getDateFormat($v['starttime'], 'time');
                        $result['endTime_mon'] = getDateFormat($v['endtime'], 'time');
                        break 1;
                    case $name . '_tue' :
                        $result['startTime_tue'] = getDateFormat($v['starttime'], 'time');
                        $result['endTime_tue'] = getDateFormat($v['endtime'], 'time');
                        break 1;
                    case $name . '_wed' :
                        $result['startTime_wed'] = getDateFormat($v['starttime'], 'time');
                        $result['endTime_wed'] = getDateFormat($v['endtime'], 'time');
                        break 1;
                    case $name . '_thu' :
                        $result['startTime_thu'] = getDateFormat($v['starttime'], 'time');
                        $result['endTime_thu'] = getDateFormat($v['endtime'], 'time');
                        break 1;
                    case $name . '_fri' :
                        $result['startTime_fri'] = getDateFormat($v['starttime'], 'time');
                        $result['endTime_fri'] = getDateFormat($v['endtime'], 'time');
                        break 1;
                    case $name . '_sat' :
                        $result['startTime_sat'] = getDateFormat($v['starttime'], 'time');
                        $result['endTime_sat'] = getDateFormat($v['endtime'], 'time');
                        break 1;
                    case $name . '_sun' :
                        $result['startTime_sun'] = getDateFormat($v['starttime'], 'time');
                        $result['endTime_sun'] = getDateFormat($v['endtime'], 'time');
                        break 1;
                    default : 
                        throw new Exception('wrong sql: '.$sql);
                }
            }
        }
        $result['name'] = $name;
        $result = V::getInstance()->assign('timeList', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_POST['openDialog'])) {
        // Display add dialog
        $tpl = 'resConf/time/editTimeListDialog.tpl';
        $result = V::getInstance()->assign('timeList', $result)
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('add' === $_POST['type']) {
        // Add new time data
        if (getDataCount() >= RESCONF_LIMIT) {
            $msg = '资源数达到上限[' . RESCONF_LIMIT . ']。';
        	echo json_encode(array('msg' => $msg));
        	return;
        }
        $cmd = getAddOrEditTimeCmd('add');
        $cli = new cli();
        $cli->setLog("添加名称为".$_POST['resTimeName']."的时间列表")->run($cmd);
        echo json_encode(array('msg' => '添加成功。'));
    } else if ('edit' === $_POST['type']) {
        // Edit the specified time data
        $name = $_POST['resTimeName'];
        $flagEnable = getTimeListInUseAndEnable($name);
        if ($flagEnable == 1) {       	
        	$msg = "<p>名称为\"$name\"的时间列表被引用且处于启用状态，无法编辑。</p>";
        	echo json_encode(array('status' => -1, 'msg' => $msg));
            return false;
        }
        $cmd = getAddOrEditTimeCmd('set');
        $cli = new cli();
        $cli->setLog("编辑名称为$name的时间列表")->run($cmd);
        echo json_encode(array('msg' => '修改成功。'));
    } else if ($name = $_POST['delName']) {
        // Delete the specified time data    
        $flag = getTimeListInUse($name);
        if ($flag == 1) {       	
        	$msg = "名称为\"$name\"的时间列表被引用，无法删除。";
        	echo json_encode(array('msg' => $msg));
        } else {
        	$cmd  = "/usr/local/bin/time del name \"$name\"";
        	$cli  = new cli();
        	$cli->setLog("删除名称为".$_POST['delName']."的时间列表")->run($cmd);
        	echo json_encode(array('msg' => "[$name]删除成功。"));
        }      
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort timelist Table
        freshTimeList($orderStatement);
    } else if (!empty($_GET['checkExistResTimeName'])) {
    	$db  = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
    	$sql = "SELECT name FROM time_span WHERE spantype = '0' AND" .
            " name = '{$_GET['resTimeName']}' UNION SELECT name " .
            "FROM grp_comment WHERE name = '{$_GET['resTimeName']}'";
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
