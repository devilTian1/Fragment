<?php /* Smarty version Smarty-3.1.12, created on 2012-10-06 16:36:25
         compiled from "D:\WEB\PHP\APMServ5.2.6\www\htdocs\leadsec\tpls\templates\leftmenu.tpl" */ ?>
<?php /*%%SmartyHeaderCode:710850705e09b2b4c1-41303391%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '6660ac5bca2296686f56db72b72c7b1592b05348' => 
    array (
      0 => 'D:\\WEB\\PHP\\APMServ5.2.6\\www\\htdocs\\leadsec\\tpls\\templates\\leftmenu.tpl',
      1 => 1349501350,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '710850705e09b2b4c1-41303391',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'menu' => 0,
    'secondmenu' => 0,
    'submenu' => 0,
    'submenu2' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.12',
  'unifunc' => 'content_50705e09bd33a8_12663570',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_50705e09bd33a8_12663570')) {function content_50705e09bd33a8_12663570($_smarty_tpl) {?><?php  $_smarty_tpl->tpl_vars['secondmenu'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['secondmenu']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['menu']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['secondmenu']->key => $_smarty_tpl->tpl_vars['secondmenu']->value){
$_smarty_tpl->tpl_vars['secondmenu']->_loop = true;
?>
<div class="l1" name="<?php echo $_smarty_tpl->tpl_vars['secondmenu']->value['cfgname'];?>
">
    <span><?php echo $_smarty_tpl->tpl_vars['secondmenu']->value['name'];?>
</span>
</div>
<div class="l2" name="<?php echo $_smarty_tpl->tpl_vars['secondmenu']->value['cfgname'];?>
">
    <ul>
    	<?php  $_smarty_tpl->tpl_vars['submenu'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['submenu']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['secondmenu']->value['subMenu']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['submenu']->key => $_smarty_tpl->tpl_vars['submenu']->value){
$_smarty_tpl->tpl_vars['submenu']->_loop = true;
?>
        <li title="<?php echo $_smarty_tpl->tpl_vars['submenu']->value['cfgname'];?>
">
        	<a href="#"
            	 <?php if (count($_smarty_tpl->tpl_vars['submenu']->value['subMenu'])!=0){?> 
                    <?php  $_smarty_tpl->tpl_vars['submenu2'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['submenu2']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['submenu']->value['subMenu']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['submenu2']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['submenu2']->key => $_smarty_tpl->tpl_vars['submenu2']->value){
$_smarty_tpl->tpl_vars['submenu2']->_loop = true;
 $_smarty_tpl->tpl_vars['submenu2']->index++;
 $_smarty_tpl->tpl_vars['submenu2']->first = $_smarty_tpl->tpl_vars['submenu2']->index === 0;
 $_smarty_tpl->tpl_vars['smarty']->value['foreach']['foo']['first'] = $_smarty_tpl->tpl_vars['submenu2']->first;
?>
                        <?php if ($_smarty_tpl->getVariable('smarty')->value['foreach']['foo']['first']){?> title='<?php echo $_smarty_tpl->tpl_vars['submenu2']->value['cfgname'];?>
' <?php }?>
                    <?php } ?>
                    <?php }else{ ?> title=''<?php }?>
        
        ><?php echo $_smarty_tpl->tpl_vars['submenu']->value['name'];?>
</a></li>
        <?php } ?>
    </ul>
</div>
<?php } ?>
<script type="text/javascript">
    function showPageByAjax(groupName,liTitle,toHref) {
        $("#mainZone").html("loading... ...").load(groupName+".php?type="+liTitle+'&subtype='+toHref, { page : groupName+'/'+toHref}, function() {
            var contentH  = $("#mainZone>.mainContent").outerHeight();
            var leftmenuH = $("#leftmenu").outerHeight();
            contentH > leftmenuH ? $("#leftmenu").outerHeight(contentH) : $("#mainZone>.mainContent").outerHeight(leftmenuH);
            refreshTab();
            $("#clientTcp").tablesorter();
        });
    }
    $(document).ready(function() {
        $("#leftmenu a").click(function() {
            var toHref = $(this).attr("title");
			var liTitle=$(this).parents("li").attr("title");
            var groupName  = $(this).parents("div.l2").attr("name");
            $("#leftmenu a").removeClass("link");
            $(this).addClass("link");
            showPageByAjax(groupName,liTitle,toHref);
            return false;
        });
    });
</script>
<?php }} ?>