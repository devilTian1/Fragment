<table class="column_95">
  <tr>
    <td class="tdheader" width="200">ORACLE数据通道IP地址:</td>
    <td class="tdbody"><select name="select3" class="w200"></select></td>
  </tr>
</table>
<{include file='layout/search.tpl' tableId='transVisitTable'}>
<table class="column_95 textMid tablesorter" id="transVisitTable">
<caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_10">任务号</th>
      <th class="column_10">数据库类型</th>
      <th class="column_10">源地此</th>
      <th class="column_10">目的地此</th>
      <th class="column_10">目的端口</th>
      <th class="column_10">过滤选项</th>
      <th class="column_10">是否启动</th>
      <th class="column_10">生效时间</th>
      <th class="column_10">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td colspan="10">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/db/transVisit.php'}>
</div>
<script type="text/javascript" src="Public/js/client/db/transVisit.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/db/transVisit.php', $('#transVisitTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#transVisitTable'), {9: {sorter: false}}, [[0,0]]);
    });
</script>