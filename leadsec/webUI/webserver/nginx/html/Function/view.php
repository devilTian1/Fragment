<?php
    require_once('common.php');
    
    // record the page which user have clicked
    function recAdmShowLog() {
        $links    = explode('/', substr($_POST['func'], 0, -4), 3);
        $msg      = leftmenu::instance()->sort()->getPathName($links);
        $account  = $_SESSION['account'];
        $cip      = get_client_ip();
        $roleName = getRoleName($_SESSION['roles']);
        $msg      = $roleName . "管理员[$account]查看页面[" . join('/', $msg) .
            "], 地址来自[$cip].";
        $set      = array(
            'time' => time(), 'account' => $account, 'pri' => 6,
            'act'  => 'show', 'msg'     => $msg               
        );
        $admLog = new admLog($set);
    }
    recAdmShowLog();
   
    if (empty($_POST['func']) || $_SESSION === NULL) {
        return 'building... ...';
    } else {
        $func = $_POST['func'];
        if (file_exists($func)) {
            // load init data
            require_once($func);
        }
        $action = $_SESSION['action'];
        if($action=='new')
        {
	        $_SESSION['history'][]=$func;
	        $_SESSION['pos']=0;
        }
        $_SESSION['action'] = 'new';      
        $tpl  = str_replace('.php', '.tpl', $func);
        try {
            V::getInstance()->display($tpl);
        } catch(SmartyException $e) {
            //todo
            echo $e->getMessage();
        }
    }
?>
