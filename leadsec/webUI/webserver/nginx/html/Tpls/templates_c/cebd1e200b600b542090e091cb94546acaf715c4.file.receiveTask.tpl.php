<?php /* Smarty version Smarty-3.1.11, created on 2013-05-08 08:22:09
         compiled from "D:\leadsec\Fragment\leadsec\webUI\webserver\nginx\html\Tpls\templates\server\fileEx\receiveTask.tpl" */ ?>
<?php /*%%SmartyHeaderCode:12425518a0b31cb31c0-47691452%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'cebd1e200b600b542090e091cb94546acaf715c4' => 
    array (
      0 => 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Tpls\\templates\\server\\fileEx\\receiveTask.tpl',
      1 => 1366726990,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '12425518a0b31cb31c0-47691452',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_518a0b31d10938_31982820',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_518a0b31d10938_31982820')) {function content_518a0b31d10938_31982820($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('layout/search.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array('tableId'=>'receiveTaskTable'), 0);?>

<table class="column_95 textMid tablesorter" id="receiveTaskTable">
    <caption>信息列表</caption>
    <thead>
        <tr>
            <th class="column_20" name="task_id">任务号</th>
            <th class="column_20" name="ip">服务器地址</th>
            <th class="column_20" name="share_name">服务器共享名</th>
            <th class="column_20" name="fs">文件系统</th>
            <th class="column_10" name="active">是否启动</th>
            <th class="column_10">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="6">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewReceiveTaskDialog()">添加
</button>
<div class="pager floatRight">
    <?php echo $_smarty_tpl->getSubTemplate ('layout/pagination.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array('func'=>'Function/server/fileEx/receiveTask.php'), 0);?>

</div>
<script type="text/javascript" src="Public/js/server/fileEx/receiveTask.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/server/fileEx/receiveTask.php',
            $('#receiveTaskTable'), 'ORDER BY task_id ASC LIMIT 10');
        sortTableInit($('#receiveTaskTable'), {5: {sorter: false}}, [[0,0]]);
    });
</script>
<?php }} ?>