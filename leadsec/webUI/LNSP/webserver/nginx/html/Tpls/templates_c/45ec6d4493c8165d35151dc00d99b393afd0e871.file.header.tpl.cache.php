<?php /* Smarty version Smarty-3.1.11, created on 2012-10-18 11:41:07
         compiled from "/usr/local/webserver/nginx/html/Fragment/leadsec/webUI/Tpls/templates/header.tpl" */ ?>
<?php /*%%SmartyHeaderCode:2121000204507f7a53c67711-30406162%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '45ec6d4493c8165d35151dc00d99b393afd0e871' => 
    array (
      0 => '/usr/local/webserver/nginx/html/Fragment/leadsec/webUI/Tpls/templates/header.tpl',
      1 => 1350531310,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2121000204507f7a53c67711-30406162',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'themePath' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_507f7a53c7d425_65106005',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_507f7a53c7d425_65106005')) {function content_507f7a53c7d425_65106005($_smarty_tpl) {?><!-- logo -->
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