<{include file='layout/search.tpl' tableId='generalVisitTable'}>
<table class="column_95 textMid tablesorter" id="generalVisitTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_5" name="id">序号</th>
      <th class="column_10" name="sa">源地址</th>
      <th class="column_10" name="time">生效时段</th>
      <th class="column_5" name="comment">备注</th>
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
    onclick="openNewGeneralAccessCtrlDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/safeBrowse/generalVisit.php'}>
</div>
<script type="text/javascript" src="Public/js/client/safeBrowse/generalVisit.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/safeBrowse/generalVisit.php', $('#generalVisitTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#generalVisitTable'), {4: {sorter: false}}, [[0,0]]);
    });
</script>