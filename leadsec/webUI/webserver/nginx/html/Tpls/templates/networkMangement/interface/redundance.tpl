<{include file='layout/search.tpl' tableId='redundanceTable'}>
<table class="column_95 textMid tablesorter" id="redundanceTable">
 <caption>
  	  冗余设备  
   </caption>
   <thead><tr>
      <th class="column_10">设备名称</th>
      <th class="column_20">IP地址/掩码</th>
      <th class="column_10">工作模式</th>
      <th class="column_15">IP地址获取</th>
      <th class="column_15">绑定设备列表</th>
      <th class="column_10">是否启用</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td colspan="7">
      Loading
      </td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewRedundanceDialog()"
    id="addRedundance">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/networkMangement/interface/redundance.php'}>
</div>
<script type="text/javascript" src="Public/js/networkMangement/interface/redundance.js"></script>
<script type="text/javascript">
$(document).ready(function() {
   renderStandardUi();
   $("#addRedundance").button();
   freshTable('Function/networkMangement/interface/redundance.php', $('#redundanceTable'), 'ORDER BY external_name ASC LIMIT 10');
   sortTableInit($('#redundanceTable'), {6: {sorter: false}});
});
</script>
