<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    require_once($_SERVER['DOCUMENT_ROOT'].'/Function/systemManagement/maintain/backupAndRecovery.php');
    require_once($_SERVER['DOCUMENT_ROOT'].'/Function/login.php');
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
    	$cmd = "/usr/sbin/backpkg config webserver";
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
		$cmd = "config export \"$configfile\" encrypt off";
		$cli->run($cmd);
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
    }
	
   
?>
