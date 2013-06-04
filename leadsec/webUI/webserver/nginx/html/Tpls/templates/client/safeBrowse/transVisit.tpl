<{include file='layout/search.tpl' tableId='transVisitTable'}>
<table class="column_95 textMid tablesorter" id="transVisitTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_10" name="id">任务号</th>
      <th class="column_15" name="sip">源地址</th>
      <th class="column_15" name="dip">目的地址</th>
      <th class="column_10" name="port">目的端口</th>
      <th class="column_5" name="https">Https</th>
      <th class="column_15" name="time">生效时段</th>
      <th class="column_10" name="usergrp">认证用户组</th>
      <th class="column_10" name="comment">备注</th>
      <th class="column_10">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td colspan="9">Loading……</td>
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
        freshTable('Function/client/safeBrowse/transVisit.php', $('#transVisitTable'), 'ORDER BY sip ASC LIMIT 10');
        sortTableInit($('#transVisitTable'), {8: {sorter: false}}, [[0, 0], [1,0]]);
    });
</script>
