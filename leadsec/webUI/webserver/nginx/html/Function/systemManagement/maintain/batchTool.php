<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

	function show() {
		//将命令行显示到文本输入框中
		if(file_exists('/tmp/webui.cmd.log')) {
            $result = array();
			$lines  = fileLinesToArr('/tmp/webui.cmd.log', '', 1);
			$num    = count($lines);
			for ($i = $num-1; $i >= 0; $i-=2) {
                $result[] = str_replace("\n", "<br/>", $lines[$i-1]);
                $result[] = str_replace("\n", "<br/>", $lines[$i]);
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
		echo json_encode(array('status' =>0,'msg' =>"命令批处理文件已提交，请点击'执行批处理'按钮！"));

	} else if ('performBatchProcessing' === $_POST['action']) {
		$batch_cmd_path = '/tmp/upload/tmpbatcmd';
		if(file_exists($batch_cmd_path)) {
            $result = array();
			clearstatcache();
			$file_size = filesize($batch_cmd_path);
			if ($file_size > 0) {
				$fp     = @fopen($batch_cmd_path, 'r');
				$buffer = fgets($fp, 4096);
				$includeFunc = includeFunc($buffer);
				$lines  = fileLinesToArr($batch_cmd_path, '', 1, 'includeFunc',NULL);
				$num = count($lines);
				$cli = new cli();
				$sum = 0;
				foreach ($lines as $k => $v) {
					list($status,$result) = $cli->setLog("[执行批处理命令]".$v)
						->execCmdGetStatus($v,false);
					if ($status > 0) {
						$sum = $sum + 1;
						continue;
					}
				}
				$cmd_num = $num - $sum;
				file_put_contents('/tmp/upload/tmpbatcmd','');
				echo json_encode(array('status' => true,'msg' =>"执行成功!一共执行了".$cmd_num."条命令。"));
			} else {
				$result = 0;
				echo json_encode(array('status'=>true,'msg' =>"文件内容为空！"));
			} 
		}

	} else {


	}
	
?>
