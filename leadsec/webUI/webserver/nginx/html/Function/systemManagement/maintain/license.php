<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    /*
	 * Get the certificate information
	 * @param string $orderStatement. query constraints
	 * @param array $result. query results
	 */
    function getLicenseInformation($orderStatement) {
        $tpl    = 'systemManagement/maintain/licenseTable.tpl';
        $db     = new dbsqlite(DB_PATH . '/private.db');
		$sql    = "SELECT function, value, stop_time,start_time 
			FROM license where function Not In 
			('multicast_access','stream_swap','mail_swap','ha')
			$orderStatement";
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
			$result[$key]['stopTime']	=
						$val['value'] > 0 ? getStopTime($val['stop_time'],$val['start_time'],$val['function']):'';
		}
  
        echo V::getInstance()->assign('licenseInformation', $result)
			->assign('pageCount', 10)->fetch($tpl);
    }

    /*
	 * 获取license各个模块中使用的截止时间,如果大于30年则显示永久有效
	 * 否则显示截止的具体日期
	 * $stop,$start为时间戳
	 */
	function getStopTime($stop,$start,$function) {
		$funcArr=array('custom_access','ids');
		if(in_array($function,$funcArr) ){
			return '永久有效';
		}else{
			$avtiveYears =round(($stop-$start)/(365*24*60*60));
			if ($avtiveYears > 30) {
				return "永久有效";
			} else {
				return date('Y-m-d',$stop);
			}
		}
	}
    
    /*
	 * Get the results of the query to the number from license table
	 */
    function getDataCount() {
        $sql = 'SELECT value FROM license';
        $db  = new dbsqlite(DB_PATH . '/private.db');
        return $db->query($sql)->getCount();
    }

	function getSuffixOfFileName($fileName, $length = 3) {   
        $result = '';
        $p      = strrpos($fileName, '.'); 
        if (false !== $p) {
            $result = substr($fileName, $p+1, $length); 
        }
        return $result;
    } 
	
    if (isset($_FILES['uploadLicense'])) {
		//Import license 
		$str_match =  getSuffixOfFileName($_FILES['uploadLicense']['name'],3);
        $dPath = '/tmp';
        $uploadfs = new fileUpload($_FILES,$dPath);
        $uploadfs->upload();
        $cmd  = '/usr/local/license/bin/sls_upload /tmp/' .$_FILES['uploadLicense']['name'];
        $cli  = new cli();
        $msg_log = "系统管理下系统维护模块下导入许可证".$_FILES['uploadLicense']['name'];
        list($status,$result) = $cli->setLog($msg_log)->execCmdGetStatus($cmd);
		if ($status == 0) {
			echo json_encode(array('msg' => '导入成功。'));
		} else {
			echo json_encode(array('msg' => 'License文件错误。'));
		}
    } else if (isset($_POST['orderStatement'])) {
		//Call getLicenseInformation()
		$orderStatement = $_POST['orderStatement'];
        getLicenseInformation($orderStatement);
    } else {
		// init page
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
			->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
            ->assign('prev', 1)
            ->assign('next', 2);
    }
?>

