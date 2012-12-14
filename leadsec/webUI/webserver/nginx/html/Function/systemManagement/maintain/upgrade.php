<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    //Upgrade list information   
    function getResult() {
        $db = new dbsqlite(DB_PATH . '/private.db');
        $result = $db->query("SELECT up_version FROM upgrade_history ORDER BY up_time DESC")
            ->getFirstData(PDO::FETCH_ASSOC);
        $result_list = $db->query("SELECT * FROM upgrade_history ORDER BY up_time DESC")
            ->getAllData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('lastestVersion', $result['up_version'])
            ->assign('result_list', $result_list);
     }
              
    if (!empty($_FILES)) {
        // Upgrade System
        $uploadfs = new fileUpload($_FILES);
        $uploadfs->upload();
        $cmd = "upgrade package \"{$_FILES['upgradeFile']['name']}\" " ;
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '升级成功'));
    } else if (!empty($_GET['reboot'])) {
        // Reboot system
        $cmd = 'Config rest';
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '重启成功'));
    } else {
         GetResult() ;
    }  
    
?>
