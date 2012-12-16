<{include file='layout/search.tpl' tableId='emailVisit_addrTable'}>
<table class="column_95 textMid tablesorter" id="emailVisit_addrTable">
 <caption>
   邮件地址
 </caption>
<thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_20">名称</th>
      <th class="column_20">允许通过的邮件地此</th>
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
    <{include file='layout/pagination.tpl' func='Function/resConf/addrBind/emailVisit_addr.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addrBind/emailVisit_addr.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addrBind/emailVisit_addr.php', $('#emailVisit_addrTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#emailVisit_addrTable'), {5: {sorter: false}}, [[0,0]]);
    });
</script>