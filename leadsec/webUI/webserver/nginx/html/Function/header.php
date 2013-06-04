<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    require_once($_SERVER['DOCUMENT_ROOT'].'/Function/systemManagement/maintain/backupAndRecovery.php');
    require_once($_SERVER['DOCUMENT_ROOT'].'/Function/login.php');
    function getMapVal($key) {
    $map = array(
        'hostname' => '主机名',
        ''         => '空'
    );
    return !empty($map[$key]) ? $map[$key] : $key;
}
    
function includeFunc($buffer) {
    $regex1 = '/^setdb ([^\s]+) ([^\s]+) (.*)$/';
    $regex2 = '/^\s+listen\s(.*)$/';
    if (preg_match($regex1, $buffer, $match)) {
        return $match;
    } else if (preg_match($regex2, $buffer, $match)) {
        $match[0] = 'nginxConf';
        return $match;
    }
    return false;
}

function formatFunc($match) {
    if ($match[0] === 'nginxConf') {
        $result = array('Nginx', 'Listen', $match[1]);
        return $result;
    }
    $result[] = $match[1];
    $result[] = $match[2];
    preg_match_all('/([^\s]+) "([^"]+)"/', $match[3], $frag); 
    $arr = array();
    foreach ($frag[1] as $key => $colName) {
        $colName = getMapVal($colName);
        $val     = getMapVal($frag[2][$key]);
        $arr[] =  "[$colName=$val]";
    }
    $result[] = join(', ', $arr);
    return $result;
}
    
    if ($name_homepage = $_POST['headerName_homepage']) {
        // 首页  
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->setLog("保存配置")->run($cmd);
        echo json_encode(array( 'msg' => "已连接到首页."));      
    }else if ($name_fastconf = $_POST['headerName_fastconf']) {
        // 快捷配置    
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已实现快捷配置."));      
    }else if ($name_save = $_POST['headerName_save']) {
        // 保存    
    	$cli = new cli();
    	$cmd = "/usr/sbin/backpkg config";
    	$cli->setLog("保存配置")->run($cmd);    	
        echo json_encode(array( 'msg' => "已保存."));      
    }else if ($name_refresh = $_POST['headerName_refresh']) {
        // 刷新  
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已刷新."));      
    }else if ($name_exit = $_POST['headerName_exit']) {
        // 退出  
        logout();       
    }else if ($name_exportlog = $_POST['headerName_exportlog']) {
        // 导出日志  
       //生成命令后将对应的文件下载下来      
  		$filename = LOG_PATH;
		$configfile = basename($filename);
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
    }else if ($name_first = $_POST['headerName_first']) {
        // 上一步  
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已到上一步."));      
    }else if ($name_next = $_POST['headerName_next']) {
        // 下一步  
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已到下一步."));      
    }else if ($name_help = $_POST['headerName_help']) {
        // 在线帮助  
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已连接到在线帮助."));    
    }else if ($name_exportconf = $_POST['headerName_exportconf']) {
        // 导出配置  
        $path = '/tmp/download/';	
		$configfile  = ExportFile();
		//$configfile  = "ngconfig_in";
	if($_POST['export_format'] === 'normal') {
		$cmd = "config export \"$configfile\" encrypt off";
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
		
	} else if ($_POST['export_format'] === 'encrypt') {
	// 导出为加密格式
	    $cmd = "config export \"$configfile\" encrypt on";
	    $msg_log = "系统管理下系统维护模块下导出加密的配置文件".$configfile;
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

	} else if ($_POST['export_format'] === 'readable') {
	// 导出为可读格式
	$cmd = "config export \"$configfile\" encrypt off";		
		$cli->run($cmd);
	$filename = $path . $configfile;
	//$path = '/tmp/download/ngconfig_in';
        $result = fileLinesToArr($filename, '', 1, 'includeFunc', 'formatFunc');
        array_unshift($result, array('DB', 'TABLE', 'Content'));
        $filename = $path . $configfile . '_readable';
        $fh = fopen($filename, 'w');
        foreach ($result as $r) {
            if (fputcsv($fh, $r) === false) {
                throw new Exception('Can`t write readable config file.');
            }        
        }
		$file = fopen($filename,"r");
		$filename_s=iconv("utf-8","gb2312",$configfile);
		header("Content-Type: application/octet-stream; charset=UTF-8;");
		header("Content-Disposition: attachment; filename=\"{$filename_s}.csv\";");
        header('Pragma: no-cache;');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0;');
		$buffer=1024;
		$file_count=0;
	}
	
		//向浏览器返回数据
		while(!feof($file) && $file_count<filesize($filename)){
			$file_con = fread($file,$buffer);
			$file_count+=$buffer;
			echo $file_con;
		}
		fclose($file);          
    }
	
   
?>
