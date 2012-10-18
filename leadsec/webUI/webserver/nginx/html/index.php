<?php
date_default_timezone_set('Asia/chongqing');
require_once('Conf/global.php');
require_once('Function/common.php');

$smarty = new Smarty_SIS();
$smarty->assign('themePath', THEME_PATH);
$smarty->display('index.tpl');
?>
