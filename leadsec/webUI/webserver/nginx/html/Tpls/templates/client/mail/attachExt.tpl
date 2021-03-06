<{include file='layout/search.tpl' colNames='name,value,comment'}>
<table class="column_95 textMid tablesorter" id="attachExtTable">
    <caption>
           附件扩展名
    </caption>
    <thead>
    <tr>
      <th class="column_10" name="id">序号</th>
      <th class="column_20" name="name">名称</th>
      <th class="column_30" name="value">附件扩展名</th>
      <th class="column_20" name="comment">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
   <tbody>
    <tr>
      <td colspan="5">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewAttachExtDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/mail/attachExt.php'}>
</div>
<script type="text/javascript" src="Public/js/client/mail/attachExt.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/mail/attachExt.php', $('#attachExtTable'), 'ORDER BY name ASC LIMIT 10');
        sortTableInit($('#attachExtTable'), {4: {sorter: false}}, [[1,0]]);
    });
</script>