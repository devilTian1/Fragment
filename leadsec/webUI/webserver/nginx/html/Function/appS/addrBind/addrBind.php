<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

	function includeFunc($buffer) {
        if (preg_match('/^([^\s].+)$/',$buffer,$match)) {
            return $match[1];
        } else {
            return false;
        }
    }
	
	function freshIpList() {
		$tpl = 'appS/addrBind/editAddrBindDialog.tpl';
		$filePath  = '/tmp/addrbind_learn.dat';
		$result = fileLinesToArr($filePath,'', 1,'includeFunc',NULL);
		if (!empty($result)) {
			$num = count($result)-1;
			$result = array_slice($result,2,$num);
			$array_new = array();
			foreach ($result as $key=>$val) {
				$array_new[] = preg_split('/\s+/', trim($val));
			}
			echo V::getInstance()->assign('array_value', $array_new)->fetch($tpl);
		} else { 
			echo V::getInstance()->fetch($tpl);
		}
    }
	

	 function freshList($where) {
		$tpl = 'appS/addrBind/editAddrTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "SELECT * FROM addrbind $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('sql_value_array', $result)
			->assign('pageCount', 10)->fetch($tpl);
    }

	function getDataCount() {
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "SELECT count(id) as sum FROM addrbind";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return $result['sum'];
    }

    if (''===$_POST['switchbyip'] && ''===$_POST['switch']) {
		//用户按网口探测的时候若没有选择网口地址则会提示
		$result = '0' ;
		echo json_encode(array('status' => true,'msg' => $result));
	} else if (''===$_POST['switchbyip'] && 'on'===$_POST['switch']) {
		//按照网口进行探测
		$cli = new cli();
		$fec = $_POST['fecchk'] ;
		$cmd = "macbind detect if".' '.$fec.' '.">"."/tmp/addrbind_learn.dat" ;
		$cli->run($cmd);
		$result = '1' ;
		echo json_encode(array('status' => true,'msg' => $result));
	} else if ('on'===$_POST['switchbyip'] && !empty($_POST['ip'])) {
		//按照ip地址进行探测
		$fec_ip = $_POST['ip'] ;
		$cmd = "macbind detect ip".' '.$fec_ip.' '.">"."/tmp/addrbind_learn.dat" ;
		$cli = new cli();
		$cli->run($cmd);
		$result = '2';
		echo json_encode(array('status' => true,'msg' => $result));
	} else if ($_POST['showResult']==='true'){
		freshIpList();
	} else if ($_POST['action']==='del') {
		$result = file('/tmp/addrbind_learn.dat');
		if (!empty($result)) {
			$array_new = array();
			foreach ($result as $key=>$val) {
				$array_new[] = preg_split('/\s+/', trim($val));
			}
			//加判断，打开文件后，看文件的第一行是否含有IP_Address
			//等字符,若有该字符，数组进行截取的时候，不截取该元素
			$arr_top = array_slice($array_new,0,1);
			$str_top = '';
			foreach ($arr_top[0] as $kk => $vv) {
				$str_top = $str_top . $vv ;
			}
			if (preg_match("/ip/i",$str_top)) {
				$array_value = array_slice($array_new,1);
			} else {
				$array_value = $array_new;
			}
			$num = count($array_value);
			//当$_POST['checkSpecUser']被设置的时候执行以下代码
			if (isset($_POST['checkSpecUser'])) {
				$ips = $_POST['checkSpecUser'];
				$ips_count = count($ips);
				$arr_num = array();
				//当$ips的个数为1个并且$ips的值小于等于$array_value
				//的索引的最大值时用下面的删除方法
				if($ips_count == 1) {
					foreach ($ips as $key => $val) {
						array_splice($array_value,$val,1) ;
					}
					//删除后将新的数组再存入文件中去
					file_put_contents('/tmp/addrbind_learn.dat','');
					foreach ($array_value as $k => $v) {
						$str_val = implode('  ',$v) . "\r\n";
						file_put_contents('/tmp/addrbind_learn.dat',$str_val,FILE_APPEND);
					}
					$tpl = 'appS/addrBind/editAddrBindDialogTable.tpl';
					$result_val = V::getInstance()->assign('array_value',$array_value)
						->fetch($tpl);
					echo json_encode(array('msg' => $result_val));	
				} else if ($ips_count > 1) {
					foreach ($ips as $key => $val) {
						array_splice($array_value,$val,1,'');	
					}
					foreach ($array_value as $kk => $vv) {
						if (!empty($vv)) {
							$arr_num[] = $vv;
						}
					}
					//删除后将新的数组再存入文件中去
					file_put_contents('/tmp/addrbind_learn.dat','');
					foreach ($arr_num as $k => $v) {
						$str_val = implode('  ',$v) . "\r\n";
						file_put_contents('/tmp/addrbind_learn.dat',$str_val,FILE_APPEND);
					}
					$tpl = 'appS/addrBind/editAddrBindDialogTable.tpl';
					$result_val = V::getInstance()->assign('array_value',$arr_num)
						->fetch($tpl);
					echo json_encode(array('msg' => $result_val));
				}
			} else {
				//当$_POST['checkSpecUser']没有被设置的时候
				$result = '0' ;
				echo json_encode(array('msg' => $result));
			}
		} else {
			//当ip/mac地址列表中的文件内容为空的时候
			$result = 'empty' ;
			echo json_encode(array('msg' => $result));
		}
	} else if ($_POST['action']==='bind' && $_POST['switch_chk']==='on') {
		if (!isset($_POST['checkSpecUser'])) {
			$result = '3';
			echo json_encode(array('msg' => $result));
		} else {
			$ips = $_POST['checkSpecUser'];
			//根据$ips的值去取对应的ip/mac对应的值
			$result = file('/tmp/addrbind_learn.dat');
			if (!empty($result)) {
				$array_new = array();
					foreach ($result as $key=>$val) {
					$array_new[] = preg_split('/\s+/', trim($val));
				} 
				$arr_top = array_slice($array_new,0,1);
				$str_top = '';
				foreach ($arr_top[0] as $kk => $vv) {
					$str_top = $str_top . $vv ;
				}
				if (preg_match("/ip/i",$str_top)) {
					$array_value = array_slice($array_new,1);
				} else {
					$array_value = $array_new;
				}
				$sql_value_array = array();
				foreach ($ips as $key=>$val) {
					$sql_value_array[] = $array_value[$val];
				}
				foreach ($sql_value_array as $k=>$v) {
					array_push($sql_value_array[$k],true);
				}
				//echo "<pre>";
				//print_r($sql_value_array);
				$db = new dbsqlite(DB_PATH . '/rule.db');
				//向addrbind表中插入数据之前，先查看addrbind表中是否含有
				//与被绑定的ip有相同的值，若有则提示
				$arr_data_match = array();
				$arr_data_not_match = array();
				$sql_match = "SELECT ip FROM addrbind ";
				$sql_match_result = $db->query($sql_match)->getAllData(PDO::FETCH_ASSOC);
				if (empty($sql_match_result)) {
					$sqls = array("INSERT INTO addrbind VALUES(null, ?, ?, ?, ?)");
					$db->execByTransaction($sqls, $sql_value_array);	
				} else {
					//提取出两个数组中相同的值
					$num_value_array = count($sql_value_array);
					$num_match_result= count($sql_match_result);
					for($i=0;$i<$num_value_array;$i++) {
						for($j=0;$j<$num_match_result;$j++) {
							if ($sql_value_array[$i][0] === $sql_match_result[$j]['ip']) {
								$arr_data_match[] = $sql_value_array[$i];
								//将符合条件的数据删掉，得到不符合条件的数据
								unset($sql_value_array[$i]);
							} 
						}
					}
					//判断$sql_value_array是否为空，若不为空则则将里面的数据插入到
					//addrbind数据表中去,并且将数据动态的显示到列表也中去
					if (!empty($sql_value_array)) {
						$tpl = 'appS/addrBind/editAddrTable.tpl';
						$sqls = array("INSERT INTO addrbind VALUES(null, ?, ?, ?, ?)");
						$db->execByTransaction($sqls, $sql_value_array);
						$sql = 'SELECT * FROM addrbind';
						$result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);;
						echo V::getInstance()->assign('sql_value_array',$result)->fetch($tpl);
					}
					//判断$arr_data_match是否为空，若不为空则将数据中的ip提取出来
					//提示该ip已被绑定
					if (!empty($arr_data_match)) {
						//循环数组，将ip的值提取出来
						$result = array();
						foreach ($arr_data_match as $key => $val) {
							$result[] = $val[0];
						}	
						echo json_encode(array('msg' => $result));
					}
				}	
			}
		} 
	} else if (!empty($_POST['orderStatement']) && $_GET['tpl']==='editaddrtpl') {
		//查询addrbind数据表将表中的数据展示出来
		$order = $_POST['orderStatement'];
		freshList($order);
		
	} else if ($editid = $_POST['editIpId']) {
		//找出对应编辑的ip/mac绑定地址数据
		$db = new dbsqlite(DB_PATH . '/rule.db');
		$sql    = "SELECT * FROM addrbind WHERE id = '$editid'";
        $edit_result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
		$tpl = 'appS/addrBind/editAddr.tpl';
		$result = V::getInstance()->assign('edit_result', $edit_result)
			->assign('type','edit')->fetch($tpl);
		echo json_encode(array('msg' =>$result));
	} else if ($_POST['type']==='edit') {
		//执行cli命令 
		$ip = $_POST['ipaddress'];
		$mac = $_POST['macaddress'];
		if ($_POST['unique_chk']=='0') {
			$unique = 'off';
		}	else if ($_POST['unique_chk']=='1') {
			$unique = 'on' ;
		}
		$cli  = new cli();
		$cmd  = "macbind add ip $ip mac $mac unique $unique" ;
		$cli->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
	}  else  if ($ip = $_POST['deleteIpId']) {
        // 删除ip/mac地址对记录
        $cli = new cli();
        $cli->run("macbind del ip $ip");
        echo json_encode(array('msg' => '删除成功.'));
	} else if (!empty($_POST['delAllIp'])){
		//删除所有的ip/mac地址记录，查询addrbind数据表中的ip字段
		$db = new dbsqlite(DB_PATH . '/rule.db');
		$sql = "SELECT ip FROM addrbind ";
		$result_ip = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
		$num_ip = count($result_ip);
		$cli = new cli();
		foreach ($result_ip as $key=>$val) {
			$ip = $val['ip'] ;
			$cli->run("macbind del ip $ip");	
		}
		echo json_encode(array('msg' => '删除成功.'));
	} else if ($ips = $_POST['delSpecIps']) {
        // 删除已选择的ip/mac地址
        $cli = new cli();
        foreach ($ips as $ip) {
            $cli->run("macbind del ip $ip");
        }
        echo json_encode(array('msg' => '删除成功.'));
    } else if ($_POST['addNewIp'] === 'true') {
		//添加新的ip/mac地址对
		$tpl = 'appS/addrBind/editIpDialog.tpl';
        $result = V::getInstance()->assign('type', 'add')
			->fetch($tpl);
        echo json_encode(array('msg' => $result));
	} else if ('add' === $_POST['type']) {
		//执行cli命令 
		$ip = $_POST['addip'];
		$mac = $_POST['addmac'];
		if ($_POST['addUnique']=='') {
			$unique = 'off';
		}	else if ($_POST['addUnique']=='on') {
			$unique = 'on' ;
		}
		$cli  = new cli();
		$cmd  = "macbind add ip $ip mac $mac unique $unique" ;
		$cli->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
	
	} else if (!empty($_POST['orderStatement'])) {
		$order = $_POST['orderStatement'];
		freshList($order);
	} else {
		//页面初始化
		$result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
	}
?>