<?php /* Smarty version Smarty-3.1.11, created on 2012-10-12 01:50:40
         compiled from "/usr/local/apache2/htdocs/git_dt/Fragment/leadsec/webUI/Tpls/templates/header.tpl" */ ?>
<?php /*%%SmartyHeaderCode:63648704050770439bd0e62-36678706%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a065c36a08db270496920481dd41d46a7bda6af9' => 
    array (
      0 => '/usr/local/apache2/htdocs/git_dt/Fragment/leadsec/webUI/Tpls/templates/header.tpl',
      1 => 1349977593,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '63648704050770439bd0e62-36678706',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_50770439bd3547_28511354',
  'variables' => 
  array (
    'themePath' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_50770439bd3547_28511354')) {function content_50770439bd3547_28511354($_smarty_tpl) {?><!-- logo -->
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