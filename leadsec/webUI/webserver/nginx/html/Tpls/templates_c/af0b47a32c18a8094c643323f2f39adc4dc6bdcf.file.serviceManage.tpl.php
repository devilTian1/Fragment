<?php /* Smarty version Smarty-3.1.11, created on 2013-04-27 11:04:33
         compiled from "D:\leadsec\Fragment\leadsec\webUI\webserver\nginx\html\Tpls\templates\server\safeBrowse\serviceManage.tpl" */ ?>
<?php /*%%SmartyHeaderCode:12257517bb0c1b868c4-15255695%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'af0b47a32c18a8094c643323f2f39adc4dc6bdcf' => 
    array (
      0 => 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Tpls\\templates\\server\\safeBrowse\\serviceManage.tpl',
      1 => 1361669412,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '12257517bb0c1b868c4-15255695',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'httpStatus' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_517bb0c1c98172_75896491',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_517bb0c1c98172_75896491')) {function content_517bb0c1c98172_75896491($_smarty_tpl) {?><form action="Function/server/safeBrowse/serviceManage.php" method="POST" id="setServiceManageForm"
    onSubmit="return false;">
    <table class="column_95">
    	<input type="hidden" <?php if ($_smarty_tpl->tpl_vars['httpStatus']->value==1){?> value="disable" <?php }else{ ?> value="enable" <?php }?> name="stopService" id="stopService"\>
        <caption>服务管理</caption>
        <tbody>
        <tr>
            <td class="tdheader" width="250">当前服务状态:</td>
            <td class="tdbody"><span id="status">
               <?php if ($_smarty_tpl->tpl_vars['httpStatus']->value==1){?>
               		启动
               <?php }else{ ?>
               		停止
               <?php }?></span>
            </td>
        </tr>

        <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
                <button type="button" name="buttonOn" class="inputbtn standard" onclick="setServiceForm()"
                	<?php if ($_smarty_tpl->tpl_vars['httpStatus']->value==1){?> disabled="disabled"<?php }?>>启动服务</button>
                <button type="button" name="buttonOff" class="inputbtn standard" onclick="setServiceForm()"
                	<?php if ($_smarty_tpl->tpl_vars['httpStatus']->value==0){?> disabled="disabled"<?php }?>>停止服务</button>
            </td>
        </tr>
        </tbody>
    </table>
</form>
<script type="text/javascript" src="Public/js/server/safeBrowse/serviceManage.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
});
</script><?php }} ?>