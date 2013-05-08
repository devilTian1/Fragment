<?php /* Smarty version Smarty-3.1.11, created on 2013-05-08 08:22:11
         compiled from "D:\leadsec\Fragment\leadsec\webUI\webserver\nginx\html\Tpls\templates\server\fileEx\shareDir.tpl" */ ?>
<?php /*%%SmartyHeaderCode:26799518a0b33173b89-86929322%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a1a8e065db886108f2320f32973bcd2a6561c27e' => 
    array (
      0 => 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Tpls\\templates\\server\\fileEx\\shareDir.tpl',
      1 => 1366726990,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '26799518a0b33173b89-86929322',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_518a0b331bc862_62140708',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_518a0b331bc862_62140708')) {function content_518a0b331bc862_62140708($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('layout/search.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array('tableId'=>'shareDirTable'), 0);?>

<table class="column_95 textMid tablesorter" id="shareDirTable">
    <caption>信息列表</caption>
    <thead>
        <tr>
            <th class="column_10" name="task_id">任务号</th>
            <th class="column_20" name="mode">发送/接受</th>
            <th class="column_20" name="ip">服务器IP</th>
            <th class="column_20" name="share_name">服务器共享名</th>
            <th class="column_20" name="fs">文件系统</th>
            <th class="column_10">详情</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="6">Loading... ...</td>
        </tr>
    </tbody>
</table>
<div class="pager floatRight">
    <?php echo $_smarty_tpl->getSubTemplate ('layout/pagination.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array('func'=>'Function/server/fileEx/shareDir.php'), 0);?>

</div>
<script type="text/javascript" src="Public/js/server/fileEx/shareDir.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/server/fileEx/shareDir.php',
            $('#shareDirTable'), 'ORDER BY task_id ASC LIMIT 10');
        sortTableInit($('#shareDirTable'), {5: {sorter: false}}, [[0,0]]);
    });
</script>
<?php }} ?>