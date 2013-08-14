<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');


	function filterLines($buffer) {
        $regexp = '/^[^\s].+$/';
        if ($_GET['keyword'] != '') {
            $keyword = $_GET['keyword'];
            $regexp = '/^#?.*' . $keyword . '.*$/';
        }
        if (preg_match($regexp, $buffer, $match)) {
            return $match[0];
        } else {
            return false;
        }
    }
    
    function checkIDSStatus() {
    	$path = "/usr/local/lxnids/lxnids.options";
    	$idsenable = getParamFromFile($path,'/^LXNIDS_RUN=(\w{2,3})/');
    	if($idsenable[1] === 'YES'){
    		return 1;
    	}else{
    		return -1;
    	}
    }
    
	//去掉字符串首尾处的双引号
	function remove_quote($str) {
		if (preg_match("/^\"/",$str)) {
			$str = substr($str,1,strlen($str)-1);
		} 
		//判断字符串是否已'"'结束
		if (preg_match("/\"$/",$str)) {
			$str = substr($str,0,strlen($str)-1);
		}
		return $str;
	} 

	function filterParams($line) {
		$array_search_str = array('msg','tos','nocase','content','offset', 'depth','ttl',
		'dsize','ack','seq','flags','itype','icode');
		$val    = preg_split("/[\s,]+/", $line);
		$count  = count($val);
        $data_left = array('source_address' => $val[2], 'source_port'    => $val[3],
						'link_mode'      => $val[1], 'target_address' => $val[5],
						'target_port'    => $val[6]);
		if (strpos($val[0], '#') !== false) {
            $data_left['active'] = 'off';
		} else {
            $data_left['active'] = 'on';
		}
		$array_port_souce = explode(":",$data_left['source_port']);
		$array_port_target = explode(":",$data_left['target_port']);
		$data_left['source_port_start'] = $array_port_souce[0];
		$data_left['source_port_end'] = $array_port_souce[1];
		$data_left['target_port_start'] = $array_port_target[0];
		$data_left['target_port_end'] = $array_port_target[1];
		//如果个数大于7截取$val数组索引从7之后的数组
		if ($count > 7) {
			$result_right = array();
			$data_right = array_slice($val,7);
			$num_right  = count($data_right);
			$num_seach  = count($array_search_str);
			for ($i=0;$i<$num_right;$i++) {
				for($j=0;$j<$num_seach;$j++) {
					if(strpos($data_right[$i],$array_search_str[$j])!== false) {
						$key_search = $array_search_str[$j];
						$offset = strlen($array_search_str[$j]) + 1;
						$result_right[$key_search]  = remove_quote(substr($data_right[$i],$offset,-1)); 
					}
				}
			}
			$result_right['msg'] = substr_replace($result_right['msg'],"",strpos($result_right['msg'],":\""),2);
			//合并数组
			$data = array_merge($data_left,$result_right);
		}
		return $data;
	}
	
	function getCustomTestInfo($limit,$offset){
		$filePath = "/usr/local/lxnids/local.rules";
		$result   = array();
		$data     = fileLinesToArr($filePath, '', 1, 'filterLines');
		if ($limit === 'all') {
			$limit = 4096;
		}
		for ($i = 0; !empty($data[$i+$offset]) && $i < $limit; $i++){
			$num  = $i + $offset;
			$line = $data[$num];
			if($r = filterParams($line)){
				$result[$i] = $r;
				$result[$i]['rule_id'] = $i+1;
				$result[$i]['rowsNum'] = $num + 1; 
			}
		}
		return $result;
	}
 	
    function freshCustomTest($where) {
        $tpl =  'appS/ids/customTestTable.tpl';
        if (!empty($where)) {
            preg_match('/LIMIT (\d+) OFFSET (\d+)/', $where, $match);
            $limit  = $match[1];
            $offset = $match[2];
        } else {
            $limit  = 'all';
            $offset = 0;
        }
		$result= getCustomTestInfo($limit, $offset);
		
		echo V::getInstance()->assign('list', $result)
			->assign('pageCount', 10)
			->fetch($tpl);
		
    }

    function getCmd($type) {
        $sourceAddr = $_POST['source_address'];
        $sourcePort = $_POST['source_address_port1'].":".$_POST['source_address_port2'];
        $destAddr   = $_POST['target_address'];
        $destPort   = $_POST['target_port1'].":".$_POST['target_port2'];
		$editId     = $_POST['editId'];
		switch ($_POST['link_mode']) {
			case 'tcp':
				$protocal = 'tcp';
			break;
			case 'udp':
				$protocal = 'udp';
			break;
			case 'icmp':
				$protocal = 'icmp';
			break;
		}
		if (!empty($_POST['txt_msg'])) {
			$msg = $_POST['txt_msg'];
		} else {
			$msg = '';
		}
		if (!empty($_POST['txt_ipID'])) {
			$tos = "'tos:".$_POST['txt_ipID'].";";
		} else {
			$tos = "'";
		}
		if (isset($_POST['chk_case'])) {
			$nocase = '';
		} else {
			$nocase = 'nocase; ';
		}
		if (!empty($_POST['txt_content'])) {
			$content = "content:\"".$_POST['txt_content']."\";";
		} else {
			$content = '';
		}
		if (!empty($_POST['txt_ipTTL'])) { 
			$ttl = "ttl:".$_POST['txt_ipTTL'].";";
		} else {
			$ttl = '';
		}
		if (!empty($_POST['txt_dsize'])) {
			$datasize = "dsize:".$_POST['txt_dsize'].";";
		} else {
			$datasize = '';
		}
		if(!empty($_POST['txt_tcpACKnum'])) {
			$ack = "ack:".$_POST['txt_tcpACKnum'].";";
		} else {
			$ack = '';
		}
		if (!empty($_POST['txt_tcpSEQnum'])) {
			$seq = "seq:".$_POST['txt_tcpSEQnum'].";";
		} else {
			$seq = '';
		}
		if (!empty($_POST['txt_offset'])) {
			$offset = "offset:".$_POST['txt_offset'].";";
		} else {
			$offset = '';
		}
		if (!empty($_POST['txt_depth'])) {
			$depth = "depth:".$_POST['txt_depth'].";";
		} else {
			$depth = '';
		}
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
		if($protocal === 'tcp') {
			$itype = "";
			$icode = "";
			if (isset($_POST['empty'])) {
				$flagStr = "'";
			} else {
				$flagStr = "flags:".$retain_1.$retain_2.$flagUrg.$flagAck.$flagPsh.$flagRst.$flagSyn.$flagFin.";";
			}
		} else if ($protocal === 'icmp') {
			$flagStr = "";
			if (isset($_POST['rad_icmp'])) {
				$itype = "itype:{$_POST['rad_icmp']};";
			} else {
				$itype = '';
			}
			if (!empty($_POST['txt_icmpcode'])) {
				$icode = "icode:".$_POST['txt_icmpcode'].";";
			} else {
				$icode = 'icode:0;';
			}
		} else if ($protocal === 'udp') {
			$itype = "";
			$flagStr = "";
			$icode = "";
		}
		switch ($type) {
			case 'add':
				$result = "ids $type"."local $sourceAddr" .
            " $sourcePort $destAddr $destPort $protocal '$msg'" .
			" $tos $nocase $content $offset $depth $ttl" .
			" $datasize $ack $seq $flagStr $itype $icode'";
				break;
			case 'set':
				$result = "ids $type"."local $editId $sourceAddr" .
            " $sourcePort $destAddr $destPort $protocal '$msg'" . 
			" $tos $nocase $content $offset $depth $ttl" .
			" $datasize $ack $seq $flagStr $itype $icode'";
				break;
		}
        return $result;
    }

    function getDataCount() {
        $filePath = '/usr/local/lxnids/local.rules';
		$lines = fileLinesToArr($filePath, '', 1,'filterLines',NULL);
		return count($lines);
    }

	if ($id = $_POST['editId'] && !empty($_POST['openEditCustomTestDialog'])) {
        // Get specified addrGroup data
		$result_id = array();
		$result_data = getCustomTestInfo('all',0);
		foreach ($result_data as $k => $v) {
			if($v['rule_id'] == $_POST['editId']) {
				$result_id = $result_data[$k];
			}	
		}
		//$str_offset = strpos($result_id['msg'],":\"");
		//$listMsg = substr_replace($result_id['msg'],"",$str_offset,2);
		if(!empty($result_id['flags'])) {
			//将字符串转换为数组
			$flagsCheckedStr = str_split($result_id['flags']);
		}
        $tpl  = 'appS/ids/editCustomTestDialog.tpl';
        $result_new = V::getInstance()
            ->assign('list', $result_id)
			->assign('checkStr',$flagsCheckedStr)
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
    	$idsstatus = checkIDSStatus();
    	if($idsstatus === 1){
    		$cmd = getCmd('set');
    		$msg_log = "应用防护下入侵检测模块下修改自定义检测。";
    		$cli = new cli();
    		$cli->setLog($msg_log)->run($cmd);
    		echo json_encode(array('msg' => '修改成功。'));
    	}else{
    		echo json_encode(array('msg' => '请先启动入侵检测。'));
    	}    	
    } else if ('add' === $_POST['type']) {
        // Add the specified Alias
    	$idsstatus = checkIDSStatus();
    	if($idsstatus === 1){
    		$cmd = getCmd('add');
    		$msg_log = "应用防护下入侵检测模块下添加自定义检测。";
    		$cli = new cli();
    		$cli->setLog($msg_log)->run($cmd);
    		echo json_encode(array('msg' => '添加成功。'));
    	}else{
    		echo json_encode(array('msg' => '请先启动入侵检测。'));
    	}     	
    } else if (!empty($_POST['delRuleId'])) {
        // Delete specified Alias data
    	$idsstatus = checkIDSStatus();
    	if($idsstatus === 1){
    		$id = $_POST['delRuleId'];
    		$cli  = new cli();
    		$msg_log = "应用防护下入侵检测模块下删除自定义检测中的任务号".$id;
    		$cli->setLog($msg_log)->run("ids dellocal $id");
    		echo json_encode(array('msg' => "删除成功。"));
    	}else{
    		echo json_encode(array('msg' => '请先启动入侵检测。'));
    	}     	
    } else if ($action = $_POST['action']) {
        // Switch specified alias device
    	$idsstatus = checkIDSStatus();
    	if($idsstatus === 1){
    		$rule_id = $_POST['switch_id'];
    		$cli = new cli();
    		if ($action === 'disable') {
    			$cmd = "ids blocklocal $rule_id";
    			$msg_log = "应用防护下入侵检测模块下关闭自定义检测中的任务号".$rule_id;
    			$cli->setLog($msg_log)->run($cmd);
    			echo json_encode(array('msg' => "任务已关闭。"));
    		} else if ($action === 'enable') {
    			$cmd = "ids activatelocal $rule_id";
    			$msg_log = "应用防护下入侵检测模块下启动自定义检测中的任务号".$rule_id;
    			$cli->setLog($msg_log)->run($cmd);
    			echo json_encode(array('msg' => "任务已启动。"));
    		} else {
    			echo json_encode(array('status' => -1, 'msg' => '执行动作错误。'));
    		}
    	}else{
    		echo json_encode(array('msg' => '请先启动入侵检测。'));
    	}    	
    } else if (isset($_POST['orderStatement'])) {
        // fresh and resort alias Table
        freshCustomTest($_POST['orderStatement']);
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
