<{include file='layout/search.tpl' tableId='fileExTable'}>
<table class="column_95 textMid tablesorter" id="fileExTable">
    <caption>信息列表</caption>
    <thead>
    <tr>
        <th class="column_5">任务号</th>
        <th class="column_10">源地此</th>
        <th class="column_10">本机地此</th>
        <th class="column_10">本地端口</th>
        <th class="column_10">认证/加密</th>
        <th class="column_10">公共名</th>
        <th class="column_10">本地备份</th>
        <th class="column_10">流病毒扫描</th>
        <th class="column_10">生效时间</th>
        <th class="column_5">备注</th>
        <th class="column_10">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td colspan="11">Loading... ...</td>
    </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/fileEx/fileEx.php'}>
</div>
<script type="text/javascript" src="Public/js/client/fileEx/fileEx.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/fileEx/fileEx.php', $('#fileExTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#fileExTable'), {10: {sorter: false}}, [[0,0]]);
    });
</script>
