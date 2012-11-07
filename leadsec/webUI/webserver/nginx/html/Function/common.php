<?php
    @session_start();
    setlocale(LC_CTYPE, 'zh_CN.utf8');
    // Load Config File
    require_once(dirname(__FILE__) . '/../Conf/global.php');

    // debug
    DEBUG && error_reporting(E_ALL);

    // set exception handler
    function exceptionHandler($e) {
        echo json_encode(array('status' => -1, 'msg' => $e->getMessage()));
    }
    set_exception_handler('exceptionHandler');

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
    // upload driver
    require_once(WEB_PATH . '/Lib/driver/fileUpload.php');

    // login function
    require_once(WEB_PATH . '/Function/login.php');
    //用户操作操时处理
    chklogin(EXPIRED_TIME);

    // boot web UI
    function bootstrap() {
        // set time zone
        date_default_timezone_set('Asia/chongqing');

        // get array of leftmenu which has sorted.
        $menuArr = leftmenu::instance()->sort()->getMenu();

        // generate smarty instance
        V::getInstance()->assign('menuArr', $menuArr)->display('index.tpl');
    }
?>
