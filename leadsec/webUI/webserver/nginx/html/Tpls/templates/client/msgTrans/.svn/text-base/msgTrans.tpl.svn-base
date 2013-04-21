<{include file='layout/search.tpl' tableId='msgTransTable'}>
<table class="column_95 textMid tablesorter" id="msgTransTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_8" name="id">任务号</th>
      <th class="column_10" name="sa">源地址</th>
      <th class="column_10" name="lip">本机地址</th>
      <th class="column_10" name="lport">本机端口</th>
      <th class="column_7" name="ssl">认证/加密</th>
      <th class="column_6" name="backup">本机备份</th>
      <th class="column_6" name="scanvirus">病毒扫描</th>
      <th class="column_6" name="active">是否启动</th>
      <th class="column_8" name="name">生效时段</th>
      <th class="column_15">备注</th>
      <th class="column_15">操作</th>
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
        sortTableInit($('#msgTransTable'), {9: {sorter: false},10: {sorter: false}}, [[0,0]]);
    });
</script>