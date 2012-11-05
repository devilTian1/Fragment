<?php
    require_once('common.php');
    if (empty($_POST['func']) || $_SESSION === NULL) {
        return 'building... ...';
    } else {
        $func = $_POST['func'];
	if (file_exists($func)) {
	    // load init data
	    require_once($func);
	}
        $tpl  = str_replace('.php', '.tpl', $func);
        try {
            V::getInstance()->display($tpl);
        } catch(SmartyException $e) {
            //todo
            echo $e->getMessage();
        }
    }
?>
