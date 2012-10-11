<?php
date_default_timezone_set('Asia/chongqing');
$lang_file="index.mo";
include("include/common.ini.php");
$tpl->assign("title", __R("安全隔离与信息交换系统 "));
$tpl->assign("content", __R("this is the test"));
$tpl->display("index.tpl");
?>
