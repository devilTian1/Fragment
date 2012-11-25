<?php
    require_once('../common.php');

    // display tab content
    $path = $_POST['tabPath'];
    list($tabinfo, $subMenu) =
        leftmenu::instance()->sort()->getSubMenu($path);
    $tabs = $subMenu['children'];
    if (count($tabs) === 0) {
        $tabs = array($subMenu);
        $tabinfo = $subMenu['title'];
    }
    V::getInstance()->assign('tabs',    $tabs)
                    ->assign('tabinfo', $tabinfo)
                    ->assign('baseurl', join('/', $path))
                    ->display('layout/tabs.tpl');
?>
