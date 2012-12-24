<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

	/**
	* 在指定位置插入指定字符串
	* @param type $str 预准备字符串
	* @param type $offset    位置偏移量
	* @param type $input    插入的字符串
	* @return type        返回新的字符串
	*/
	function insert_str($str, $offset, $input)
	{
		$newstr = '';
		for ($i = 0; $i < strlen($str); $i++)
		{
			if (is_array($offset)) //如果插入是多个位置
			{
				foreach ($offset as $v)
				{
					if ($i == $v) $newstr.=$input;
				}
			}
			else    //直接是一个位置偏移量
			{
				if ($i == $offset) $newstr.=$input;
			}
			$newstr.=$str{$i};
		}
		return $newstr;
	}

	function show() {
		//将命令行显示到文本输入框中
		if(file_exists('/tmp/webui.cmd.log')) {
			$arr   = file('/tmp/webui.cmd.log');
			//倒排数组，将最新的命令显示在第一条
			krsort($arr);
			$arr_s = array('CGI_COSYS:',':command=/usr/local/bin/','2>/dev/null');
			$str   = '';
			$result = array();
			foreach($arr as $key => $val) {
				// 替换指定的字符串
				$new_str = str_replace($arr_s,$str,$arr[$key]);
				$new_str = str_replace("\n","\r\n",$new_str);
				$result[] = insert_str(insert_str($new_str,0,'#'),34,"\r\n");
			}
		}			
			echo json_encode(array('status' => true,'msg' =>$result));	
	}

	if ('getStr' === $_POST['action']) {
		show();
	} else if ('empty' === $_POST['action']) {
		//清除文本框中的内容
		if(file_exists('/tmp/webui.cmd.log')) {
			file_put_contents('/tmp/webui.cmd.log','');
			$result   = file('/tmp/webui.cmd.log');
			echo json_encode(array('status' => true,'msg' =>$result));
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
		$result = file_get_contents('/tmp/upload/' . $_FILES['batchToolExportFile']['name']);
		echo json_encode(array('status' => true,'msg' => $result));
			
	} else if ($batchCmd = $_POST['batchCmd']) {
			//echo
			//echo json_encode(array('msg' => 'return'));

	} else {
	
	}
	
?>