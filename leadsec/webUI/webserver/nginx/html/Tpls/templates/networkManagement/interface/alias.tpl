<{include file='layout/search.tpl'}>
  <table class="column_95 textMid tablesorter" id="aliasTable">
    <caption>
  	 别名设备
   </caption>
   <thead>
    <tr>
      <th class="column_10" name="external_name">设备名称</th>
      <th class="column_30" name="ip">地址/掩码</th>
      <th class="column_20" name="phy_device">绑定设备</th>
      <th class="column_10" name="alias_id">别名ID</th>
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
    <{include file='layout/pagination.tpl' func='Function/networkManagement/interface/alias.php'}>
</div>

<script type="text/javascript" src="Public/js/networkManagement/interface/alias.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/networkManagement/interface/alias.php', $('#aliasTable'), 'ORDER BY external_name ASC LIMIT 10');
        sortTableInit($('#aliasTable'), {4: {sorter: false}, 5: {sorter: false}});
    });
</script>
