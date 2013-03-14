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
		$fp     = @fopen($filePath, 'r');
		$buffer = fgets($fp, 4096);
		$includeFunc = includeFunc($buffer);
		$array_new = fileLinesToArr($filePath,'', 1,'includeFunc',NULL);
		$result = array();
		foreach ($array_new as $key =>$val) {
			$val = preg_split("/[\s,]+/", $array_new[$key]);
				if (strstr($val[$k],'#')) {
					$result[] =	array('source_address'=>$val[3],'source_port'=>$val[4],
						'link_mode'=>$val[2],'target_address'=>$val[6],
						'target_port'=>$val[7],'txt_msg'=>str_replace($arr_serch,'',$val[9]),
						'active'=>'on','rule_id'=>$key+1);
				} else {
					$result[] =	array('source_address'=>$val[2],'source_port'=>$val[3],
						'link_mode'=>$val[1],'target_address'=>$val[5],
						'target_port'=>$val[6],'txt_msg'=>str_replace($arr_serch,'',$val[8]),
						'active'=>'off','rule_id'=>$key+1);
				}
		}
        echo V::getInstance()->assign('list', $result)
        	->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getCmd($type) {
        $sourceAddr = $_POST['source_address'];
        $sourcePort = $_POST['source_address_port1'].":".$_POST['source_address_port1'];
        $destAddr   = $_POST['target_address'];
        $destPort   = $_POST['target_port1'].":".$_POST['target_port2'];
        $protocal   = $_POST['link_mode'];
		$editId     = $_POST['editId'];
		if ($_post['link_mode'] == '0') {
			$protocal = 'tcp';
		} else if ($_post['link_mode'] == '1') {
			$protocal = 'udp' ;
		} else {
			$protocal = 'icmp' ;
		}
		$msg = $_POST['txt_msg'];
		if ($type ==='add') {
        $result = "ids $type"."local $sourceAddr" .
            " $sourcePort $destAddr $destPort $protocal '$msg' ";
		} else if ($type ==='edit') {
		$result = "ids $type"."local $editId $sourceAddr" .
            " $sourcePort $destAddr $destPort $protocal '$msg' ";
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
		$filePath = "/usr/local/lxnids/local.rules";
		$fp     = @fopen($filePath, 'r');
		$buffer = fgets($fp, 4096);
		$includeFunc = includeFunc($buffer);
		$array_new = fileLinesToArr($filePath,'', 1, 'includeFunc',NULL);
		$result = array();
		foreach ($array_new as $key =>$val) {
				$val = preg_split("/[\s,]+/", $array_new[$key]);
				if (strstr($val[$k],'#')) {
					$result[] =	array('source_address'=>$val[3],'source_port'=>$val[4],
						'link_mode'=>$val[2],'target_address'=>$val[6],
						'target_port'=>$val[7],'txt_msg'=>$val[9],
						'active'=>'on','rule_id'=>$key+1);
				} else {
					$result[] =	array('source_address'=>$val[2],'source_port'=>$val[3],
						'link_mode'=>$val[1],'target_address'=>$val[5],
						'target_port'=>$val[6],'txt_msg'=>$val[8],
						'active'=>'off','rule_id'=>$key+1);
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
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add the specified Alias
        $cmd = getCmd('add');
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['delRuleId'])) {
        // Delete specified Alias data
        $id = $_POST['delRuleId'];
        $cli  = new cli();
        $cli->run("ids dellocal $id");
        echo json_encode(array('msg' => "删除成功."));
    } else if ($action = $_POST['action']) {
        // Switch specified alias device
        $rule_id = $_POST['switch_id'];
        $cli = new cli();
        if ($action === 'disable') {
            $cmd = "ids blocklocal $rule_id";
            $cli->run($cmd);
            echo json_encode(array('msg' => "任务已关闭."));
        } else if ($action === 'enable') {
            $cmd = "ids activatelocal $rule_id";
            $cli->run($cmd);
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
