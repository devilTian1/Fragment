<?php
// set time zone
date_default_timezone_set('Asia/chongqing');

// Load Config File
require_once('Conf/global.php');

// Load Common Function
require_once('Function/common.php');

// get array of leftmenu which has sorted.
$menuArr = leftmenu::instance()->sort()->getMenu();

// generate Smarty class
$smarty = new Smarty_SIS();
$smarty->assign('menuArr', $menuArr);
$smarty->display('index.tpl');
?>
