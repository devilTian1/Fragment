<{include file='layout/search.tpl'}>
<table class="column_95 textMid tablesorter" id="dbSyncTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_8" name = "id">任务号</th>
      <th class="column_8" name = "sa">源地址</th>
      <th class="column_8" name = "lip">本机地址</th>
      <th class="column_8" name = "lport">本地端口</th>
      <th class="column_8" >认证/加密</th>
      <th class="column_8" name = "commname">公共名</th>
      <th class="column_8">病毒扫描</th>
      <th class="column_8">是否启动</th>
      <th class="column_8">生效时间</th>
      <th class="column_10" name = "comment">备注</th>
      <th class="column_10">操作</th>
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
    <{include file='layout/pagination.tpl' func='Function/client/dbSync/dbSync.php'}>
</div>
<script type="text/javascript" src="Public/js/client/dbSync/dbSync.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/dbSync/dbSync.php', $('#dbSyncTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#dbSyncTable'), {7: {sorter: false}, 10: {sorter: false}},[[1,0]]);
    });
</script>