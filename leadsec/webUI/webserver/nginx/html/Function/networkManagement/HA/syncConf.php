<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
	 function getAllHaInterface() {
   	   //获得设备属性为“HA接口”的设备IP
   		$db = new dbsqlite(DB_PATH . '/configs.db');
        $sql    = 'SELECT ip FROM interface where if_property = 1';
        $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $d) {         
                $result[] = $d['ip'];
        }
        return $result;
    }
    if (isset($_GET['server'])) {
        // 服务器设置
        $ip = $_POST['ha_ip'];
        $logPortReq = $_POST['logPortReq'];
        $cmd = "ha_sync_ctl set client host $ip service $logPortReq";
        $cli = new cli();
        $cli->setLog("双机热备 配置同步  修改服务器设置")->run($cmd);
        echo json_encode(array('msg' => '修改服务器设置成功.'));
    } else if (!empty($_POST['downloadConf'])) {
        // 下载配置
        $cmd = "ha_sync_ctl getcfg";       	         	 	      	
        $cli = new cli(); 
        $cli->setLog("双机热备 配置同步 服务器设置 下载配置")->run($cmd); 
        echo json_encode(array('msg' => '下载配置成功.'));
    } else if (!empty($_POST['rollbackConf'])) {
        // 回滚配置
        $cmd = "ha_sync_ctl rollback";       	         	 	      	
        $cli = new cli(); 
        $cli->setLog("双机热备 配置同步 服务器设置 回滚配置")->run($cmd);
        echo json_encode(array('msg' => '回滚配置成功.'));
    } else if (!empty($_POST['historyDialog'])) {
        // 同步历史记录       
        $tpl = 'networkManagement/HA/syncHistory.tpl';
    	if(file_exists('/var/log/sync.log')) {
			$data = file('/var/log/sync.log');
			$hisData =array();
			foreach($data as $k=>$d){
				$arr = explode("|",$d);
				$hisData[$k]['ip'] = $arr[0];
				$hisData[$k]['start'] = $arr[1];
				$hisData[$k]['end'] = $arr[2];
				$hisData[$k]['result'] = $arr[3];	
			}						
		}
        $result = V::getInstance()
        	->assign('hisData', $hisData)
			->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (isset($_GET['local'])) {
    	//本地设置  	
        $localAddr = $_POST['localAddr'];
        $logPortReq = $_POST['logPortReq'];
        $cmd = "ha_sync_ctl set server host $localAddr service ".
        	"$logPortReq 1>/dev/null";
        $cli = new cli();
        $cli->setLog("双机热备 配置同步  修改本地设置")->run($cmd);
        echo json_encode(array('msg' => '修改本地设置成功.'));
   }else if (!empty($_POST['startConf'])) {
        // 启动配置
        $cmd = "ha_sync_ctl reconfigure";         	         	 	      	
        $cli = new cli(); 
        $cli->setLog("双机热备 配置同步  启动本地设置")->run($cmd);
        $cmd1 = "ha_sync_ctl start 1>/dev/null"; 
        $cli->setLog("开启高可用性 配置同步 配置")->run($cmd1);	       
        echo json_encode(array('msg' => '配置已启动.'));
    } else if (!empty($_POST['stopConf'])) {
        // 停止配置
        $cmd = "ha_sync_ctl stop";       	         	 	      	
        $cli = new cli(); 
        $cli->setLog("双机热备 配置同步  停止本地设置")->run($cmd);	      
        echo json_encode(array('msg' => '配置已停止.'));
    } else if (!empty($_POST['downDialog'])) {
        // 下载历史记录       
        $tpl = 'networkManagement/HA/downHistory.tpl';
    	if(file_exists('/var/log/download.log')) {
			$data = file('/var/log/download.log');
			$hisData =array();
			foreach($data as $k=>$d){
				$arr = explode("|",$d);
				$downData[$k]['ip'] = $arr[0];
				$downData[$k]['start'] = $arr[1];
				$downData[$k]['end'] = $arr[2];
				$downData[$k]['result'] = $arr[3];	
			}						
		}
        $result = V::getInstance()
        	->assign('downData', $downData)
			->fetch($tpl);
        echo json_encode(array('msg' => $result));
    }else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/netgap_ha.db');
        $result = $db->query('SELECT * FROM sync_cfg_client')
                     ->getAllData(PDO::FETCH_ASSOC);
   		foreach($result as $r){
        	$ser['host'] = $r['host'];
        	$ser['service'] = $r['service'];
        }             
		$result1 = $db->query('SELECT * FROM sync_cfg_server')
                     ->getAllData(PDO::FETCH_ASSOC);
        foreach($result1 as $r1){
        	$local['host'] = $r1['host'];
        	$local['service'] = $r1['service'];
        }
        $db = new dbsqlite(DB_PATH . '/netgap_system.db');
        $result = $db->query('SELECT ha_sync_status FROM system')
                     ->getAllData(PDO::FETCH_ASSOC);
        foreach($result as $r){
        	$state['state'] = $r['ha_sync_status'];
        }              
        $haInterface = getAllHaInterface();
        V::getInstance()->assign('ser', $ser)
        				->assign('local', $local)
        				->assign('state', $state)
        				->assign('haInterface', $haInterface);
    }
?>
