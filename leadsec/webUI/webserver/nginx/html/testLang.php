<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>php语言包测试demo</title>
</head>
<style type="text/css">
	.bold{color:#F00; font-weight:bold; font-size:14px}
</style>
<script type="text/javascript" src="Public/js/jquery/jquery-1.8.1.min.js"></script>
<script type="text/javascript">
var cookie = {
set: function(key, value, days) {
document.cookie = 'leadsec_' + key + '=' + value + '; expires=' +
(new Date(new Date().getTime() + ((days ? days : 14) * 86400000))).toUTCString() + '; path=/';
},
get: function(key) {
var r = ('; ' + document.cookie + ';').match('; leadsec_' + key + '=(.*?);');
return r ? r[1] : null;
},
unset: function(key) {
document.cookie = 'leadsec_' + key + '=; expires=' +
(new Date(1)).toUTCString() + '; path=/';
}
};
$(document).ready(function(){
 	 $("#lang").change(function(){
		cookie.set("lang",this.value);
		location.reload();
	 });
	 var langCookie=cookie.get("lang");
	 $("#lang").val(langCookie);
});
</script>
<body>
<?php
include 'Conf/global.php';
if($_COOKIE["leadsec_lang"]==NULL){
	$LANG="zh_CN";
}else{
	$LANG=$_COOKIE["leadsec_lang"];
}
define('LANG',$LANG);//定义使用哪个语言包
$mofilepath = WEB_PATH.'./Lang/'.LANG.'/';
$lang_file="message.mo";
if(!isset($lang_file)){$lang_file='default.mo';}
define('MO_FILE', $mofilepath.$lang_file);//定义语言包位置
//$tpl->assign("title", __R("this is the test key!"));
include(WEB_PATH.'./Lib/thirdParty/LangClass/streams.php');
include(WEB_PATH.'./Lib/thirdParty/LangClass/gettext.php');
//输出不现国家的语言
function __R($string){
	$mo2po = new gettext_reader(new CachedFileReader(MO_FILE));
	return $mo2po->translate($string);
}
?>
<table width="100%" border="1" cellpadding="8" cellspacing="2">
  <tr>
    <td colspan="3" align="center">语言包测试demo
      <label>
        <select name="lang" id="lang">
        	<option value="zh_CN" selected="selected">简体中文</option>
            <option value="en">English</option>
       </select>
    </label></td>
  </tr>
  <tr>
    <td width="37%"><?php echo __R("显示内容")?>：</td>
    <td width="52%" class="bold"><?php echo __R("登录"); ?></td>
    <td width="11%" class="bold"><?php echo __R("退出"); ?></td>
  </tr>
</table>

</body>
</html>