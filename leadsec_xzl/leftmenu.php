<?php
$lang_file="leftmenu.mo";
include("include/common.ini.php");
include("menu.php");
$tpl->assign("menu",$menuArr);
$tpl->assign("title", __R("this is the test key!"));
$tpl->display("leftmenu.tpl");
?>