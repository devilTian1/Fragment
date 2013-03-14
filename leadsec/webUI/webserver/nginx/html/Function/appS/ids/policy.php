<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

		if ($action_type = $_POST['action_type']) {
			$cli = new cli();
			$name = $_POST['policyName'];
			if ($action_type === 'disable') {
				//停止任务
				$cmd1 = "ids start";
				$cmd2 = "ids unset $name";
				$cli->run($cmd1);
				$cli->run($cmd2);
				echo json_encode(array('status' => 0,'msg' => "{$name}服务已停止"));
			} else if ($action_type ==='enable'){
				//开启任务
				$cmd1 = "ids start";
				$cmd2 = "ids set $name";
				$cli->run($cmd1);
				$cli->run($cmd2);
				echo json_encode(array('status' => 0,'msg' => "{$name}服务已开启!"));
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
					 $str_array = getParamFromFile($filePath,"/^$paramsEnglish[$k] = (\S+)/");
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