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


    //TODO TESTING
    $db  = new dbsqlite(DB_PATH . '/test.db');
    $sql = "select * from account";
    var_dump($db->query($sql)->getAllData());
    var_dump($db->query($sql)->getFirstData());
    var_dump($db->query($sql)->getCount());
    //insert
    $insertSql = 'insert into account values(?)';
    $params = array(99);
    var_dump($db->exec($insertSql, $params));
    //update
    $updateSql = 'update account set x=? where x=?';
    $params = array(999, 99);
    var_dump($db->exec($updateSql, $params));
    //delete
    $deleteSql = 'delete from account where x="999"';
    var_dump($db->exec($deleteSql));
    $db->close();

    //test transaction
    $db  = new dbsqlite(DB_PATH . '/test.db');
    $db->execByTransaction(
            array($insertSql,$insertSql,$insertSql), array(array('a'), array('b'), array('c')));

    

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
