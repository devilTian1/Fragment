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
        
		$result = array(
    		'0' =>array('id' => 'homepage',   'img' => 'top_icon_1.png',  'name' => '首页'),
    		'1' =>array('id' => 'fastconf',   'img' => 'top_icon_2.png',  'name' => '快捷配置'),
    		'2' =>array('id' => 'homepage',   'img' => 'top_icon_3.png',  'name' => '首页'),
    		'3' =>array('id' => 'save',       'img' => 'top_icon_4.png',  'name' => '保存'),
    		'4' =>array('id' => 'homepage',   'img' => 'top_icon_5.png',  'name' => '首页'),
    		'5' =>array('id' => 'refresh',    'img' => 'top_icon_6.png',  'name' => '刷新'),
    		'6' =>array('id' => 'exit',       'img' => 'top_icon_7.png',  'name' => '退出'),
    		'7' =>array('id' => 'exportlog',  'img' => 'top_icon_8.png',  'name' => '导出日志'),
    		'8' =>array('id' => 'first',       'img' => 'top_icon_9.png',  'name' => '上一步'),
    		'9' =>array('id' => 'next',        'img' => 'top_icon_10.png', 'name' => '下一步'),
    		'10' =>array('id' => 'help',       'img' => 'top_icon_11.png', 'name' => '在线帮助'),
    		'11' =>array('id' => 'inline',     'img' => 'top_icon_12.png', 'name' => '内网'),
    		'12' =>array('id' => 'online',     'img' => 'top_icon_13.png', 'name' => '外网'),
    		'13' =>array('id' => 'exportconf', 'img' => 'top_icon_14.png', 'name' => '导出配置')
    	);
        // generate smarty instance
        V::getInstance()->assign('result', $result)
        				->assign('menuArr', $menuArr)
                        ->assign('hostStatus', $hostStatus)
                        ->display('index.tpl');
    }
?>
