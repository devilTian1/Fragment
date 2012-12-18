<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (!empty($_FILES)) {
        // Upgrade System
        $uploadfs = new fileUpload($_FILES);
        $uploadfs->upload();
        $cmd = "upgrade package \"{$_FILES['licenseFile']['name']}\" " ;
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '升级成功'));
    } else {

    }

?>

