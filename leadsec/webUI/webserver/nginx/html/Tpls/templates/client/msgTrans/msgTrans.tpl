<{include file='layout/search.tpl' tableId='msgTransTable'}>
<table class="column_95 textMid tablesorter" id="msgTransTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_5">任务号</th>
      <th class="column_10">源地此</th>
      <th class="column_10">本机地此</th>
      <th class="column_10">本地端口</th>
      <th class="column_10">认证/加密</th>
      <th class="column_10">本机备份</th>
      <th class="column_10">病毒扫描</th>
      <th class="column_10">是否启动</th>
      <th class="column_10">生效时间</th>
      <th class="column_5">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td colspan="11">Loading……</td>
    </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/msgTrans/msgTrans.php'}>
</div>
<script type="text/javascript" src="Public/js/client/msgTrans/msgTrans.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/msgTrans/msgTrans.php', $('#msgTransTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#msgTransTable'), {4: {sorter: false}}, [[0,0]]);
    });
</script>