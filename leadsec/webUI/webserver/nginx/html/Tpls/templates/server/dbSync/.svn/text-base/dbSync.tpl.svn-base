<{include file='layout/search.tpl' tableId='dbSyncServerTable'}>
<table class="column_95 textMid tablesorter" id="dbSyncServerTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_10" name="id">任务号</th>
      <th class="column_20">服务器地址</th>
      <th class="column_10">服务器端口</th>
      <th class="column_10">认证/加密</th>
      <th class="column_10">公共名</th>
      <th class="column_10">是否启动</th>
      <th class="column_10">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td colspan="11">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/server/dbSync/dbSync.php'}>
</div>
<script type="text/javascript" src="Public/js/server/dbSync/dbSync.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/server/dbSync/dbSync.php', $('#dbSyncServerTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#dbSyncServerTable'), {10: {sorter: false}}, [[0,0]]);
    });
});
</script>