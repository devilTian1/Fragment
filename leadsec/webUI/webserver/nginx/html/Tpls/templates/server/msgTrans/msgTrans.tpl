<{include file='layout/search.tpl' tableId='msgTransTable'}>
<table class="column_95 textMid tablesorter" id="msgTransTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_10" name='id'>任务号</th>
      <th class="column_15" name='serip'>服务器地址</th>
      <th class="column_15" name='serport'>服务器端口</th>
      <th class="column_10" name='ssl'>认证/加密</th>
      <th class="column_10" name='backup'>本地备份</th>
      <th class="column_10" name='active'>是否启动</th>
      <th class="column_15">备注</th>
      <th class="column_15">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td colspan="8">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/server/msgTrans/msgTrans.php'}>
</div>

<script type="text/javascript" src="Public/js/server/msgTrans/msgTrans.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    freshTable('Function/server/msgTrans/msgTrans.php', $('#msgTransTable'), 'ORDER BY id ASC LIMIT 10');
    sortTableInit($('#msgTransTable'), {6: {sorter: false},7: {sorter: false}}, [[0,0]]);
});
</script>