<{include file='layout/search.tpl' tableId='fileSyncTable'}>
<table class="column_95 textMid tablesorter" id="fileSyncTable">
    <caption>信息列表</caption>
    <thead>
        <tr>
            <th class="column_10" name="id">任务号</th>
            <th class="column_20" name="serverip">服务器地址</th>
            <th class="column_10" name="sport">服务器端口</th>
            <th class="column_10" name="ssl">认证/加密</th>
            <th class="column_10" name="commname">公共名</th>
            <th class="column_10" name="mode">本地备份</th>
            <th class="column_10" name="comment">备注</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="8">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewFileSyncDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/server/fileSync/fileSync.php'}>
</div>
<script type="text/javascript" src="Public/js/server/fileSync/fileSync.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/server/fileSync/fileSync.php', $('#fileSyncTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#fileSyncTable'), {7: {sorter: false}}, [[0,0]]);
    });
</script>
