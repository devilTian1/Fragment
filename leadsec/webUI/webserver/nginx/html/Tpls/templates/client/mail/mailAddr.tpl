<{include file='layout/search.tpl' tableId='mailAddrTable'}>
<table class="column_95 textMid tablesorter" id="mailAddrTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_10" name="id">序号</th>
      <th class="column_10" name="name">名称</th>
      <th class="column_35" name="value">邮件地址</th>
      <th class="column_10" name="type">类别</th>
      <th class="column_20" name="comment">备注</th>
      <th class="column_15">操作</th>
    </tr>
    </thead>
   <tbody>
    <tr>
      <td colspan="6">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewMailAddrDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/mail/mailAddr.php'}>
</div>
<script type="text/javascript" src="Public/js/client/mail/mailAddr.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/mail/mailAddr.php', $('#mailAddrTable'), 'ORDER BY name ASC LIMIT 10');
        sortTableInit($('#mailAddrTable'), {5: {sorter: false}}, [[1,0]]);
    });
</script>