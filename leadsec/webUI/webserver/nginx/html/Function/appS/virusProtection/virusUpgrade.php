<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if($_POST['flgUpNow'] === '0')
    {
    	$test = $_POST['flgUpNow'];
    	echo json_encode(array('msg' => $test));
    	if($_POST['autoUpEnable'] == 'on')
    	// �����Զ�����
    	{
    		$upAddr = $_POST['upAddr'];
    		$upPort = $_POST['upPort'];
    		if($_POST['upType'] === '1')
    		// ʵʱ����
    		{
    			$upType = "real";
    		}
    		else {
    			// ��ʱ����
    			$upType = "time";
    			if($_POST['upWay'] === '1')
    			// ��ʱ�䳤�ȣ�ÿNСʱ����һ��
    			{
    				$hour = $_POST['selectLengthList'];
    				$timeStr = "hour $hour";
    			}
    			else if($_POST['upWay'] === '2'){
    				// ���̶�ʱ�䣬ÿ��N������
    				$day = $_POST['selectTimeList'];
    				$timeStr = "day $day";
    			}
    			else if($_POST['upWay'] === '3'){
    				// ��ÿ��ʱ�䣬ÿ������M��N������
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
    		// �������Զ�����
    		$cmdStr = "upgrade autoup off";
    	}
    	$cli = new cli();
        $cli->run($cmdStr);
        echo json_encode(array('msg' => '�Զ��������óɹ�!'));
    }
    else if($_POST['flgUpNow'] === '1'){
    	$upAddr = $_POST['upAddr'];
    	$upPort = $_POST['upPort'];
    	$cmdStr = "upgrade autoupNow ip \"$upAddr\" port $upPort";
    	$cli = new cli();
        $cli->run($cmdStr);
    	echo json_encode(array('msg' => '�����������óɹ�!��ǰ�Ѿ������������⡣'));
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
