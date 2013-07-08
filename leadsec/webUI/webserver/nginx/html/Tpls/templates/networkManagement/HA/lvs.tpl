<{include file='layout/search.tpl' tableId='lvsTables'}>
<table class="column_95 textMid tablesorter" id="lvsTables">
    <caption>
         负载均衡
    </caption>
   <thead><tr>
      <th class="column_10">序号</th>
      <th class="column_20">虚拟地址</th>
      <th class="column_10">端口</th>
      <th class="column_10">真实地址1</th>
      <th class="column_10">真实端口1</th>
      <th class="column_10">真实地址2</th>
      <th class="column_10">真实端口2</th>
      <th class="column_20">操作</th>
    </tr></thead>
    <tbody>
    <tr>
      <td>序号</td>
      <td>虚拟地址</td>
      <td>端口</td>
      <td>真实地址1</td>
      <td>真实端口1</td>
      <td>真实地址2</td>
      <td>真实端口2</td>
      <td><a href="#" class="edit" onclick="edituser()">编辑</a>&nbsp;&nbsp;&nbsp;<a href="#" class="delete" onclick="deluser()">删除</a></td>
    </tr>
    </tbody>
  </table>
  <button class="standard floatLeft" style="position: static"
    onclick="openNewLvsDialog()"
    id="addLvsTable">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/networkMangement/HA/lvs.php'}>
</div>
<script type="text/javascript" src="Public/js/networkMangement/HA/lvs.js"></script>
<script type="text/javascript">
$(document).ready(function() {
   renderStandardUi();
   freshTable('Function/networkMangement/HA/lvs.php', $('#lvsTables'), 'ORDER BY id ASC LIMIT 10');
   sortTableInit($('#lvsTables'), {3: {sorter: false}});
});
</script>