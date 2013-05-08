<?php /* Smarty version Smarty-3.1.11, created on 2013-05-08 08:22:15
         compiled from "D:\leadsec\Fragment\leadsec\webUI\webserver\nginx\html\Tpls\templates\server\customized\tcpTable.tpl" */ ?>
<?php /*%%SmartyHeaderCode:12186518a0b37436b68-54614911%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '926b205be15a5901f985e1ec599e0e97cb37c15b' => 
    array (
      0 => 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Tpls\\templates\\server\\customized\\tcpTable.tpl',
      1 => 1366726990,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '12186518a0b37436b68-54614911',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'tcpCommServerAcl' => 0,
    'r' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_518a0b375996b4_44237343',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_518a0b375996b4_44237343')) {function content_518a0b375996b4_44237343($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_truncate')) include 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Lib\\thirdParty\\Smarty\\plugins\\modifier.truncate.php';
?><?php  $_smarty_tpl->tpl_vars['r'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['r']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['tcpCommServerAcl']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['r']->key => $_smarty_tpl->tpl_vars['r']->value){
$_smarty_tpl->tpl_vars['r']->_loop = true;
?>
    <tr>
        <td><?php echo $_smarty_tpl->tpl_vars['r']->value['id'];?>
</td>
        <td><?php echo $_smarty_tpl->tpl_vars['r']->value['serverip'];?>
</td>
        <td><?php echo $_smarty_tpl->tpl_vars['r']->value['sport'];?>
</td>
        <td>
            <form action="Function/server/customized/tcp.php"
                method="POST" id="switchTcpCommServerForm_<?php echo $_smarty_tpl->tpl_vars['r']->value['id'];?>
"
                onSubmit="return false;">
                <input type="hidden" name="customId" value="<?php echo $_smarty_tpl->tpl_vars['r']->value['id'];?>
"/>
                <input type="hidden" name="serverIp" value="<?php echo $_smarty_tpl->tpl_vars['r']->value['serverip'];?>
"/>
                <input type="hidden" name="sportReq" value="<?php echo $_smarty_tpl->tpl_vars['r']->value['sport'];?>
"/>
                <input type="hidden" name="comment" value="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['r']->value['comment'], ENT_QUOTES, 'UTF-8', true);?>
"/>
                <?php if ($_smarty_tpl->tpl_vars['r']->value['active']==1||$_smarty_tpl->tpl_vars['r']->value['active']=='Y'){?>
                    <a href="#" onClick="switchTcpCommServerAcl('<?php echo $_smarty_tpl->tpl_vars['r']->value['id'];?>
', 'disable')">
                        <img src="<?php echo @THEME_PATH;?>
/images/icon/select.png" width="16" height="16"/>
                        <input type="hidden" name="action" value="disable"/>
                    </a>
                <?php }else{ ?>
                    <a href="#" onClick="switchTcpCommServerAcl('<?php echo $_smarty_tpl->tpl_vars['r']->value['id'];?>
', 'enable')">
                        <img src="<?php echo @THEME_PATH;?>
/images/icon/stop.png"
                        width="16" height="16"/>
                        <input type="hidden" name="action" value="enable"/>
                    </a>
                <?php }?>
            </form>
        </td>
        <td title="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['r']->value['comment'], ENT_QUOTES, 'UTF-8', true);?>
"><?php echo smarty_modifier_truncate(htmlspecialchars($_smarty_tpl->tpl_vars['r']->value['comment'], ENT_QUOTES, 'UTF-8', true),25,"... ...");?>
</td>
        <td class="no_search">
            <a href="#" class="edit" onclick="editTcpCommServerAclDialog('<?php echo $_smarty_tpl->tpl_vars['r']->value['id'];?>
')">编辑</a>
            <a href="#" class="delete" onclick="delTcpCommServerAclDialog('<?php echo $_smarty_tpl->tpl_vars['r']->value['id'];?>
')">删除</a> 
        </td>
    </tr>
<?php }
if (!$_smarty_tpl->tpl_vars['r']->_loop) {
?>
    <tr><td colspan='6'>没有任务</td></tr>
<?php } ?>
<?php }} ?>