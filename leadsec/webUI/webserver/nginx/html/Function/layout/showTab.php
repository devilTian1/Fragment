<?php
    require_once('../common.php');

    // display tab content
    $path = $_POST['tabPath'];
    list($tabinfo, $subMenu) =
        leftmenu::instance()->sort()->getSubMenu($path);
    $tabs = $subMenu['children'];
    V::getInstance()->assign('tabs',    $tabs)
                    ->assign('tabinfo', $tabinfo)
                    ->assign('baseurl', join('/', $path))
                    ->display('layout/tabs.tpl');
?>
