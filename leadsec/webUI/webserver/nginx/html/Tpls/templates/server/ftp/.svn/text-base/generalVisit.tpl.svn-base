<{include file='layout/search.tpl' tableId='ftpCommServerTable'}>
<table class="column_95 textMid tablesorter" id="ftpCommServerTable">
    <caption>信息列表</caption>
    <thead>
        <tr>
            <th class="column_10" name="id">任务号</th>
            <th class="column_20" name="serverip">服务器地址</th>
            <th class="column_10" name="sport">服务器端口</th>
            <th class="column_10" name="active">是否启动</th>
            <th class="column_30" name="comment">备注</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="6">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onClick="openNewFtpCommServerAclDialog()">添加</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/server/ftp/generalVisit.php'}>
</div>

<script type="text/javascript" src="Public/js/server/ftp/generalVisit.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/server/ftp/generalVisit.php',
            $('#ftpCommServerTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#ftpCommServerTable'), {5: {sorter: false}}, [[0,0]]);
    });
</script>
