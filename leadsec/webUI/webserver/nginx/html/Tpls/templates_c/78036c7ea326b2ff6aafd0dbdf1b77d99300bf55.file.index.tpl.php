<?php /* Smarty version Smarty-3.1.11, created on 2013-07-08 18:57:55
         compiled from "D:\leadsec\Fragment\leadsec\webUI\webserver\nginx\html\Tpls\templates\index.tpl" */ ?>
<?php /*%%SmartyHeaderCode:2775851da9b3367f755-77005321%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '78036c7ea326b2ff6aafd0dbdf1b77d99300bf55' => 
    array (
      0 => 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Tpls\\templates\\index.tpl',
      1 => 1373278812,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2775851da9b3367f755-77005321',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'hostStatus' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_51da9b336f1bd7_61263161',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_51da9b336f1bd7_61263161')) {function content_51da9b336f1bd7_61263161($_smarty_tpl) {?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <?php echo $_smarty_tpl->getSubTemplate ('layout/css.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

    </head>
    <body>
        <div class="wrapper">
            <div id="header">
            <?php echo $_smarty_tpl->getSubTemplate ('layout/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

            </div>
            <!-- NAV & CONTENT -->
            <div class="content" id="content">
                <div class="secondary">
                    <!-- leftmenuinfo -->
                    <div id="leftmenutop">
                    	<strong>安全隔离网闸<?php echo $_smarty_tpl->tpl_vars['hostStatus']->value;?>
</strong>
                    </div>
                    <!-- leftmenu -->
                    <div id="leftmenu">
                    <?php echo $_smarty_tpl->getSubTemplate ('layout/leftmenu.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

                    </div>
                    <!-- switch btn -->
                    <div class="switchpic">
                        <img src="<?php echo @THEME_PATH;?>
/images/switch_left.gif" title="隐藏左侧导航栏" id="ImgArrow"/>
                    </div>
                </div>
                <!-- content -->
                <div class="primary" id="mainZone">
                    <div id="tab">
                        <?php echo $_smarty_tpl->getSubTemplate ("layout/tabs.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

                    </div>
                    <div id="mainContentTop">
                        <div id="mainContent">
                            <?php echo $_smarty_tpl->getSubTemplate ('layout/content.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

                        </div>
                    </div>
                </div>
            </div>
            <div class="clearFloat"></div>
            <!-- FOOTER -->
            <div class="footer">
                <div class="bottom">@ 2010-2020 <?php echo @COMPANY_NAME;?>
版权所有</div>
            </div>
        </div>
    </body>
</html>
<?php echo $_smarty_tpl->getSubTemplate ('layout/js.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

<?php }} ?>