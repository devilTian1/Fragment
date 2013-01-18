<{include file='layout/search.tpl' tableId='generalVisitTable'}>
<table class="column_95 textMid tablesorter" id="generalVisitTable">
    <caption>信息列表</caption>
    <thead>
    <tr>
        <th class="column_10" name="id">任务号</th>
        <th class="column_10" name="sa">源地址</th>
        <th class="column_10" name="lip">本机地址</th>
        <th class="column_10" name="lport">本机端口</th>
        <th class="column_20" name="filter">过滤选项</th>
        <th class="column_10" name="time">生效时间</th>
        <th class="column_10" name="active">是否启动</th>
        <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="7">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewFtpCommClientAclDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/ftp/generalVisit.php'}>
</div>
<script type="text/javascript" src="Public/js/client/ftp/generalVisit.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/ftp/generalVisit.php', $('#generalVisitTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#generalVisitTable'), {7: {sorter: false}}, [[0,0]]);
    });
</script>
