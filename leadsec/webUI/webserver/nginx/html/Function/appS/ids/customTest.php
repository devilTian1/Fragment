<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

	function includeFunc($buffer) {
        if (preg_match('/^([^\s].+)$/',$buffer,$match)) {
            return $match[1];
        } else {
            return false;
        }
    }
 	
    function freshCustomTest() {
		$arr_serch = array('"',';',')');
        $tpl =  'appS/ids/customTestTable.tpl';
        $filePath = "/usr/local/lxnids/local.rules";
		$isExisted = file_exists($filePath);
		if ($isExisted) {
			$fp     = @fopen($filePath, 'r');
			$buffer = fgets($fp, 4096);
			$includeFunc = includeFunc($buffer);
			$array_new = fileLinesToArr($filePath,'', 1,'includeFunc',NULL);
			$result = array();
			foreach ($array_new as $key =>$val) {
				$val = preg_split("/[\s,]+/", $array_new[$key]);
					if (strpos($val[0],'#')!== false) {
						$result[] =	array('source_address'=>$val[2],'source_port'=>$val[3],
							'link_mode'=>$val[1],'target_address'=>$val[5],
							'target_port'=>$val[6],'txt_msg'=>str_replace($arr_serch,'',substr($val[8],0,-5)),
							'active'=>'off','rule_id'=>$key+1);
					} else {
						$result[] =	array('source_address'=>$val[2],'source_port'=>$val[3],
							'link_mode'=>$val[1],'target_address'=>$val[5],
							'target_port'=>$val[6],'txt_msg'=>str_replace($arr_serch,'',substr($val[8],0,-5)),
							'active'=>'on','rule_id'=>$key+1);
					}
			}
			echo V::getInstance()->assign('list', $result)
				->assign('pageCount', 10)
				->fetch($tpl);
		}
    }

    function getCmd($type) {
        $sourceAddr = $_POST['source_address'];
        $sourcePort = $_POST['source_address_port1'].":".$_POST['source_address_port2'];
        $destAddr   = $_POST['target_address'];
        $destPort   = $_POST['target_port1'].":".$_POST['target_port2'];
		$editId     = $_POST['editId'];
		switch ($_POST['link_mode']) {
			case 'tcp':
				$protocal = 'tcp';break;
			case 'udp':
				$protocal = 'udp';break;
			case 'icmp':
				$protocal = 'icmp';break;
		}
		$msg = $_POST['txt_msg'];
		$tos = $_POST['txt_ipID'];
		if (isset($_POST['chk_case'])) {
			$nocase = '';
		} else {
			$nocase = 'nocase';
		}
		$content = $_POST['txt_content'];
		$ttl = $_POST['txt_ipTTL'];
		$datasize = $_POST['txt_dsize'];
		$ack = $_POST['txt_tcpACKnum'];
		$seq = $_POST['txt_tcpSEQnum'];
		$offset = $_POST['txt_offset'];
		$depth = $_POST['txt_depth'];
		if (isset($_POST['retain_1'])) {
			$retain_1 = '1';
		} else {
			$retain_1 = '';
		}
		if (isset($_POST['retain_2'])) {
			$retain_2 = '2';
		} else {
			$retain_2 = '';
		}
		if (isset($_POST['urg'])) {
			$flagUrg = 'U';
		} else {
			$flagUrg = '';
		}
		if (isset($_POST['ack'])) {
			$flagAck = 'A';
		} else {
			$flagAck = '';
		}
		if (isset($_POST['psh'])) {
			$flagPsh = 'P';
		} else {
			$flagPsh = '';
		}
		if (isset($_POST['rst'])) {
			$flagRst = 'R';
		} else {
			$flagRst = '';
		}
		if (isset($_POST['syn'])) {
			$flagSyn = 'S';
		} else {
			$flagSyn = '';
		}
		if (isset($_POST['fin'])) {
			$flagFin = 'F';
		} else {
			$flagFin = '';
		}
		if (isset($_POST['empty'])) {
			$flagStr = '';
		} else {
			$flagStr = $retain_1.$retain_2.$flagUrg.$flagAck.$flagPsh.$flagRst.$flagSyn.$flagFin;
		}
		switch ($type) {
			case 'add':
				$result = "ids $type"."local $sourceAddr" .
            " $sourcePort $destAddr $destPort $protocal '$msg'" .
			" 'tos:$tos; $nocase; content:\"$content\"; offset:$offset; depth:$depth; ttl:$ttl;" .
			" datasize:$datasize; ack:$ack; seq:$seq; flags:$flagStr;'";
				break;
			case 'set':
				$result = "ids $type"."local $editId $sourceAddr" .
            " $sourcePort $destAddr $destPort $protocal '$msg'" . 
			" 'tos:$tos; $nocase; content:\"$content\"; offset:$offset; depth:$depth; ttl:$ttl;" .
			" datasize:$datasize; ack:$ack; seq:$seq; flags:$flagStr'";
				break;
		}
		
        return $result;
    }

    function getDataCount() {
        $tpl =  'appS/ids/customTestTable.tpl';
        $filePath = "/usr/local/lxnids/local.rules";
        $result = file($filePath);
		$array_new = array();
		foreach ($result as $key=>$val) {
			if (strlen($val) > 1) {
				$array_new[] = ($result[$key]);
			}
		}
		return count($array_new);
    }

	if ($id = ($_POST['editId']) && !empty($_POST['openEditCustomTestDialog'])) {
        // Get specified addrGroup data
		$arr_serch = array('"',';',')');
		$filePath = "/usr/local/lxnids/local.rules";
		$fp     = @fopen($filePath, 'r');
		$buffer = fgets($fp, 4096);
		$includeFunc = includeFunc($buffer);
		$array_new = fileLinesToArr($filePath,'', 1, 'includeFunc',NULL);
		$result = array();
		foreach ($array_new as $key =>$val) {
				$val = preg_split("/[\s,]+/", $array_new[$key]);
				if (strpos($val[0],'#')!== false) {
					$result[] =	array('source_address'=>$val[2],'source_port'=>$val[3],
						'link_mode'=>$val[1],'target_address'=>$val[5],
						'target_port'=>$val[6],'txt_msg'=>str_replace($arr_serch,'',substr($val[8],0,-5)),
						'active'=>'off','rule_id'=>$key+1);
				} else {
					$result[] =	array('source_address'=>$val[2],'source_port'=>$val[3],
						'link_mode'=>$val[1],'target_address'=>$val[5],
						'target_port'=>$val[6],'txt_msg'=>str_replace($arr_serch,'',substr($val[8],0,-5)),
						'active'=>'on','rule_id'=>$key+1);
				}
		}
		$result_id = array();
		foreach ($result as $k => $v) {
			if($v['rule_id'] == $_POST['editId']) {
				$result_id[] = $result[$k];
			}	
		}
		$result_data = $result_id[0];
        $tpl  = 'appS/ids/editCustomTestDialog.tpl';
        $result_new = V::getInstance()
            ->assign('list', $result_data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result_new));
    } else if (!empty($_POST['openNewCustomTestDialog'])) {
        // Display add dbSyncinformation
        $tpl = $_POST['tpl'];
        $result = V::getInstance()
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {	
        // Edit the specified Alias
        $cmd = getCmd('set');
		$msg_log = "应用防护下入侵检测模块下修改自定义检测";
        $cli = new cli();
        $cli->setLog($msg_log)->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add the specified Alias
        $cmd = getCmd('add');
		$msg_log = "应用防护下入侵检测模块下添加自定义检测";
        $cli = new cli();
        $cli->setLog($msg_log)->run($cmd);
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['delRuleId'])) {
        // Delete specified Alias data
        $id = $_POST['delRuleId'];
        $cli  = new cli();
		$msg_log = "应用防护下入侵检测模块下删除自定义检测中的任务号".$id;
        $cli->setLog($msg_log)->run("ids dellocal $id");
        echo json_encode(array('msg' => "删除成功."));
    } else if ($action = $_POST['action']) {
        // Switch specified alias device
        $rule_id = $_POST['switch_id'];
        $cli = new cli();
        if ($action === 'disable') {
            $cmd = "ids blocklocal $rule_id";
			$msg_log = "应用防护下入侵检测模块下关闭自定义检测中的任务号".$rule_id;
            $cli->setLog($msg_log)->run($cmd);
            echo json_encode(array('msg' => "任务已关闭."));
        } else if ($action === 'enable') {
            $cmd = "ids activatelocal $rule_id";
			$msg_log = "应用防护下入侵检测模块下启动自定义检测中的任务号".$rule_id;
            $cli->setLog($msg_log)->run($cmd);
            echo json_encode(array('msg' => "任务已启动."));
        } else {
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort alias Table
        freshCustomTest($orderStatement);
    }else {
        // init page data
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }


?>
