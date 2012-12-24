<{include file='layout/search.tpl' tableId='staticRouteTable'}>
<table class="column_95 textMid tablesorter" id="staticRouteTable">
	<caption>
       静态路由
    </caption>
    <thead>
    <tr>
      <th class="column_30" name="destip">目的地址</th>
      <th class="column_20" name="nexthopip">下一跳</th>
      <th class="column_20" name="interface">网络接口</th>
      <th class="column_10" name="active">是否启用</th>
      <th class="column_20">操作</th>
    </tr></thead>
    <tbody>
        <td colspan='5'>Loading……</td>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewStaticRouteDialog()"
    id="addStaticRouteTable">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/networkMangement/basic/staticRoute.php'}>
</div>
<script type="text/javascript" src="Public/js/networkMangement/basic/staticRoute.js"></script>
<script type="text/javascript">
$(document).ready(function() {
   renderStandardUi();
   $("#addStaticRouteTable").button();
   freshTable('Function/networkMangement/basic/staticRoute.php', $('#staticRouteTable'), 'ORDER BY id ASC LIMIT 10');
   sortTableInit($('#staticRouteTable'), {4: {sorter: false}});
});
</script>