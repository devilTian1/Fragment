<?php /* Smarty version Smarty-3.1.11, created on 2013-05-08 08:22:10
         compiled from "D:\leadsec\Fragment\leadsec\webUI\webserver\nginx\html\Tpls\templates\server\fileEx\receiveTaskTable.tpl" */ ?>
<?php /*%%SmartyHeaderCode:6286518a0b32046e60-67732999%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '407bd2ab509c1a9e5420d1d0b9b2f825103cd3a2' => 
    array (
      0 => 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Tpls\\templates\\server\\fileEx\\receiveTaskTable.tpl',
      1 => 1366726990,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '6286518a0b32046e60-67732999',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'receiveTask' => 0,
    'r' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_518a0b32142ef8_16317968',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_518a0b32142ef8_16317968')) {function content_518a0b32142ef8_16317968($_smarty_tpl) {?><?php  $_smarty_tpl->tpl_vars['r'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['r']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['receiveTask']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['r']->key => $_smarty_tpl->tpl_vars['r']->value){
$_smarty_tpl->tpl_vars['r']->_loop = true;
?>
    <tr>
        <td><?php echo $_smarty_tpl->tpl_vars['r']->value['task_id'];?>
</td>
        <td><?php echo $_smarty_tpl->tpl_vars['r']->value['ip'];?>
</td>
        <td><?php echo $_smarty_tpl->tpl_vars['r']->value['share_name'];?>
</td>
        <td><?php echo $_smarty_tpl->tpl_vars['r']->value['fs'];?>
</td>
        <td>
            <form action="Function/server/fileEx/receiveTask.php"
                method="POST" id="switchReceiveTaskForm_<?php echo $_smarty_tpl->tpl_vars['r']->value['task_id'];?>
"
                onSubmit="return false;">
                <input type="hidden" name="receiveTaskId" value="<?php echo $_smarty_tpl->tpl_vars['r']->value['task_id'];?>
"/>
                <input type="hidden" name="sip" value="<?php echo $_smarty_tpl->tpl_vars['r']->value['ip'];?>
"/>
                <input type="hidden" name="shareName" value="<?php echo $_smarty_tpl->tpl_vars['r']->value['share_name'];?>
"/>
                <input type="hidden" name="fs" value="<?php echo $_smarty_tpl->tpl_vars['r']->value['fs'];?>
"/>
                <input type="hidden" name="smbUser" value="<?php echo $_smarty_tpl->tpl_vars['r']->value['user'];?>
"/>
                <input type="hidden" name="smbPwd" value="<?php echo $_smarty_tpl->tpl_vars['r']->value['password'];?>
"/>
                <input type="hidden" name="lip" value="<?php echo $_smarty_tpl->tpl_vars['r']->value['lip'];?>
"/>
                <input type="hidden" name="portReq" value="<?php echo $_smarty_tpl->tpl_vars['r']->value['port'];?>
"/>
                <?php if ($_smarty_tpl->tpl_vars['r']->value['active']==1||$_smarty_tpl->tpl_vars['r']->value['active']=='Y'){?>
                    <a href="#" onClick="switchReceiveTaskAcl('<?php echo $_smarty_tpl->tpl_vars['r']->value['task_id'];?>
', 'disable')">
                        <img src="<?php echo @THEME_PATH;?>
/images/icon/select.png" width="16" height="16"/>
                        <input type="hidden" name="action" value="disable"/>
                    </a>
                <?php }else{ ?>
                    <a href="#" onClick="switchReceiveTaskAcl('<?php echo $_smarty_tpl->tpl_vars['r']->value['task_id'];?>
', 'enable')">
                        <img src="<?php echo @THEME_PATH;?>
/images/icon/stop.png"
                        width="16" height="16"/>
                        <input type="hidden" name="action" value="enable"/>
                    </a>
                <?php }?>
            </form>
        </td>
        <td class="no_search">
            <a href="#" class="edit"
                onclick="editReceiveTaskDialog('<?php echo $_smarty_tpl->tpl_vars['r']->value['task_id'];?>
')">编辑</a>
            <a href="#" class="delete"
                onclick="delReceiveTaskDialog('<?php echo $_smarty_tpl->tpl_vars['r']->value['task_id'];?>
')">删除</a> 
        </td>
    </tr>
<?php }
if (!$_smarty_tpl->tpl_vars['r']->_loop) {
?>
    <tr><td colspan='6'>No Data</td></tr>
<?php } ?>
<?php }} ?>