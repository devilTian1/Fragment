<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

	function show() {
		//将命令行显示到文本输入框中
		if(file_exists('/tmp/webui.cmd.log')) {
            $result = array();
			$lines  = fileLinesToArr('/tmp/webui.cmd.log', '', 1);
			$num    = count($lines);
			for ($i = $num-1; $i >= 0; $i-=2) {
                $result[] = str_replace(PHP_EOL, "\r\n", $lines[$i-1]);
                $result[] = str_replace(PHP_EOL, "\r\n", $lines[$i]);
			}
			echo json_encode(array('status' => true,'msg' => $result));
		}
	}

	function includeFunc($buffer) {
        if (preg_match('/^([^\s].+)$/',$buffer,$match)) {
            return $match[1];
        } else {
            return false;
        }
    }

	if ('getStr' === $_POST['action']) {
		show();
	} else if ('empty' === $_POST['action']) {
		if(file_exists('/tmp/webui.cmd.log')) {
			if(false === file_put_contents('/tmp/webui.cmd.log','')) {
				 throw new Exception('Can`t empty.');
			}
		}
	} else if ('down' === $_POST['action']) {
		//下载文件
		$filename = urlencode('webui_cmd_log.txt');
        header("Content-Type: application/octet-stream; charset=utf-8;");
        header("Content-Disposition: attachment; filename=\"$filename\";");
        header('Pragma: no-cache;');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0;');
		if(file_exists('/tmp/webui.cmd.log')) {
			$arr   = file('/tmp/webui.cmd.log');
			echo "#hardware: SIS-3000-GE11   software: 1.0.201.89\r\n";
			foreach ($arr as $key=>$val) {
				echo $val . "\r\n";
			}
		}			
	
	} else if ('uploadBatchFile' === $_POST['action']) {
		$dest = '/tmp/upload/';
		$file_name = $dest . 'tmpbatcmd';
		move_uploaded_file($_FILES['batchToolExportFile']['tmp_name'],$file_name);
		$result = file_get_contents($file_name);
		echo json_encode(array('status' => true,'msg' => $result));
			
	} else if ($batchCmd = $_POST['batchCmd']) {
		//先清空文件里面的内容
		file_put_contents('/tmp/upload/tmpbatcmd','');
		//将文本框中的内容写入到文件中去
		file_put_contents('/tmp/upload/tmpbatcmd',$batchCmd);

	} else if ('performBatchProcessing' === $_POST['action']) {
		/*
		//读取文件里面的内容，获取每行命令
		$result = file('/tmp/upload/tmpbatcmd');
		$result_new = array();
		//如果返回的内容里面有空的则将此项
		foreach ($result as $key => $value) {
			if (strlen(trim($value))!==0) {
				$result_new[] = $result[$key];
			}
		}
		$num = count($result_new);
		$num_array =array();
		$num_array[] = $num ;
		$cli = new cli();
		$msg_result =array();
		foreach ($result as $k => $v) {
			$v = trim($v);
			if (empty($v)) {
				continue;
			}
			$cli_array = $cli->run($v);
			$msg_result = array_merge($msg_result,$cli_array);
		}
		$msg_result = array_merge($num_array,$msg_result);
		//批处理结束后再将文件里面的内容清空
		file_put_contents('/tmp/upload/tmpbatcmd','');
		echo json_encode(array('status' => true,'msg' =>$msg_result));
		*/
		$batch_cmd_path = '/tmp/upload/tmpbatcmd';
		if(file_exists($batch_cmd_path)) {
            $result = array();
			clearstatcache();
			$file_size = filesize($batch_cmd_path);
			if ($file_size > 0) {
				//$lines  = fileLinesToArr($batch_cmd_path, '', 1);
				$fp     = @fopen($batch_cmd_path, 'r');
				$buffer = fgets($fp, 4096);
				$includeFunc = includeFunc($buffer);
				$lines  = fileLinesToArr($batch_cmd_path, '', 1, 'includeFunc',NULL);
				//echo "<pre>";
				//print_r($lines);
				$num = count($lines);
				$cli = new cli();
				$sum = 0;
				//$msg_result =array();
				foreach ($lines as $k => $v) {
					//$cli_array = $cli->setGetResult(true)->setLog("[执行批处理命令]".$v)->run($v);
					//echo "<pre>";
					//print_r($cli_array);
					//$msg_result = array_merge($msg_result,$cli_array);
					//$cli->setLog("[执行批处理命令]".$v)->run($v);
					list($status,$result) = $cli->setLog("[执行批处理命令]".$v)
						->execCmdGetStatus($v);
					if ($status > 0) {
					//	echo json_encode(array('msg' =>$v."命令出现错误!"));
						$sum = $sum + 1;
						continue;
					}
				}
				$cmd_num = $num - $sum;
				//array_unshift($msg_result,$num);
				file_put_contents('/tmp/upload/tmpbatcmd','');
				echo json_encode(array('status' => true,'msg' =>$cmd_num));
			} else {
				$result = 0;
				echo json_encode(array('msg' => $result));
			} 
		}

	} else {


	}
	
?>
