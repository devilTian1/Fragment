<?php
    @$expTime = $_POST['expTime'];
    $file = '/usr/local/webserver/nginx/html/Conf/global.php';
    $contents = file_get_contents($file);
    $contents = preg_replace("@\('EXPIRED_TIME',\s?(.*)\)@",
        "('EXPIRED_TIME',$expTime)", $contents);
    file_put_contents($file, $contents);
    echo json_encode(array('msg' => '修改成功', 'status' => -1));
?>
