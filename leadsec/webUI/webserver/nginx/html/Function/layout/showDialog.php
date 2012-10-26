<?php
    require_once('../common.php');

    // display tab content
    $tpl = $_POST['tpl'];
    V::getInstance()->display($tpl);
?>
