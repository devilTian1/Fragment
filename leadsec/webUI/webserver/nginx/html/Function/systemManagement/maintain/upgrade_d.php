<?php
        $filename = urlencode('upgrade_history.txt');
        header("Content-Type: application/octet-stream; charset=utf-8;");
        header("Content-Disposition: attachment; filename=\"$filename\";");
        header("Content-Length: 100;");
        header("Content-Transfer-Encoding: binary;");
        header('Pragma: Public;', true);
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0;');

        require_once($_SERVER['DOCUMENT_ROOT'] . '/Conf/global.php');
        DEBUG && error_reporting(E_ALL);

        // set exception handler
        function exceptionHandler($e) {
            echo json_encode(array('status' => -1, 'msg' => $e->getMessage()));
        }
        set_exception_handler('exceptionHandler');

        // Include common driver
        // Exception driver
        require_once(WEB_PATH . '/Lib/driver/exception.php');

        require_once(WEB_PATH . '/Lib/driver/dbsqlite.php');
        require_once(WEB_PATH . '/Lib/driver/function.php');
        $db = new dbsqlite(DB_PATH . '/private.db');
        $result_list = $db->query("SELECT * FROM  upgrade_history ORDER BY up_time DESC ")
            ->getAllData(PDO::FETCH_ASSOC);
        if(!empty($result_list)) {
            $downtimestr = '下载时间:' . date('Y-n-d H:i:s',time());
            $downlist = '序号    升级以后版本号   升级时间                更新描述';
            $os = get_client_os();
            if ($os ==='Linux') {
                echo $downtimestr . "\n";
                echo $downlist . "\n";
                foreach($result_list as $val){
                    $id         = str_pad(substr($val['id'], 0, 7), 7, ' ');
                    $up_version = str_pad(substr($val['up_version'], 0, 15), 15, ' ');
                    $up_time    = str_pad(substr($val['up_time'], 0 , 22), 22, ' ');
                    $del_bugs   = str_pad(substr($val['del_bugs'], 0 ,30), 30, ' ');
                    echo  "$id$up_version$up_time$del_bugs\n" ;
                }
            } else if ($os === 'Windows XP') {
                echo $downtimestr . "\r\n";
                echo $downlist . "\r\n";
                foreach($result_list as $val){
                    $id         = str_pad(substr($val['id'], 0, 8), 8, ' ');
                    $up_version = str_pad(substr($val['up_version'], 0, 17), 17, ' ');
                    $up_time    = str_pad(substr($val['up_time'], 0 , 24), 24, ' ');
                    $del_bugs   = str_pad(substr($val['del_bugs'], 0 ,30), 30, ' ');
                    echo  "$id$up_version$up_time$del_bugs\r\n" ;  
                }
            }
       } else {
                echo "No Upgrade History Data" ;
    }
    exit();
?>
