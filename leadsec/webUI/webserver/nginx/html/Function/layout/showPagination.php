<?php
    require_once('../common.php');

    // display pagination
    echo V::getInstance()->assign('dataCount', $_POST['pageCount'])
            ->assign('pageCount', $_POST['pageCount']))
            ->assign('clickedPageNo', $_POST['clickedPageNo'])->fetch('layout/pagination.tpl')
?>
