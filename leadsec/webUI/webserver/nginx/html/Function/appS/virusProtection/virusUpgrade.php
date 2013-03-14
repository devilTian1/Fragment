<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
    if($_POST['flgUpNow'] === '0')
    {
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
    } else if($_POST['flgUpNow'] === '1'){
    	// 立即升级
    	$upAddr = $_POST['upAddr'];
    	$upPort = $_POST['upPort'];
    	$cmdStr = "upgrade autoupNow ip \"$upAddr\" port $upPort";
    	$cli = new cli();
        $cli->run($cmdStr);
    	echo json_encode(array('msg' => '立即升级设置成功!当前已经是最新特征库。'));
    } else if (($_GET['c'] === '1') && !empty($_FILES)) {
        // 手动升级，文件上传
        $uploadfs = new fileUpload($_FILES);
        $uploadfs->upload();
        $cmd = "upgrade avpackage \"{$_FILES['updateFile']['name']}\"";        
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '升级成功'));
    } else if ('exportUpgradeHistory' === $_POST['action']) {
        $db = new dbsqlite(DB_PATH . '/netgap_av.db');
        $result_list = $db->query("SELECT * FROM  upgrade_history ORDER BY up_time DESC")
            ->getAllData(PDO::FETCH_ASSOC);
        $filename = urlencode('update_history.txt');
        header("Content-Type: application/octet-stream; charset=utf-8;");
        header("Content-Disposition: attachment; filename=\"$filename\";");
        header('Pragma: no-cache;');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0;');
        if(!empty($result_list)) {
            echo '下载时间: ' . date('Y-n-d H:i:s',time()) .  "\r\n";
            echo "序号\t升级以后版本号\t升级时间 \t\t更新描述\r\n";
            foreach($result_list as $val){
                echo str_pad(substr($val['id'], 0, 5), 5) . "\t" .
                    str_pad(substr($val['up_version'], 0, 10), 10) . "\t" .
                    $val['up_time'] . "\t" . $val['del_bugs'] . "\r\n";
            }
        } else {
            echo "No Update History Data." ;
        }
        return true;
    } else {
		// init page data		
        $db = new dbsqlite(DB_PATH . '/netgap_av.db');
        $result = $db->query('SELECT * FROM autoupNew')
                     ->getFirstData(PDO::FETCH_ASSOC);
        $uphistory = $db->query('SELECT * FROM upgrade_history ORDER BY up_time DESC')
                     ->getAllData(PDO::FETCH_ASSOC);       
        V::getInstance()->assign('autoUpSet', $result)
        				->assign('uphistory', $uphistory); 
    }
?>
