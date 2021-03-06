<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
    function checkIDSStatus() {
    	$path = "/usr/local/lxnids/lxnids.options";
    	$idsenable = getParamFromFile($path,'/^LXNIDS_RUN=(\w{2,3})/');
    	if($idsenable[1] === 'YES'){
    		return 1;
    	}else{
    		return -1;
    	}
    }
    
		if ($action_type = $_POST['action_type']) {
			$idsstatus = checkIDSStatus();
			if($idsstatus === 1){
				$cli = new cli();
				$name = $_POST['policyName'];
				$name_c = $_POST['policyName_c'];
				if ($action_type === 'disable') {
					//停止任务
					$cmd1 = "ids start";
					$cmd2 = "ids unset $name";
					$msg_log = "应用防护下入侵检测模块下".$name."服务停止!";
					$cli->run($cmd1);
					$cli->setLog($msg_log)->run($cmd2);
					echo json_encode(array('status' => 0,'msg' => "{$name_c}服务已停止。"));
				} else if ($action_type ==='enable'){
					//开启任务
					$cmd1 = "ids start";
					$cmd2 = "ids set $name";
					$msg_log = "应用防护下入侵检测模块下".$name."服务开启!";
					$cli->run($cmd1);
					$cli->setLog($msg_log)->run($cmd2);
					echo json_encode(array('status' => 0,'msg' => "{$name_c}服务已开启。"));
				}
			}else{    		
				echo json_encode(array('msg' => '请先启动入侵检测。'));
    	    }			
		} else {
			// init page data
			$filePath = "/usr/local/lxnids/idsrules.help";
			$isExisted = file_exists($filePath);
			if ($isExisted) {
				//调用Lib/driver/function.php中的getParamFromFile()
				$matchParamsEnglish = getParamFromFile($filePath,'/^idsPolicyEnglish = (\S+)/');
				$matchValues = getParamFromFile($filePath,'/^enable = (\S+)/');
				$matchParamsChinese = getParamFromFile($filePath,'/^idsPolicyChinese = (\S+)/');
				$matchParamsChinese = iconv("GB2312","UTF-8",$matchParamsChinese['1']);
				$paramsEnglish = explode('|',$matchParamsEnglish['1']);
				$description = array();
				foreach ($paramsEnglish as $k => $v) {
					 $str_array = getParamFromFile($filePath,"/^$paramsEnglish[$k] = ([\S ]+)/");
					 $description[] = iconv("GB2312","UTF-8",$str_array['1']);
				}
				$paramsChinese = explode('|',$matchParamsChinese);
				$values = explode('|',$matchValues['1']);
				if (empty($values)) {
					$count      = count($params);
					$values     = array(0,$count,'N');
					$valuesLine = "enable = " . join('|',$values);
					insertLinetoFile($filePath,$valuesLine,$regexp,'append');
				}
				$result = array();
				foreach ($paramsEnglish as $k => $v) {
					$result[] =			array('EnglishName'=>$paramsEnglish[$k],'ChineseName'=>$paramsChinese[$k],
						'status'=>$values[$k],'description'=>$description[$k]);
				}
				V::getInstance()->assign('dataInfo', $result);
			}

		}
?>