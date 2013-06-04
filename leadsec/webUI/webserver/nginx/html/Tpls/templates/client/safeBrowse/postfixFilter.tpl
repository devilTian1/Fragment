<{include file='layout/search.tpl'}>
<table class="column_95 textMid tablesorter" id="postfixFilterTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_30" name="list">文件名后缀</th>
      <th class="column_40" name="comment">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
   <tbody>
    <tr>
      <td colspan="4">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewPostfixFilterDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/safeBrowse/postfixFilter.php'}>
</div>
<script type="text/javascript" src="Public/js/client/safeBrowse/postfixFilter.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/safeBrowse/postfixFilter.php', $('#postfixFilterTable'), 'ORDER BY list ASC LIMIT 10');
        sortTableInit($('#postfixFilterTable'), {0: {sorter: false},3: {sorter: false}}, [[1,0]]);
    });
</script>