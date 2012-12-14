<?php
    require_once($_SERVER['DOCUMENT_ROOT'].'/Function/common.php');
    
     if (!empty($_FILES)) {
        // Upgrade System
        $uploadfs = new fileUpload($_FILES);
        $uploadfs->upload();
        $cmd = "config import \"{$_FILES['importFile']['name']}\"";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '升级成功'));
    } else if (!empty($_GET['rest'])){
        $cmd = 'Config rest';
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '恢复出厂配置成功'));
    } else if (!empty($_GET['save'])){
        $cmd = 'Config save';
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '保存配置成功'));
    } else {
        
    }




?>
