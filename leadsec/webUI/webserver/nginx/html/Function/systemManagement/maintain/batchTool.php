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

	if ('getStr' === $_POST['action']) {
		if(file_exists('/tmp/webui.cmd.log')) {
			$arr   = file('/tmp/webui.cmd.log');
			krsort($arr);
			$arr_s = array('CGI_COSYS:',':command=/usr/local/bin/','2>/dev/null');
			$str   = '';
			$result = array();
			foreach($arr as $key => $val) {
				$new_str = str_replace($arr_s,$str,$arr[$key]);
				$result[]= insert_str(insert_str($new_str,0,'#'),34,"\n");
			}
		}			
			echo json_encode(array('status' => true,'msg' =>$result));
	} else {
		
	
	}
	
?>