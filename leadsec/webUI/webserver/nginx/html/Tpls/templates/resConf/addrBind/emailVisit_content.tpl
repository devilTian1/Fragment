<{include file='layout/search.tpl' tableId='emailVisit_contentTable'}>
<table class="column_95 textMid tablesorter" id="emailVisit_contentTable">
 <caption>
   内容关键字
 </caption>
<thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_20">名称</th>
      <th class="column_20">内容关键字</th>
      <th class="column_10">类别</th>
      <th class="column_20">备注</th>
      <th class="column_20">操作</th>
    </tr>
</thead>
<tbody>
     <tr>
      <td colspan="6">Loading……</td>
    </tr>
</tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/addrBind/emailVisit_content.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addrBind/emailVisit_content.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addrBind/emailVisit_content.php', $('#emailVisit_contentTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#emailVisit_contentTable'), {5: {sorter: false}}, [[0,0]]);
    });
</script>