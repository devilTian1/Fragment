<{include file='layout/search.tpl' tableId='generalVisitTable'}>
<table class="column_95 textMid tablesorter" id="generalVisitTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_10">任务号</th>
      <th class="column_10">源地此</th>
      <th class="column_10">本机地此</th>
      <th class="column_10">本机端口</th>
      <th class="column_10">过滤选项</th>
      <th class="column_10">是否启动</th>
      <th class="column_10">生效时间</th>
      <th class="column_10">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
     <tbody>
    <tr>
      <td colspan="9">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/safeBrowse/generalVisit.php'}>
</div>
<script type="text/javascript" src="Public/js/client/safeBrowse/generalVisit.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/safeBrowse/generalVisit.php', $('#generalVisitTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#generalVisitTable'), {8: {sorter: false}}, [[0,0]]);
    });
</script>