<{include file='layout/search.tpl' colNames='name,value,type,comment'}>
<table class="column_95 textMid tablesorter" id="keywordTable">
    <caption>
           内容关键字
    </caption>
    <thead>
    <tr>
      <th class="column_10" name="id">序号</th>
      <th class="column_10" name="name">名称</th>
      <th class="column_35" name="value">内容关键字</th>
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
    onclick="openNewKeywordDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/mail/keyword.php'}>
</div>
<script type="text/javascript" src="Public/js/client/mail/keyword.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/mail/keyword.php', $('#keywordTable'), 'ORDER BY name ASC LIMIT 10');
        sortTableInit($('#keywordTable'), {5: {sorter: false}}, [[1,0]]);
    });
</script>