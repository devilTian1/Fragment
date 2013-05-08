<?php /* Smarty version Smarty-3.1.11, created on 2013-05-08 08:22:11
         compiled from "D:\leadsec\Fragment\leadsec\webUI\webserver\nginx\html\Tpls\templates\server\fileEx\shareDirTable.tpl" */ ?>
<?php /*%%SmartyHeaderCode:5308518a0b333fcf50-53751072%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'e470edd9cb4d7afec85a3ef4c8d233259aff72fe' => 
    array (
      0 => 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Tpls\\templates\\server\\fileEx\\shareDirTable.tpl',
      1 => 1366726990,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '5308518a0b333fcf50-53751072',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'shareDir' => 0,
    'r' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_518a0b334abf59_13397481',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_518a0b334abf59_13397481')) {function content_518a0b334abf59_13397481($_smarty_tpl) {?><?php  $_smarty_tpl->tpl_vars['r'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['r']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['shareDir']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['r']->key => $_smarty_tpl->tpl_vars['r']->value){
$_smarty_tpl->tpl_vars['r']->_loop = true;
?>
    <tr>
        <td><?php echo $_smarty_tpl->tpl_vars['r']->value['task_id'];?>
</td>
        <td>
            <?php if ($_smarty_tpl->tpl_vars['r']->value['mode']==='C'){?>
            发送
            <?php }else{ ?>
            接受
            <?php }?>
        </td>
        <td><?php echo $_smarty_tpl->tpl_vars['r']->value['ip'];?>
</td>
        <td><?php echo $_smarty_tpl->tpl_vars['r']->value['share_name'];?>
</td>
        <td><?php echo $_smarty_tpl->tpl_vars['r']->value['fs'];?>
</td>
        <td class="no_search">
            <a href="#" class="detail"
                onclick="showShareDirDialog('<?php echo $_smarty_tpl->tpl_vars['r']->value['task_id'];?>
')">详情</a>
        </td>
    </tr>
<?php }
if (!$_smarty_tpl->tpl_vars['r']->_loop) {
?>
    <tr><td colspan='6'>No Data</td></tr>
<?php } ?>
<?php }} ?>