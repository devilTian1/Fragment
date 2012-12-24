<{include file='layout/search.tpl' tableId='dataVisit_optionsTable'}>
<table class="column_95 textMid tablesorter" id="dataVisit_optionsTable">
    <caption>
           过滤选项集
    </caption>
    <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_20">名称</th>
      <th class="column_10">用户名过滤</th>
      <th class="column_10">SQL语句过滤</th>
      <th class="column_10">流病毒扫描</th>
      <th class="column_20">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
<tbody>
    <tr>
      <td colspan="7">Loading……</td>
    </tr>
</tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/addrBind/dataVisit_options.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addrBind/dataVisit_options.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addrBind/dataVisit_options.php', $('#dataVisit_optionsTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#dataVisit_optionsTable'), {6: {sorter: false}}, [[0,0]]);
    });
</script>