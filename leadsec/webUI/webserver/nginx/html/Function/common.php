<?php

    // Load Config File
    require_once(dirname(__FILE__) . '/../Conf/global.php');
    // Load template engine smarty
    require_once(WEB_PATH . '/Lib/driver/smarty.php');
    // Load leftmenu driver
    require_once(WEB_PATH . '/Lib/driver/leftmenu.php');

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
        V::getInstance()->display('login.tpl');
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
