<{include file='layout/search.tpl' tableId='physicalTable'}>
<table class="column_95 textMid tablesorter" id="physicalTable">
 <caption>
     物理设备
 </caption>
   <thead><tr>
      <th class="column_10" name="external_name">设备名称</th>
      <th class="column_20" name="ip">地址/掩码</th>
      <th class="column_20" name="if_property">设备属性</th>
      <th class="column_20" name="ipaddr_type">地址获取</th>
      <th class="column_10" name="enable">是否启用</th>
      <th class="column_20">操作</th>
    </tr></thead>
    <tbody>
    <tr>
     	<td colspan='6'>Loading ... ...</td>
    </tr>
    </tbody>
 </table>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/networkMangement/interface/physical.php'}>
</div>

<script type="text/javascript" src="Public/js/networkMangement/interface/physical.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    freshTable('Function/networkMangement/interface/physical.php', $('#physicalTable'), 'ORDER BY external_name ASC LIMIT 10');
    sortTableInit($('#physicalTable'), {5: {sorter: false}});
});
</script>
