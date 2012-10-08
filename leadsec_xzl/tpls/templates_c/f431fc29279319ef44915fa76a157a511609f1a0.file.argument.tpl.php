<?php /* Smarty version Smarty-3.1.12, created on 2012-10-06 16:37:36
         compiled from "D:\WEB\PHP\APMServ5.2.6\www\htdocs\leadsec\tpls\templates\systemManagement\conf\argument.tpl" */ ?>
<?php /*%%SmartyHeaderCode:959250705e0c829f71-34686787%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f431fc29279319ef44915fa76a157a511609f1a0' => 
    array (
      0 => 'D:\\WEB\\PHP\\APMServ5.2.6\\www\\htdocs\\leadsec\\tpls\\templates\\systemManagement\\conf\\argument.tpl',
      1 => 1349541440,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '959250705e0c829f71-34686787',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.12',
  'unifunc' => 'content_50705e0c8bce11_61340227',
  'variables' => 
  array (
    'tabmenu' => 0,
    'subtype' => 0,
    'limenu' => 0,
    'mainmenu' => 0,
    'typemenu' => 0,
    'picmenu' => 0,
    'label_0' => 0,
    'hostname' => 0,
    'explain_0' => 0,
    'btn_0' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_50705e0c8bce11_61340227')) {function content_50705e0c8bce11_61340227($_smarty_tpl) {?><!-- tabs -->
<div class="tabs">
    <ul>
     <?php  $_smarty_tpl->tpl_vars['limenu'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['limenu']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['tabmenu']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['limenu']->key => $_smarty_tpl->tpl_vars['limenu']->value){
$_smarty_tpl->tpl_vars['limenu']->_loop = true;
?>
       		<?php if ($_smarty_tpl->tpl_vars['subtype']->value==$_smarty_tpl->tpl_vars['limenu']->value['cfgname']){?>
       			<li class='visitedTab' title="<?php echo $_smarty_tpl->tpl_vars['mainmenu']->value;?>
__<?php echo $_smarty_tpl->tpl_vars['typemenu']->value;?>
__<?php echo $_smarty_tpl->tpl_vars['limenu']->value['cfgname'];?>
">
             <?php }else{ ?>
             	<li title="<?php echo $_smarty_tpl->tpl_vars['mainmenu']->value;?>
__<?php echo $_smarty_tpl->tpl_vars['typemenu']->value;?>
__<?php echo $_smarty_tpl->tpl_vars['limenu']->value['cfgname'];?>
">
            <?php }?>
            	<?php echo $_smarty_tpl->tpl_vars['limenu']->value['name'];?>

            	</li>
      <?php } ?>
    </ul>
</div>
<div class="tabinfo">
    &nbsp;&nbsp;<img src="images/hi.gif" />&nbsp;
    <span id="show_text"><?php echo $_smarty_tpl->tpl_vars['picmenu']->value;?>
</span>
</div>
<br class="clearFloat"/>
<!-- mainContent -->
<div class="mainContent">
 <table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <tr>
      <td width="18%"><?php echo $_smarty_tpl->tpl_vars['label_0']->value;?>
:</td>
      <td width="82%"><input type="text" name="inputtext" id="hostname" value="<?php echo $_smarty_tpl->tpl_vars['hostname']->value;?>
"/>&nbsp;&nbsp;&nbsp;( <?php echo $_smarty_tpl->tpl_vars['explain_0']->value;?>
 )</td>
    </tr>
    <tr>
      <td></td>
      <td><input name="°´Å¥" type="button" value="<?php echo $_smarty_tpl->tpl_vars['btn_0']->value;?>
" width="50" id="ti_btn" /></td>
    </tr>
  </table>
</div>
<script type="text/javascript">
 $(document).ready(function() {
	$('#ti_btn').click(function(){
		var hostname=$.trim($('#hostname').val());
		$.get("control/system.php?act=hostname",{ hostname: hostname},
				  function(data){
					alert(data);
				  });
								
	})
 })
</script>

<?php }} ?>