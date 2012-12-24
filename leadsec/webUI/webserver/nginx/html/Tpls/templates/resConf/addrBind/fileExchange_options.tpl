<{include file='layout/search.tpl' tableId='fileExchange_optionsTable'}>
<table class="column_95 textMid tablesorter" id="fileExchange_optionsTable">
    <caption>
           文件属性控制
    </caption>
    <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_10">名称</th>
      <th class="column_10">文件名控制</th>
      <th class="column_10">内容黑名单</th>
      <th class="column_20">内容白名单</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tr>
     <tr>
      <td colspan="6">Loading……</td>
    </tr>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/addrBind/fileExchange_options.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addrBind/fileExchange_options.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addrBind/fileExchange_options.php', $('#fileExchange_optionsTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#fileExchange_optionsTable'), {5: {sorter: false}}, [[0,0]]);
    });
</script>