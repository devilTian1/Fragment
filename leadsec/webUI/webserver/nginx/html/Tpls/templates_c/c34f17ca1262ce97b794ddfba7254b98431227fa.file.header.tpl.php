<?php /* Smarty version Smarty-3.1.11, created on 2013-07-08 18:57:55
         compiled from "D:\leadsec\Fragment\leadsec\webUI\webserver\nginx\html\Tpls\templates\layout\header.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1526051da9b33839176-00610496%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c34f17ca1262ce97b794ddfba7254b98431227fa' => 
    array (
      0 => 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Tpls\\templates\\layout\\header.tpl',
      1 => 1370567940,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1526051da9b33839176-00610496',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'result' => 0,
    'header' => 0,
    'loginname' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_51da9b338c25b1_21853811',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_51da9b338c25b1_21853811')) {function content_51da9b338c25b1_21853811($_smarty_tpl) {?><div class="logo">
     <img src="<?php echo @THEME_PATH;?>
/images/top_logo.gif" />
</div>
 <!-- rightNav-->
<div class="right_nav">
    <!--icon nav-->
    <div class="dock" id="dock2">
        <div class="dock-container2">
        <?php  $_smarty_tpl->tpl_vars['header'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['header']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['result']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['header']->key => $_smarty_tpl->tpl_vars['header']->value){
$_smarty_tpl->tpl_vars['header']->_loop = true;
?>
		    <form action="Function/header.php" method="POST"
	            id="headerFormId_<?php echo $_smarty_tpl->tpl_vars['header']->value['id'];?>
" onSubmit="return false;">
	        <input type="hidden" name="headerName_<?php echo $_smarty_tpl->tpl_vars['header']->value['id'];?>
" value="<?php echo $_smarty_tpl->tpl_vars['header']->value['name'];?>
"/>
	        <?php if ($_smarty_tpl->tpl_vars['header']->value['id']==='exportconf'){?><input type="hidden" name="export_format" value="normal"/><?php }?>
            <a class="dock-item2" href="#" onClick="headerSpan('<?php echo $_smarty_tpl->tpl_vars['header']->value['name'];?>
','<?php echo $_smarty_tpl->tpl_vars['header']->value['id'];?>
')"><span class="black"><?php echo $_smarty_tpl->tpl_vars['header']->value['name'];?>
</span><img src="<?php echo @THEME_PATH;?>
/images/<?php echo $_smarty_tpl->tpl_vars['header']->value['img'];?>
" alt="<?php echo $_smarty_tpl->tpl_vars['header']->value['name'];?>
"/></a>
            </form>
        <?php } ?> 
            <a class="dock-item2" href="index.php?logout=1" onClick="function() {window.Location.href='index.php'}"><span class="black">退出</span><img src="<?php echo @THEME_PATH;?>
/images/top_icon_7.png" alt="<?php echo $_smarty_tpl->tpl_vars['header']->value['name'];?>
"/></a>          
        </div>
    </div>
    <!-- userinfo -->
    <div class="top_userinfo">
        <div class="paddingLeft30">
            <span>欢迎</span>,&nbsp;<strong><?php echo $_smarty_tpl->tpl_vars['loginname']->value;?>
</strong>
            <br>
            [<a href="javascript:openEditUserDialog('<?php echo $_smarty_tpl->tpl_vars['loginname']->value;?>
')"><?php echo $_smarty_tpl->tpl_vars['loginname']->value;?>
</a>,&nbsp;<a href="index.php?logout=1" onClick="function() {window.Location.href='index.php'}">退出</a>]
        </div>
   </div>
</div>
<script type="text/javascript" src="Public/js/systemManagement/admin/account.js"></script>
<?php }} ?>