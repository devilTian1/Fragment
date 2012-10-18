<?php /* Smarty version Smarty-3.1.11, created on 2012-10-18 12:02:33
         compiled from "/usr/local/webserver/nginx/html/Fragment/leadsec/webUI/LNSP/webserver/nginx/html/Tpls/templates/header.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1932941953507f7f59ab2750-22083000%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a116cd3e78e6ba2f4717fed3da38c53b9521eb15' => 
    array (
      0 => '/usr/local/webserver/nginx/html/Fragment/leadsec/webUI/LNSP/webserver/nginx/html/Tpls/templates/header.tpl',
      1 => 1350531310,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1932941953507f7f59ab2750-22083000',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'themePath' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_507f7f59ac7d33_07331085',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_507f7f59ac7d33_07331085')) {function content_507f7f59ac7d33_07331085($_smarty_tpl) {?><!-- logo -->
<div class="logo">
    <img src="<?php echo $_smarty_tpl->tpl_vars['themePath']->value;?>
/images/man_logo.jpg" alt="leadsec" />
</div>
<!-- rightNav-->
<div class="right_nav">
    <div class="text_left">
        <img src="<?php echo $_smarty_tpl->tpl_vars['themePath']->value;?>
/images/direct.gif" width="8" height="21" />
        安全隔离与信息交换系统
    </div>
    <div class="text_right">
        <img src="<?php echo $_smarty_tpl->tpl_vars['themePath']->value;?>
/images/return.gif" width="13" height="21" />&nbsp;[
        <a href="#">返回首页</a>&nbsp;|&nbsp;<a href="#">栏目导航</a> ]
   </div>
</div>
<?php }} ?>