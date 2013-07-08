<?php /* Smarty version Smarty-3.1.11, created on 2013-07-08 18:57:55
         compiled from "D:\leadsec\Fragment\leadsec\webUI\webserver\nginx\html\Tpls\templates\layout\tabs.tpl" */ ?>
<?php /*%%SmartyHeaderCode:2495451da9b33981eb6-99780128%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c75d7309e8534eda99d1c2da9ab4f0161c4599d4' => 
    array (
      0 => 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Tpls\\templates\\layout\\tabs.tpl',
      1 => 1370567940,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2495451da9b33981eb6-99780128',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'tabinfo' => 0,
    'seq' => 0,
    'tabnum' => 0,
    't' => 0,
    'tabs' => 0,
    'tab' => 0,
    'baseurl' => 0,
    'modStat' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_51da9b33aa6d95_26591536',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_51da9b33aa6d95_26591536')) {function content_51da9b33aa6d95_26591536($_smarty_tpl) {?><div class="tabinfo">
    <div class="tabinfo_left"></div>
    <div class="tabinfo_cen" id="tabinfo_cen"><strong>当前位置：</strong>
    	<?php  $_smarty_tpl->tpl_vars['t'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['t']->_loop = false;
 $_smarty_tpl->tpl_vars['seq'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['tabinfo']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['t']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['t']->key => $_smarty_tpl->tpl_vars['t']->value){
$_smarty_tpl->tpl_vars['t']->_loop = true;
 $_smarty_tpl->tpl_vars['seq']->value = $_smarty_tpl->tpl_vars['t']->key;
 $_smarty_tpl->tpl_vars['t']->index++;
?>
        <span
        <?php if ($_smarty_tpl->tpl_vars['seq']->value!=(($tmp = @$_smarty_tpl->tpl_vars['tabnum']->value)===null||$tmp==='' ? 0 : $tmp)){?>
            class="hide"
        <?php }?>
        id="show_text<?php echo $_smarty_tpl->tpl_vars['t']->index;?>
">
        <?php echo $_smarty_tpl->tpl_vars['t']->value['breadCrumbs'];?>
&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $_smarty_tpl->tpl_vars['t']->value['note'];?>

        </span>
    <?php } ?>
    </div>
    <div class="tabinfo_right"></div>
</div>
<div class="tabs">
     <ul>
        <?php if (!isset($_smarty_tpl->tpl_vars['tabs']->value)){?>
            <?php $_smarty_tpl->tpl_vars['tabinfo'] = new Smarty_variable(array(1,2,3,4), null, 0);?>
            <li class="visitedTab">1</li>
            <li>2</li>
            <li>3</li>
            <li>4</li>
            <li>5</li>
        <?php }else{ ?>
            <?php  $_smarty_tpl->tpl_vars['tab'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['tab']->_loop = false;
 $_smarty_tpl->tpl_vars['seq'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['tabs']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['tab']->key => $_smarty_tpl->tpl_vars['tab']->value){
$_smarty_tpl->tpl_vars['tab']->_loop = true;
 $_smarty_tpl->tpl_vars['seq']->value = $_smarty_tpl->tpl_vars['tab']->key;
?>
                <li
                <?php if ($_smarty_tpl->tpl_vars['seq']->value==(($tmp = @$_smarty_tpl->tpl_vars['tabnum']->value)===null||$tmp==='' ? 0 : $tmp)){?>
                    class="visitedTab"
                <?php }?>
                name="<?php echo $_smarty_tpl->tpl_vars['tab']->value['link'];?>
" title="<?php echo $_smarty_tpl->tpl_vars['tab']->value['title'];?>
"
                onClick="freshModStat('<?php echo $_smarty_tpl->tpl_vars['baseurl']->value;?>
', '<?php echo $_smarty_tpl->tpl_vars['tab']->value['link'];?>
');showPageByAjax('<?php echo ((($_smarty_tpl->tpl_vars['baseurl']->value).('/')).($_smarty_tpl->tpl_vars['tab']->value['link'])).('.php');?>
')">
                <?php echo $_smarty_tpl->tpl_vars['tab']->value['name'];?>

                </li>
            <?php } ?>
        <?php }?>
    </ul>
    <?php if ($_smarty_tpl->tpl_vars['modStat']->value['active']=='on'){?>
        <span name="modechk|<?php echo $_smarty_tpl->tpl_vars['modStat']->value['mod'];?>
|<?php echo $_smarty_tpl->tpl_vars['modStat']->value['serv'];?>
"
            id="modechk" class="modelchk_on"
            onClick="switchModStat()"></span>
    <?php }elseif($_smarty_tpl->tpl_vars['modStat']->value['active']=='off'){?>
        <span name="modechk|<?php echo $_smarty_tpl->tpl_vars['modStat']->value['mod'];?>
|<?php echo $_smarty_tpl->tpl_vars['modStat']->value['serv'];?>
"
            id="modechk" class="modelchk_off"
            onClick="switchModStat()"></span>
    <?php }?>
</div>
<script type="text/javascript">
    <?php if (isset($_smarty_tpl->tpl_vars['tabs']->value)&&count($_smarty_tpl->tpl_vars['tabs']->value)!=0){?>
        showPageByAjax("<?php echo ((($_smarty_tpl->tpl_vars['baseurl']->value).('/')).($_smarty_tpl->tpl_vars['tabs']->value[(($tmp = @$_smarty_tpl->tpl_vars['tabnum']->value)===null||$tmp==='' ? 0 : $tmp)]['link'])).('.php');?>
");
    <?php }?>
    var mainZoneWidth=document.getElementById("mainZone").scrollWidth;
    document.getElementById("tabinfo_cen").style.width=(mainZoneWidth-200)+"px";
    <?php if ($_smarty_tpl->tpl_vars['modStat']->value['active']=='on'){?>
        $("#modechk").attr("title","点击后将关闭服务");
        $("#modechk").tooltip();
    <?php }elseif($_smarty_tpl->tpl_vars['modStat']->value['active']=='off'){?>
        $("#modechk").attr("title","点击后将启动服务");
        $("#modechk").tooltip();
    <?php }?>    
</script>
<?php }} ?>