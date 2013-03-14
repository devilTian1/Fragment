<{include file='layout/search.tpl' tableId='urlFilterTable'}>
<table class="column_95 textMid tablesorter" id="urlFilterTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_10" name="id">序号</th>
      <th class="column_30" name="list">URL</th>
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
    onclick="openNewUrlFilterDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/safeBrowse/urlFilter.php'}>
</div>
<script type="text/javascript" src="Public/js/client/safeBrowse/urlFilter.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/safeBrowse/urlFilter.php', $('#urlFilterTable'), 'ORDER BY list ASC LIMIT 10');
        sortTableInit($('#urlFilterTable'), {3: {sorter: false}}, [[1,0]]);
    });
</script>