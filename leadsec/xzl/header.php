<?php
$lang_file="header.mo";
include("include/common.ini.php");
$tpl->assign("title", __R("this is the test key!"));
$tpl->display("header.tpl");
?>