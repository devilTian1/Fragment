<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshRuleList($where) {
        $tpl = 'resConf/user/accessControlListTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT * FROM connect_rule $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('ruleList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function freshUserList($where) {
        $tpl = 'resConf/user/editUserListByRoleIdTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = 'SELECT user.user_id AS userId, user.user_name AS name, ' .
            'user.true_name AS realname, user.auth_type AS authType ' .
            'FROM user, user_role_map, role ' .
            'WHERE user.user_id = user_role_map.User_id AND ' .
            'user_role_map.Role_id = role.role_id AND role.role_id = ' .
            $_GET['roleId'] . " $where";
        $data = array();
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);

        $authType = array('VIP', 'local pwd',     'local cert',
                          '',    '2-fa/ cert+pw', '2-fa / dyn + pw');

        $result   = array();
        foreach ($data as $d) {
            $userId = $d['userId'];
            $sql = 'SELECT ip FROM user_online WHERE user_id=' . $userId;
            $res_online = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            if (empty($res_online['ip'])) {
            	$isOnline = 0;
            	$onlineIp = "";
            } else {
            	$isOnline = 1;
            	$onlineIp = $res_online['ip'];
            }
            $roles = getRolesByUserId($userId);
            $result[] = array('user_id'   => $userId,
                              'user_name' => $d['name'],
                              'true_name' => $d['realname'],
                              'auth_type' => $authType[$d['authType']],
                              'roles'     => join('<br/>', $roles),
                              'isOnline' => $isOnline,
                              'onlineIp' => $onlineIp
            );
        }
        echo V::getInstance()->assign('userData', $result)
            ->assign('roleId', $_GET['id'])
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getCmdStr($action) {
        $name     = $_POST['roleName'];
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

    function getRolesByUserId($userId) {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = 'SELECT role.role_name AS name FROM user_role_map, role ' .
            'WHERE user_role_map.Role_id = role.role_id AND ' .
            'user_role_map.User_id = ' . $userId;
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $d) {
            $result[] = $d['name'];
        }
        return $result;
    }

    function getSpecRuleDataByName($name) {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT * FROM connect_rule where rule_name = '$name'";
        return $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
    }

    function getUserCountByRoleId($id) {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = 'SELECT count(User_id) AS sum FROM user_role_map ' .
            "WHERE Role_id = $id";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return $result['sum'];
    }

    function getDataCount() {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT count(rule_name) as sum FROM connect_rule";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
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
        //$ruleData['userCount'] = getUserCountByRoleId($id);
        //$ruleData['type'] =
        //    $ruleData['type'] === 1 ? 'checked="checked"' : '';
        $result = V::getInstance()->assign('ruleData', $ruleData)
            ->assign('type', 'edit')
            ->fetch('resConf/user/editRuleListDialog.tpl');
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit spec role
        $cli = new cli();
		$msg_log = "资源控制下用户模块中对规则".$_POST['roleName']."进行了修改";
        $cli->setLog($msg_log)->run(getCmdStr('set'));
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add new role
        $cli = new cli();
		$msg_log = "资源控制下用户模块中增加了对规则".$_POST['roleName']."的接入控制";
        $cli->setLog($msg_log)->run(getCmdStr('add'));
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($name = $_POST['delRuleName']) {
        // Delete specified role
        $cli = new cli();
		$msg_log = "资源控制下用户模块中删除了对规则".$name."的接入控制";
        $cli->setLog($msg_log)->run("connect-rule del rulename \"$name\"");
        echo json_encode(array('msg' => '删除成功.'));
    } else if (!empty($_POST['delAllRules'])) {
        // Delete All roles
        $cli = new cli();
		$msg_log = "资源控制下用户模块中下的接入控制清除所有的规则";
        $cli->setLog($msg_log)->run('connect-rule del all');
        echo json_encode(array('msg' => '已清空角色列表.'));
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
    } else if ($order = $_POST['orderStatement']) { 
        //if (!empty($_GET['roleId'])) {
            // Fresh and resort user list Table for spec role
         //   freshUserList($order);
        //} else {
            // Fresh and resort role list Table
            freshRuleList($order);
        //}
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
