<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if ($_POST['addNewUserGroup'] === 'true') {
        $tpl = 'resConf/user/editUserGroupDialog.tpl';
        $result = V::getInstance()->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } elseif ($_POST['addProcess'] === 'true'){
        $tpl = 'resConf/user/editProcessListDialog.tpl';
        $result = V::getInstance()->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else {
        
    } 
?>
