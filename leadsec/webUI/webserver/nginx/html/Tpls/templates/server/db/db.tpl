<{include file='layout/search.tpl' colNames='id,dbtype,serverip,sport,comment'}>
<table class="column_95 textMid tablesorter" id="serverDbIdTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_10" name="id">任务号</th>
      <th class="column_15" name="dbtype">数据库类型</th>
      <th class="column_15" name="serverip">服务器地址</th>
      <th class="column_15" name="sport">服务器端口</th>
      <th class="column_15">是否启动</th>
      <th class="column_15">备注</th>
      <th class="column_15">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td colspan="7">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openDbDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/server/db/db.php'}>
</div>
<script type="text/javascript" src="Public/js/server/db/db.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/server/db/db.php', $('#serverDbIdTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#serverDbIdTable'), {4: {sorter: false},5: {sorter: false}}, [[0,0]]);
});
</script>