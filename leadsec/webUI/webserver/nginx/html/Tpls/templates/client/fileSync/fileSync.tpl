<{include file='layout/search.tpl' tableId='fileSyncTable'}>
<table class="column_95 textMid tablesorter" id="fileSyncTable">
    <caption>信息列表</caption>
    <thead>
        <tr>
            <th class="column_10" name="id">任务号</th>
            <th class="column_8" name="sa">源地址</th>
            <th class="column_10" name="lip">本机地址</th>
            <th class="column_8" name="lport">端口</th>
            <th class="column_10" name="ssl">认证/加密</th>
            <th class="column_9" name="commname">公共名</th>
            <th class="column_10" name="killvirus">流病毒扫描</th>
            <th class="column_10" name="time">生效时段</th>
            <th class="column_8" name="comment">备注</th>
            <th class="column_7">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="11">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewFileSyncDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/fileSync/fileSync.php'}>
</div>
<script type="text/javascript" src="Public/js/client/fileSync/fileSync.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/fileSync/fileSync.php', $('#fileSyncTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#fileSyncTable'), {10: {sorter: false}}, [[0,0]]);
    });
</script>
