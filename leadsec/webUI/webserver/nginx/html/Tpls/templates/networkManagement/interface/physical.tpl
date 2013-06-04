<{include file='layout/search.tpl'}>
<table class="column_95 textMid tablesorter" id="physicalTable">
 <caption>
     物理设备
 </caption>
   <thead><tr>
      <th class="column_15" name="external_name">设备名称</th>
      <th class="column_15" name="ip">地址/掩码</th>
      <th class="column_15" name="if_property">设备属性</th>
      <th class="column_15" name="ipaddr_type">地址获取</th>
      <th class="column_15" name="workmode">工作模式</th>
      <th class="column_15" name="enable">是否启用</th>
      <th class="column_10">操作</th>
    </tr></thead>
    <tbody>
    <tr>
     	<td colspan='7'>Loading ... ...</td>
    </tr>
    </tbody>
 </table>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/networkManagement/interface/physical.php'}>
</div>

<script type="text/javascript" src="Public/js/networkManagement/interface/physical.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    freshTable('Function/networkManagement/interface/physical.php', $('#physicalTable'), 'ORDER BY external_name ASC LIMIT 10');
    sortTableInit($('#physicalTable'), {6: {sorter: false}});
});
</script>
