<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function setConf($name, $val) {
        $file = $_SERVER['DOCUMENT_ROOT'] . '/Conf/global.php';
        $contents = file_get_contents($file);
        $contents = preg_replace("@\('$name',\s?(.*)\)@",
            "('$name',$val)", $contents);
        file_put_contents($file, $contents);
    }

    function delSpecifiedUser($username) {
        if (isUserOnline($username) !== false) {
            return '被删除用户在线, 请先通知其下线.';
        }
        $cmd = "admacct del name \"$username\"";
        $cli = new cli();
        $cli->run($cmd);
        return '删除成功.';
    }

    function getUserData() {
        return array(
            $_POST['account'],
            $_POST['passwd'],
            $_POST['confAdmin'] === 'on' ? 'on' : 'off',
            $_POST['policyAdmin'] === 'on' ? 'on' : 'off',
            $_POST['logAdmin'] === 'on' ? 'on' : 'off'
        );
    }

	//当前用户
	function getCurrentUser() {
		$current_user = $_SESSION['account'];
		return $current_user;
	}

	//当前用户的角色信息
	function getCurrentUserRole($current_user) {
		$db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query("SELECT * FROM accounts WHERE account = '$current_user'")
            ->getAllData(PDO::FETCH_ASSOC);
		return $result;
	}

	//管理员列表中每个管理员在线的状态
	function getAccountsIsOnline($account) {
		//isUserOnline()函数判断管理员的在线状态情况
		foreach ($account as $k => $v) {
			if (isUserOnline($v['account']) !== false) {
				$account[$k]['isOnline'] = 'yes';
			} else {
				$account[$k]['isOnline'] = 'no';
			}
		}
		return $account;
	} 
	//得到当前登录用户的名称
	$user = getCurrentUser();
	//得到当前登录用户的角色信息
	$user_role = getCurrentUserRole($user);
    if (!empty($_POST['expTime'])) {
        // modify expired time
        setConf('EXPIRED_TIME', $_POST['expTime']);
        echo json_encode(array('msg' => '修改成功'));
    } else if (!empty($_POST['limitErrNum']) || !empty($_POST['limitErrTime'])){
        // modify limit error login num and time
        setConf('LIMITERR_NUM',  $_POST['limitErrNum']);
        setConf('LIMITERR_TIME', $_POST['limitErrTime']);
        echo json_encode(array('msg' => '修改成功'));
    } else if (!empty($_POST['editUser'])) {
        // get specified account data
        $tpl  = $_POST['tpl'];
        $name = $_POST['editUser'];
		$name_role = getCurrentUserRole($name);
		$role_type = $name_role[0]['super'];
		if ($user_role[0]['super'] === '1') {
			$isEditRole = true;
		} else {
			$isEditRole = false;
		}
		//查看(非超级管理员)在线的用户
		if (isUserOnline($name) !== false && $name_role[0]['super'] !== '1' && $name !== $user ) {
			echo json_encode(array('msg' => '该用户处于在线状态,不能进行编辑!'));
		} else {
			$db = new dbsqlite(DB_PATH . '/configs.db');
			$result = $db->query("SELECT * FROM accounts WHERE account = '$name'")
						 ->getFirstData(PDO::FETCH_ASSOC);
			$result = V::getInstance()->assign('account',  $result['account'])
				->assign('passwd',   $result['passwd'])
				->assign('isEditRole', $isEditRole)
				->assign('isConf',  $result['manager'] === '1' ? 'checked="checked"' : '')
				->assign('isPolicyer', $result['policyer'] === '1' ? 'checked="checked"' : '')
				->assign('isLoger',  $result['auditor'] === '1' ? 'checked="checked"' : '')
				->assign('role_type', $role_type)
				->assign('type', 'edit')->fetch($tpl);
			echo json_encode(array('msg' => $result));
		}
    } else if ($_POST['type'] === 'add') {
        // add a new account
        list($account, $passwd, $isManager, $isPolicyer, $isAuditor) =
            getUserData();
        $cmd = "admacct add name \"$account\" password \"$passwd\"".
            " manager $isManager policyer $isPolicyer auditor $isAuditor";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '添加成功'));
    } else if ($_POST['type'] === 'edit')  {
        // edit account
        list($account, $passwd, $isManager, $isPolicyer, $isAuditor) =
            getUserData();
        $cmd = "admacct set name \"$account\" password \"$passwd\"".
            " manager $isManager policyer $isPolicyer auditor $isAuditor";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功'));
    } else if (!empty($_POST['delUser'])) {
        // delete specified account
        $msg = delSpecifiedUser($_POST['delUser']);
        echo json_encode(array('msg' => $msg));
    } else if (!empty($_POST['multiAdm'])) { 
        $s = $_POST['multiAdm'];
        $cmd = "admacct set multiadm $s";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功'));
    } else if (!empty($_POST['freshAccountList'])) {
        $tpl = 'systemManagement/admin/accountTable.tpl';
		//如果用户是超级管理员显示所有的列表信息
		if ($user_role[0]['super'] === '1') {
			$db  = new dbsqlite(DB_PATH . '/configs.db');
			$result = $db->query('SELECT * FROM accounts')
				->getAllData(PDO::FETCH_ASSOC);
			$result = getAccountsIsOnline($result);
			echo V::getInstance()->assign('accounts', $result)->fetch($tpl);
		} else {
		//反之则显示当前自己的信息
			echo V::getInstance()->assign('accounts',$user_role)->fetch($tpl);
		}
    } else {
        // init page data
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $multiAdm = $db->query('SELECT allow FROM allow_multiple')
            ->getFirstData(PDO::FETCH_ASSOC);
        $isMultiAdm = $multiAdm['allow'] === '0' ? '' : 'checked="checked"';
        V::getInstance()->assign('isMultiAdm', $isMultiAdm);
    }
?>
