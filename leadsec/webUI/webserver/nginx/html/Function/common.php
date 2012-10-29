<?php
    // Load Config File
    require_once(dirname(__FILE__) . '/../Conf/global.php');

    // debug
    DEBUG && error_reporting(E_ALL);

    // Include common driver
    // Exception driver
    require_once(WEB_PATH . '/Lib/driver/exception.php');
    // Template engine, smarty
    require_once(WEB_PATH . '/Lib/driver/smarty.php');
    // Menu
    require_once(WEB_PATH . '/Lib/driver/leftmenu.php');
    // DB driver
    require_once(WEB_PATH . '/Lib/driver/dbsqlite.php');
    // CLI driver
    require_once(WEB_PATH . '/Lib/driver/cli.php');
	// function
    require_once(WEB_PATH . '/Lib/driver/function.php');
    //用户操作操时处理
	//chklogin(600);


    // i am tester~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // $cli = new cli();
    // echo $cli->run('ls -al');
    // i am tester~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    // boot web UI
    function bootstrap() {
        // set time zone
        date_default_timezone_set('Asia/chongqing');

        // get array of leftmenu which has sorted.
        $menuArr = leftmenu::instance()->sort()->getMenu();

        // generate smarty instance
        V::getInstance()->assign('menuArr', $menuArr)->display('index.tpl');
    }

    // login page
    function login() {
    	if(@$_GET['chkusr']!='ok'){
    		V::getInstance()->display('login/login.tpl');
    		exit();
    	}
        $account = @$_POST['account'];
        $passwd  = @$_POST['passwd'];
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $client_ip=get_client_ip();
        $sql_ip="select ip from adminips where ip='$client_ip'";    //管理主机ip检测
        $resultall= $db->query($sql_ip)->getFirstData();
        if($resultall===false){
        	DEBUG || exit('管理主机限制登录');
        }
        $sql = "select * from accounts
            where account = '$account' and passwd='$passwd'";
        $result = $db->query($sql)->getFirstData();
        if ($result === false) {
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
    function logout(){
    	@$_SESSION=NULL;
    	@session_unset();
		@session_destroy();
    }
    /**
	 * 检测用户与是否操作超时
	 * time 超时时间,单位:秒
	 * @param $timeout
	 */
	function chklogin($timeout){
		$now=time();
		if(!isset($_SESSION['account'])){//检测是否通过登录过来，排除直接输入地此进入
			login();
		}
		if(isset($_SESSION['session_time'])){//超时管理
			if(($now-$_SESSION['session_time'])> $timeout) 
			{
			   logout();
			}else{ 
			    //还没超时. 
			    $_SESSION['session_time']=time(); 
			} 
		}
	}
?>
