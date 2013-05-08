<?php /* Smarty version Smarty-3.1.11, created on 2013-05-08 08:22:14
         compiled from "D:\leadsec\Fragment\leadsec\webUI\webserver\nginx\html\Tpls\templates\server\customized\tcp.tpl" */ ?>
<?php /*%%SmartyHeaderCode:19525518a0b36f0a681-75833805%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'e28c5b0c89614617cf614ec4ace116b42aa53d3e' => 
    array (
      0 => 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Tpls\\templates\\server\\customized\\tcp.tpl',
      1 => 1366726990,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '19525518a0b36f0a681-75833805',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_518a0b370d20c9_57890539',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_518a0b370d20c9_57890539')) {function content_518a0b370d20c9_57890539($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('layout/search.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array('tableId'=>'tcpCommServerTable'), 0);?>

<table class="column_95 textMid tablesorter" id="tcpCommServerTable">
    <caption>信息列表</caption>
    <thead>
        <tr>
            <th class="column_10" name="id">任务号</th>
            <th class="column_20" name="serverip">服务器地址</th>
            <th class="column_10" name="sport">服务器端口</th>
            <th class="column_10" name="active">是否启动</th>
            <th class="column_30" name="comment">备注</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="6">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onClick="openNewTcpCommServerAclDialog()">添加</button>
<div class="pager floatRight">
    <?php echo $_smarty_tpl->getSubTemplate ('layout/pagination.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array('func'=>'Function/server/customized/tcp.php'), 0);?>

</div>
<script type="text/javascript" src="Public/js/server/customized/tcp.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/server/customized/tcp.php',
            $('#tcpCommServerTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#tcpCommServerTable'), {5: {sorter: false}}, [[0,0]]);
    });
</script>
<?php }} ?>