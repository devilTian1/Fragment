<?php
    // Load Config File
    require_once(dirname(__FILE__) . '/../Conf/global.php');

    // Include common driver
    // Template engine, smarty
    require_once(WEB_PATH . '/Lib/driver/smarty.php');
    // Menu
    require_once(WEB_PATH . '/Lib/driver/leftmenu.php');
    // DB driver
    require_once(WEB_PATH . '/Lib/driver/dbsqlite.php');


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
        $account = @$_POST['account'];
        $passwd  = @$_POST['passwd'];
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query("select * from accounts where account = '$account' and passwd='$passwd'")
           ->getFirstData();
        if ($result === false) {
            V::getInstance()->display('login/login.tpl');
        } else {
            // login successful
            @$_SESSION['account']  = $result['account'];
            @$_SESSION['super']    = $result['super'];
            @$_SESSION['manager']  = $result['manager'];
            @$_SESSION['policyer'] = $result['policyer'];
            @$_SESSION['auditor']  = $result['auditor'];
            bootstrap();
        }
    }

    // display tab content
    function displayTabs() {    
        $path = $_POST['tabPath'];
        list($tabinfo, $subMenu) =
            leftmenu::instance()->sort()->getSubMenu($path);
        $tabs = $subMenu['children'];
        V::getInstance()->assign('tabs',    $tabs)
                        ->assign('tabinfo', $tabinfo)
                        ->assign('baseurl', join('/', $path))
                        ->display('layout/tabs.tpl');
    }
?>
