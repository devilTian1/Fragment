<?php
$lang_file="messages.mo";
include("include/common.ini.php");
$tpl->assign("title", __R("this is the test key!"));
$tpl->display("content.tpl");
?>