<{include file='layout/search.tpl' colNames='name,allow,sqllist,comment'}>
<table class="column_95 textMid tablesorter" id="dataVisit_sqlTable">
 <caption>
   SQL语句过滤
 </caption>
<thead>
    <tr>
      <th class="column_20" name="name">名称</th>
      <th class="column_20" name="allow">过滤模式</th>
      <th class="column_20" name="sqllist">命令列表</th>
      <th class="column_20">备注</th>
      <th class="column_20">操作</th>
    </tr>
</thead>
<tbody>
    <tr>
      <td colspan="5">Loading... ...</td>
    </tr>
</tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/db/sqlFilter.php'}>
</div>
<script type="text/javascript" src="Public/js/client/db/sqlFilter.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/db/sqlFilter.php', $('#dataVisit_sqlTable'), 'ORDER BY name ASC LIMIT 10');
        sortTableInit($('#dataVisit_sqlTable'), {3: {sorter: false},4: {sorter: false}}, [[0,0]]);
    });
</script>
