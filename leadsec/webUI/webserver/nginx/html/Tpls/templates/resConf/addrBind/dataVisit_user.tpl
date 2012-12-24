<{include file='layout/search.tpl' tableId='dataVisit_userTable'}>
<table class="column_95 textMid tablesorter" id="dataVisit_userTable">
 <caption>
   用户过滤
 </caption>
<thead>
    <tr>
      <th class="column_20">名称</th>
      <th class="column_20">用户名列表</th>
      <th class="column_20">过滤模式</th>
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
    <{include file='layout/pagination.tpl' func='Function/resConf/addrBind/dataVisit_user.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addrBind/dataVisit_user.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addrBind/dataVisit_user.php', $('#dataVisit_userTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#dataVisit_userTable'), {4: {sorter: false}}, [[0,0]]);
    });
</script>