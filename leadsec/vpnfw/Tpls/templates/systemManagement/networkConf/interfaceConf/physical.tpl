<{include file='layout/search.tpl' width=400 height=300
    dialogFunc="index.php?R=systemManagement/networkConf/interfaceConf/physical/openAdvSearchDialog"
    searchFunc="index.php?R=systemManagement/networkConf/interfaceConf/physical/freshTableAndPagination"
    tableDom="$('#physicalTable')" pageDom="$('div.pager')" }>

<table class="column_95 textMid tablesorter" id="physicalTable">
 <caption>
     物理设备
 </caption>
   <thead><tr>
      <th class="column_8" name="chk">
          <input class="checkAll" type="checkbox"
                    onClick="$(this).checkAll()"/>
      </th>
      <th class="column_10" name="0">设备名称</th>
      <th class="column_15" name="1">IP地址/掩码</th>
      <th class="column_15" name="3">工作模式</th>      
      <th class="column_15" name="4">IP地址获取</th>
      <th class="column_15" name="5">开启带宽管理</th>
      <th class="column_10" name="6">是否启用</th>
      <th class="column_10">操作</th>
    </tr></thead>
    <tbody>
    <tr>
     	<td colspan='7'>Loading ... ...</td>
    </tr>
    </tbody>
 </table>
 <button class="standard floatLeft" style="position: static" id="stopBtn"
  onclick="openBatchHandlerDialog('index.php?R=systemManagement/networkConf/interfaceConf/physical/batchStop','stop')">停止
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl'
        func="index.php?R=systemManagement/networkConf/interfaceConf/physical/freshTableAndPagination"}>
</div>
<script type="text/javascript" src="Public/js/systemManagement/networkConf/interfaceConf/physical.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    addAdvSearchData($("#advSearch"), [{name:4, value:1}, {name:5, value:1},{name:6, value:1}]);
    initTable('index.php?R=systemManagement/networkConf/interfaceConf/physical/showTable', $('#physicalTable'));
    sortTableInit($('#physicalTable'), [0,3,4,5,6,7],[[1,0]]);
});
</script>
