<?php
    function login() {
        // add class for recording log
        $cIp      = get_client_ip();
        $admLog   = new admLog();

    	if (@$_GET['chkusr'] != 'ok'){
            if ('/index.php' === $_SERVER['SCRIPT_NAME']) {
                V::getInstance()->display('login/login.tpl');
                exit();
            } else {
                exit('timeOut');
            }
    	}
        $account = @$_POST['account'];
        $passwd  = @$_POST['passwd'];
        // check limit the number of login error
        if (DEBUG || @$_SESSION[$account] >= LIMITERR_NUM &&
            !chkLimitErrTime($account)) {
            $_SESSION['limitErrTime'] = time();
            //$errMsg = '错误登录次数超过' . LIMITERR_NUM . '次<br/>请等待' .
            //    LIMITERR_TIME . '秒';
			$errMsg = "输错密码超过规定次数,账号".$account."已被封锁!";
            $msg = "用户[$account]" . str_replace('<br/>', ', ', $errMsg) .
                "地址来自[$cIp].";
            $set = array(
                'time' => time(), 'account' => $account, 'pri' => 3,
                'act' => 'login', 'msg'     => $msg
            );
            $admLog->add($set);
            exit($errMsg);
        }
        //管理主机ip检测
        $db = new dbsqlite(DB_PATH . '/configs.db');
        /*
        if (checkAdminIpv4s() === false) {
            $msg = '管理主机限制登录.';
            $set = array(
                'time' => time(), 'account' => $account, 'pri' => 4,
                'act' => 'login', 'msg'     => $msg . " 用户[$account], 地址" .
                                               "来自[$cIp]."
            );
            $admLog->add($set);
            DEBUG || exit($msg);
        }
        */
        // check allow to serveral admins to login or not
        $sql = "SELECT allow FROM allow_multiple";
        $result = $db->query($sql)->getFirstData();
        $isMultiAdm = $result['allow'] === '1' ? true : false;
        if ($isMultiAdm === false && false !== isUserOnline($account)) {
            $msg = '禁止多管理员同时登录.';
            $set = array(
                'time' => time(), 'account' => $account, 'pri' => 3,
                'act' => 'login', 'msg'     => $msg . " 用户[$account], 地址" .
                                               "来自[$cIp]."
            );
            $admLog->add($set);
            exit($msg);
        }
        //check user/passwd
        $sql = "select * from accounts
            where account = '$account' and passwd='$passwd'";
        $result = $db->query($sql)->getFirstData();
        if ($result === false) {
            $_SESSION[$account]++;
            $msg = '用户名或密码错误!';
            $set = array(
                'time' => time(), 'account' => $account, 'pri' => 3,
                'act' => 'login', 'msg'     => $msg. " 用户[$account], 地址" .
                                               "来自[$cIp]."
            );
            $admLog->add($set);
            exit($msg);
        } else {
            // login successful
            session_regenerate_id();
            saveUserInfo($result);
        }
    }

    function logout() {
        $logoutUser = $_SESSION['account'];
        $cIp        = get_client_ip();
        $roleName   = getRoleName($_SESSION['roles']);
        delOnlineUser($logoutUser);
        @unlink(WEB_PATH . '/Logs/ethInfo/' . $_SESSION['ethFile']);
    	@$_SESSION = array();
		@session_destroy();
        setcookie('web_locale', '', 1, '/');
        V::getInstance()->clearAllAssign();
        V::getInstance()->clearAllCache();
        $set = array(
            'time' => time(),  'account' => $logoutUser, 'pri' => 5,
            'act' => 'logout', 'msg'     => $roleName . "管理员[$logoutUser]" .
                                            "退出成功, 地址来自[$cIp]."
        );
        $admLog = new admLog($set);
    }
    /**
	 * 检测用户与是否操作超时
	 * time 超时时间,单位:秒
	 * @param $timeout
	 */
	function chklogin($timeout) {
		$now = time();
        //检测是否通过登录过来，排除直接输入地此进入
		if (!isset($_SESSION['account'])) {
            login();
		}
		if (isset($_SESSION['session_time'])) {//超时管理
			if (($now-$_SESSION['session_time']) > $timeout) {
                $set = array(
                    'time' => time(), 'account' => $_SESSION['account'],
                    'pri'  => 5,      'act'     => 'logout',
                    'msg'  => "管理员[{$_SESSION['account']}]访问超时."
                );
                $admLog = new admLog($set);
			    logout();
                exit('timeOut'); 
			} else {
			    //还没超时. 
			    $_SESSION['session_time']=time(); 
			} 
		}
	}

    function chkLimitErrTime($account) {
        $limitErrTime = @$_SESSION['limitErrTime'];
        if (!empty($limitErrTime) && (time() - $limitErrTime > LIMITERR_TIME)) {
            $_SESSION[$account] = NULL;
            $_SESSION['limitErrTime'] = NULL;
            return true;
        } else {
            return false;       
        }
    }

    function addOnlineUsers($account) {
        $filePath  = WEB_PATH . '/Logs/onlineUsers';
        $client_ip = get_client_ip();
        $contents  = file_get_contents($filePath);
        $newUser   = "$account/$client_ip";
        if (strpos($contents, $newUser) === false) {
            $contents .= "$newUser\n";
            file_put_contents($filePath, $contents);
        }
    }
    function delOnlineUser($account) {
        $filePath  = WEB_PATH . '/Logs/onlineUsers';
        $client_ip = get_client_ip();
        $contents  = file_get_contents($filePath);
        $newUser   = "$account/$client_ip";
        file_put_contents($filePath, str_replace("$newUser\n", '', $contents));
    }

    function isUserOnline($account) {
        $filePath  = WEB_PATH . '/Logs/onlineUsers';
        $contents  = file_get_contents($filePath);
        return strpos($contents, "$account/");
    }

    function saveUserInfo($userData) {
        $account = $userData['account'];
        addOnlineUsers($account);
        $roles = array();
        if ($userData['super'] === '1') {
            $roles[] = 'super';
        }
        if ($userData['manager'] === '1') {
            $roles[] = 'manager';
        }
        if ($userData['policyer'] === '1') {
            $roles[] = 'policyer';
        }
        if ($userData['auditor'] === '1') {
            $roles[] = 'auditor';
        }

        $cIp      = get_client_ip();
        $roleName = getRoleName($roles);
        $set = array(
            'time' => time(), 'account' => $account, 'pri' => 5,
            'act' => 'login', 'msg'     => $roleName . "管理员[$account]" .
                                           "登录成功, 地址来自[$cIp]."
        );
        $admLog = new admLog($set);

        @$_SESSION['roles']        = $roles;
        @$_SESSION['account']      = $account;
        @$_SESSION['session_time'] = time();
        @$_SESSION['history']=array();
        @$_SESSION['pos']=0;
        @$_SESSION['action']='new';
        @$_SESSION['ethFile']=time();
        exit('sucess');
    }
    
    function checkAdminIpv4s() {
        $db      = new dbsqlite(DB_PATH . '/configs.db');
        $cIp     = get_client_ip();
        if (strtolower($cIp) === 'localhost' || $cIp === '127.0.0.1') {
            return true;
        }
        if ($db->query('SELECT ip FROM adminips')->getCount() === 0) {
            return true;
        }
        $cIpFrag = explode('.', trim($cIp));
        $sql     =
            "SELECT ip FROM adminips WHERE ip = '$cIp' OR ip = '0.0.0.0'";
        $result  = $db->query($sql)->getCount();
        if ($result > 0) {
            return true;
        } else {
            $sql    = 'SELECT ip, netmask FROM adminips';
            $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
            foreach ($result as $value) {
                $ip          = $value['ip'];
                $mask        = convertToIpv4Mask($value['netmask']);
                $ipFrag      = explode('.', trim($ip));
                $maskFrag    = explode('.', trim($mask));
                $domainFrag  = array();
                $cDomainFrag = array();
                for ($i = 0; $i < 4; $i++) {
                    $domainFrag[]  =
                        intval($ipFrag[$i]) & intval($maskFrag[$i]);
                    $cDomainFrag[] =
                        intval($cIpFrag[$i]) & intval($maskFrag[$i]);
                }
                if (join('.', $domainFrag) === join('.', $cDomainFrag)) {
                    return true;
                }
            }
            return false;
        }
    }
?>
