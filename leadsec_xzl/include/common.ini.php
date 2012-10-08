<?php
define('WWWROOT', substr(dirname(__FILE__), 0, -7));
define('LANG','zh_CN');//这里更改多语言配置,en与zh_CN俩中
//define('DBROOT', "/usr/local/webserver/sqlite3/");//定义sqlite数据的位置
define('DBROOT', "D:/WEB/PHP/APMServ5.2.6/www/htdocs/sqlite3/");//定义sqlite数据的位置
define('SMARTY_ROOT',WWWROOT.'./tpls');
$mofilepath = WWWROOT.'./lang/'.LANG.'/';
if(!isset($lang_file)){$lang_file='default.mo';}
define('MO_FILE', $mofilepath.$lang_file);
include(WWWROOT."./include/smarty/libs/Smarty.class.php");
include(WWWROOT.'./include/streams.php');
include(WWWROOT.'./include/gettext.php');
include(WWWROOT.'./include/db_sqlite.php');
include(WWWROOT.'./include/function.php');
$tpl = new Smarty();
$tpl->template_dir = SMARTY_ROOT."/templates/";
$tpl->compile_dir = SMARTY_ROOT."/templates_c/";
$tpl->config_dir = SMARTY_ROOT."/configs/";
$tpl->cache_dir = SMARTY_ROOT."/cache/";
$tpl->caching=0;
$tpl->cache_lifetime=60*60*24;
$tpl->left_delimiter = '<{';
$tpl->right_delimiter = '}>';
@session_start();