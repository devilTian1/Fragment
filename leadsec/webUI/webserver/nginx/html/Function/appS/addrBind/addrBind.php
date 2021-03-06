<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

	function includeFunc($buffer) {
        if (preg_match('/^([^\s].+)$/',$buffer,$match)) {
            return $match[1];
        } else {
            return false;
        }
    }
	
	function freshList($where) {
		$tpl = 'appS/addrBind/addrBindListTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "SELECT * FROM addrbind";
		$params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql,$params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('sql_value_array', $result)
			->assign('pageCount', 10)->fetch($tpl);
    }

	function freshDetectIpList($where) {
        $tpl = 'appS/addrBind/detectIpListTable.tpl';
		$result= getAddrBindInfo('show');
		echo V::getInstance()->assign("array_value", $result)
			->fetch($tpl);
    }

	function getWhereStatement($db, $cols, $keyword) {
        //$value  = '%' . $keyword . '%';
		$value  = $keyword;
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' WHERE (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $db->getFilterParams($params));
    }

	function getDataCount() {
        $db  = new dbsqlite(DB_PATH . '/rule.db');
        $sql = "SELECT count(id) as sum FROM addrbind";
		$params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $result = $db->query($sql,$params)->getFirstData(PDO::FETCH_ASSOC);
        return $result['sum'];
    }
	
	function getAddrBindInfo($action){
		$filePath  = '/tmp/addrbind_learn.dat';
		$result = fileLinesToArr($filePath,'', 1,'includeFunc',NULL);
		if (!empty($result)) {
			$num = count($result)-1;
			if ($action == 'show') {
				$result = array_slice($result,1,$num);
			} else if ($action == 'del') {
				$result = array_slice($result,0,$num);
			}
			$array_new = array();
			foreach ($result as $key=>$val) {
				$array_new[] = preg_split('/\s+/', trim($val));
			}
		} 
		return $array_new;
	}

	function getIpbyAddrbindTable($str){
		$db = new dbsqlite(DB_PATH . '/rule.db');
		$sql = "SELECT ip FROM addrbind where $str";
		$result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
		return $result;
	}

	function checkType($str){
		if ($str==='on') {
			$result = 'on';
		} else {
			$result = 'off';
		}
		return $result;
	}

	function getAllIfname() {
    	$IfnameListArr = array();
    	$sql = "SELECT external_name FROM interface WHERE device_type=1 AND (workmode!=3) AND enable=1 AND valid=1 ORDER BY external_name asc";
    	$db  = new dbsqlite(DB_PATH . '/configs.db');
    	$result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	foreach ($result as $k => $v) {
    		$IfnameListArr[] = $v['external_name'];
    	}
    	return $IfnameListArr;
    }

    if (''===$_POST['switchbyip'] && ''===$_POST['switch']) {
		//用户按网口探测的时候若没有选择网口地址则会提示
		$result = '0' ;
		echo json_encode(array('status' => true,'msg' => $result));
	} else if (''===$_POST['switchbyip'] && !empty($_POST['ifname'])) {
		//按照网口进行探测
		$cli = new cli();
		$fec = $_POST['ifname'] ;
		$cmd = "su - -c "."'macbind detect if $fec > /tmp/addrbind_learn.dat'" ;
		$msg_log = "应用防护下地址绑定模块按照".$fec."进行探测。";
		$cli->setLog($msg_log)->setGetResult(true)->run($cmd);
		//$result = '1' ;
		echo json_encode(array('status' => true,'msg' =>'探测成功，点击探测IP/MAC按钮查看结果。'));
	} else if ('on'===$_POST['switchbyip'] && !empty($_POST['ip'])) {
		//按照ip地址进行探测
		$fec_ip = $_POST['ip'] ;
		$cmd = "su - -c "."'macbind detect ip $fec_ip > /tmp/addrbind_learn.dat'" ;
		$msg_log = "应用防护下地址绑定模块按照".$fec_ip."进行探测。";
		$cli = new cli();
		$cli->setLog($msg_log)->setGetResult(true)->run($cmd);
		$result = '2';
		echo json_encode(array('status' => true,'msg' => '探测成功，点击探测IP/MAC按钮查看结果。'));
	} else if ($_POST['showResult']==='true'){
		$tpl = 'appS/addrBind/detectIp.tpl';
		$filePath  = '/tmp/addrbind_learn.dat';
		$result = fileLinesToArr($filePath,'', 1,'includeFunc',NULL);
		if (!empty($result)) {
			$num = count($result)-1;
			$result = array_slice($result,1,$num);
			$array_new = array();
			foreach ($result as $key=>$val) {
				$array_new[] = preg_split('/\s+/', trim($val));
			}
		} 
		$result_all = V::getInstance()->assign("array_value", $array_new)
			->fetch($tpl);
		echo json_encode(array('msg' => $result_all));
	} else if ($_POST['action']==='del') {
		$result = getAddrBindInfo('del');
		if (!empty($result)) {
			$num = count($result);
			//当$_POST['checkSpecUser']被设置的时候
			if (isset($_POST['checkSpecUser'])) {
				$ipsDel = $_POST['checkSpecUser'];
				//根据$ips数组中的键值对删除$result数组中的元素
				foreach ($result as $key => $val) {
					foreach ($ipsDel as $k => $v) {
						//利用unset删除符合条件的元素
						unset($result[$v+1]);
					}
				}
				//删除后将新的数组再存入文件中去
				file_put_contents('/tmp/addrbind_learn.dat','');
				foreach ($result as $key => $val) {
					$str_val = implode('  ',$val) . "\r\n";
					file_put_contents('/tmp/addrbind_learn.dat',$str_val,FILE_APPEND);
				}
				//$tpl = 'appS/addrBind/detectIpListTable.tpl';
				//$result_val = V::getInstance()->assign('array_value',$result)
				//		->fetch($tpl);
				echo json_encode(array('msg' =>'删除成功。'));
			} else {
				//当$_POST['checkSpecUser']没有被设置的时候
				throw new Exception('至少要选中一条记录。');
			}
		} else {
			//当ip/mac地址列表中的文件内容为空的时候
			throw new Exception('无任何IP/MAC地址对。');
		}
	} else if ($_POST['action']==='bind') {
		if (!isset($_POST['checkSpecUser'])) {
			throw new Exception('至少要选中一条记录。');
		} else if (isset($_POST['switch_chk'])) {
			//check set on 
			$cli = new cli();
			//$type是为了cli命令检查唯一性操作的开启
			$type = checkType($_POST['switch_chk']);
			//得到被选中的记录，结果是一个数组
			$ips = $_POST['checkSpecUser'];
			$arr = getAddrBindInfo('show');
			$macbind_arr = array();
			foreach ($ips as $key=>$val) {
				//获取复选框选中的ip信息
				$macbind_arr[] = $arr[$val];
				
			}
			foreach ($macbind_arr as $key=>$val){
				$ipsInstr = $ipsInstr."'".$val[0]."'," ;
			}
			$ipsInstr = substr($ipsInstr,0,-1);
			$searchStr = "ip in(".$ipsInstr.")";
			//查表addrbind获取已绑定的ip地址
			$arr_data_match = getIpbyAddrbindTable($searchStr);
			foreach ($macbind_arr as $key=>$val) {
				foreach ($arr_data_match as $k=>$v) {
					if ($arr_data_match[$k]['ip'] == $macbind_arr[$key][0]) {
						//删除选择ip中已被绑定的ip
						unset($macbind_arr[$key]);
					}
				}
			}
			//如果两个数组都不为空则
			if (!empty($arr_data_match)) {
				//将$macbind_arr中的ip地址绑定
				if(!empty($macbind_arr)) {
					foreach ($macbind_arr as $k => $v) {
						$macbind_ip = $v[0];
						$macbind_mac = $v[1];
						$cmd = "macbind add ip $macbind_ip mac $macbind_mac unique $type";
						$msg_log = "应用防护下地址绑定模块按照".$macbind_ip."进行绑定。";
						$cli->setLog($msg_log)->run($path.$cmd);
					}
				}
				//循环数组$arr_data_match，将ip的提取出来,提示用户已经被绑定的ip地址
				foreach ($arr_data_match as $key => $val) {
						$result = $result.$val['ip']."<br>";
				}
				echo json_encode(array('status'=>-1,'msg' => $result."已被绑定"));
			} else if (empty($arr_data_match)) {
				//如果$arr_data_match为空说明被选择的ip中没有被绑定的地址
				foreach ($macbind_arr as $k => $v) {
					$macbind_ip = $v[0];
					$macbind_mac = $v[1];
					$cmd = "macbind add ip $macbind_ip mac $macbind_mac unique $type";
					$msg_log = "应用防护下地址绑定模块按照".$macbind_ip."进行绑定。";
					$cli->setLog($msg_log)->run($path.$cmd);
				}
					$result = '绑定成功。';
					echo json_encode(array('status'=>0,'msg' => $result));
			}
		} 
	} else if (isset($_POST['orderStatement']) && $_GET['tpl']==='editaddrtpl') {
		//查询addrbind数据表将表中的数据展示出来
		$order = $_POST['orderStatement'];
		freshList($order);
	} else if (isset($_POST['orderStatement']) && $_GET['tpl']==='detecttpl') {
		//刷新detecIpList.tpl

		freshDetectIpList($_POST['orderStatement']);
	} else if (isset($_POST['orderStatement'])) {
		$order = $_POST['orderStatement'];
		freshList($order);
	} else if ($editid = $_POST['editIpId']) {
		//找出对应编辑的ip/mac绑定地址数据
		$db = new dbsqlite(DB_PATH . '/rule.db');
		$sql    = "SELECT * FROM addrbind WHERE id = '$editid'";
        $edit_result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
		$tpl = 'appS/addrBind/editAddrBindDialog.tpl';
		$result = V::getInstance()->assign('edit_result', $edit_result)
			->assign('type','edit')->fetch($tpl);
		echo json_encode(array('msg' =>$result));
	} else if ($_POST['type']==='edit') {
		//执行cli命令 
		$ip = $_POST['ipaddress'];
		$mac = $_POST['macaddress'];
		$type = checkType($_POST['unique']);
		$cli  = new cli();
		$cmd  = "macbind modify ip $ip mac $mac unique $type" ;
		$msg_log = "应用防护下地址绑定模快下修改ip为".$ip."的地址绑定。";
		$cli->setLog($msg_log)->run($cmd);
        echo json_encode(array('msg' => '修改成功。'));
	}  else  if ($ip = $_POST['deleteIpId']) {
        // 删除ip/mac地址对记录
        $cli = new cli();
		$msg_log = "应用防护下地址绑定模快下删除ip".$ip;
        $cli->setLog($msg_log)->run("macbind del ip $ip");
        echo json_encode(array('msg' => '删除成功。'));
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
		echo json_encode(array('msg' => '删除成功。'));
	} else if ($ips = $_POST['delSpecIps']) {
        // 删除已选择的ip/mac地址
        $cli = new cli();
        foreach ($ips as $ip) {
            $cli->setLog("应用防护下地址绑定模快下删除ip".$ip."绑定")->run("macbind del ip $ip");
        }
        echo json_encode(array('msg' => '删除成功。'));
    } else if ($_POST['addNewIp'] === 'true') {
		//添加新的ip/mac地址对
		$tpl = 'appS/addrBind/editAddrBindDialog.tpl';
        $result = V::getInstance()->assign('type', 'add')
			->fetch($tpl);
        echo json_encode(array('msg' => $result));
	} else if ('add' === $_POST['type']) {
		//执行cli命令 
		$ip = $_POST['ipaddress'];
		$mac = $_POST['macaddress'];
		$type = checkType($_POST['unique']);
		$cli  = new cli();
		$msg_log = "应用防护下地址绑定模快下添加地址IP".$ip."MAC".$mac."绑定";
		$cmd  = "macbind add ip $ip mac $mac unique $type" ;
		$cli->setLog($msg_log)->run($cmd);
        echo json_encode(array('msg' => '添加成功。'));
	
	} else if (isset($_GET['reconf'])) {
		//start/stop service
		 $cli = new cli();
		 if ('on' === $_POST['switch_serveice']) {
			$msg_log = "应用防护下地址绑定模块服务启动。";
            $cli->setLog($msg_log)->run('ipmaccfg ipmac_check on');
            $msg = '服务已启动。';
			echo json_encode(array('status' => 0,'msg' => $msg));
        } else {
            // stop start
			$msg_log = "应用防护下地址绑定模块服务停止。";
            $cli->setLog($msg_log)->run('ipmaccfg ipmac_check off');
            $msg = '服务已停止。';
			echo json_encode(array('status' => 0,'msg' => $msg));
        }
	} else {
		//页面初始化
		$cli     = new cli();
        $return  = $cli->setGetResult(true)->run('ipmaccfg show');
		$str     = $return[0];
		if (false !== strpos($str, 'off')) {
            $switch = 'off';
        } else if (false !== strpos($str, 'on')) {
            $switch = 'on';
        } else {
            throw new Exception('Can`t detect the status of ipmac service.');
        }
		$result = getDataCount();
		$iflist = getAllIfname();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2)
			->assign('status',$switch)
			->assign('ifnames',$iflist);
	}
?>