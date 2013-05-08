<?php /* Smarty version Smarty-3.1.11, created on 2013-05-08 08:22:06
         compiled from "D:\leadsec\Fragment\leadsec\webUI\webserver\nginx\html\Tpls\templates\networkManagement\interface\redundanceTable.tpl" */ ?>
<?php /*%%SmartyHeaderCode:21731518a0b2ec5f339-62314752%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '5d102d9e0c75a5663e8f5e57da2f11ae8881cdcd' => 
    array (
      0 => 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Tpls\\templates\\networkManagement\\interface\\redundanceTable.tpl',
      1 => 1366726990,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '21731518a0b2ec5f339-62314752',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'list' => 0,
    'value' => 0,
    'workmodeArr' => 0,
    'ipaddrArr' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_518a0b2ee1e0d5_32627668',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_518a0b2ee1e0d5_32627668')) {function content_518a0b2ee1e0d5_32627668($_smarty_tpl) {?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['list']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['value']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['value']->index++;
?>
    <tr>
        <td>
            <?php echo $_smarty_tpl->tpl_vars['value']->value['external_name'];?>

        </td>
        <td>
            <?php echo $_smarty_tpl->tpl_vars['value']->value['ip'];?>
/<?php echo $_smarty_tpl->tpl_vars['value']->value['mask'];?>

        </td>
        <td>
            <?php echo $_smarty_tpl->tpl_vars['workmodeArr']->value[$_smarty_tpl->tpl_vars['value']->value['workmode']];?>

        </td>
        <td>
            <?php echo $_smarty_tpl->tpl_vars['ipaddrArr']->value[$_smarty_tpl->tpl_vars['value']->value['ipaddr_type']];?>

        </td>
        <td>
            <?php echo (($tmp = @$_smarty_tpl->tpl_vars['value']->value['interface_list'])===null||$tmp==='' ? '空' : $tmp);?>

        </td>
        <td>
            <form action="Function/networkManagement/interface/redundance.php" method="POST"
                id="switchRedundanceDevForm_<?php echo $_smarty_tpl->tpl_vars['value']->index;?>
" onSubmit="return false;">
                <input type="hidden" name="switch_name" value="<?php echo $_smarty_tpl->tpl_vars['value']->value['external_name'];?>
"/>
            <?php if ($_smarty_tpl->tpl_vars['value']->value['enable']==1){?>
                <a href="#" onClick="switchRedundanceDev('<?php echo $_smarty_tpl->tpl_vars['value']->value['external_name'];?>
', 'disable', '<?php echo $_smarty_tpl->tpl_vars['value']->index;?>
')">
                    <img src="<?php echo @THEME_PATH;?>
/images/icon/select.png"
                        width="16" height="16" />
                    <input type="hidden" name="action" value="disable"/>
                </a>
            <?php }else{ ?>
                <a href="#" onClick="switchRedundanceDev('<?php echo $_smarty_tpl->tpl_vars['value']->value['external_name'];?>
', 'enable', '<?php echo $_smarty_tpl->tpl_vars['value']->index;?>
')">
                    <img src="<?php echo @THEME_PATH;?>
/images/icon/stop.png"
                        width="16" height="16" />
                    <input type="hidden" name="action" value="enable"/>
                </a>
            <?php }?>
            </form>
        </td>
        <td>
            <a href="#" class="edit"
                onclick="openEditRedundanceDevDialog('<?php echo $_smarty_tpl->tpl_vars['value']->value['external_name'];?>
')">
                编辑</a>
      	    <a href="#" class="delete"
                onclick="openDelRedundanceDevDialog('<?php echo $_smarty_tpl->tpl_vars['value']->value['external_name'];?>
')">
                删除</a>	
        </td>
    </tr>
<?php }
if (!$_smarty_tpl->tpl_vars['value']->_loop) {
?>
    <tr>
        <td colspan='7'>No Redundance Device Data</td>
    </tr>
<?php } ?>
<?php }} ?>