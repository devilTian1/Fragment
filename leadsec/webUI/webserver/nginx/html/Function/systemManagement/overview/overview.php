<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

	function includeFunc($buffer) {
        if (preg_match('/^([^\s].+)$/',$buffer,$match)) {
            return $match[1];
        } else {
            return false;
        }
    }

	function getSerialNum() {//get serialnum
        $filePath = "/etc/firewall/fw_id";
		$array_new = fileLinesToArr($filePath,'', 1,'includeFunc',NULL);
		return $array_new[0];
    }

	function getHostname(){//get hostname
		$db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query("SELECT hostname FROM hostname")
                     ->getFirstData(PDO::FETCH_ASSOC);
        return $result['hostname'];
	}

	function getHardwareVersion() {// get hardewareversion
		$db = new dbsqlite(DB_PATH . '/private.db');
        $result = $db->query("SELECT version FROM hardware")
                     ->getFirstData(PDO::FETCH_ASSOC);
        return $result['version'];
	}
	
	function getSoftNum() { //get softnum 
		$db  = new dbsqlite(DB_PATH . '/private.db');
        $sql = 'SELECT up_version FROM upgrade_history ORDER BY up_time ASC';
        $result = $db->query($sql)
                     ->getFirstData(PDO::FETCH_ASSOC);
		if (!empty($result)) {
			return $result['up_version'];
		} else {
			return '';
		}
	}

    function getIfName($name = 'external') {
		$db     = new dbsqlite(DB_PATH . '/configs.db');
        $sql    = 'SELECT external_name, internal_name FROM interface ' .
            'WHERE device_type = 1 and enable = 1 ORDER BY external_name';
        return $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    }

    function getActiveIfName() {
        $data = getIfName();
        $result = array();
        foreach ($data as $d) {
            $result[] = $d['external_name'];
        }
        natsort($result);
        return $result;
    }

    function getIfStatInfo() {
        $file = '/proc/net/stat';
        if (!file_exists($file)) {
            throw new Exception("Error: [$file] is not existed.");
        }
        $result = array();
        $ethArr = array();
        $ifData = getIfName();
        foreach ($ifData as $d) {
            $ethArr[] = $d['internal_name'];
        }
        if (count($ethArr) === 0) {
            throw new Exception("Error: No interface.");
        }
        natsort($ethArr);
        $cmd = $_SERVER['DOCUMENT_ROOT'] . '/Script/ethxInfo.sh "' .
            join(' ', $ethArr) . '" "Mb" "' . $_SESSION['ethFile'] . '"';

        $cli   = new cli();
        $data  = $cli->setGetResult(true)->setIsRec(false)->run($cmd);
        $d     = array_pop($data);
        $d     = preg_split('/\s+/', trim($d));
        $count = count($d);
    	$time  = time()*1000;
        for ($i = 0; $i < $count; $i+=2) {
            $in  = $d[$i] === 'n/a' ? 0 : floatval($d[$i]);
            $out = $d[$i+1] === 'n/a' ? 0 : floatval($d[$i+1]);
            $fe['inKb']  = array('x' => $time, 'y' => $in);
            $fe['outKb'] = array('x' => $time, 'y' => $out);
            $result[]    = $fe;
        }
        return $result;
    }

	//get dev info
	function getDevInfo(){
		$devinfo=array();
		$devinfo['hostname']=getHostname();
		$devinfo['serialnum']=getSerialNum();
		$devinfo['devnum']=getHardwareVersion();
		$devinfo['softnum']=getSoftNum();
		return $devinfo;
	}
	//get license info
    function getLicenseInfo(){
    	$db     = new dbsqlite(DB_PATH . '/private.db');
		$sql    = "SELECT function , value FROM license where function Not In ('multicast_access','stream_swap','mail_swap','ha');";
        $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
		$chNames=array(	 'file_swap'		=>'文件交换'
						,'file_swap_new'	=>'文件同步'
						,'database_swap'	=>'数据库访问'
						,'http_access'		=>'安全浏览'
						,'ftp_access'		=>'FTP访问'
						,'mail_access'		=>'邮件访问'
						,'database_access'	=>'数据库同步'
						,'fastpass_access'	=>'安全通道'
						,'msg_swap'			=>'消息传输'
						,'custom_access'	=>'定制访问'
						,'ids'				=>'入侵检测'
						,'anti-virus'		=>'病毒防护'
					);
		$result = array();
		foreach ($data as $key => $val) {
			$result[$key]['function']	=$val['function'];
			$result[$key]['ch_name']	=
						array_key_exists($val['function'],$chNames)?$chNames[$val['function']]:'';
			$result[$key]['status']		=$val['value']>0 ? '启用':'停止';
		}
    	return $result;
    }

	//get haRole info 
	function getHaRole() {
		$db  = new dbsqlite(DB_PATH . '/netgap_ha.db');
		$sql = "SELECT role FROM basic_configure";
		$result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
		return $result['role'];	
	} 

	//get ha info 
	function getHaInfo() {
		$hainfo = array();
		$hainfo['role'] = getHaRole();
		$status = getLvsAndHaStatus();
		$hainfo['ha_status'] = $status['ha_status'];
		$hainfo['role_name'] = 
			$hainfo['role'] === 'M' ? '主闸' : '从闸';
		$hainfo['ha_type']=
			$hainfo['ha_status'] === '1'? '启动' : '停止';
		return $hainfo;
	}

	//get lvsRole info 
	function getLvsRole() {
		$db  = new dbsqlite(DB_PATH . '/netgap_ha.db');
		$sql = "SELECT role FROM lvs_basic";
		$result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
		return $result['role'];	
	}


	//get lvs status info 
	function getLvsAndHaStatus() {
		$db  = new dbsqlite(DB_PATH . '/netgap_system.db');
		$sql = "SELECT lvs_status,ha_status FROM system";
		$result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
		return $result;	
	}

    function getCpuUsed() {
        $cli  = new cli();
        $data = $cli->setIsRec(false)->setGetResult(true)
                    ->run($_SERVER['DOCUMENT_ROOT'] . '/Script/cpuUsed.sh');
        return floatval(substr($data[0], 0, -1));
    }

    function getCpuXUsed() {
        $cli  = new cli();
        $data = $cli->setIsRec(false)->setGetResult(true)
                    ->run($_SERVER['DOCUMENT_ROOT'] . '/Script/cpuXUsed.sh');
        $result = array();
        foreach ($data as $d) {
            $result[] = floatval(substr($d, 0, -1));
        }
        return $result;
    }

    function getMemUsed() {
        $cli  = new cli();
        $data = $cli->setIsRec(false)->setGetResult(true)
                    ->run($_SERVER['DOCUMENT_ROOT'] . '/Script/memUsed.sh');
        return floatval(substr($data[0], 0, -1));
    }

	//get lvs info
	function getLvsInfo() {
		$lvsinfo = array();
		$lvsinfo['role'] = getLvsRole();
		$status = getLvsAndHaStatus();
		$lvsinfo['lvs_status'] = $status['lvs_status'];
		$lvsinfo['role_name'] = 
			$lvsinfo['role'] === 'D'? '调度器' : '节点';
		$lvsinfo['lvs_type']=
			$lvsinfo['lvs_status'] === '1'? '启动' : '停止';
		return $lvsinfo;
	}

	function getServerStatusInfo(){
		$status=array();
		$db  = new dbsqlite(DB_PATH . '/netgap_system.db');
		$sql = "SELECT ctcp_status,cudp_status,db_status,db_swap_status,".
			"sync_status,fs_new_status,http_status,sync_msg_status FROM system";
		$result = $db->query($sql)
                  ->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $r) {
        	$status['tcp'] = $r['ctcp_status'];
        	$status['udp'] = $r['cudp_status'];
        	$status['db']  = $r['db_status'];
        	$status['dbswap'] = $r['db_swap_status'];
        	$status['sync']   = $r['sync_status'];
        	$status['fswap']  = $r['fs_new_status'];
        	$status['http']   = $r['http_status'];
        	$status['msg']    = $r['sync_msg_status'];
        }  
        $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
        $sql = "SELECT smtp_status,pop3_status FROM mail_system";
        $result_mail = $db->query($sql)
                  ->getAllData(PDO::FETCH_ASSOC);
		foreach ($result_mail as $m) {
        	$status['smtp'] = $m['smtp_status'];
        	$status['pop3'] = $m['pop3_status'];
        }
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        $sql = "SELECT ftp_status FROM system";
        $result_ftp = $db->query($sql)
                  ->getAllData(PDO::FETCH_ASSOC);
		foreach ($result_ftp as $f) {
        	$status['ftp'] = $f['ftp_status'];
        }
        $db  = new dbsqlite(DB_PATH . '/netgap_fastpass.db');
        $sql = "SELECT status FROM fastpass_status";
        $result_fastpass = $db->query($sql)
                  ->getAllData(PDO::FETCH_ASSOC);
		foreach ($result_fastpass as $p) {
        	$status['pass'] = $p['status'];
        }
        return $status;
	}
	if ('edit' === $_POST['type']) {
        // Edit a specified addr group data
        list($name, $comment, $addmbr) = getAddOrEditData();
        $cmd1 = "addrgrp set name \"$name\" comment \"$comment\"";
        $cmd2 = "addrgrp set name \"$name\" delallmbr";
        $cmd3 = "addrgrp set name \"$name\" addmbr \"$addmbr\"";
        $cli  = new cli();
        $cli->run($cmd1);
        $cli->run($cmd2);
        $cli->run($cmd3);
        echo json_encode(array('msg' => "[$name]修改成功。"));
    } else if ('add' === $_POST['type']) {
        // Add a new addr group data
        list($name, $comment, $addmbr) = getAddOrEditData();
        $cmd1 = "addrgrp add name \"$name\" comment \"$comment\"";
        $cmd2 = "addrgrp set name \"$name\" addmbr \"$addmbr\"";
        $cli  = new cli();
        $cli->run($cmd1);
        $cli->run($cmd2);
        echo json_encode(array('msg' => "[$name]添加成功。"));
    } elseif('getImgData' === $_POST['type']){
    	$eth  = $_POST['eth'];//根据不同的网关来查找相关的数据
        $msg  = array('ifData'  => getIfStatInfo(),
                      'memUsed' => getMemUsed(),
                      'cpuUsed' => getCpuUsed());
    	echo json_encode(array('msg' => $msg));
    } elseif('getMulCoreData' === $_POST['type']){
        // get Multiple cpu usage rate
        echo json_encode(array('msg' => getCpuXUsed()));
    } else if (!empty($_POST['openDualCoreDialog'])) {
        // open dialog for checking usage rate of multiple core
        $tpl = 'systemManagement/overview/viewMultiCorDialog.tpl';
        $info   = getCpuXUsed();
        $count  = count($info);
        $result = V::getInstance()->assign('count', $count)
            ->assign('result', $info)->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($_POST['action'] === 'viewProcMonitor') {
         V::getInstance()->assign('curStampTime', time())
            ->assign('ifsName', getActiveIfName())
            ->assign('cpuUsed', getCpuUsed())
            ->assign('memUsed', getMemUsed())
            ->display('systemManagement/overview/viewProcMonitor.tpl');
        $cmd = '/bin/cp -rf /proc/net/dev ' .
            '/usr/local/webserver/nginx/html/Logs/ethInfo/' .
            "{$_SESSION['ethFile']}";
        $cli = new cli();
        $cli->setIsRec(false)->run($cmd);
    } else {
        // init page data
        $devinfo  = getDevInfo();
        $liceinfo = getLicenseInfo();
        $hainfo   = getHaInfo();
        $lvsinfo  = getLvsInfo();
        $status   = getServerStatusInfo();
        V::getInstance()->assign('devinfo', $devinfo)
        	->assign('liceinfo', $liceinfo)
        	->assign('status', $status)
			->assign('hainfo', $hainfo)
			->assign('lvsinfo',$lvsinfo);
    }
?>
