<{include file='layout/search.tpl' tableId='udpTransVisitTable'}>
<table class="column_95 textMid tablesorter" id="udpTransVisitTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_10">任务号</th>
      <th class="column_10">源地此</th>
      <th class="column_10">目的地此</th>
      <th class="column_10">目的端口</th>
      <th class="column_10">是否启动</th>
      <th class="column_10">生效时间</th>
      <th class="column_20">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td colspan="8">Loading……</td>
    </tr>
    </tbody>
  </table>
  <button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/customized/udpTransVisit.php'}>
</div>
<script type="text/javascript" src="Public/js/client/customized/udpTransVisit.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/customized/udpTransVisit.php', $('#udpTransVisitTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#udpTransVisitTable'), {7: {sorter: false}}, [[0,0]]);
    });
</script>