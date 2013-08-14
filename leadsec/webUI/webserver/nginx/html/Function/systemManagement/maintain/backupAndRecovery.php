<?php
    require_once($_SERVER['DOCUMENT_ROOT'].'/Function/common.php');

    /*
     * Get suffix of filename
     * @param $fileName.
     * @param $length. length of suffix of fileName
     */
    function getSuffixOfFileName($fileName, $length = 3) {   
        $result = '';
        $p      = strrpos($fileName, '.'); 
        if (false !== $p) {
            $result = substr($fileName, $p+1, $length); 
        }
        return $result;
    } 
    
    /*
     * Get Db Name
     * param $path. absolute path. eg: /usr/local/conf/private.db
     * return. String. db name. eg: private
     */
    function getDbName($path) {
        return substr($path, strrpos($path, '/') + 1, strrpos($path, '.'));
    }

    /*
        判断要下载的文件属于外网与内网
    */
    function ExportFile() {
        $db   = new dbsqlite(DB_PATH . '/netgap_system.db');
        $host = $db->query('SELECT host FROM system')
            ->getFirstData(PDO::FETCH_ASSOC);
        if ($host['host'] === 'O'){
            $configfile = 'ngconfig_out';
        } else {
            $configfile = 'ngconfig_in';
        }
        return $configfile ;
    }


    function getEncryptStr($result) {
        return base64_encode($result);
    }

	/*
	 * 判断上传文件的格式
	 */
	function getUploadFileName($file) {
		if ($file!=='ngconfig_in' || $file!=='ngconfig_out') {
			return false;
		} else {
			return true;
		}
	}
	
	function getStatusInfo($status) {
		switch ($status) {
			case 1:
				$showErrorInfo = 'mount失败';break;
			case 2:
				$showErrorInfo = '数据库打开失败';break;
		}
		return $showErrorInfo;
	}

    $cli = new cli();
    if (!empty($_FILES)) {
		$uploadfs = new fileUpload();
		$uploadfs->upload();
		$cmd = "config import \"{$_FILES['importFile']['name']}\"";
		$log = '系统管理下系统维护模块下导入配置文件' .
            $_FILES['importFile']['name'];
		list($status,$result) = $cli->setLog($log)->execCmdGetStatus($cmd);
		if ($status > 0) {
			echo json_encode(array('status'=>$status,'msg' => '导入失败，请选择正确的配置文件。'));	
		} else {
			echo json_encode(array('status'=>$status,'msg' => '导入成功，请重启网闸。'));
		}
    } else if ('off' === $_POST['switch']) {
		$path = '/tmp/download/';
		$type = $_POST['switch'];
		$configfile  = ExportFile();
		//$configfile  = "ngconfig_in";
		$cmd = "config export \"$configfile\" encrypt $type ";
		$msg_log = "系统管理下系统维护模块下导出不加密的配置文件".$configfile;
		$cli->setLog($msg_log)->run($cmd);
		//生成命令后将对应的文件下载下来
		$filename = $path . $configfile;
		$file = fopen($filename,"r");
		$filename_s=iconv("utf-8","gb2312",$configfile);
		header("Content-Type: application/octet-stream; charset=utf-8;");
		header("Content-Disposition: attachment; filename=\"$filename_s\";");
        header('Pragma: no-cache;');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0;');
		$buffer=1024;
		$file_count=0;
		//向浏览器返回数据
		while(!feof($file) && $file_count<filesize($filename)){
			$file_con = fread($file,$buffer);
			$file_count+=$buffer;
			echo $file_con;
		}
		fclose($file);
    } else if ('on' === $_POST['switch']) {
		$path = '/tmp/download/';
		$type = $_POST['switch'];
		$configfile  = ExportFile();
		//$configfile  = "ngconfig_in";
		$msg_log = "系统管理下系统维护模块下导出加密的配置文件".$configfile;
		$cmd = "config export \"$configfile\" encrypt $type ";
		$cli->setLog($msg_log)->run($cmd);
		//生成命令后将对应的文件下载下来
		$filename = $path . $configfile;
		$file = fopen($filename,"r");
		header("Content-Type: application/octet-stream;");
		header("Content-Disposition: attachment; filename=\"$configfile\";");
        header('Pragma: no-cache;');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0;');
		$buffer=1024;
		$file_count=0;
		//向浏览器返回数据
		while(!feof($file) && $file_count<filesize($filename)){
			$file_con = fread($file,$buffer);
			$file_count+=$buffer;
			echo $file_con;
		}
		fclose($file);	
	} else if (!empty($_GET['restore'])){
        // restore the factory configuration
        $cmd = 'config reset';
		$msg_log = "系统管理下系统维护模块下恢复出厂配置";
		list($status,$result) = $cli->setLog($msg)->execCmdGetStatus($cmd);
        if ($status > 0) {
			$showErrorInfo = getStatusInfo($status);
			echo json_encode(array('status'=>$status,'msg' => $showErrorInfo));
		} else {
			echo json_encode(array('status'=>$status,'msg' => '操作成功!请重启安全隔离网闸。'));
		}
    } else if (!empty($_GET['reboot'])) {
		$msg_log = "系统管理下恢复出厂配置后对网闸进行重启";
        $cli = new cli();
        $cli->setLog($msg_log)->run('/sbin/reboot');
	} else if (!empty($_GET['save'])){
        // save configuration info
		$msg_log = "系统管理下系统维护模块下保存配置";
        $cli->setLog($msg_log)->run('config save');
        echo json_encode(array('msg' => '保存配置成功。'));
    } else {
        // initial page info
    }
?>
