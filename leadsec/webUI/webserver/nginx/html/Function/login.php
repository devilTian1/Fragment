<?php
    // login page
    function login() {
    	if (@$_GET['chkusr']!='ok'){
    		V::getInstance()->display('login/login.tpl');
    		exit();
    	}
        $account = @$_POST['account'];
        $passwd  = @$_POST['passwd'];
        if (DEBUG || @$_SESSION[$account] >= LIMITERR_NUM && !chkLimitErrTime($account)) {
            $_SESSION['limitErrTime'] = time();
            exit('错误登录次数超过' . LIMITERR_NUM . '次<br/>请等待' . LIMITERR_TIME . '秒');
        }
        //管理主机ip检测
        $db        = new dbsqlite(DB_PATH . '/configs.db');
        $client_ip = get_client_ip();
        $sql_ip    = "select ip from adminips where ip='$client_ip'";
        $resultall = $db->query($sql_ip)->getFirstData();
        if ($resultall === false) {
            DEBUG || exit('管理主机限制登录');
        }
        $sql = "select * from accounts
            where account = '$account' and passwd='$passwd'";
        $result = $db->query($sql)->getFirstData();
        if ($result === false) {
            $_SESSION[$account]++;
            exit('用户名与密码错误!');
        } else {
            // login successful
            @$_SESSION['account']  = $result['account'];
            @$_SESSION['super']    = $result['super'];
            @$_SESSION['manager']  = $result['manager'];
            @$_SESSION['policyer'] = $result['policyer'];
            @$_SESSION['auditor']  = $result['auditor'];
            @$_SESSION['session_time']=time();
          	exit('sucess');
        }
    }
    //logout
    function logout() {
    	@$_SESSION=NULL;
    	@session_unset();
		@session_destroy();
        V::getInstance()->clearAllAssign();
        V::getInstance()->clearAllCache();
    }
    /**
	 * 检测用户与是否操作超时
	 * time 超时时间,单位:秒
	 * @param $timeout
	 */
	function chklogin($timeout) {
		$now = time();
		if (!isset($_SESSION['account'])) {//检测是否通过登录过来，排除直接输入地此进入
            login();
		}
		if (isset($_SESSION['session_time'])) {//超时管理
			if (($now-$_SESSION['session_time']) > $timeout) {
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
?>
