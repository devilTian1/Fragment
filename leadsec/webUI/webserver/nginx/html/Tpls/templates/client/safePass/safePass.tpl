<{include file='layout/search.tpl'}>
<table class="column_95 textMid tablesorter" id="safePassTable">
    <caption>
       信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_5" name="id">任务号</th>
      <th class="column_8" name="samenet">访问类型</th>
      <th class="column_10" name="sa">源地址</th>
      <th class="column_8" name="sport">源端口</th>
      <th class="column_10" name="da">目的地址</th>
      <th class="column_8" name="dport">目的端口</th>
      <th class="column_10" name="service">服务类型</th>
      <th class="column_10" name="time">生效时间</th>
      <th class="column_8" name="active">是否启动</th>      
      <th class="column_13" name="comment">备注</th>
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
    onclick="openNewSafePassDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/safePass/safePass.php'}>
</div>
<script type="text/javascript" src="Public/js/client/safePass/safePass.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/safePass/safePass.php', $('#safePassTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#safePassTable'), {10: {sorter: false}}, [[0,0]]);
    });
</script>