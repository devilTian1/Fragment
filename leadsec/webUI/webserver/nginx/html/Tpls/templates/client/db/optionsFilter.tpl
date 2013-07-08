<{include file='layout/search.tpl' colNames='name,usergrp,sqlgrp,comment'}>
<table class="column_95 textMid tablesorter" id="dataVisit_optionsTable">
    <caption>
           过滤选项集
    </caption>
    <thead>
    <tr>
      <th class="column_10" name="id">序号</th>
      <th class="column_10" name="name">名称</th>
      <th class="column_10" name="usergrp">用户名过滤</th>
      <th class="column_10" name="sqlgrp">SQL语句过滤</th>
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
    onclick="openNewOptionsDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/db/optionsFilter.php'}>
</div>
<script type="text/javascript" src="Public/js/client/db/optionsFilter.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/db/optionsFilter.php', $('#dataVisit_optionsTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#dataVisit_optionsTable'), {4: {sorter: false},5: {sorter: false}}, [[0,0]]);
    });
</script>