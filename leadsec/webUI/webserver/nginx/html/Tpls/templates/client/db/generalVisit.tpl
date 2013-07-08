<{include file='layout/search.tpl'}>
<table class="column_95 textMid tablesorter" id="generalVisitTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_10" name="id">任务号</th>
      <th class="column_10" name="dbtype">数据库类型</th>
      <th class="column_10" name="sa">源地址</th>
      <th class="column_10" name="lip">本机地址</th>
      <th class="column_10" name="lport">本机端口</th>
      <th class="column_10" name="filter">过滤选项</th>
      <th class="column_10" >是否启动</th>
      <th class="column_10" name="time">生效时间</th>
      <th class="column_10" name="comment">备注</th>
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
    <{include file='layout/pagination.tpl' func='Function/client/db/generalVisit.php'}>
</div>
<script type="text/javascript" src="Public/js/client/db/optionsFilter.js"></script>
<script type="text/javascript" src="Public/js/client/db/generalVisit.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/db/generalVisit.php', $('#generalVisitTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#generalVisitTable'), {6: {sorter: false},9: {sorter: false}}, [[0,0]]);
    });
</script>