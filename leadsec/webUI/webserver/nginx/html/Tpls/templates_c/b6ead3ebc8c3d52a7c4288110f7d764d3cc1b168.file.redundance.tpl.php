<?php /* Smarty version Smarty-3.1.11, created on 2013-05-08 08:22:06
         compiled from "D:\leadsec\Fragment\leadsec\webUI\webserver\nginx\html\Tpls\templates\networkManagement\interface\redundance.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1298518a0b2e8ad649-65576204%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'b6ead3ebc8c3d52a7c4288110f7d764d3cc1b168' => 
    array (
      0 => 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Tpls\\templates\\networkManagement\\interface\\redundance.tpl',
      1 => 1366726990,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1298518a0b2e8ad649-65576204',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_518a0b2e910d34_50567751',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_518a0b2e910d34_50567751')) {function content_518a0b2e910d34_50567751($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('layout/search.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array('tableId'=>'redundanceTable'), 0);?>

<table class="column_95 textMid tablesorter" id="redundanceTable">
    <caption>冗余设备</caption>
    <thead>
        <tr>
            <th class="column_10" name="external_name">设备名称</th>
            <th class="column_20" name="ip">IP地址/掩码</th>
            <th class="column_10" name="workmode">工作模式</th>
            <th class="column_15" name="ipaddr_type">IP地址获取</th>
            <th class="column_15" name="interface_list">绑定设备列表</th>
            <th class="column_10">是否启用</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="7">Loading</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openSetWorkModeDialog()"
    id="workModeSet">高级设置
</button>
<button class="standard floatLeft" style="position: static"
    onclick="openNewRedundanceDevDialog()"
    id="addRedundance">添加
</button>
<div class="pager floatRight">
    <?php echo $_smarty_tpl->getSubTemplate ('layout/pagination.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array('func'=>'Function/networkManagement/interface/redundance.php'), 0);?>

</div>
<script type="text/javascript" src="Public/js/networkManagement/interface/redundance.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/networkManagement/interface/redundance.php',
            $('#redundanceTable'), 'ORDER BY external_name ASC LIMIT 10');
        sortTableInit($('#redundanceTable'),
            {5: {sorter: false}, 6: {sorter: false}});
    });
</script>
<?php }} ?>