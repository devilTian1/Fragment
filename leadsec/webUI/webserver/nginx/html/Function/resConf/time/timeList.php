<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshTimeList($where) {
        $tpl  = 'resConf/time/timeListTable.tpl';
        $db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql  = "SELECT name, spantype, comment FROM time_span";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);        
        $result = array();
        $weekName = array('mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun');
        foreach ($data as $v) {        	
        	if ($v['spantype'] !== '0') {
        		$pos = strrpos($v['name'], '_');
            	if ($pos !== false) {
                	$nameSuffix = substr($v['name'], $pos+1);
                	if (false !== array_search($nameSuffix, $weekName)) {
                    	$v['name'] = substr($v['name'], 0, -4);
                    	$sql  = "SELECT comment FROM grp_comment WHERE name = '{$v['name']}'";
                    	$comments = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
                    	$v['comment'] = $comments['comment'];
                    	$result[$v['name']] = $v;
                		} else {
                    		$result[$v['name']] = $v;
                		}
            	} else {
                	$result[$v['name']] = $v;
            	}
        	} else {        		
        		$result[$v['name']] = $v;	
        	}          
        }
        
        echo V::getInstance()->assign('timeList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql  = "SELECT name, spantype, comment FROM time_span";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);        
        $result = array();
        $weekName = array('mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun');
        foreach ($data as $v) {        	
        	if ($v['spantype'] !== '0') {
        		$pos = strrpos($v['name'], '_');
            	if ($pos !== false) {
                	$nameSuffix = substr($v['name'], $pos+1);
                	if (false !== array_search($nameSuffix, $weekName)) {
                    	$v['name'] = substr($v['name'], 0, -4);
                    	$sql  = "SELECT comment FROM grp_comment WHERE name = '{$v['name']}'";
                    	$comments = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
                    	$v['comment'] = $comments['comment'];
                    	$result[$v['name']] = $v;
                		} else {
                    		$result[$v['name']] = $v;
                		}
            	} else {
                	$result[$v['name']] = $v;
            	}
        	} else {        		
        		$result[$v['name']] = $v;	
        	}          
        }
        return count($result);
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
        if ($_POST['startTime_thur'] !== '') {
            $result[] = 'thu ' . $_POST['startTime_thur'] . '-' .
                $_POST['endTime_thur'];
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
        $cmd = getAddOrEditTimeCmd('add');
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '添加成功.'));
    } else if ('edit' === $_POST['type']) {
        // Edit the specified time data
        $cmd = getAddOrEditTimeCmd('set');
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else if ($name = $_POST['delName']) {
        // Delete the specified time data
        $cmd  = "/usr/local/bin/time del name \"$name\"";
        $cli  = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[$name]删除成功."));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort timelist Table
        freshTimeList($orderStatement);
    } else if (!empty($_GET['checkExistResTimeName'])) {
    	$db  = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
    	$sql = "SELECT name FROM time_span WHERE spantype = '0' and name = '".$_GET['resTimeName']."'"
               ."UNION SELECT name FROM grp_comment WHERE name = '".$_GET['resTimeName']."'";
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
