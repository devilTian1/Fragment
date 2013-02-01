<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
  
    function getTimeListData() {
    	//获得时间列表里的值
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
                    	$v['name'] = substr($v['name'], 0, -4);                    	
                    	$result[] = $v['name'];
                		} else {
                    		$result[] = $v['name'];
                		}
            	} else {
                	$result[] = $v['name'];
            	}
        	} else {       		
        		$result[] = $v['name'];	
        	}          
        }  
        $result = array_unique($result);    
        return $result;
    }
    function getTimeData() {
    	//获得时间组里的所有值:包括已添加的名称及时间组成员
        $db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql  = "SELECT distinct name FROM time_grp";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $d) {
        	$result[] = $d['name']; 
        }              
        return $result;
    }
    function getSpecComment($name) {
        $db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql  = "SELECT comment FROM grp_comment WHERE name = '$name'";
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return $data['comment'];
    }
    function getTimeGroupData() {
        $result = array();       
        $timelist = getTimeListData();
        $timedata = getTimeData();         
        foreach ($timedata as $d) {
        	if (false === array_search($d, $timelist)) {
        		//获得时间组里已添加的名称
        	 	$db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        	 	$sql  = "SELECT subname FROM time_grp where name = '$d'";
                $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
                foreach ($data as $d2) {
                	$result[$d]['subname'][] = $d2['subname'];	
                }
                $result[$d]['comment'] = getSpecComment($d);                 
        	}	
        }          
        return $result;
    }    
    function freshTimeGroup() {
        $tpl  = 'resConf/time/timeGroupTable.tpl';
        $data = getTimeGroupData();
        echo V::getInstance()->assign('timeGroup', $data)
            ->fetch($tpl);
    }
 	function getDataCount() {
        $result = array();       
        $timelist = getTimeListData();
        $timedata = getTimeData();         
        foreach ($timedata as $d) {
        	if (false === array_search($d, $timelist)) {        	 
                $result[] = $d;                 
        	}	
        }  
        return count($result);        
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
        $cli->run($cmd);
        foreach ($addmbr as $m) {
            $cmd = "timegrp set name \"$name\" addmbr \"$m\"";
            $cli->run($cmd);
        }
        echo json_encode(array('msg' => '添加成功.'));
    } else if ('edit' === $_POST['type']) {
        // Edit the specified time group data
        $name    = $_POST['resTimeName'];
        $addmbr  = $_POST['timeGrpMember'];
        $comment = $_POST['comment'];

        $cli = new cli();
        $cmd = "timegrp set name \"$name\" delallmbr";
        $cli->run($cmd);
        $cmd = "timegrp set name \"$name\" comment \"$comment\"";
        $cli->run($cmd);
        foreach ($addmbr as $m) {
            $cmd = "timegrp set name \"$name\" addmbr \"$m\"";
            $cli->run($cmd);
        }
        echo json_encode(array('msg' => '修改成功.'));
    } else if ($name = $_POST['delName']) {
        // Delete the specified time group data
        $cmd  = "timegrp del name \"$name\"";
        $cli  = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[$name]删除成功."));
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
        freshTimeGroup();
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
