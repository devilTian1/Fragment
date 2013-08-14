<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getConnectRule() {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT rule_name FROM connect_rule";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array('' => '无');
        foreach ($data as $d) {
            $index = $d['rule_name'];
            $result[$index] = $d['rule_name'];
        }
        return $result;
    }

    function getAllRoles() {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT role_name FROM role";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $d) {
            $result[] = $d['role_name'];
        }
        return $result;
    }

    function getSpecRolesByUserName($name) {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = 'SELECT role_name FROM user, user_role_map, role WHERE'.
            ' user.user_id = user_role_map.User_id AND '.
            "user_role_map.Role_id = role.role_id AND user.user_name = '$name'";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $d) {
            $result[] = $d['role_name'];
        }
        return $result;
    }

    function getUserDataByName($name) {
        $db     = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql    = "SELECT * FROM user WHERE user_name = '$name'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return $result;       
    }

    function getWhereStatement($db, $cols, $keyword) {
        $value  = $keyword ;
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' WHERE (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $db->getFilterParams($params));
    }

    function getDataCount() {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT count(user_id) as sum FROM user";
        $params = array();
		$keyword='/'.$_GET['keyword'];
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $keyword);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $result = $db->query($sql, $params)->getFirstData(PDO::FETCH_ASSOC);
        return $result['sum'];
    }

    function freshUserList($where) {
        $tpl  = 'resConf/user/userListTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT user_id, user_name,auth_type, true_name, active, validtime, dyn_sn FROM user";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('userList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getLockTimeByName($name) {
        $db     = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql    = "SELECT lock_time FROM user WHERE user_name = '$name'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return $result['lock_time'];       
    }

    function getAddOrEditCmd($action) {
        $ip     = $_POST['bindIp'];
        $mac    = $_POST['bindMac'];
        $active = $_POST['active'] === 'on' ? 'on' : 'off';
        $authType = $_POST['authType'];
        $firstChangePwd = $_POST['firstChangePwd'];
        $modifyPwdAllow = $_POST['modifyPwdAllow'];
        $pwd      = $_POST['passwd_user'];
        $realName = $_POST['realName'];
        $name     = $_POST['userListName'];
        $ap       = $_POST['validTime'];
        $pap      = $_POST['validTime_pwd'];
        $cRule     = $_POST['connectRule'];
        $comment  = $_POST['comment'];

        $result = "user $action username \"$name\" ".
            "auth-type $authType";
        if ($authType === 'local-pwd' || $authType === 'dyn-pwd') {
        	   if ('add' === $action || 'on' === $_POST['modifyEnable'] || 1===$_POST['vip']) {
                $result .= " pwd '$pwd'";
            }
            if ($authType === 'dyn-pwd' && !empty($_FILES['sn']['name'])) {
                $uploadfs = new fileUpload($_FILES);
                $uploadfs->upload();
                $result .= " sn {$_FILES['sn']['name']}";
            }
        }
        if (!empty($_POST['rolesMember'])) {
            $roles   = join(',', $_POST['rolesMember']);
            $result .= " role \"$roles\"";
        }
        if ($realName !== '') {
            $result .= " true-name \"$realName\"";
        }
        if ($ip !== '') {
            $result .= " bind-ip4 \"$ip\"";
        }
        if ($mac !== '') {
            $result .= " bind-mac \"$mac\"";
        }
        if ($active !== '') {
            $result .= " active $active";
        }
        if (!empty($modifyPwdAllow)) {
            $result .= " modify-pwd-allow $modifyPwdAllow";
        }
        if (!empty($firstChangePwd)) {
            $result .= " first-change-pwd $firstChangePwd";
        }
        if (!empty($ap)) {
            $result .= " available-period $ap";
        }
        if (!empty($pap)) {
            $result .= " pwd-available-period $pap";
        }
        if (!empty($cRule)) {
            $result .= " connect-rule $cRule";
        }
        if ($comment !== '')
            $result .= " comment '$comment'";
        return $result;
    }
    
    function isInUseCheck($name) {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT user_id FROM user where user_name='$name'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $sql = "SELECT user_id FROM user_online where user_id='{$result['user_id']}'";        
        $num = $db->query($sql)->getCount();
        if(intval($num) > 0) {
            return true;
        } else {
            return false;
        }
    }
    
    function freshParamsConfData() {
    	$db  = new dbsqlite(DB_PATH . '/auth_server.db');
    	$sql = 'SELECT * FROM auth_config_info';
    	$result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
    	return $result;
    }
    
    if ($_POST['addNewUser'] === 'true') {
        // Open add new user dialog
        $tpl = 'resConf/user/editUserListDialog.tpl';
        $presult = freshParamsConfData();
        $result = V::getInstance()->assign('allRolesArr', getAllRoles())
            ->assign('paramsConf', $presult)
            ->assign('mpa_on',    'checked="checked"')
            ->assign('fcp_off',   'checked="checked"')
            ->assign('active_on', 'checked="checked"')
            ->assign('connectRuleArr', getConnectRule())
            ->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('add' === $_POST['type']) {
        // Open new user dialog
        if (getDataCount() >= RESCONF_LIMIT) {
            $msg = '资源数达到上限[' . RESCONF_LIMIT . ']。';
        	echo json_encode(array('msg' => $msg));
        	return;
        }
        $cmd = getAddOrEditCmd('add');
        $cli = new cli();
		list($status,$result) = $cli->setLog("添加用户".$_POST['userListName'])
				->execCmdGetStatus($cmd);
		if ($status == 103) {
			echo json_encode(array('msg' => '添加失败！登陆密码不符合密码复杂度要求。'));
	         } else if ($status == 150) {
			echo json_encode(array('msg' => '添加失败！SN文件已被使用。'));
		} else if ($status == 107) {
			echo json_encode(array('msg' => '添加失败！MAC地址错误。'));
		} else {
			if($_POST['authType'] === 'dyn-pwd') {
				echo json_encode(array('status'=>$status,'msg' => '添加成功，请导入SN文件和同步密码。'));
			} else {
				echo json_encode(array('status'=>$status,'msg' => '添加成功。'));
			}
		}
        //$cli->setLog("添加用户".$_POST['userListName'])->run($cmd);
        //echo json_encode(array('msg' => '添加成功。'));
    } else if ($names = $_POST['delSpecUsers']) {
        // Delete Specified Users Data
        $cli = new cli();
        foreach ($names as $name) {
            $cli->setLog("删除用户{$name}")->run("user del username \"$name\"");
        }
        echo json_encode(array('msg' => '删除成功。'));
    } else if (!empty($_POST['delAllUsers'])) {
        // Delete All User Data
        $cli = new cli();
        $cli->setLog("删除全部用户")->run('user del all');
        echo json_encode(array('msg' => '删除成功。'));
    } else if ($name = $_POST['delName']) {
        // Delete specified user data
        $cli = new cli();
        $cli->setLog("删除用户{$name}")->run("user del username \"$name\"");
        echo json_encode(array('msg' => '删除成功。'));
    } else if (!empty($_FILES['importFile']) && ($name = $_POST['snName'])) {
        // Import sn file for specified user
        $uploadfs = new fileUpload($_FILES);
        $uploadfs->upload();
        $cmd = 'user set username "' . $name . '" import-sn ' . $_FILES['importFile']['name'];
        $cli = new cli();
        $cli->setLog("用户{$name}导入sn文件".$_FILES['importFile']['name'])->run($cmd);
         echo json_encode(array('msg' => '导入成功。'));
    } else if (false) {
        //
    } else if ($specUser = $_POST['editUser']) {
        // Open user dialog of specified user
        $userList = getUserDataByName($specUser);
        $mpa = $userList['modify_pwd_allow'] === '1' ? 'mpa_on' : 'mpa_off';
        $fcp = $userList['first_change_pwd'] === '1' ? 'fcp_on' : 'fcp_off';
        $active = $userList['active'] === '1' ? 'active_on' : 'active_off';
        switch ($userList['auth_type']) {
            case '0':
                $at = 'vip';
                break;
            case '1':
                $at = 'localPwd';
                break;
            case '2':
                $at = 'localCert';
                break;
            case '4':
                $at = 'twofa';
                break;
            case '5':
                $at = 'twofa';
                break;
            default: 
                throw New Exception('error: Auth Type.'. $userList['auth_type']);
        }
        $rolesMemberArr = getSpecRolesByUserName($specUser);
        $presult = freshParamsConfData();
        $result = V::getInstance()
            ->assign('userList', $userList)
            ->assign('allRolesArr', array_diff(getAllRoles(), $rolesMemberArr))
            ->assign('rolesMemberArr', $rolesMemberArr)
            ->assign('paramsConf', $presult)
            ->assign($mpa, 'checked="checked"')
            ->assign($fcp, 'checked="checked"')
            ->assign($active, 'checked="checked"')
            ->assign($at, 'checked="checked"')
            ->assign('connectRuleArr', getConnectRule())
            ->assign('type', 'edit')
            ->fetch('resConf/user/editUserListDialog.tpl');
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified user data
        $cmd = getAddOrEditCmd('set');
        $cli = new cli();
        list($status,$result) = $cli->setLog("修改用户".$_POST['userListName'])
				->execCmdGetStatus($cmd);
		if ($status == 103) {
			echo json_encode(array('msg' => '修改失败！登陆密码不符合密码复杂度要求。'));
		} else if ($status == 150) {
			echo json_encode(array('msg' => '修改失败！SN文件已被使用。'));
		} else if ($status == 107) {
			echo json_encode(array('msg' => '修改失败！MAC地址错误。'));
		} else {
		    echo json_encode(array('msg' => '修改成功。'));
		}
        //$cli->setLog("修改用户".$_POST['userListName'])->run($cmd);        
    } else if (isset($_POST['lockTime'])) {
        // Set lock time for specified user
        $time = $_POST['lockTime'];
        $name = $_POST['name'];
        $cli  = new cli();
        $cli->setLog("锁定用户{$name}，锁定时间{$time}s")->run("user lock username \"$name\" time $time");
        echo json_encode(array('msg' => '修改成功。'));
    } else if ($name = $_POST['lockUser']) {
        // Get Lock Data of specified user
        $time = getLockTimeByName($name);
        $tpl  = 'resConf/user/editLockUserDialog.tpl';
        $result = V::getInstance()
            ->assign('name', $name)
            ->assign('lockTime', $time)
            ->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (($name = $_POST['resetPwdName']) && ($pwd = $_POST['passwd_user'])) {
        // Set lock time for specified user
        $cli  = new cli();
        $cli->setLog("用户{$name}重置密码为{$pwd}")->run("user reset username \"$name\" password '$pwd'");
        echo json_encode(array('msg' => '修改成功。'));
    } else if ($name = $_POST['resetPwdUser']) {
        // Get specified user`s pwd data
        $tpl  = 'resConf/user/editResetPwdDialog.tpl';
        $result = V::getInstance()
            ->assign('name', $name)
            ->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (($name = $_POST['activeName']) && ($pwd = $_POST['activePwd'])) {
    // set import sn file of specified user
    	$cmd = 'user set username "' . $name . '" syndynpass ' . $pwd . ' dyntime 0 dynclock 0';
        $cli  = new cli();
        list($status,$result) = $cli->setLog("用户{$name}同步动态密码为{$pwd}")->execCmdGetStatus($cmd);
	if($status !== 0) {
	    echo json_encode(array('msg' => '同步失败，动态密码错误。'));
	} else {
            echo json_encode(array('msg' => '同步成功。'));
        }
    } else if ($name = $_POST['showImportSnFileName']) {
        // Show import sn file dialog
        $tpl  = 'resConf/user/editImportSnFileDialog.tpl';
        $result = V::getInstance()
            ->assign('name', $name)
            ->fetch($tpl);
        echo json_encode(array('msg' => $result));
    //} else if ($name = $_POST['snName'] && !empty($_FILES['sn']['name'])) {
        // set import sn file of specified user
    } else if (($active = $_POST['activeChk']) && ($name = $_POST['userName'])) {
        $retStr = $name;
        $retStr .= ($active === 'ok') ? '已启用。' : '已禁用。' ;
        $active = ($active === 'ok') ? 'on' : 'off' ;
        $logMsg = ($active === 'ok') ? '启用。' : '禁用。' ;
        $cmd = "user set username $name active $active";
        $cli  = new cli();
        $cli->setLog($logMsg."用户{$name}")->run($cmd);        
        echo json_encode(array('msg' => $retStr));
    } else if ($name = $_POST['showActiveUserName']) {
        // Show active specified name dialog
        $tpl  = 'resConf/user/editActiveUserDialog.tpl';
        $result = V::getInstance()
            ->assign('name', $name)
            ->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($_GET['isInUseCheck']) {
    // check whether the spec user is online
        $name = $_GET['checkName'];
        if(isInUseCheck($name)) {
            echo "true";
        } else {
            echo "false";
        }
    } else if ($_GET['checkAll']) {
        // check ether users is online
        $sql = "SELECT user_id FROM user_online";
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $num = $db->query($sql)->getCount();
        if(intval($num) > 0) {
            $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            $sql = "SELECT user_name FROM user WHERE user_id={$result['user_id']}";
            $result1 = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            echo $result1['user_name'];
        } else {
            echo "false";
        }
    } else if ($_GET['checkSpecUsers']) {
    // check delete users is online
        $users = $_GET['usersArray'];
        foreach($users as $name) {
            if(isInUseCheck($name)) {
                echo $name;
                return;
            }
        } 
        echo "false";
    } else if ($_GET['checkExistUserName']) {
        $name = $_GET['userListName'];
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT user_id FROM user where user_name='$name'";
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if ($order = $_POST['orderStatement']) { 
        // Fresh and resort user list Table
        freshUserList($order);
    } else {
        // Init page data
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
