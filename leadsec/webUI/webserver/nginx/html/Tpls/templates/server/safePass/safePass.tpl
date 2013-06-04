<{include file='layout/search.tpl'}>
<table class="column_95 textMid tablesorter" id="safePassServerTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_10" name="id">任务号</th>
      <th class="column_10" name="sip">服务器地址</th>
      <th class="column_10" name="sport">服务器端口</th>
      <th class="column_15" name="eip">流出网口IP</th>
      <th class="column_10" name="service">服务类型</th>
      <th class="column_10" name="active">是否启动</th>
      <th class="column_15" name="comment">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
   <tbody>
    <tr>
      <td colspan="8">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="floatLeft standard"  style="position: static" onClick="openNewSafePassDialog()">添加</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/server/safePass/safePass.php'}>
</div>
<script type="text/javascript" src="Public/js/server/safePass/safePass.js"></script>
<script type="text/javascript">
$(document).ready(function() {
        renderStandardUi();
        freshTable('Function/server/safePass/safePass.php', $('#safePassServerTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#safePassServerTable'), {7: {sorter: false}}, [[0,0]]);
});
</script>