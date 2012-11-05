<?php
    require_once('../common.php');

    // display tab content
    $tpl = $_POST['tpl'];
    echo json_encode(array('msg' => V::getInstance()->fetch($tpl)));
?>
