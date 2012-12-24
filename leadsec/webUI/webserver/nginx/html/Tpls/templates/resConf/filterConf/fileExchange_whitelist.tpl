<{include file='layout/search.tpl' tableId='fileExchange_whitelistTable'}>
<table class="column_95 textMid tablesorter" id="fileExchange_whitelistTable">
  <caption>
    内容白名单
  </caption>
  <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_20">名称</th>
      <th class="column_30">允许的内容</th>
      <th class="column_20">备注</th>
      <th class="column_20">操作</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td colspan="5">Loading……</td>
    </tr>
  </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/addrBind/fileExchange_whitelist.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addrBind/fileExchange_whitelist.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addrBind/fileExchange_whitelist.php', $('#fileExchange_whitelistTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#fileExchange_whitelistTable'), {5: {sorter: false}}, [[0,0]]);
    });
</script>