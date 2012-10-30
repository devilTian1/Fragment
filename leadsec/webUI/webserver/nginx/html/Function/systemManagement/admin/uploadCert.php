<?php
    require_once('/usr/local/webserver/nginx/html/Fragment/leadsec/webUI/webserver/nginx/html/Function/common.php');
    //require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    $errMsg = array();
    $newPath = '/tmp/upload/';
    foreach ($_FILES as $fname => $info) {
        if ($info['error'] == UPLOAD_ERR_OK) {
            if (move_uploaded_file($info['tmp_name'], $newPath . $info['name'])) {
                //echo "file saved in $newPath{$info['name']}<br/>";
            }
        } else {
            $errMsg[] = $info['error'];
            echo '导入失败';
            return false;
        }
    }
    $cmd = "admcert add cacert \"{$_FILES['CAcert']['name']}\" " .
        "ngcert \"{$_FILES['SIScert']['name']}\" " .
        "ngkey \"{$_FILES['SISkey']['name']}\"";
    $cli = new cli();
    $cli->run($cmd);
    echo '导入成功';
?>
