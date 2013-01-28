<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    if ($name_homepage = $_POST['headerName_homepage']) {
        // 首页  
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已连接到首页."));      
    }else if ($name_fastconf = $_POST['headerName_fastconf']) {
        // 快捷配置    
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已实现快捷配置."));      
    }else if ($name_homepage = $_POST['headerName_homepage']) {
        // 首页  
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已连接到首页."));      
    }else if ($name_save = $_POST['headerName_save']) {
        // 保存    
        $cmd = "/usr/sbin/backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已保存."));      
    }else if ($name_homepage = $_POST['headerName_homepage']) {
        // 首页  
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已连接到首页."));      
    }else if ($name_refresh = $_POST['headerName_refresh']) {
        // 刷新  
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已刷新."));      
    }else if ($name_exit = $_POST['headerName_exit']) {
        // 退出  
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已退出."));      
    }else if ($name_exportlog = $_POST['headerName_exportlog']) {
        // 导出日志  
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已导出日志."));      
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
    }else if ($name_inline = $_POST['headerName_inline']) {
        // 内网  
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已连接到内网."));      
    }else if ($name_online = $_POST['headerName_online']) {
        // 外网  
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已连接到外网."));      
    }else if ($name_exportconf = $_POST['headerName_exportconf']) {
        // 导出配置  
        $cmd = "backpkg config";        
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array( 'msg' => "已导出配置."));      
    }
	
   
?>
