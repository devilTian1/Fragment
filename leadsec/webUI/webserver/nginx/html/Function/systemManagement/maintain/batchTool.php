<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

	/**
	* ��ָ��λ�ò���ָ���ַ���
	* @param type $str Ԥ׼���ַ���
	* @param type $offset    λ��ƫ����
	* @param type $input    ������ַ���
	* @return type        �����µ��ַ���
	*/
	function insert_str($str, $offset, $input)
	{
		$newstr = '';
		for ($i = 0; $i < strlen($str); $i++)
		{
			if (is_array($offset)) //��������Ƕ��λ��
			{
				foreach ($offset as $v)
				{
					if ($i == $v) $newstr.=$input;
				}
			}
			else    //ֱ����һ��λ��ƫ����
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