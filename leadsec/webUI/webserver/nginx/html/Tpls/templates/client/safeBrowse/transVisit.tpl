<{include file='layout/search.tpl' tableId='transVisitTable'}>
<table class="column_95 textMid tablesorter" id="transVisitTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_5" name="id">序号</th>
      <th class="column_10" name="sa">源地址</th>
      <th class="column_10" name="da">目的地址</th>
      <th class="column_10" name="dport">目的端口</th>
      <th class="column_10" name="service">Https</th>
      <th class="column_10" name="time">生效时段</th>
      <th class="column_5" name="comment">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td colspan="8">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewTransAccessCtrlDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/safeBrowse/transVisit.php'}>
</div>
<script type="text/javascript" src="Public/js/client/safeBrowse/transVisit.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/safeBrowse/transVisit.php', $('#transVisitTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#transVisitTable'), {7: {sorter: false}}, [[0,0]]);
    });
</script>