<table class="column_95 textMid tablesorter" id="physicalTable">
 <caption>
     物理设备
 </caption>
   <thead><tr>
   <th class="column_8" name="chk">选定</th>
      <th class="column_10" name="external_name">设备名称</th>
      <th class="column_15" name="ip">IP地址/掩码</th>
      <th class="column_15" name="workmode">工作模式</th>      
      <th class="column_15" name="ipaddr_type">IP地址获取</th>
      <th class="column_15" name="if_property">开启带宽管理</th>
      <th class="column_10" name="enable">是否启用</th>
      <th class="column_10">操作</th>
    </tr></thead>
    <tbody>
    <tr>
     	<td colspan='7'>Loading ... ...</td>
    </tr>
    </tbody>
 </table>
 <button class="standard floatLeft" style="position: static"  onclick="openStopDialog()"
    id="stopBtn">停止
</button>
<script type="text/javascript" src="Public/js/systemManagement/networkConf/interfaceConf/physical.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    freshTable('index.php?R=systemManagement/networkConf/interfaceConf/physical/showTable', $('#physicalTable'), 'ORDER BY external_name ASC LIMIT 10');
    sortTableInit($('#physicalTable'), {6: {sorter: false}});
});
</script>
