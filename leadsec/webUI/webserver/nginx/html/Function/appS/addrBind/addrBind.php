<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
    if (''===$_POST['switchbyip'] && ''===$_POST['switch']) {
		//用户按网口探测的时候若没有选择网口地址则会提示
		$result = '0' ;
		echo json_encode(array('status' => true,'msg' => $result));
	} else if (''===$_POST['switchbyip'] && 'on'===$_POST['switch']) {
		//用户按网口探测并选择了网口地址，执行"macbind detect if <name> "
		//执行该命令后将数据内容写在"tmp/addrbind_learn.dat"文件中去
		/*
		 * 注意：由于自身的php开发环境不能调用"macbind detect if <name>"
		 * 故暂时屏蔽以下代码，直接在/tmp下建立一个addrbind_learn.dat文件
		 * 假设$str是命令运行后得到的结果
		$fec = $_POST['fecchk'] ;
		$cmd = "macbind detect if" . ' ' . $fec ;
		$cli = new cli();
		$cli->run($cmd);
		$result = $cli->run($cmd);
		*/
		$str = "IP_Address	MAC_Address		Interface
192.164.1.11	00:1C:25:D6:F4:89	fe2
192.164.1.22	00:25:11:69:1A:75	fe2
192.164.1.68	00:90:FB:28:ED:9D	fe2
192.164.1.85	44:37:E6:77:93:14	fe2
192.164.1.90	00:1E:90:75:F4:06	fe2
192.164.1.157	44:37:E6:90:3F:26	fe2
192.164.1.145	00:25:11:40:AE:6A	fe2
192.164.1.167	C8:9C:DC:FB:39:52	fe2
192.164.1.189	44:37:E6:0A:1C:84	fe2
192.164.1.222	44:37:E6:77:AE:E5	fe2
192.164.1.244	00:01:6C:42:7C:B5	fe2
192.164.1.245	00:25:11:40:AE:9E	fe2
192.164.1.21	00:25:11:69:1D:F6	fe2";
		file_put_contents('/tmp/addrbind_learn.dat',$str);
		echo json_encode(array('status' => true,'msg' => $str));
	} else if ('on'===$_POST['switchbyip'] && !empty($_POST['ip'])) {
		//如果用户选择输入ip地址进行探测,执行"macbind detect ip <name> "
		//同样将执行的结果存放在文件"tmp/addrbind_learn.dat"中去，同时
		//文件里面以前的内容清除掉
		/*
		 * 注意：由于自身的php开发环境不能调用"macbind detect ip <name>"
		 * 假设$str是命令运行后得到的结果
		$fec = $_POST['ip'] ;
		$cmd = "macbind detect ip" . ' ' . $fec ;
		$cli = new cli();
		$cli->run($cmd);
		$result = $cli->run($cmd);
		*/
		$str = "IP_Address	MAC_Address		Interface
192.164.1.11	00:1C:25:D6:F4:89	fe2";
		file_put_contents('/tmp/addrbind_learn.dat',$str);
		echo json_encode(array('status' => true,'msg' => $str));
	} else if ($_POST['showResult']==='true'){
		//读取文件的内容，获得数据
		$result = file('/tmp/addrbind_learn.dat');
		$tpl = 'appS/addrBind/editAddrBindDialog.tpl';
		$array_new = array();
		foreach ($result as $key=>$val) {
			$array_new[] = preg_split('/\s+/', trim($val));
		
		}
		$array_value = array_slice($array_new,1,-1);
		$result_val = V::getInstance()->assign('array_value',$array_value)
			->fetch($tpl);
		//echo "<pre>";
		//print_r($array_value);
        echo json_encode(array('msg' => $result_val));
	} else {

	}
?>