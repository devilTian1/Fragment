<?php
    $newPath = '/tmp/upload/';
    foreach ($_FILES as $fname => $info) {
        if ($info['error'] == UPLOAD_ERR_OK) {
            if (move_uploaded_file($info['tmp_name'], $newPath . $info['name'])) {
                print "file saved in $newPath{$info['name']}<br/>";
            }
        } else {
            print $info['error'] . '<br/>';
        }
    }
?>
