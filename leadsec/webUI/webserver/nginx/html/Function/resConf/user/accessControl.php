<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshRuleList($where) {
        $tpl = 'resConf/user/accessControlListTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT * FROM connect_rule";
		$params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql,$params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('ruleList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getCmdStr($action) {
        $name     = $_POST['ruleName'];
		$version  = '';
		$proc_name = '';
		if ($_POST['checkVer']==='1' and $_POST['checkProc']==='1') {
			$versionName =  $_POST['verList'];
			$proc        =  $_POST['procList'];
			//$version     = '"' . join('", "', $versionName) . '"';
			$version     = join(',', $versionName);
			$proc_name   = join(',', $proc);
			$cmd = "connect-rule $action rulename \"$name\" client-check version-check $version proc-check $proc_name ";
		} else if ($_POST['checkVer']==='1' and $_POST['checkProc']==='0') {
			$versionName =  $_POST['verList'];
			$version     = join(',', $versionName);
			$cmd = "connect-rule $action rulename \"$name\" client-check version-check $version ";
		} else if ($_POST['checkVer']==='0' and $_POST['checkProc']==='1') {
			$proc        =  $_POST['procList'];
			$proc_name   = join(',', $proc);
			$cmd = "connect-rule $action rulename \"$name\" client-check proc-check $proc_name ";
		} else {
			$cmd = "connect-rule $action rulename \"$name\" ";
		}
        return $cmd;
    }

    function getSpecRuleDataByName($name) {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT * FROM connect_rule where rule_name = '$name'";
        return $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
    }


    function getWhereStatement($db, $cols, $keyword) {
        $value  = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' WHERE (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }

    function getDataCount() {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT count(rule_name) as sum FROM connect_rule";
		$params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $result = $db->query($sql,$params)->getFirstData(PDO::FETCH_ASSOC);
        return $result['sum'];
    }

    if (!empty($_POST['addNewRule'])) {
        // Open add new role dialog 
        $result = V::getInstance()
            ->fetch('resConf/user/editRuleListDialog.tpl');
        echo json_encode(array('msg' => $result));
    } else if ($name = $_POST['editRuleName']) {
        // Open edit spec role dialog
        $ruleData =  getSpecRuleDataByName($name);
		if (!empty($ruleData['c_version'])) {
			$ruleData['names'] = explode(',',$ruleData['c_version']);
		}
		if (!empty($ruleData['c_proc_list'])) {
			$ruleData['procs'] = explode(',',$ruleData['c_proc_list']);
		}
		if (!empty($ruleData['c_proc_list'])) {
			$checkProc = '1';
		} else {
			$checkProc = '0';
		}
        $result = V::getInstance()->assign('ruleData', $ruleData)
            ->assign('type', 'edit')
			->assign('checkProc',$checkProc)
            ->fetch('resConf/user/editRuleListDialog.tpl');
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit spec role
        $cli = new cli();
		$msg_log = "资源控制下用户模块中对规则".$_POST['ruleName']."进行了修改";
        $cli->setLog($msg_log)->run(getCmdStr('set'));
        echo json_encode(array('msg' => '修改成功。'));
    } else if ('add' === $_POST['type']) {
        // Add new role
        $cli = new cli();
		$msg_log = "资源控制下用户模块中增加了对规则".$_POST['ruleName']."的接入控制";
        $cli->setLog($msg_log)->run(getCmdStr('add'));
        echo json_encode(array('msg' => '添加成功。'));
    } else if ($name = $_POST['delRuleName']) {
        // Delete specified role
        $cli = new cli();
		$msg_log = "资源控制下用户模块中删除了对规则".$name."的接入控制";
        $cli->setLog($msg_log)->run("connect-rule del rulename \"$name\"");
        echo json_encode(array('msg' => '删除成功。'));
    } else if (!empty($_POST['delAllRules'])) {
        // Delete All roles
        $cli = new cli();
		$msg_log = "资源控制下用户模块中下的接入控制清除所有的规则";
        $cli->setLog($msg_log)->run('connect-rule del all');
        echo json_encode(array('msg' => '已清空接入控制列表。'));
    } else if ($roles = $_POST['delSpecRules']) {
        // Batch Delete spec roles
        $cli = new cli(); 
        foreach ($roles as $role) {
            $cli->setLog("资源控制下用户模块中删除了对规则".$role."的接入控制")
				->run("connect-rule del rulename \"$role\"");
        }
        echo json_encode(array('msg' => '批量删除成功.'));
    } else if ($id = $_POST['showUsersByRoleId']) {
        // show dialog of users data for spec role
        $count  = getUserCountByRoleId($id);
        $result = V::getInstance()->assign('roleId', $id)
            ->assign('dataCount', $count)
            ->assign('pageCount', ceil($count/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2)
            ->fetch('resConf/user/editUserListByRoleIdDialog.tpl');
        echo json_encode(array('msg' => $result));
    } else if ($_GET['checkExistRuleName']) {
         $rules = $_GET['ruleName'];
         $sql = "SELECT * FROM connect_rule where rule_name = '$rules'";
         $db = new dbsqlite(DB_PATH . '/uma_auth.db');
         echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if ($order = $_POST['orderStatement']) { 
            freshRuleList($order);
    } else {
        // init page
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    } 
?>
