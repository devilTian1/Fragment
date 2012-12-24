<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if($_POST['flgUpNow'] === '0')
    {
    	$test = $_POST['flgUpNow'];
    	echo json_encode(array('msg' => $test));
    	if($_POST['autoUpEnable'] == 'on')
    	// 启用自动升级
    	{
    		$upAddr = $_POST['upAddr'];
    		$upPort = $_POST['upPort'];
    		if($_POST['upType'] === '1')
    		// 实时升级
    		{
    			$upType = "real";
    		}
    		else {
    			// 定时升级
    			$upType = "time";
    			if($_POST['upWay'] === '1')
    			// 按时间长度，每N小时升级一次
    			{
    				$hour = $_POST['selectLengthList'];
    				$timeStr = "hour $hour";
    			}
    			else if($_POST['upWay'] === '2'){
    				// 按固定时间，每天N点升级
    				$day = $_POST['selectTimeList'];
    				$timeStr = "day $day";
    			}
    			else if($_POST['upWay'] === '3'){
    				// 按每周时间，每周星期M，N点升级
    				$week = $_POST['selectDayList'];
    				$whour = $_POST['selectHourList'];
    				$timeStr = "week $week whour $whour";
    			}
    			else 
    				$timeStr = "";
    		}
    		$cmdStr = "upgrade autoup type $upType ip \"$upAddr\" port $upPort " . $timeStr;
    	}
    	else {
    		// 不启用自动升级
    		$cmdStr = "upgrade autoup off";
    	}
    	$cli = new cli();
        $cli->run($cmdStr);
        echo json_encode(array('msg' => '自动升级配置成功!'));
    }
    else if($_POST['flgUpNow'] === '1'){
    	$upAddr = $_POST['upAddr'];
    	$upPort = $_POST['upPort'];
    	$cmdStr = "upgrade autoupNow ip \"$upAddr\" port $upPort";
    	$cli = new cli();
        $cli->run($cmdStr);
    	echo json_encode(array('msg' => '立即升级设置成功!当前已经是最新特征库。'));
    }    
    else if (!empty($_GET['c'])) {
        // set server time to localtime

    } else {
// init page data
        $db = new dbsqlite(DB_PATH . '/netgap_av.db');
        $result = $db->query('SELECT * FROM autoupNew')
                     ->getFirstData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('autoUpSet', $result);  
    }
?>
