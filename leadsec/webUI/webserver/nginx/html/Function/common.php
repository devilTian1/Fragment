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
    // netgap resource
    require_once(WEB_PATH . '/Lib/driver/netGapRes.php');

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

        // Check this device is in host or out host
        $db = new dbsqlite(DB_PATH . '/netgap_system.db');
        $result = $db->query("SELECT host FROM system")
                     ->getFirstData(PDO::FETCH_ASSOC);
        $hostStatus = $result['host'] === 'I' ? '内网' : '外网';

        // generate smarty instance
        V::getInstance()->assign('menuArr', $menuArr)
                        ->assign('hostStatus', $hostStatus)
                        ->display('index.tpl');
    }
?>
