<{include file='layout/search.tpl' tableId='dataVisit_userTable'}>
<table class="column_95 textMid tablesorter" id="dataVisit_userTable">
 <caption>
   用户过滤
 </caption>
<thead>
    <tr>
      <th class="column_10" name="name">名称</th>
      <th class="column_60" name="usrnamelist">用户名列表</th>
      <th class="column_10" name="allow">过滤模式</th>
      <th class="column_10">备注</th>
      <th class="column_10">操作</th>
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
    <{include file='layout/pagination.tpl' func='Function/client/db/userFilter.php'}>
</div>
<script type="text/javascript" src="Public/js/client/db/userFilter.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/db/userFilter.php', $('#dataVisit_userTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#dataVisit_userTable'), {3: {sorter: false},4: {sorter: false}}, [[0,0]]);
    });
</script>