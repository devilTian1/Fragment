<?php
    require_once('common.php');
    if (empty($_POST['func'])) {
        echo '没有这个功能 ... ...';
        return ;
    } else {
        $func = $_POST['func'];
        $tpl  = str_replace('.php', '.tpl', $func);
        try {
            V::getInstance()->display($tpl);
        } catch(SmartyException $e) {
            //todo
            echo $e->getMessage();
        }
    }
?>
