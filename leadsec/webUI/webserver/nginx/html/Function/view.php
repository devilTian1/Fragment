<?php
    require_once('common.php');
    if (empty($_POST['func'])) {
        echo '没有这个功能 ... ...';
        return ;
    } else {
        $func = $_POST['func'];
        @require_once($func);
    }
?>
