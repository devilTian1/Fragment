<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

   //Upgrade list information   
    function GetResult() {
         $db = new dbsqlite(DB_PATH . '/private.db');
         $result = $db->query("SELECT up_version FROM upgrade_history ORDER  by up_time DESC ")
                     ->getFirstData(PDO::FETCH_ASSOC);
         $result_list = $db->query("SELECT * FROM upgrade_history ORDER by up_time DESC ")
                     ->getAllData(PDO::FETCH_ASSOC);
         V::getInstance() ->assign('lastestVersion', $result['up_version']);
         V::getInstance() ->assign('result_list', $result_list);
     }
              
    if(!empty($_FILES)) {
        $uploadfs = new fileUpload($_FILES);
        list($status, $msg) = $uploadfs->upload();
        if ($status !== 0) {
            echo json_encode(array('status' => $status, 'msg' => $msg));
            return false ;
        } 
        $cmd = "upgrade package \"{$_FILES['upload']['name']}\" " ;
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('status' => $status, 'msg' => '升级成功'));
    } else if (!empty($_GET['reboot'])){
        $cmd = "Config rest" ;
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('status' => $status, 'msg' => '重启成功'));
   }  else if (!empty($_POST['downloadUpgradeHistory'])) {
        header('Content-Type:download-force');
        header("Content-Disposition: attachment; filename=upgrade_history.txt");
        $db = new dbsqlite(DB_PATH . '/private.db');
        $result_list = $db->query("SELECT * FROM  upgrade_history ORDER by up_time DESC ")
                     ->getAllData(PDO::FETCH_ASSOC);
        $data = '下载时间:';
        $downtime = date('Y-n-d H:i:s',time());
        $downtimestr = $data.$downtime ;
        $downlist = '序号    升级以后版本号   升级时间                更新描述';
        $os = get_client_os();
        //for linux 
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
                // for windows
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
} 
    else {
         GetResult() ;
  }  

    
?>
