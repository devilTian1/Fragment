<?php /* Smarty version Smarty-3.1.11, created on 2013-07-08 18:57:55
         compiled from "D:\leadsec\Fragment\leadsec\webUI\webserver\nginx\html\Tpls\templates\layout\leftmenu.tpl" */ ?>
<?php /*%%SmartyHeaderCode:656551da9b33901168-77136618%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'cf22ee7fc10553d760146fb282718420cfc8ce51' => 
    array (
      0 => 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Tpls\\templates\\layout\\leftmenu.tpl',
      1 => 1370567940,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '656551da9b33901168-77136618',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'menuArr' => 0,
    'l1' => 0,
    'l2' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_51da9b33942ef4_96638178',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_51da9b33942ef4_96638178')) {function content_51da9b33942ef4_96638178($_smarty_tpl) {?><?php  $_smarty_tpl->tpl_vars['l1'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['l1']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['menuArr']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['l1']->key => $_smarty_tpl->tpl_vars['l1']->value){
$_smarty_tpl->tpl_vars['l1']->_loop = true;
?>
    <!--[if IE 8]>
    <p style="margin: 0px; padding: 0px; height: 9px;"></p>
    <![endif]-->
    <div class="l1 l1_close_<?php echo $_smarty_tpl->tpl_vars['l1']->value['link'];?>
" name="<?php echo $_smarty_tpl->tpl_vars['l1']->value['link'];?>
">
        <span><?php echo $_smarty_tpl->tpl_vars['l1']->value['name'];?>
</span>
    </div>
        <div class="l2" name="<?php echo $_smarty_tpl->tpl_vars['l1']->value['link'];?>
">
            <ul>
            <?php  $_smarty_tpl->tpl_vars['l2'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['l2']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['l1']->value['children']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['l2']->key => $_smarty_tpl->tpl_vars['l2']->value){
$_smarty_tpl->tpl_vars['l2']->_loop = true;
?>
                <li>
                    <a name="<?php echo $_smarty_tpl->tpl_vars['l2']->value['link'];?>
" title="<?php echo $_smarty_tpl->tpl_vars['l2']->value['name'];?>
"><?php echo $_smarty_tpl->tpl_vars['l2']->value['name'];?>
</a>
                </li>
            <?php } ?>
            </ul>
        </div>
<?php } ?>
<?php }} ?>