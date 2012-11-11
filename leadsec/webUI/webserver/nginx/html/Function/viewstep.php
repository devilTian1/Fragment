<?php
    require_once('common.php');
    if (empty($_POST['func']) ||empty($_POST['steptpl'])|| $_SESSION === NULL) {
        return 'building... ...';
    } else {
        $func = $_POST['func'];
        $steptpl=$_POST['steptpl'];
        //echo $func;
        //echo $steptpl;
		if (file_exists($func)) {
		    // load init data
		    require_once($func);
		}
        $tpl  = str_replace('.php', '', $func);
        $tpl.="_$steptpl.tpl";
        //echo $tpl;
        try {
            V::getInstance()->display($tpl);
        } catch(SmartyException $e) {
            //todo
            echo $e->getMessage();
        }
    }
?>
