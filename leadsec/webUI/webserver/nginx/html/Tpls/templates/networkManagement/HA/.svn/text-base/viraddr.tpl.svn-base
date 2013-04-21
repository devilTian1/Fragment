<{include file='layout/search.tpl' tableId='viraddrTable'}>
<table class="column_95 textMid tablesorter" id="viraddrTable">
	<caption>
       虚拟地此
    </caption>
    <thead>
    <tr>
      <th class="column_10" name="destip">序号</th>
      <th class="column_30" name="nexthopip">网络接口</th>
      <th class="column_40" name="interface">虚拟地此/掩码</th>
      <th class="column_20">操作</th>
    </tr></thead>
    <tbody>
        <td colspan='4'>Loading……</td>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewViraddrDialog()"
    id="addViraddrTable">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/networkMangement/HA/viraddr.php'}>
</div>
<script type="text/javascript" src="Public/js/networkMangement/HA/viraddr.js"></script>
<script type="text/javascript">
$(document).ready(function() {
   renderStandardUi();
   $("#addViraddrTable").button();
   freshTable('Function/networkMangement/HA/viraddr.php', $('#viraddrTable'), 'ORDER BY id ASC LIMIT 10');
   sortTableInit($('#viraddrTable'), {3: {sorter: false}});
});
</script>