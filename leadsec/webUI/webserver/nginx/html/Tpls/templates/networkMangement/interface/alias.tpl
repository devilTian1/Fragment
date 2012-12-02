<{include file='layout/search.tpl' tableId='aliasTable'}>
  <table class="column_95 textMid tablesorter" id="aliasTable">
    <caption>
  	 别名设备
   </caption>
   <thead>
    <tr>
      <th class="column_10">设备名称</th>
      <th class="column_30">地址/掩码</th>
      <th class="column_20">绑定设备</th>
      <th class="column_10">别名ID</th>
      <th class="column_10">是否启用</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
     <tr>
        <td colspan='6'>Loading ... ...</td>
     </tr>
    </tbody>
  </table>
  <button class="standard floatLeft" style="position: static"
    onclick="openNewAliasDialog()"
    id="addAlias">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/networkMangement/interface/alias.php'}>
</div>

<script type="text/javascript" src="Public/js/networkMangement/interface/alias.js"></script>
<script type="text/javascript">
$(document).ready(function() {
   renderStandardUi();
   $("#addAlias").button();
   freshTable('Function/networkMangement/interface/alias.php', $('#aliasTable'), 'ORDER BY external_name ASC LIMIT 10');
   sortTableInit($('#aliasTable'), {5: {sorter: false}});
});
</script>