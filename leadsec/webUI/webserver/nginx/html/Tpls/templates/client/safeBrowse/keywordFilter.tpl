<{include file='layout/search.tpl'}>
<table class="column_95 textMid tablesorter" id="keywordFilterTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_15" name="name">名称</th>
      <th class="column_30" name="context">禁止以下内容</th>
      <th class="column_30" name="comment">备注</th>
      <th class="column_15">操作</th>
    </tr>
    </thead>
   <tbody>
    <tr>
      <td colspan="4">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewKeywordFilterDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/safeBrowse/keywordFilter.php'}>
</div>
<script type="text/javascript" src="Public/js/client/safeBrowse/keywordFilter.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/safeBrowse/keywordFilter.php', $('#keywordFilterTable'), 'ORDER BY name ASC LIMIT 10');
        sortTableInit($('#keywordFilterTable'), {0: {sorter: false},4: {sorter: false}}, [[1,0]]);
    });
</script>